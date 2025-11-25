// lib/providers/download_provider.dart
import 'dart:async' show unawaited;
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' show Value;

import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/services/download_service.dart';
import 'package:klubradio_archivum/services/api_service.dart'; // Import ApiService

import '../providers/episode_provider.dart';

/// Einfacher ChangeNotifier-Provider rund um den DownloadService.
class DownloadProvider extends ChangeNotifier {
  DownloadProvider({
    required AppDatabase db,
    required EpisodeProvider episodeProvider,
    required this.apiService,
  })  : episodesDao = EpisodesDao(db),
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
      episodeProvider: episodeProvider,
      apiService: apiService,
    );
    // init bewusst nicht awaiten – der Service wartet intern auf _ready
    unawaited(service.init());
  }

  late final DownloadService service;

  final EpisodesDao episodesDao;
  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;
  final RetentionDao retentionDao;
  final ApiService apiService; // Add apiService field

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

  Future<void> deleteEpisodesForPodcast(String podcastId) async {
    await service.deleteEpisodesForPodcast(podcastId);
    notifyListeners();
  }

  Future<int> autodownloadPodcast(String podcastId) async {
    final count = await service.autodownloadPodcast(podcastId);
    notifyListeners();
    return count;
  }

  Future<void> autoEnqueueLatestN(
    String podcastId,
    int n,
    List<model.Episode> candidates,
  ) async {
    final latest = candidates.take(n).toList();

    for (final ep in latest) {
      final row = await episodesDao.getById(ep.id);
      final alreadyDone = row?.status == 3 && (row?.localPath ?? '').isNotEmpty;
      final alreadyQueuedOrRunning = row?.status == 1 || row?.status == 2;

      if (alreadyDone || alreadyQueuedOrRunning) {
        continue;
      }

      if (row == null) {
        await episodesDao.upsert(
          EpisodesCompanion(
            id: Value(ep.id),
            podcastId: Value(ep.podcastId),
            title: Value(ep.title),
            audioUrl: Value(ep.audioUrl),
            publishedAt: Value(ep.publishedAt),
            status: const Value(0), // none
            progress: const Value(0),
          ),
        );
      }

      await service.enqueueEpisode(ep);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    // Stream sauber abmelden, damit nach Widget-Dispose keine Events mehr ankommen
    unawaited(service.dispose());
    super.dispose();
  }
}
