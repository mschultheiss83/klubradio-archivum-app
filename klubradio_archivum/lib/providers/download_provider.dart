// lib/providers/download_provider.dart
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' show Value;

import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/services/download_service.dart';

/// Einfacher ChangeNotifier-Provider rund um den DownloadService.
/// Bindet man in der App mit Provider/GetIt ein.
class DownloadProvider extends ChangeNotifier {
  DownloadProvider({required AppDatabase db})
    : episodesDao = EpisodesDao(db),
      subscriptionsDao = SubscriptionsDao(db),
      settingsDao = SettingsDao(db),
      retentionDao = RetentionDao(
        db,
        EpisodesDao(db),
        SubscriptionsDao(db),
        SettingsDao(db),
      ) {
    service = DownloadService(
      db: db,
      episodesDao: episodesDao,
      subscriptionsDao: subscriptionsDao,
      settingsDao: settingsDao,
      retentionDao: retentionDao,
    );
    service.init();
  }

  late final DownloadService service;

  final EpisodesDao episodesDao;
  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;
  final RetentionDao retentionDao;

  /// API, die Screens aufrufen:
  Future<void> enqueue(model.Episode ep) async {
    await service.enqueueEpisode(ep);
    notifyListeners();
  }

  Future<void> pause(String episodeId) async {
    await service.pause(episodeId);
    notifyListeners();
  }

  Future<void> resume(String episodeId) async {
    await service.resume(episodeId);
    notifyListeners();
  }

  Future<void> cancel(String episodeId) async {
    await service.cancel(episodeId);
    notifyListeners();
  }

  Future<void> removeLocalFile(String episodeId) async {
    await service.removeLocalFile(episodeId);
    notifyListeners();
  }

  @override
  void dispose() {
    service.dispose();
    super.dispose();
  }
}

extension AutoDownload on DownloadProvider {
  Future<void> autoEnqueueLatestN(
    String podcastId,
    int n,
    List<model.Episode> candidates,
  ) async {
    final latest = candidates.take(n).toList();
    for (final ep in latest) {
      // DB-Zustand prüfen: schon vorhanden?
      final row = await episodesDao.getById(ep.id);
      final alreadyDone = row?.status == 3 && (row?.localPath ?? '').isNotEmpty;
      final alreadyQueuedOrRunning = row?.status == 1 || row?.status == 2;

      if (alreadyDone || alreadyQueuedOrRunning) {
        continue;
      }

      // Episode (falls noch nicht da) minimal in DB anlegen, damit UI-Stream sie kennt
      if (row == null) {
        await episodesDao.upsert(
          EpisodesCompanion(
            id: Value(ep.id),
            podcastId: Value(ep.podcastId),
            title: Value(ep.title),
            audioUrl: Value(ep.audioUrl),
            publishedAt: ep.publishedAt == null
                ? const Value.absent()
                : Value(ep.publishedAt!),
            status: const Value(0), // none
            progress: const Value(0),
          ),
        );
      }

      // Enqueue im Service (startet echten Download)
      await service.enqueueEpisode(ep);
    }
    notifyListeners();
  }
}
