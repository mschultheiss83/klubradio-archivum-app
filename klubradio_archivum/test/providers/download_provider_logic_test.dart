// test/providers/download_provider_logic_test.dart
//
// Tests the autoEnqueueLatestN candidate-filtering logic from DownloadProvider
// using an in-memory Drift database. We replicate the filtering logic because
// DownloadProvider's constructor requires native plugins we can't instantiate
// in a unit-test environment.

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;

void main() {
  late AppDatabase db;
  late EpisodesDao epsDao;

  model.Episode ep(String id) => model.Episode(
        id: id,
        podcastId: 'pod-1',
        title: 'Episode $id',
        description: '',
        audioUrl: 'https://example.com/$id.mp3',
        publishedAt: DateTime(2024, 1, 1),
        showDate: '2024-01-01',
        duration: const Duration(minutes: 30),
      );

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    epsDao = EpisodesDao(db);
  });

  tearDown(() async => await db.close());

  // Replicate the autoEnqueueLatestN filtering logic from DownloadProvider.
  // Returns IDs of episodes that WOULD be enqueued.
  Future<List<String>> filterCandidates(
    EpisodesDao dao,
    List<model.Episode> candidates,
    int n,
  ) async {
    final latest = candidates.take(n).toList();
    final toEnqueue = <String>[];

    for (final ep in latest) {
      final row = await dao.getById(ep.id);
      final alreadyDone =
          row?.status == 3 && (row?.localPath ?? '').isNotEmpty;
      final alreadyQueuedOrRunning = row?.status == 1 || row?.status == 2;

      if (alreadyDone || alreadyQueuedOrRunning) continue;

      if (row == null) {
        await dao.upsert(
          EpisodesCompanion(
            id: Value(ep.id),
            podcastId: Value(ep.podcastId),
            title: Value(ep.title),
            audioUrl: Value(ep.audioUrl),
            publishedAt: Value(ep.publishedAt),
            status: const Value(0),
            progress: const Value(0),
          ),
        );
      }
      toEnqueue.add(ep.id);
    }
    return toEnqueue;
  }

  group('autoEnqueueLatestN filtering logic', () {
    test('enqueues episode not in DB', () async {
      final result = await filterCandidates(epsDao, [ep('new-1')], 1);
      expect(result, ['new-1']);
      // Episode should now be in DB
      final row = await epsDao.getById('new-1');
      expect(row, isNotNull);
      expect(row!.status, 0);
    });

    test('skips completed episode with local file (status=3)', () async {
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('done-1'),
        podcastId: const Value('pod-1'),
        title: const Value('Done'),
        audioUrl: const Value('https://x.com/done.mp3'),
        status: const Value(3),
        localPath: const Value('/path/file.mp3'),
      ));

      final result = await filterCandidates(epsDao, [ep('done-1')], 1);
      expect(result, isEmpty);
    });

    test('skips queued episode (status=1)', () async {
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('q-1'),
        podcastId: const Value('pod-1'),
        title: const Value('Queued'),
        audioUrl: const Value('https://x.com/q.mp3'),
        status: const Value(1),
      ));

      final result = await filterCandidates(epsDao, [ep('q-1')], 1);
      expect(result, isEmpty);
    });

    test('skips downloading episode (status=2)', () async {
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('dl-1'),
        podcastId: const Value('pod-1'),
        title: const Value('Downloading'),
        audioUrl: const Value('https://x.com/dl.mp3'),
        status: const Value(2),
      ));

      final result = await filterCandidates(epsDao, [ep('dl-1')], 1);
      expect(result, isEmpty);
    });

    test('enqueues failed episode (status=4)', () async {
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('fail-1'),
        podcastId: const Value('pod-1'),
        title: const Value('Failed'),
        audioUrl: const Value('https://x.com/fail.mp3'),
        status: const Value(4),
      ));

      final result = await filterCandidates(epsDao, [ep('fail-1')], 1);
      expect(result, ['fail-1']);
    });

    test('enqueues canceled episode (status=5)', () async {
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('cancel-1'),
        podcastId: const Value('pod-1'),
        title: const Value('Canceled'),
        audioUrl: const Value('https://x.com/cancel.mp3'),
        status: const Value(5),
      ));

      final result = await filterCandidates(epsDao, [ep('cancel-1')], 1);
      expect(result, ['cancel-1']);
    });

    test('enqueues none/unstarted episode (status=0)', () async {
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('none-1'),
        podcastId: const Value('pod-1'),
        title: const Value('None'),
        audioUrl: const Value('https://x.com/none.mp3'),
        status: const Value(0),
      ));

      final result = await filterCandidates(epsDao, [ep('none-1')], 1);
      expect(result, ['none-1']);
    });

    test('respects n limit (takes first N candidates)', () async {
      final candidates = [ep('a'), ep('b'), ep('c'), ep('d')];
      final result = await filterCandidates(epsDao, candidates, 2);
      expect(result, ['a', 'b']);
    });

    test('mixed statuses: filters correctly', () async {
      // done-1 completed, q-1 queued, new-1 new, fail-1 failed
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('done-1'),
        podcastId: const Value('pod-1'),
        title: const Value('Done'),
        audioUrl: const Value('https://x.com/d.mp3'),
        status: const Value(3),
        localPath: const Value('/f.mp3'),
      ));
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('q-1'),
        podcastId: const Value('pod-1'),
        title: const Value('Queued'),
        audioUrl: const Value('https://x.com/q.mp3'),
        status: const Value(1),
      ));

      final candidates = [ep('done-1'), ep('q-1'), ep('new-1'), ep('fail-1')];

      // Pre-insert fail-1 as failed
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('fail-1'),
        podcastId: const Value('pod-1'),
        title: const Value('Failed'),
        audioUrl: const Value('https://x.com/f.mp3'),
        status: const Value(4),
      ));

      final result = await filterCandidates(epsDao, candidates, 4);
      expect(result, containsAll(['new-1', 'fail-1']));
      expect(result, isNot(contains('done-1')));
      expect(result, isNot(contains('q-1')));
    });

    test('completed without localPath IS enqueued', () async {
      // status=3 but localPath is empty -> not "done", should be re-enqueued
      await epsDao.upsert(EpisodesCompanion(
        id: const Value('nofile-1'),
        podcastId: const Value('pod-1'),
        title: const Value('NoFile'),
        audioUrl: const Value('https://x.com/nf.mp3'),
        status: const Value(3),
        localPath: const Value(''),
      ));

      final result = await filterCandidates(epsDao, [ep('nofile-1')], 1);
      expect(result, ['nofile-1']);
    });
  });
}
