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
  });

  final AppDatabase db;
  final EpisodesDao episodesDao;
  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;
  final RetentionDao retentionDao;

  late FileDownloader _downloader;
  StreamSubscription<TaskUpdate>? _sub;

  final Map<String, DownloadTask> _tasksByEpisodeId = {};
  final Map<String, String?> _imageUrlHintByEpisodeId = {};
  final Map<String, _EpisodeMetaLite> _metaHintByEpisodeId = {};

  final Completer<void> _ready = Completer<void>();
  bool _disposed = false;
  static const _relDir = 'Klubradio';
  String _podcastSubdir(String podcastId) => p.join(_relDir, podcastId);
  String _episodeMp3Name(String episodeId) => '$episodeId.mp3';
  String _episodeJsonName(String episodeId) => '$episodeId.json';
  String _episodeJpgName(String episodeId) => '$episodeId.jpg';

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

    if (!_ready.isCompleted) _ready.complete();
  }

  Future<void> dispose() async {
    _disposed = true;
    await _sub?.cancel();
  }

  Future<void> enqueueEpisode(model.Episode ep) async {
    await _ready.future;
    if (_disposed) return;
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
    // Merkt die (optionale) Bild-URL pro Episode bis zum COMPLETE

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
          break;
        case TaskStatus.canceled:
          await episodesDao.setCanceled(episodeId);
          break;
        case TaskStatus.failed:
          await episodesDao.setFailed(episodeId);
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

            // Episode aus DB besorgen, um podcastId/title/image ziehen zu können
            final row = await episodesDao.getById(episodeId);

            // Minimal-Infos für Cache (falls Model/Row Felder abweichen, passe hier an)
            final podcastId = row?.podcastId ?? '';
            final title = row?.title; // oder vom Domain-Model, falls vorhanden
            final imageUrl = _imageUrlHintByEpisodeId[episodeId];

            // JSON + Cover schreiben (optional)
            final cache = await _cacheEpisodeAssets(
              episodeId: episodeId,
              podcastId: podcastId,
              title: title,
              imageUrl: imageUrl,
              mp3Path: localPath,
            );

            // Pfade in DB merken (nur was vorhanden ist)
            await episodesDao.setCachedMeta(
              episodeId,
              title: cache.title, // wenn null -> bleibt absent
              imagePath: cache.imagePath,
              metaPath: cache.jsonPath,
            );

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
            break;
          }
        default:
          break;
      }
    } else if (u is TaskProgressUpdate) {
      await episodesDao.setProgress(episodeId, u.progress);
    }
  }

  Future<String> _resolveSaveDir() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final dir = await getApplicationSupportDirectory();
      final path = '${dir.path}/Klubradio';
      await Directory(path).create(recursive: true);
      return path;
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/Klubradio';
      await Directory(path).create(recursive: true);
      return path;
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

/// Speichert Metadaten (JSON) + skaliertes Cover (max 500x500) neben der MP3.
/// Gibt (title, imagePath, jsonPath) zurück – nur die tatsächlich geschriebenen Pfade.
Future<({String? title, String? imagePath, String? jsonPath})>
_cacheEpisodeAssets({
  required String episodeId,
  required String podcastId,
  required String? title,
  required String? imageUrl,
  required String mp3Path, // absoluter Pfad zur MP3
}) async {
  try {
    // Basisverzeichnis = Ordner der MP3
    final dir = p.dirname(mp3Path);

    // 1) JSON schreiben
    final jsonPath = p.join(dir, '$episodeId.json');
    final meta = <String, dynamic>{
      'id': episodeId,
      'podcastId': podcastId,
      'title': title ?? '',
      'imageUrl': imageUrl ?? '',
      'createdAt': DateTime.now().toIso8601String(),
    };
    await File(jsonPath).writeAsString(jsonEncode(meta), flush: true);

    // 2) Bild laden & auf 500x500 begrenzen
    String? imagePath;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      try {
        final resp = await http.get(Uri.parse(imageUrl));
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
            imagePath = p.join(dir, '$episodeId.jpg');
            await File(imagePath).writeAsBytes(jpg, flush: true);
          }
        }
      } catch (_) {
        // Bild ist optional – Fehler hier ignorieren
      }
    }

    return (title: title, imagePath: imagePath, jsonPath: jsonPath);
  } catch (_) {
    // JSON/Bild sind optional – im Fehlerfall nichts zurückgeben
    return (title: null, imagePath: null, jsonPath: null);
  }
}
