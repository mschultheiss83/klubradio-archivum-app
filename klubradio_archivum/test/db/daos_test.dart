import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

EpisodesCompanion makeEp(
  String id, {
  String podcastId = 'pod-1',
  DateTime? publishedAt,
  int status = 0,
  String? localPath,
  DateTime? playedAt,
  DateTime? completedAt,
}) =>
    EpisodesCompanion(
      id: Value(id),
      podcastId: Value(podcastId),
      title: Value('Episode $id'),
      audioUrl: Value('https://example.com/$id.mp3'),
      publishedAt: Value(publishedAt ?? DateTime(2024, 1, 1)),
      status: Value(status),
      localPath: localPath != null ? Value(localPath) : const Value.absent(),
      playedAt: playedAt != null ? Value(playedAt) : const Value.absent(),
      completedAt:
          completedAt != null ? Value(completedAt) : const Value.absent(),
    );

SubscriptionsCompanion makeSub(
  String podcastId, {
  bool active = true,
  int? autoDownloadN,
}) =>
    SubscriptionsCompanion(
      podcastId: Value(podcastId),
      active: Value(active),
      autoDownloadN:
          autoDownloadN != null ? Value(autoDownloadN) : const Value.absent(),
    );

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late AppDatabase db;
  late SubscriptionsDao subsDao;
  late EpisodesDao epsDao;
  late SettingsDao settingsDao;
  late RetentionDao retentionDao;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    subsDao = SubscriptionsDao(db);
    epsDao = EpisodesDao(db);
    settingsDao = SettingsDao(db);
    retentionDao = RetentionDao(db, epsDao, subsDao, settingsDao);
  });

  tearDown(() async => await db.close());

  // =========================================================================
  // SubscriptionsDao
  // =========================================================================

  group('SubscriptionsDao', () {
    test('upsert inserts new subscription', () async {
      await subsDao.upsert(makeSub('pod-1'));
      final row = await subsDao.getById('pod-1');
      expect(row, isNotNull);
      expect(row!.podcastId, 'pod-1');
      expect(row.active, true);
    });

    test('upsert updates existing subscription', () async {
      await subsDao.upsert(makeSub('pod-1', active: true));
      await subsDao.upsert(makeSub('pod-1', active: false));
      final row = await subsDao.getById('pod-1');
      expect(row!.active, false);
    });

    test('getById returns null for missing', () async {
      final row = await subsDao.getById('nonexistent');
      expect(row, isNull);
    });

    test('getById returns subscription', () async {
      await subsDao.upsert(makeSub('pod-1'));
      final row = await subsDao.getById('pod-1');
      expect(row, isNotNull);
      expect(row!.podcastId, 'pod-1');
    });

    test('isSubscribed returns false for unsubscribed', () async {
      final result = await subsDao.isSubscribed('pod-1');
      expect(result, false);
    });

    test('isSubscribed returns true for active subscription', () async {
      await subsDao.upsert(makeSub('pod-1', active: true));
      final result = await subsDao.isSubscribed('pod-1');
      expect(result, true);
    });

    test('toggleSubscribe creates new active subscription', () async {
      await subsDao.toggleSubscribe(podcastId: 'pod-1');
      final row = await subsDao.getById('pod-1');
      expect(row, isNotNull);
      expect(row!.active, true);
    });

    test('toggleSubscribe toggles existing off', () async {
      await subsDao.toggleSubscribe(podcastId: 'pod-1');
      await subsDao.toggleSubscribe(podcastId: 'pod-1');
      final row = await subsDao.getById('pod-1');
      expect(row!.active, false);
    });

    test('toggleSubscribe toggles back on', () async {
      await subsDao.toggleSubscribe(podcastId: 'pod-1');
      await subsDao.toggleSubscribe(podcastId: 'pod-1');
      await subsDao.toggleSubscribe(podcastId: 'pod-1');
      final row = await subsDao.getById('pod-1');
      expect(row!.active, true);
    });

    test('toggleSubscribe with explicit active=false', () async {
      await subsDao.toggleSubscribe(podcastId: 'pod-1', active: false);
      final row = await subsDao.getById('pod-1');
      expect(row!.active, false);
    });

    test('toggleSubscribe with autoDownloadN', () async {
      await subsDao.toggleSubscribe(podcastId: 'pod-1', autoDownloadN: 5);
      final row = await subsDao.getById('pod-1');
      expect(row!.autoDownloadN, 5);
    });

    test('setAutoDownloadN sets value', () async {
      await subsDao.upsert(makeSub('pod-1'));
      await subsDao.setAutoDownloadN('pod-1', 3);
      final row = await subsDao.getById('pod-1');
      expect(row!.autoDownloadN, 3);
    });

    test('setAutoDownloadN with negative normalizes to null', () async {
      await subsDao.upsert(makeSub('pod-1', autoDownloadN: 5));
      await subsDao.setAutoDownloadN('pod-1', -1);
      final row = await subsDao.getById('pod-1');
      expect(row!.autoDownloadN, isNull);
    });

    test('setLastHeard updates lastHeardEpisodeId', () async {
      await subsDao.upsert(makeSub('pod-1'));
      await subsDao.setLastHeard('pod-1', 'ep-42');
      final row = await subsDao.getById('pod-1');
      expect(row!.lastHeardEpisodeId, 'ep-42');
    });

    test('setLastDownloaded updates lastDownloadedEpisodeId', () async {
      await subsDao.upsert(makeSub('pod-1'));
      await subsDao.setLastDownloaded('pod-1', 'ep-99');
      final row = await subsDao.getById('pod-1');
      expect(row!.lastDownloadedEpisodeId, 'ep-99');
    });
  });

  // =========================================================================
  // EpisodesDao
  // =========================================================================

  group('EpisodesDao', () {
    test('upsert inserts new episode', () async {
      await epsDao.upsert(makeEp('ep-1'));
      final row = await epsDao.getById('ep-1');
      expect(row, isNotNull);
      expect(row!.title, 'Episode ep-1');
    });

    test('upsert updates existing episode', () async {
      await epsDao.upsert(makeEp('ep-1'));
      await epsDao.upsert(
        EpisodesCompanion(
          id: const Value('ep-1'),
          podcastId: const Value('pod-1'),
          title: const Value('Updated Title'),
          audioUrl: const Value('https://example.com/ep-1.mp3'),
          publishedAt: Value(DateTime(2024, 1, 1)),
          status: const Value(0),
        ),
      );
      final row = await epsDao.getById('ep-1');
      expect(row!.title, 'Updated Title');
    });

    test('getById returns null for missing', () async {
      final row = await epsDao.getById('nonexistent');
      expect(row, isNull);
    });

    test('getById returns episode', () async {
      await epsDao.upsert(makeEp('ep-1'));
      final row = await epsDao.getById('ep-1');
      expect(row, isNotNull);
      expect(row!.id, 'ep-1');
    });

    test('latestForPodcast returns N most recent by publishedAt', () async {
      await epsDao.upsert(makeEp('ep-1', publishedAt: DateTime(2024, 1, 1)));
      await epsDao.upsert(makeEp('ep-2', publishedAt: DateTime(2024, 3, 1)));
      await epsDao.upsert(makeEp('ep-3', publishedAt: DateTime(2024, 2, 1)));
      final results = await epsDao.latestForPodcast('pod-1', 2);
      expect(results.length, 2);
      expect(results[0].id, 'ep-2'); // newest first
      expect(results[1].id, 'ep-3');
    });

    test('latestForPodcast returns fewer if not enough episodes', () async {
      await epsDao.upsert(makeEp('ep-1'));
      final results = await epsDao.latestForPodcast('pod-1', 5);
      expect(results.length, 1);
    });

    test('getEpisodesByPodcastId returns all episodes for podcast', () async {
      await epsDao.upsert(makeEp('ep-1', podcastId: 'pod-1'));
      await epsDao.upsert(makeEp('ep-2', podcastId: 'pod-1'));
      await epsDao.upsert(makeEp('ep-3', podcastId: 'pod-2'));
      final results = await epsDao.getEpisodesByPodcastId('pod-1');
      expect(results.length, 2);
    });

    test('setQueued sets status to 1', () async {
      await epsDao.upsert(makeEp('ep-1'));
      await epsDao.setQueued('ep-1');
      final row = await epsDao.getById('ep-1');
      expect(row!.status, 1);
    });

    test('setDownloading sets status to 2 with progress', () async {
      await epsDao.upsert(makeEp('ep-1'));
      await epsDao.setDownloading('ep-1', progress: 0.5, bytes: 1024);
      final row = await epsDao.getById('ep-1');
      expect(row!.status, 2);
      expect(row.progress, 0.5);
      expect(row.bytesDownloaded, 1024);
    });

    test('setProgress updates progress and bytes', () async {
      await epsDao.upsert(makeEp('ep-1'));
      await epsDao.setProgress('ep-1', 0.75, bytes: 2048, total: 4096);
      final row = await epsDao.getById('ep-1');
      expect(row!.progress, 0.75);
      expect(row.bytesDownloaded, 2048);
      expect(row.totalBytes, 4096);
    });

    test('setCompleted sets status 3, localPath, completedAt', () async {
      await epsDao.upsert(makeEp('ep-1'));
      await epsDao.setCompleted('ep-1', '/path/to/file.mp3');
      final row = await epsDao.getById('ep-1');
      expect(row!.status, 3);
      expect(row.localPath, '/path/to/file.mp3');
      expect(row.progress, 1.0);
      expect(row.completedAt, isNotNull);
    });

    test('setFailed sets status to 4', () async {
      await epsDao.upsert(makeEp('ep-1'));
      await epsDao.setFailed('ep-1');
      final row = await epsDao.getById('ep-1');
      expect(row!.status, 4);
    });

    test('setCanceled sets status to 5', () async {
      await epsDao.upsert(makeEp('ep-1'));
      await epsDao.setCanceled('ep-1');
      final row = await epsDao.getById('ep-1');
      expect(row!.status, 5);
    });

    test('markPlayed sets playedAt', () async {
      await epsDao.upsert(makeEp('ep-1'));
      await epsDao.markPlayed('ep-1');
      final row = await epsDao.getById('ep-1');
      expect(row!.playedAt, isNotNull);
    });

    test('clearLocalFile resets localPath, cachedMetaPath, cachedImagePath, status=0',
        () async {
      await epsDao.upsert(makeEp('ep-1', status: 3, localPath: '/file.mp3'));
      await epsDao.setCachedMeta(
        'ep-1',
        metaPath: '/meta.json',
        imagePath: '/cover.jpg',
      );
      await epsDao.clearLocalFile('ep-1');
      final row = await epsDao.getById('ep-1');
      expect(row!.status, 0);
      expect(row.localPath, isNull);
      expect(row.cachedMetaPath, isNull);
      expect(row.cachedImagePath, isNull);
    });

    test('completedWithFileDesc returns only completed with file, newest first',
        () async {
      // Use explicit completedAt timestamps to ensure deterministic ordering.
      // setCompleted uses DateTime.now() which may be same ms, so write directly.
      await epsDao.upsert(makeEp('ep-1', status: 3, localPath: '/a.mp3'));
      await (db.update(db.episodes)..where((e) => e.id.equals('ep-1'))).write(
        EpisodesCompanion(
          completedAt: Value(DateTime(2024, 1, 1)),
        ),
      );

      await epsDao.upsert(makeEp('ep-2', status: 3, localPath: '/b.mp3'));
      await (db.update(db.episodes)..where((e) => e.id.equals('ep-2'))).write(
        EpisodesCompanion(
          completedAt: Value(DateTime(2024, 1, 2)),
        ),
      );

      // Not completed (status 0)
      await epsDao.upsert(makeEp('ep-3'));

      // Completed but no localPath
      await epsDao.upsert(makeEp('ep-4', status: 3));

      // Different podcast
      await epsDao.upsert(
          makeEp('ep-5', podcastId: 'pod-2', status: 3, localPath: '/c.mp3'));

      final results = await epsDao.completedWithFileDesc('pod-1');
      expect(results.length, 2);
      // Newest completedAt first (ep-2 Jan 2 > ep-1 Jan 1)
      expect(results[0].id, 'ep-2');
      expect(results[1].id, 'ep-1');
    });

    test('enqueueLatestN marks eligible episodes as queued (status 0, 4, 5)',
        () async {
      await epsDao.upsert(
          makeEp('ep-1', publishedAt: DateTime(2024, 3, 1), status: 0));
      await epsDao.upsert(
          makeEp('ep-2', publishedAt: DateTime(2024, 2, 1), status: 4));
      await epsDao.upsert(
          makeEp('ep-3', publishedAt: DateTime(2024, 1, 1), status: 5));

      await epsDao.enqueueLatestN('pod-1', 3);

      final ep1 = await epsDao.getById('ep-1');
      final ep2 = await epsDao.getById('ep-2');
      final ep3 = await epsDao.getById('ep-3');
      expect(ep1!.status, 1); // queued
      expect(ep2!.status, 1);
      expect(ep3!.status, 1);
    });

    test('enqueueLatestN skips already completed/queued episodes', () async {
      await epsDao.upsert(
          makeEp('ep-1', publishedAt: DateTime(2024, 3, 1), status: 3));
      await epsDao.upsert(
          makeEp('ep-2', publishedAt: DateTime(2024, 2, 1), status: 1));
      await epsDao.upsert(
          makeEp('ep-3', publishedAt: DateTime(2024, 1, 1), status: 0));

      await epsDao.enqueueLatestN('pod-1', 3);

      final ep1 = await epsDao.getById('ep-1');
      final ep2 = await epsDao.getById('ep-2');
      final ep3 = await epsDao.getById('ep-3');
      expect(ep1!.status, 3); // unchanged (completed)
      expect(ep2!.status, 1); // unchanged (already queued)
      expect(ep3!.status, 1); // queued (was 0)
    });

    test('setCachedMeta updates title, imagePath, metaPath', () async {
      await epsDao.upsert(makeEp('ep-1'));
      await epsDao.setCachedMeta(
        'ep-1',
        title: 'Cached Title',
        imagePath: '/cache/cover.jpg',
        metaPath: '/cache/meta.json',
      );
      final row = await epsDao.getById('ep-1');
      expect(row!.cachedTitle, 'Cached Title');
      expect(row.cachedImagePath, '/cache/cover.jpg');
      expect(row.cachedMetaPath, '/cache/meta.json');
    });

    test('upsertAll bulk inserts', () async {
      await epsDao.upsertAll([
        makeEp('ep-1'),
        makeEp('ep-2'),
        makeEp('ep-3'),
      ]);
      final ep1 = await epsDao.getById('ep-1');
      final ep2 = await epsDao.getById('ep-2');
      final ep3 = await epsDao.getById('ep-3');
      expect(ep1, isNotNull);
      expect(ep2, isNotNull);
      expect(ep3, isNotNull);
    });

    test('watchByPodcast emits episodes newest first by default', () async {
      await epsDao.upsert(makeEp('ep-old', publishedAt: DateTime(2024, 1, 1)));
      await epsDao.upsert(makeEp('ep-new', publishedAt: DateTime(2024, 6, 1)));

      final results = await epsDao.watchByPodcast('pod-1').first;
      expect(results.length, 2);
      expect(results[0].id, 'ep-new');
      expect(results[1].id, 'ep-old');
    });

    test('watchByPodcast with ascending=true emits oldest first', () async {
      await epsDao.upsert(makeEp('ep-old', publishedAt: DateTime(2024, 1, 1)));
      await epsDao.upsert(makeEp('ep-new', publishedAt: DateTime(2024, 6, 1)));

      final results =
          await epsDao.watchByPodcast('pod-1', ascending: true).first;
      expect(results[0].id, 'ep-old');
      expect(results[1].id, 'ep-new');
    });

    test('watchActiveDownloads returns only queued and downloading', () async {
      await epsDao.upsert(makeEp('ep-none', status: 0));
      await epsDao.upsert(makeEp('ep-queued', status: 1));
      await epsDao.upsert(makeEp('ep-dl', status: 2));
      await epsDao.upsert(makeEp('ep-done', status: 3));
      await epsDao.upsert(makeEp('ep-fail', status: 4));

      final results = await epsDao.watchActiveDownloads().first;
      expect(results.map((e) => e.id).toSet(), {'ep-queued', 'ep-dl'});
    });

    test('playedBefore returns episodes played before threshold', () async {
      final old = DateTime(2024, 1, 1);
      final recent = DateTime(2024, 6, 1);
      await epsDao.upsert(
          makeEp('ep-old', status: 3, localPath: '/a.mp3', playedAt: old));
      await epsDao.upsert(
          makeEp('ep-recent', status: 3, localPath: '/b.mp3', playedAt: recent));

      final threshold = DateTime(2024, 3, 1);
      final results = await epsDao.playedBefore(threshold);
      expect(results.map((e) => e.id), ['ep-old']);
    });
  });

  // =========================================================================
  // RetentionDao
  // =========================================================================

  group('RetentionDao', () {
    // Helper: insert a settings row so RetentionDao can read it.
    Future<void> insertSettings({int? deleteAfterHours, int? keepLatestN}) async {
      await db.into(db.settings).insert(
            SettingsCompanion(
              id: const Value(1),
              wifiOnly: const Value(false),
              maxParallel: const Value(2),
              deleteAfterHours: Value(deleteAfterHours),
              keepLatestN: Value(keepLatestN),
              autodownloadSubscribed: const Value(false),
              playOrder: const Value('newest'),
            ),
          );
    }

    test('computePlanForPodcast returns empty plan when no rules set',
        () async {
      await insertSettings();
      await epsDao.upsert(
          makeEp('ep-1', status: 3, localPath: '/a.mp3'));
      await epsDao.setCompleted('ep-1', '/a.mp3');

      final plan = await retentionDao.computePlanForPodcast('pod-1');
      expect(plan.toDeleteIds, isEmpty);
    });

    test(
        'computePlanForPodcast with deleteAfterHours marks old played episodes',
        () async {
      await insertSettings(deleteAfterHours: 1);

      // Episode played 2 hours ago (should be marked for deletion)
      final twoHoursAgo = DateTime.now().subtract(const Duration(hours: 2));
      await epsDao.upsert(makeEp(
        'ep-old',
        status: 3,
        localPath: '/old.mp3',
        playedAt: twoHoursAgo,
      ));

      // Episode played 30 minutes ago (should NOT be marked)
      final thirtyMinAgo =
          DateTime.now().subtract(const Duration(minutes: 30));
      await epsDao.upsert(makeEp(
        'ep-recent',
        status: 3,
        localPath: '/recent.mp3',
        playedAt: thirtyMinAgo,
      ));

      final plan = await retentionDao.computePlanForPodcast('pod-1');
      expect(plan.toDeleteIds, contains('ep-old'));
      expect(plan.toDeleteIds, isNot(contains('ep-recent')));
    });

    test(
        'computePlanForPodcast with keepLatestN marks excess completed episodes',
        () async {
      await insertSettings(keepLatestN: 1);

      // Two completed episodes; keepLatestN=1 means only keep the newest.
      // Use explicit completedAt to ensure deterministic ordering.
      await epsDao.upsert(makeEp('ep-1', status: 3, localPath: '/a.mp3'));
      await (db.update(db.episodes)..where((e) => e.id.equals('ep-1'))).write(
        EpisodesCompanion(completedAt: Value(DateTime(2024, 1, 1))),
      );

      await epsDao.upsert(makeEp('ep-2', status: 3, localPath: '/b.mp3'));
      await (db.update(db.episodes)..where((e) => e.id.equals('ep-2'))).write(
        EpisodesCompanion(completedAt: Value(DateTime(2024, 1, 2))),
      );

      final plan = await retentionDao.computePlanForPodcast('pod-1');
      // ep-2 is newest, ep-1 should be marked for deletion
      expect(plan.toDeleteIds, contains('ep-1'));
      expect(plan.toDeleteIds, isNot(contains('ep-2')));
    });

    test('computePlanForPodcast deduplicates IDs', () async {
      await insertSettings(deleteAfterHours: 1, keepLatestN: 1);

      final twoHoursAgo = DateTime.now().subtract(const Duration(hours: 2));
      // ep-1: old played, completed first
      await epsDao.upsert(makeEp(
        'ep-1',
        status: 3,
        localPath: '/a.mp3',
        playedAt: twoHoursAgo,
      ));
      await (db.update(db.episodes)..where((e) => e.id.equals('ep-1'))).write(
        EpisodesCompanion(completedAt: Value(DateTime(2024, 1, 1))),
      );

      // ep-2: old played, completed later
      await epsDao.upsert(makeEp(
        'ep-2',
        status: 3,
        localPath: '/b.mp3',
        playedAt: twoHoursAgo,
      ));
      await (db.update(db.episodes)..where((e) => e.id.equals('ep-2'))).write(
        EpisodesCompanion(completedAt: Value(DateTime(2024, 1, 2))),
      );

      final plan = await retentionDao.computePlanForPodcast('pod-1');
      // ep-1 could appear from both rules; verify no duplicates.
      final uniqueCount = plan.toDeleteIds.toSet().length;
      expect(plan.toDeleteIds.length, uniqueCount);
    });

    test('computePlanForPodcast with both rules combines results', () async {
      await insertSettings(deleteAfterHours: 1, keepLatestN: 2);

      final twoHoursAgo = DateTime.now().subtract(const Duration(hours: 2));

      // ep-1: old played, completed first (oldest)
      await epsDao.upsert(makeEp(
        'ep-1',
        status: 3,
        localPath: '/a.mp3',
        playedAt: twoHoursAgo,
      ));
      await (db.update(db.episodes)..where((e) => e.id.equals('ep-1'))).write(
        EpisodesCompanion(completedAt: Value(DateTime(2024, 1, 1))),
      );

      // ep-2: not played, completed second
      await epsDao.upsert(makeEp(
        'ep-2',
        status: 3,
        localPath: '/b.mp3',
      ));
      await (db.update(db.episodes)..where((e) => e.id.equals('ep-2'))).write(
        EpisodesCompanion(completedAt: Value(DateTime(2024, 1, 2))),
      );

      // ep-3: not played, completed third (newest)
      await epsDao.upsert(makeEp(
        'ep-3',
        status: 3,
        localPath: '/c.mp3',
      ));
      await (db.update(db.episodes)..where((e) => e.id.equals('ep-3'))).write(
        EpisodesCompanion(completedAt: Value(DateTime(2024, 1, 3))),
      );

      final plan = await retentionDao.computePlanForPodcast('pod-1');
      // deleteAfterHours catches ep-1 (played 2h ago)
      // keepLatestN=2 catches ep-1 (3 completed, oldest is excess)
      expect(plan.toDeleteIds, contains('ep-1'));
      // ep-2 and ep-3 are within keepLatestN=2 and not old-played
      expect(plan.toDeleteIds, isNot(contains('ep-3')));
    });
  });
}
