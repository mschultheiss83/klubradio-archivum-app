import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:drift/drift.dart' show Value;
import 'package:background_downloader/background_downloader.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;

/// Mappt unsere integer-Statuswerte aus der DB
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

  // <-- NEU: getrennte Initialisierung
  Future<void> init() async {
    _downloader = FileDownloader();

    _downloader.configureNotification(
      running: const TaskNotification('Downloading', 'file: {filename}'),
      complete: const TaskNotification('Download finished', 'file: {filename}'),
      progressBar: true,
    );

    _sub = _downloader.updates.listen(_onUpdate);
    await _downloader.start(); // DB/Reschedule aktivieren
  }

  final AppDatabase db;
  final EpisodesDao episodesDao;
  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;
  final RetentionDao retentionDao;

  late FileDownloader _downloader;
  late StreamSubscription<TaskUpdate> _sub;

  // Wichtig: Map speichert DownloadTask (für pause/resume)
  final Map<String, DownloadTask> _tasksByEpisodeId = {};

  Future<void> dispose() async {
    await _sub.cancel();
  }

  Future<void> enqueueEpisode(model.Episode ep) async {
    await episodesDao.upsert(
      EpisodesCompanion(
        id: Value(ep.id),
        podcastId: Value(ep.podcastId),
        title: Value(ep.title),
        audioUrl: Value(ep.audioUrl),
        publishedAt: Value(ep.publishedAt),
        status: Value(EpisodeStatusDB.queued),
        progress: const Value(0),
      ),
    );

    final settings = await settingsDao.getOne();
    final wifiOnly = settings?.wifiOnly ?? true;

    final saveDir = await _resolveSaveDir();
    final filename = '${ep.id}.mp3';

    final task = DownloadTask(
      url: ep.audioUrl,
      filename: filename,
      directory: saveDir,
      updates: Updates.statusAndProgress,
      retries: 3,
      allowPause: true,
      requiresWiFi: wifiOnly,
      metaData: 'episodeId=${ep.id}',
    );

    _tasksByEpisodeId[ep.id] = task; // ok: DownloadTask
    await _downloader.enqueue(task);
  }

  Future<void> pause(String episodeId) async {
    final task = _tasksByEpisodeId[episodeId];
    if (task != null) {
      await _downloader.pause(task); // erwartet DownloadTask
    }
  }

  Future<void> resume(String episodeId) async {
    final task = _tasksByEpisodeId[episodeId];
    if (task != null) {
      await _downloader.resume(task); // erwartet DownloadTask
    }
  }

  Future<void> cancel(String episodeId) async {
    final task = _tasksByEpisodeId[episodeId];
    if (task != null) {
      await _downloader.cancel(task);
    }
    await episodesDao.setCanceled(episodeId);
  }

  Future<void> _onUpdate(TaskUpdate u) async {
    final task = u.task;

    // episodeId aus metaData oder Dateiname herausziehen
    String? episodeId;
    if (task.metaData.contains('episodeId=')) {
      episodeId = task.metaData.split('episodeId=').last;
    } else {
      final name = task.filename;
      if (name.endsWith('.mp3')) {
        episodeId = name.substring(0, name.length - 4);
      }
    }
    if (episodeId == null) return;

    // ⬇️ FIX: Nur speichern, wenn es wirklich ein DownloadTask ist
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
          final localPath = '${task.directory}/${task.filename}';
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

  Future<void> removeLocalFile(String episodeId) async {
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
}
