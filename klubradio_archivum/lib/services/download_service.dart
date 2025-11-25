// lib/services/download_service.dart
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart' show Value;
import 'package:background_downloader/background_downloader.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/services/api_service.dart';

class _EpisodeMetaLite {
  _EpisodeMetaLite({
    required this.id,
    required this.podcastId,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.publishedAt,
    required this.showDate,
    required this.durationSeconds,
    required this.hosts,
    this.imageUrl,
  });

  final String id;
  final String podcastId;
  final String title;
  final String description;
  final String audioUrl;
  final DateTime publishedAt;
  final String showDate;
  final int durationSeconds;
  final List<String> hosts;
  final String? imageUrl;

  factory _EpisodeMetaLite.fromModel(model.Episode e) => _EpisodeMetaLite(
    id: e.id,
    podcastId: e.podcastId,
    title: e.displayTitle, // cachedTitle bevorzugt
    description: e.description,
    audioUrl: e.audioUrl,
    publishedAt: e.publishedAt,
    showDate: e.showDate,
    durationSeconds: e.duration.inSeconds,
    hosts: e.hosts,
    imageUrl: e.imageUrl,
  );

  Map<String, dynamic> toJson({
    String? cachedImageFile,
    String? mp3File,
    int schemaVersion = 1,
  }) => {
    'schemaVersion': schemaVersion,
    'id': id,
    'podcastId': podcastId,
    'title': title,
    'description': description,
    'audioUrl': audioUrl,
    'publishedAt': publishedAt.toIso8601String(),
    'showDate': showDate,
    'duration': durationSeconds,
    'hosts': hosts,
    'imageUrl': imageUrl ?? '',
    'cachedImageFile': cachedImageFile ?? '',
    'mp3File': mp3File ?? '',
    'createdAt': DateTime.now().toIso8601String(),
  };
}

/// Integer-Status in der DB
class EpisodeStatusDB {
  static const none = 0;
  static const queued = 1;
  static const downloading = 2;
  static const completed = 3;
  static const failed = 4;
  static const canceled = 5;
}

class DownloadService {
  DownloadService({
    required this.db,
    required this.episodesDao,
    required this.subscriptionsDao,
    required this.settingsDao,
    required this.retentionDao,
    required this.episodeProvider,
    required this.apiService,
  });

  final AppDatabase db;
  final EpisodesDao episodesDao;
  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;
  final RetentionDao retentionDao;
  final EpisodeProvider episodeProvider;
  final ApiService apiService;

  late FileDownloader _downloader;
  StreamSubscription<TaskUpdate>? _sub;
  Timer? _autodownloadTimer;

  final Map<String, DownloadTask> _tasksByEpisodeId = {};
  final Map<String, String?> _imageUrlHintByEpisodeId = {};
  final Map<String, _EpisodeMetaLite> _metaHintByEpisodeId = {};

  final List<model.Episode> _pendingDownloadQueue = [];
  int _activeDownloadCount = 0;

  final Completer<void> _ready = Completer<void>();
  bool _disposed = false;
  static const _relDir = 'Klubradio';
  String _podcastSubdir(String podcastId) => p.join(_relDir, podcastId);
  String _episodeMp3Name(String episodeId) => '$episodeId.mp3';

  /// Muss genau einmal aufgerufen werden. Lädt Konfig & startet Eventstream.
  Future<void> init() async {
    if (_disposed) return;
    _downloader = FileDownloader();

    _downloader.configureNotification(
      running: const TaskNotification('Downloading', 'file: {filename}'),
      complete: const TaskNotification('Download finished', 'file: {filename}'),
      progressBar: true,
    );

    _sub = _downloader.updates.listen(_onUpdate, onError: (_) {});
    await _downloader.start();

    _autodownloadTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => checkAutodownloads(),
    );

    if (!_ready.isCompleted) _ready.complete();
  }

  Future<void> dispose() async {
    _disposed = true;
    await _sub?.cancel();
    _autodownloadTimer?.cancel();
  }

  Future<void> enqueueEpisode(model.Episode ep) async {
    await _ready.future;
    final existingSub = await subscriptionsDao.getById(ep.podcastId);
    if (existingSub == null) {
      await subscriptionsDao.upsert(
        SubscriptionsCompanion.insert(
          podcastId: ep.podcastId,
          active: const Value(false),
        ),
      );
    }
    if (_disposed) return;

    _pendingDownloadQueue.add(ep);
    _processQueue();
  }

  Future<void> _processQueue() async {
    if (_disposed) return;
    final settings = await settingsDao.getOne();
    final maxParallel = settings?.maxParallel ?? 1; // Default to 1 if not set

    while (_activeDownloadCount < maxParallel &&
        _pendingDownloadQueue.isNotEmpty) {
      final ep = _pendingDownloadQueue.removeAt(0);
      _activeDownloadCount++;
      _startDownload(ep);
    }
  }

  Future<void> _startDownload(model.Episode ep) async {
    final isResumable = await _checkResumable(ep.audioUrl);

    await episodesDao.upsert(
      EpisodesCompanion(
        id: Value(ep.id),
        podcastId: Value(ep.podcastId),
        title: Value(ep.title),
        audioUrl: Value(ep.audioUrl),
        publishedAt: Value(ep.publishedAt),
        status: Value(EpisodeStatusDB.queued),
        progress: const Value(0),
        resumable: Value(isResumable),
      ),
    );

    final settings = await settingsDao.getOne();
    final wifiOnly = settings?.wifiOnly ?? true;
    final subdir = _podcastSubdir(ep.podcastId);
    final filename = _episodeMp3Name(ep.id);

    final task = DownloadTask(
      url: ep.audioUrl,
      filename: filename,
      baseDirectory: BaseDirectory.applicationSupport,
      directory: subdir,
      updates: Updates.statusAndProgress,
      retries: 3,
      allowPause: isResumable,
      requiresWiFi: wifiOnly,
      metaData: 'episodeId=${ep.id}',
    );

    _imageUrlHintByEpisodeId[ep.id] = ep.imageUrl;
    _metaHintByEpisodeId[ep.id] = _EpisodeMetaLite.fromModel(ep);
    _tasksByEpisodeId[ep.id] = task;
    if (task.baseDirectory == BaseDirectory.applicationSupport) {
      final base = await getApplicationSupportDirectory();
      final absDir = p.join(base.path, task.directory);
      await Directory(absDir).create(recursive: true);
    }

    await _downloader.enqueue(task);
  }

  Future<void> pause(String episodeId) async {
    await _ready.future;
    if (_disposed) return;

    final task = _tasksByEpisodeId[episodeId];
    if (task != null) {
      await _downloader.pause(task);
    }
  }

  Future<void> resume(String episodeId) async {
    await _ready.future;
    if (_disposed) return;

    final task = _tasksByEpisodeId[episodeId];
    if (task != null) {
      await _downloader.resume(task);
    }
  }

  Future<void> cancel(String episodeId) async {
    await _ready.future;
    if (_disposed) return;

    final task = _tasksByEpisodeId[episodeId];
    if (task != null) {
      await _downloader.cancel(task);
    }
    await episodesDao.setCanceled(episodeId);
  }

  Future<void> _onUpdate(TaskUpdate u) async {
    if (_disposed) return;

    final task = u.task;

    // episodeId aus metaData oder Dateiname herausziehen (null-sicher)
    String? episodeId;
    final meta = task.metaData;
    if (meta.contains('episodeId=')) {
      episodeId = meta.split('episodeId=').last;
    } else {
      final name = task.filename;
      if (name.endsWith('.mp3')) {
        episodeId = name.substring(0, name.length - 4);
      }
    }
    if (episodeId == null) return;

    if (task is DownloadTask) {
      _tasksByEpisodeId[episodeId] = task;
    }

    if (u is TaskStatusUpdate) {
      switch (u.status) {
        case TaskStatus.running:
          await episodesDao.setDownloading(episodeId);
          break;
        case TaskStatus.paused:
          await episodesDao.setQueued(episodeId);
          _activeDownloadCount--;
          _processQueue();
          break;
        case TaskStatus.canceled:
          await episodesDao.setCanceled(episodeId);
          _activeDownloadCount--;
          _processQueue();
          break;
        case TaskStatus.failed:
          await episodesDao.setFailed(episodeId);
          _activeDownloadCount--;
          _processQueue();
          break;
        case TaskStatus.complete:
          {
            final localPath = await _finalPathForTask(task as DownloadTask);
            await episodesDao.setCompleted(episodeId, localPath);
            final dirPath = p.dirname(localPath);
            final meta = _metaHintByEpisodeId[episodeId];
            if (meta != null) {
              // JPG + JSON (mit relativen Verweisen) schreiben
              final cache = await _writeEpisodeCache(
                dirPath: dirPath, // <-- exakt der Ordner der MP3
                meta: meta, // enthält podcastId, title, showDate, hosts, ...
              );

              await episodesDao.setCachedMeta(
                episodeId,
                title: meta.title, // cachedTitle
                imagePath: cache.imagePath, // ABSOLUT
                metaPath: cache.jsonPath, // ABSOLUT
              );

              _metaHintByEpisodeId.remove(episodeId);
            }

            // nach dem Caching aufräumen:
            _imageUrlHintByEpisodeId.remove(episodeId);

            // (Deine Retention-Logik anschließend wie gehabt)
            final epRow = await episodesDao.getById(episodeId);
            if (epRow != null) {
              final plan = await retentionDao.computePlanForPodcast(
                epRow.podcastId,
              );
              for (final id in plan.toDeleteIds) {
                await removeLocalFile(id);
              }
            }
            // Notify EpisodeProvider that the episode has been downloaded
            episodeProvider.onEpisodeDownloaded(episodeId, localPath);
            _activeDownloadCount--;
            _processQueue();
            break;
          }
        default:
          break;
      }
    } else if (u is TaskProgressUpdate) {
      await episodesDao.setProgress(episodeId, u.progress);
    }
  }

  Future<String> _finalPathForTask(DownloadTask task) async {
    // 1) map BaseDirectory -> echtes Basis-Verzeichnis vom OS
    Directory base;
    switch (task.baseDirectory) {
      case BaseDirectory.applicationSupport:
        base = await getApplicationSupportDirectory();
        break;
      case BaseDirectory.applicationDocuments:
        base = await getApplicationDocumentsDirectory();
        break;
      case BaseDirectory.temporary:
        base = await getTemporaryDirectory();
        break;
      default:
        base = await getApplicationSupportDirectory();
    }

    // 2) zusammensetzen: base + (relatives) directory + filename
    final relDir = task.directory;
    return p.join(base.path, relDir, task.filename);
  }

  Future<void> removeLocalFile(String episodeId) async {
    await _ready.future;
    if (_disposed) return;

    final ep = await episodesDao.getById(episodeId);
    if (ep?.localPath != null) {
      try {
        final f = File(ep!.localPath!);
        if (await f.exists()) {
          await f.delete();
        }
      } catch (_) {
        // optional: loggen
      }
    }
    await episodesDao.clearLocalFile(episodeId);
  }

  Future<void> deleteEpisodesForPodcast(String podcastId) async {
    await _ready.future;
    if (_disposed) return;

    final episodes = await episodesDao.getEpisodesByPodcastId(podcastId);
    for (final episode in episodes) {
      if (episode.localPath != null && episode.localPath!.isNotEmpty) {
        await removeLocalFile(episode.id);
      }
    }
  }

  Future<void> checkAutodownloads() async {
    if (_disposed) return;
    final settings = await settingsDao.getOne();
    if (settings?.autodownloadSubscribed ?? false) {
      final activeSubscriptions = await subscriptionsDao.watchAllActive().first;
      for (final sub in activeSubscriptions) {
        await autodownloadPodcast(sub.podcastId);
      }
    }
  }

  Future<int> autodownloadPodcast(String podcastId) async {
    final settings = await settingsDao.getOne();
    final keepN = settings?.keepLatestN ?? 0;

    if (keepN <= 0) {
      return 0; // If keepN is 0 or less, do nothing.
    }

    // Fetch latest episodes for this podcast from the API and sort them.
    final latestEpisodes = await apiService.fetchEpisodesForPodcast(podcastId);
    latestEpisodes.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    // These are the episodes we want to have locally.
    final targetEpisodes = latestEpisodes.take(keepN);

    // Get what we already have.
    final downloadedEpisodes = await episodesDao.getEpisodesByPodcastId(
      podcastId,
    );
    final downloadedEpisodeIds = downloadedEpisodes.map((e) => e.id).toSet();

    int downloadCount = 0;
    for (final episodeToDownload in targetEpisodes) {
      if (!downloadedEpisodeIds.contains(episodeToDownload.id)) {
        // This is a new episode that we don't have, enqueue it.
        await enqueueEpisode(episodeToDownload);
        downloadCount++;
      }
    }
    return downloadCount;
  }

  Future<bool> _checkResumable(String url) async {
    try {
      final resp = await http.head(Uri.parse(url));
      final ar = resp.headers['accept-ranges'] ?? resp.headers['Accept-Ranges'];
      return (ar ?? '').toLowerCase().contains('bytes');
    } catch (_) {
      return false;
    }
  }

  Future<({String? imagePath, String jsonPath})> _writeEpisodeCache({
    required String dirPath,
    required _EpisodeMetaLite meta,
  }) async {
    String? imagePath;
    String? imageFile;
    // 1) Cover (optional)
    if ((meta.imageUrl ?? '').isNotEmpty) {
      try {
        final resp = await http.get(Uri.parse(meta.imageUrl!));
        if (resp.statusCode >= 200 &&
            resp.statusCode < 300 &&
            resp.bodyBytes.isNotEmpty) {
          final decoded = img.decodeImage(resp.bodyBytes);
          if (decoded != null) {
            final resized = img.copyResize(
              decoded,
              width: 500,
              height: 500,
              maintainAspect: true,
            );
            final jpg = img.encodeJpg(resized, quality: 85);
            imageFile = '${meta.id}.jpg';
            imagePath = p.join(dirPath, imageFile);
            await File(imagePath).writeAsBytes(jpg, flush: true);
          }
        }
      } catch (_) {
        /* optional log */
      }
    }

    // 2) JSON
    final jsonFileName = '${meta.id}.json';
    final jsonPath = p.join(dirPath, jsonFileName);
    final mp3File = '${meta.id}.mp3'; // wir nutzen ja diese Namenskonvention
    final jsonMap = meta.toJson(
      cachedImageFile: imageFile,
      mp3File: mp3File,
      schemaVersion: 1,
    );
    await File(jsonPath).writeAsString(jsonEncode(jsonMap), flush: true);

    return (imagePath: imagePath, jsonPath: jsonPath);
  }
}
