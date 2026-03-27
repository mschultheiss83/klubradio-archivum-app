// test/providers/episode_provider_queue_test.dart
//
// Unit tests for queue/playlist management in EpisodeProvider.
//
// Covers:
//   - addToQueue     : append, duplicate prevention, notifyListeners
//   - removeFromQueue: remove by id, edge cases, notifyListeners
//   - reorderQueue   : forward/backward moves, index-correction logic
//   - queue getter   : unmodifiable, empty initial state
//   - getNextEpisode : navigation, boundary, missing episode
//   - getPreviousEpisode: navigation, boundary
//   - playEpisode    : queue parameter sets list, without param prepends/deduplicates
//
// Widget tests for _QueueSheet (now_playing_bar.dart) are intentionally skipped
// because the widget depends on the AudioPlayer native plugin.
// See test/screens/podcast_detail_screen_test.dart for the documented pattern.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/audio_player_service.dart';

import 'episode_provider_queue_test.mocks.dart';

@GenerateMocks([AudioPlayerService, ApiService, db.AppDatabase])
void main() {
  // ==================== Helpers ====================

  /// Creates a minimal Episode with the given [id].
  Episode ep(String id, {String title = ''}) => Episode(
        id: id,
        podcastId: 'pod-1',
        title: title.isEmpty ? 'Episode $id' : title,
        description: 'Desc',
        audioUrl: 'https://example.com/$id.mp3',
        publishedAt: DateTime(2024, 1, 1),
        showDate: '2024-01-01',
        duration: const Duration(minutes: 30),
      );

  // ==================== Test fixtures ====================

  late MockAudioPlayerService mockAudio;
  late MockApiService mockApi;
  late MockAppDatabase mockDb;
  late StreamController<Duration> positionCtrl;
  late StreamController<PlayerState> playerStateCtrl;
  late StreamController<bool> bufferingCtrl;
  late EpisodeProvider provider;

  setUp(() {
    positionCtrl = StreamController<Duration>.broadcast();
    playerStateCtrl = StreamController<PlayerState>.broadcast();
    bufferingCtrl = StreamController<bool>.broadcast();

    mockAudio = MockAudioPlayerService();
    mockApi = MockApiService();
    mockDb = MockAppDatabase();

    // Stub streams required by EpisodeProvider constructor
    when(mockAudio.positionStream).thenAnswer((_) => positionCtrl.stream);
    when(mockAudio.playerStateStream)
        .thenAnswer((_) => playerStateCtrl.stream);
    when(mockAudio.bufferingStream).thenAnswer((_) => bufferingCtrl.stream);
    when(mockAudio.errorStream).thenAnswer((_) => const Stream<String?>.empty());
    when(mockAudio.isPlaying).thenReturn(false);
    when(mockAudio.totalDuration).thenReturn(null);
    // loadEpisode is called by playEpisode; return immediately without errors
    when(mockAudio.loadEpisode(any)).thenAnswer((_) async {});

    provider = EpisodeProvider(
      apiService: mockApi,
      audioPlayerService: mockAudio,
      db: mockDb,
    );
  });

  tearDown(() async {
    await positionCtrl.close();
    await playerStateCtrl.close();
    await bufferingCtrl.close();
    await provider.dispose();
  });

  // ==================== addToQueue ====================

  group('addToQueue', () {
    test('appends episodes in order', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      expect(provider.queue.map((e) => e.id), ['a', 'b', 'c']);
    });

    test('does not add duplicate (same id)', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('a'));

      expect(provider.queue.length, 1);
    });

    test('notifies listeners when episode is added', () {
      int calls = 0;
      provider.addListener(() => calls++);

      provider.addToQueue(ep('x'));

      expect(calls, 1);
    });

    test('does not notify listeners when duplicate is rejected', () {
      provider.addToQueue(ep('x')); // first add succeeds
      int calls = 0;
      provider.addListener(() => calls++);

      provider.addToQueue(ep('x')); // duplicate → rejected silently

      expect(calls, 0);
    });
  });

  // ==================== removeFromQueue ====================

  group('removeFromQueue', () {
    test('removes episode by id from the middle', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      provider.removeFromQueue('b');

      expect(provider.queue.map((e) => e.id), ['a', 'c']);
    });

    test('removes first episode', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));

      provider.removeFromQueue('a');

      expect(provider.queue.map((e) => e.id), ['b']);
    });

    test('removes last episode', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));

      provider.removeFromQueue('b');

      expect(provider.queue.map((e) => e.id), ['a']);
    });

    test('is a no-op when id is not in queue', () {
      provider.addToQueue(ep('a'));

      provider.removeFromQueue('does-not-exist');

      expect(provider.queue.length, 1);
    });

    test('empties queue when only episode is removed', () {
      provider.addToQueue(ep('only'));

      provider.removeFromQueue('only');

      expect(provider.queue, isEmpty);
    });

    test('notifies listeners on remove', () {
      provider.addToQueue(ep('x'));
      int calls = 0;
      provider.addListener(() => calls++);

      provider.removeFromQueue('x');

      expect(calls, 1);
    });
  });

  // ==================== reorderQueue ====================
  //
  // reorderQueue mirrors the Flutter ReorderableListView contract:
  //   - When dragging FORWARD (oldIndex < newIndex), the widget passes
  //     newIndex = targetPosition + 1. The provider adjusts: newIndex -= 1.
  //   - When dragging BACKWARD (oldIndex >= newIndex), no adjustment.
  //
  // Queue before each test: [a(0), b(1), c(2), d(3)]

  group('reorderQueue', () {
    setUp(() {
      for (final id in ['a', 'b', 'c', 'd']) {
        provider.addToQueue(ep(id));
      }
    });

    test('moves item backward: d (3) → before b (1)', () {
      // oldIndex=3, newIndex=1 → no adjustment (oldIndex > newIndex)
      // removeAt(3): [a, b, c]  →  insert(1, d): [a, d, b, c]
      provider.reorderQueue(3, 1);

      expect(provider.queue.map((e) => e.id), ['a', 'd', 'b', 'c']);
    });

    test('moves item forward: a (0) → before d, widget passes newIndex=3', () {
      // oldIndex=0, newIndex=3 → adjust: newIndex=2
      // removeAt(0): [b, c, d]  →  insert(2, a): [b, c, a, d]
      provider.reorderQueue(0, 3);

      expect(provider.queue.map((e) => e.id), ['b', 'c', 'a', 'd']);
    });

    test('moves item one step forward: a (0) → widget passes newIndex=2', () {
      // oldIndex=0, newIndex=2 → adjust: newIndex=1
      // removeAt(0): [b, c, d]  →  insert(1, a): [b, a, c, d]
      provider.reorderQueue(0, 2);

      expect(provider.queue.map((e) => e.id), ['b', 'a', 'c', 'd']);
    });

    test('moves item one step backward: c (2) → before b (1)', () {
      // oldIndex=2, newIndex=1 → no adjustment
      // removeAt(2): [a, b, d]  →  insert(1, c): [a, c, b, d]
      provider.reorderQueue(2, 1);

      expect(provider.queue.map((e) => e.id), ['a', 'c', 'b', 'd']);
    });

    test('no-op when oldIndex == newIndex', () {
      // oldIndex=2, newIndex=2 → no adjustment (not < newIndex)
      // removeAt(2): [a, b, d]  →  insert(2, c): [a, b, c, d]
      provider.reorderQueue(2, 2);

      expect(provider.queue.map((e) => e.id), ['a', 'b', 'c', 'd']);
    });

    test('moves item to first position', () {
      // Move d to front: oldIndex=3, newIndex=0
      // removeAt(3): [a, b, c]  →  insert(0, d): [d, a, b, c]
      provider.reorderQueue(3, 0);

      expect(provider.queue.map((e) => e.id), ['d', 'a', 'b', 'c']);
    });

    test('moves item to last position via widget convention', () {
      // Move a to after d: widget passes newIndex=4 (length)
      // oldIndex=0, newIndex=4 → adjust: newIndex=3
      // removeAt(0): [b, c, d]  →  insert(3, a): [b, c, d, a]
      provider.reorderQueue(0, 4);

      expect(provider.queue.map((e) => e.id), ['b', 'c', 'd', 'a']);
    });

    test('notifies listeners after reorder', () {
      int calls = 0;
      provider.addListener(() => calls++);

      provider.reorderQueue(0, 2);

      expect(calls, 1);
    });
  });

  // ==================== queue getter ====================

  group('queue getter', () {
    test('returns empty list initially', () {
      expect(provider.queue, isEmpty);
    });

    test('returns unmodifiable list — add throws', () {
      provider.addToQueue(ep('a'));

      expect(
        () => provider.queue.add(ep('illegal')),
        throwsUnsupportedError,
      );
    });

    test('returned list reflects current state', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));

      expect(provider.queue.length, 2);

      provider.removeFromQueue('a');

      expect(provider.queue.length, 1);
      expect(provider.queue.first.id, 'b');
    });
  });

  // ==================== getNextEpisode ====================

  group('getNextEpisode', () {
    test('returns null when no current episode', () {
      provider.addToQueue(ep('a'));

      expect(provider.getNextEpisode(), isNull);
    });

    test('returns null when queue is empty', () {
      expect(provider.getNextEpisode(), isNull);
    });

    test('returns next episode in queue', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(a, queue: [a, b, c]);

      expect(provider.getNextEpisode()?.id, 'b');
    });

    test('returns null when at last episode', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(b, queue: [a, b]);

      expect(provider.getNextEpisode(), isNull);
    });

    test('returns null when current episode is no longer in queue', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(a, queue: [a, b]);
      provider.removeFromQueue('a'); // remove current from queue

      expect(provider.getNextEpisode(), isNull);
    });

    test('returns correct next after queue is reordered', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(a, queue: [a, b, c]);
      // Move c before b: reorderQueue(2, 1) → [a, c, b]
      provider.reorderQueue(2, 1);

      expect(provider.getNextEpisode()?.id, 'c');
    });
  });

  // ==================== getPreviousEpisode ====================

  group('getPreviousEpisode', () {
    test('returns null when no current episode', () {
      provider.addToQueue(ep('a'));

      expect(provider.getPreviousEpisode(), isNull);
    });

    test('returns null when at first episode', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(a, queue: [a, b]);

      expect(provider.getPreviousEpisode(), isNull);
    });

    test('returns previous episode', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(b, queue: [a, b, c]);

      expect(provider.getPreviousEpisode()?.id, 'a');
    });

    test('returns second-to-last when at last episode', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(c, queue: [a, b, c]);

      expect(provider.getPreviousEpisode()?.id, 'b');
    });

    test('returns correct previous after queue is reordered', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(c, queue: [a, b, c]);
      // Move a to end: reorderQueue(0, 3) → [b, c, a]
      provider.reorderQueue(0, 3);

      expect(provider.getPreviousEpisode()?.id, 'b');
    });
  });

  // ==================== playEpisode — queue behaviour ====================

  group('playEpisode — queue behaviour', () {
    test('with queue param: replaces queue with provided list', () async {
      provider.addToQueue(ep('old'));
      final a = ep('a');
      final b = ep('b');

      await provider.playEpisode(a, queue: [a, b]);

      expect(provider.queue.map((e) => e.id), ['a', 'b']);
    });

    test('without queue param: prepends episode when not already in queue',
        () async {
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      await provider.playEpisode(ep('a'));

      expect(provider.queue.first.id, 'a');
      expect(provider.queue.length, 3);
    });

    test('without queue param: does not prepend if already in queue', () async {
      final a = ep('a');
      provider.addToQueue(a);

      await provider.playEpisode(a);

      expect(provider.queue.length, 1);
    });

    test('sets currentEpisode to the played episode', () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      expect(provider.currentEpisode?.id, 'a');
    });

    test('notifies listeners after playEpisode', () async {
      int calls = 0;
      provider.addListener(() => calls++);

      await provider.playEpisode(ep('a'), queue: [ep('a')]);

      expect(calls, greaterThan(0));
    });
  });

  // ==================== combined: remove while navigating ====================

  group('remove + navigation', () {
    test('removing non-current episode shifts next correctly', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(a, queue: [a, b, c]);

      provider.removeFromQueue('b'); // remove the one after current

      expect(provider.getNextEpisode()?.id, 'c');
    });

    test('removing current does not affect previous lookup', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(b, queue: [a, b, c]);

      provider.removeFromQueue('b'); // remove current

      // b is gone from queue, indexWhere returns -1 → null
      expect(provider.getPreviousEpisode(), isNull);
      expect(provider.getNextEpisode(), isNull);
    });
  });
}
