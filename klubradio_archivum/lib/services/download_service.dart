// lib/services/download_service.dart
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart' show Value;
import 'package:background_downloader/background_downloader.dart';
import 'package:http/http.dart' as http;

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;

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
  final Completer<void> _ready = Completer<void>();
  bool _disposed = false;

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

  static const _relDir = 'Klubradio';

  Future<String> _composeLocalPath(String filename) async {
    final base =
        await getApplicationSupportDirectory(); // Win/macOS/Linux/iOS/Android
    final path = '${base.path}/$_relDir/$filename';
    return path;
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
    final filename = '${ep.id}.mp3';

    final task = DownloadTask(
      url: ep.audioUrl,
      filename: filename,
      baseDirectory: BaseDirectory.applicationSupport,
      directory: _relDir,
      updates: Updates.statusAndProgress,
      retries: 3,
      allowPause: isResumable,
      requiresWiFi: wifiOnly,
      metaData: 'episodeId=${ep.id}',
    );

    _tasksByEpisodeId[ep.id] = task;
    if (task.baseDirectory == BaseDirectory.applicationSupport) {
      final base = await getApplicationSupportDirectory();
      final absDir = p.join(base.path, task.directory!);
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
          break;
        case TaskStatus.canceled:
          await episodesDao.setCanceled(episodeId);
          break;
        case TaskStatus.failed:
          await episodesDao.setFailed(episodeId);
          break;
        case TaskStatus.complete:
          final localPath = await _finalPathForTask(task as DownloadTask);
          final exists = await File(localPath).exists();
          await episodesDao.setCompleted(episodeId, localPath);
          final epRow = await episodesDao.getById(episodeId);
          if (epRow != null) {
            final plan = await retentionDao.computePlanForPodcast(
              epRow.podcastId,
            );
            for (final id in plan.toDeleteIds) {
              await removeLocalFile(id);
            }
          }
          print('COMPLETE id=$episodeId path: $localPath exists=$exists');

          break;
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
    final relDir = task.directory ?? '';
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
}
