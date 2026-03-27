// test/db/autodownload_logic_test.dart
//
// Tests for the auto-download preconditions that checkAutodownloads() and
// autodownloadPodcast() rely on. These run against a real in-memory DB so we
// can verify the exact conditions without mocking native plugins.

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/services/download_service.dart'
    show EpisodeStatusDB;

void main() {
  late AppDatabase db;
  late SettingsDao settingsDao;
  late SubscriptionsDao subscriptionsDao;
  late EpisodesDao episodesDao;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    settingsDao = SettingsDao(db);
    subscriptionsDao = SubscriptionsDao(db);
    episodesDao = EpisodesDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('checkAutodownloads preconditions', () {
    test('default settings have autodownloadSubscribed = false', () async {
      await settingsDao.ensureDefaults();
      final settings = await settingsDao.getOne();

      expect(settings, isNotNull);
      expect(settings!.autodownloadSubscribed, isFalse,
          reason: 'Auto-download must be explicitly enabled by the user');
    });

    test('enabling autodownloadSubscribed persists in DB', () async {
      await settingsDao.ensureDefaults();
      await settingsDao.setAutodownloadSubscribed(true);

      final settings = await settingsDao.getOne();
      expect(settings!.autodownloadSubscribed, isTrue);
    });

    test('no active subscriptions returns empty list', () async {
      final subs = await subscriptionsDao.watchAllActive().first;
      expect(subs, isEmpty);
    });

    test('active subscription appears in watchAllActive', () async {
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 3,
      );

      final subs = await subscriptionsDao.watchAllActive().first;
      expect(subs, hasLength(1));
      expect(subs.first.podcastId, 'p1');
      expect(subs.first.autoDownloadN, 3);
    });

    test('inactive subscription is excluded from watchAllActive', () async {
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: false,
      );

      final subs = await subscriptionsDao.watchAllActive().first;
      expect(subs, isEmpty);
    });
  });

  group('autodownloadPodcast preconditions', () {
    test('per-podcast autoDownloadN takes priority over global keepLatestN',
        () async {
      // Set global keepLatestN = 5
      await settingsDao.ensureDefaults();
      await settingsDao.setKeepLatestN(5);

      // Set per-podcast autoDownloadN = 2
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 2,
      );

      final sub = await subscriptionsDao.getById('p1');
      final settings = await settingsDao.getOne();
      final keepN = sub?.autoDownloadN ?? settings?.keepLatestN ?? 0;

      expect(keepN, 2, reason: 'Per-podcast autoDownloadN should win');
    });

    test('falls back to global keepLatestN when per-podcast is null', () async {
      await settingsDao.ensureDefaults();
      await settingsDao.setKeepLatestN(5);

      // Subscribe without autoDownloadN
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
      );

      final sub = await subscriptionsDao.getById('p1');
      final settings = await settingsDao.getOne();
      final keepN = sub?.autoDownloadN ?? settings?.keepLatestN ?? 0;

      expect(keepN, 5, reason: 'Should fall back to global keepLatestN');
    });

    test('keepN = 0 when both per-podcast and global are null', () async {
      await settingsDao.ensureDefaults();

      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
      );

      final sub = await subscriptionsDao.getById('p1');
      final settings = await settingsDao.getOne();
      final keepN = sub?.autoDownloadN ?? settings?.keepLatestN ?? 0;

      expect(keepN, 0,
          reason: 'No auto-download when both values are null');
    });

    test('already completed episodes are skipped', () async {
      // Create a subscription and an episode that is already completed
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 3,
      );

      await episodesDao.upsert(EpisodesCompanion.insert(
        id: 'ep1',
        podcastId: 'p1',
        title: 'Episode 1',
        audioUrl: 'https://example.com/ep1.mp3',
      ));
      await episodesDao.setCompleted('ep1', '/path/to/ep1.mp3');

      final allEpisodes = await episodesDao.getEpisodesByPodcastId('p1');
      final skipIds = allEpisodes
          .where((e) =>
              e.status == EpisodeStatusDB.completed ||
              e.status == EpisodeStatusDB.queued ||
              e.status == EpisodeStatusDB.downloading)
          .map((e) => e.id)
          .toSet();

      expect(skipIds, contains('ep1'),
          reason: 'Completed episode should be in skip set');
    });

    test('queued and downloading episodes are also skipped', () async {
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 3,
      );

      await episodesDao.upsert(EpisodesCompanion.insert(
        id: 'ep1',
        podcastId: 'p1',
        title: 'Queued Episode',
        audioUrl: 'https://example.com/ep1.mp3',
      ));
      await episodesDao.setQueued('ep1');

      await episodesDao.upsert(EpisodesCompanion.insert(
        id: 'ep2',
        podcastId: 'p1',
        title: 'Downloading Episode',
        audioUrl: 'https://example.com/ep2.mp3',
      ));
      await episodesDao.setDownloading('ep2');

      final allEpisodes = await episodesDao.getEpisodesByPodcastId('p1');
      final skipIds = allEpisodes
          .where((e) =>
              e.status == EpisodeStatusDB.completed ||
              e.status == EpisodeStatusDB.queued ||
              e.status == EpisodeStatusDB.downloading)
          .map((e) => e.id)
          .toSet();

      expect(skipIds, containsAll(['ep1', 'ep2']));
    });

    // ==================== L4: setAutoDownloadN normalization ====================

    test('setAutoDownloadN(0) stores 0 (disabled, not null)', () async {
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 5,
      );

      await subscriptionsDao.setAutoDownloadN('p1', 0);

      final sub = await subscriptionsDao.getById('p1');
      expect(sub!.autoDownloadN, 0,
          reason: '0 means "disabled" and must be stored, not normalized to null');
    });

    test('setAutoDownloadN(-1) normalizes to null', () async {
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 5,
      );

      await subscriptionsDao.setAutoDownloadN('p1', -1);

      final sub = await subscriptionsDao.getById('p1');
      expect(sub!.autoDownloadN, isNull,
          reason: 'Negative values should be normalized to null');
    });

    test('setAutoDownloadN(null) stores null', () async {
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 5,
      );

      await subscriptionsDao.setAutoDownloadN('p1', null);

      final sub = await subscriptionsDao.getById('p1');
      expect(sub!.autoDownloadN, isNull,
          reason: 'null means "use global default"');
    });

    test('failed and canceled episodes are NOT skipped (will retry)', () async {
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 3,
      );

      await episodesDao.upsert(EpisodesCompanion.insert(
        id: 'ep1',
        podcastId: 'p1',
        title: 'Failed Episode',
        audioUrl: 'https://example.com/ep1.mp3',
      ));
      await episodesDao.setFailed('ep1');

      await episodesDao.upsert(EpisodesCompanion.insert(
        id: 'ep2',
        podcastId: 'p1',
        title: 'Canceled Episode',
        audioUrl: 'https://example.com/ep2.mp3',
      ));
      await episodesDao.setCanceled('ep2');

      final allEpisodes = await episodesDao.getEpisodesByPodcastId('p1');
      final skipIds = allEpisodes
          .where((e) =>
              e.status == EpisodeStatusDB.completed ||
              e.status == EpisodeStatusDB.queued ||
              e.status == EpisodeStatusDB.downloading)
          .map((e) => e.id)
          .toSet();

      expect(skipIds, isNot(contains('ep1')),
          reason: 'Failed episodes should be retried');
      expect(skipIds, isNot(contains('ep2')),
          reason: 'Canceled episodes should be retried');
    });
  });

  group('full auto-download scenario', () {
    test(
        'auto-download triggers when autodownloadSubscribed=true, '
        'active subscription exists, and autoDownloadN > 0', () async {
      // 1. Enable auto-download globally
      await settingsDao.ensureDefaults();
      await settingsDao.setAutodownloadSubscribed(true);

      // 2. Create an active subscription with autoDownloadN = 2
      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 2,
      );

      // Verify all preconditions that checkAutodownloads() checks:
      final settings = await settingsDao.getOne();
      expect(settings!.autodownloadSubscribed, isTrue,
          reason: 'Gate 1: autodownloadSubscribed must be true');

      final activeSubs = await subscriptionsDao.watchAllActive().first;
      expect(activeSubs, isNotEmpty,
          reason: 'Gate 2: must have active subscriptions');

      final sub = await subscriptionsDao.getById('p1');
      final keepN = sub?.autoDownloadN ?? settings.keepLatestN ?? 0;
      expect(keepN, greaterThan(0),
          reason: 'Gate 3: keepN must be > 0 for downloads to happen');
    });

    test(
        'auto-download does NOT trigger with default settings '
        '(autodownloadSubscribed=false)', () async {
      await settingsDao.ensureDefaults();

      await subscriptionsDao.toggleSubscribe(
        podcastId: 'p1',
        active: true,
        autoDownloadN: 2,
      );

      final settings = await settingsDao.getOne();
      expect(settings!.autodownloadSubscribed, isFalse,
          reason: 'Default: auto-download is off — checkAutodownloads returns early');
    });
  });
}
