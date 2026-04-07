// test/providers/episode_provider_playback_test.dart
//
// Unit tests for playback, lifecycle, and stream callback methods in
// EpisodeProvider — complementing the queue tests in
// episode_provider_queue_test.dart.
//
// Covers:
//   - playEpisode      : currentEpisode, loadEpisode call, busy guard, queue handling
//   - onEpisodeDownloaded : localFilePath update, no-op cases
//   - seekRelative      : forward/backward, clamping, no-op when null
//   - playback controls : togglePlayPause, seek, updatePlaybackSpeed
//   - stream callbacks  : position, playerState, buffering, error streams
//   - fetchEpisodes     : delegation, cache clearing

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/mockito.dart';

import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/audio_player_service.dart';

// Reuse the generated mocks from the queue test file.
import 'episode_provider_queue_test.mocks.dart';

void main() {
  // ==================== Helpers ====================

  /// Creates a minimal Episode with the given [id].
  Episode ep(String id, {String title = '', String? localPath}) => Episode(
        id: id,
        podcastId: 'pod-1',
        title: title.isEmpty ? 'Episode $id' : title,
        description: 'Desc',
        audioUrl: 'https://example.com/$id.mp3',
        publishedAt: DateTime(2024, 1, 1),
        showDate: '2024-01-01',
        duration: const Duration(minutes: 30),
        localFilePath: localPath,
      );

  // ==================== Test fixtures ====================

  late MockAudioPlayerService mockAudio;
  late MockApiService mockApi;
  late MockAppDatabase mockDb;
  late StreamController<Duration> positionCtrl;
  late StreamController<PlayerState> playerStateCtrl;
  late StreamController<bool> bufferingCtrl;
  late StreamController<String?> errorCtrl;
  late EpisodeProvider provider;

  setUp(() {
    positionCtrl = StreamController<Duration>.broadcast();
    playerStateCtrl = StreamController<PlayerState>.broadcast();
    bufferingCtrl = StreamController<bool>.broadcast();
    errorCtrl = StreamController<String?>.broadcast();

    mockAudio = MockAudioPlayerService();
    mockApi = MockApiService();
    mockDb = MockAppDatabase();

    // Stub streams required by EpisodeProvider constructor
    when(mockAudio.positionStream).thenAnswer((_) => positionCtrl.stream);
    when(mockAudio.playerStateStream)
        .thenAnswer((_) => playerStateCtrl.stream);
    when(mockAudio.bufferingStream).thenAnswer((_) => bufferingCtrl.stream);
    when(mockAudio.errorStream).thenAnswer((_) => errorCtrl.stream);
    when(mockAudio.isPlaying).thenReturn(false);
    when(mockAudio.totalDuration).thenReturn(null);
    when(mockAudio.currentEpisode).thenReturn(null);

    // Default stubs for methods called during playEpisode
    when(mockAudio.loadEpisode(any)).thenAnswer((_) async {});
    when(mockAudio.setSpeed(any)).thenAnswer((_) async {});
    when(mockAudio.seek(any)).thenAnswer((_) async {});
    when(mockAudio.togglePlayPause()).thenAnswer((_) async {});

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
    await errorCtrl.close();
    await provider.dispose();
  });

  // ==================== playEpisode ====================

  group('playEpisode', () {
    test('sets currentEpisode and notifies listeners', () async {
      int calls = 0;
      provider.addListener(() => calls++);

      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      expect(provider.currentEpisode?.id, 'a');
      expect(calls, greaterThan(0));
    });

    test('calls audioService.loadEpisode with the episode', () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      verify(mockAudio.loadEpisode(a)).called(1);
    });

    test('busy guard prevents concurrent calls', () async {
      // Make loadEpisode take a long time so the first call stays busy.
      final completer = Completer<void>();
      when(mockAudio.loadEpisode(any)).thenAnswer((_) => completer.future);

      final a = ep('a');
      final b = ep('b');

      // Start first call (does not complete)
      final firstCall = provider.playEpisode(a, queue: [a, b]);

      // Second call should be rejected because _playBusy is true
      await provider.playEpisode(b, queue: [a, b]);

      // Current episode should be 'a' (first call set it before await)
      expect(provider.currentEpisode?.id, 'a');

      // Let first call complete
      completer.complete();
      await firstCall;
    });

    test('with queue parameter, sets the queue', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(a, queue: [a, b]);

      expect(provider.queue.map((e) => e.id), ['a', 'b']);
    });

    test('without queue parameter, prepends to existing queue', () async {
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      await provider.playEpisode(ep('a'));

      expect(provider.queue.first.id, 'a');
      expect(provider.queue.length, 3);
    });

    test('calls setSpeed with current playback speed after loading', () async {
      // Change speed first
      await provider.updatePlaybackSpeed(1.5);
      reset(mockAudio);

      // Re-stub everything after reset
      when(mockAudio.positionStream).thenAnswer((_) => positionCtrl.stream);
      when(mockAudio.playerStateStream)
          .thenAnswer((_) => playerStateCtrl.stream);
      when(mockAudio.bufferingStream).thenAnswer((_) => bufferingCtrl.stream);
      when(mockAudio.errorStream).thenAnswer((_) => errorCtrl.stream);
      when(mockAudio.loadEpisode(any)).thenAnswer((_) async {});
      when(mockAudio.setSpeed(any)).thenAnswer((_) async {});

      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      verify(mockAudio.setSpeed(1.5)).called(1);
    });
  });

  // ==================== onEpisodeDownloaded ====================

  group('onEpisodeDownloaded', () {
    test('updates localFilePath of current episode', () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      await provider.onEpisodeDownloaded('a', '/downloads/a.mp3');

      expect(provider.currentEpisode?.localFilePath, '/downloads/a.mp3');
    });

    test('notifies listeners when current episode matches', () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      int calls = 0;
      provider.addListener(() => calls++);

      await provider.onEpisodeDownloaded('a', '/downloads/a.mp3');

      expect(calls, greaterThan(0));
    });

    test('does not update localFilePath when episode ID does not match',
        () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      await provider.onEpisodeDownloaded('b', '/downloads/b.mp3');

      expect(provider.currentEpisode?.localFilePath, isNull);
    });

    test('is safe when no current episode is set', () async {
      // No episode playing — should not throw
      await provider.onEpisodeDownloaded('a', '/downloads/a.mp3');

      expect(provider.currentEpisode, isNull);
    });

    test('notifies listeners even when episode ID does not match', () async {
      // The implementation always calls notifyListeners regardless of match
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      int calls = 0;
      provider.addListener(() => calls++);

      await provider.onEpisodeDownloaded('non-existent', '/path');

      // notifyListeners is called unconditionally in the source
      expect(calls, greaterThan(0));
    });
  });

  // ==================== seekRelative ====================

  group('seekRelative', () {
    test('seeks forward by given duration', () async {
      when(mockAudio.totalDuration)
          .thenReturn(const Duration(minutes: 30));

      // Simulate current position at 5 minutes via position stream
      positionCtrl.add(const Duration(minutes: 5));
      await Future<void>.delayed(Duration.zero); // let stream propagate

      await provider.seekRelative(const Duration(seconds: 30));

      final expectedPosition = const Duration(minutes: 5, seconds: 30);
      verify(mockAudio.seek(expectedPosition)).called(1);
    });

    test('seeks backward by given duration', () async {
      when(mockAudio.totalDuration)
          .thenReturn(const Duration(minutes: 30));

      positionCtrl.add(const Duration(minutes: 5));
      await Future<void>.delayed(Duration.zero);

      await provider.seekRelative(const Duration(seconds: -30));

      final expectedPosition = const Duration(minutes: 4, seconds: 30);
      verify(mockAudio.seek(expectedPosition)).called(1);
    });

    test('clamps to zero when seeking past start', () async {
      when(mockAudio.totalDuration)
          .thenReturn(const Duration(minutes: 30));

      positionCtrl.add(const Duration(seconds: 10));
      await Future<void>.delayed(Duration.zero);

      await provider.seekRelative(const Duration(seconds: -60));

      verify(mockAudio.seek(Duration.zero)).called(1);
    });

    test('clamps to total duration when seeking past end', () async {
      const total = Duration(minutes: 30);
      when(mockAudio.totalDuration).thenReturn(total);

      positionCtrl.add(const Duration(minutes: 29, seconds: 50));
      await Future<void>.delayed(Duration.zero);

      await provider.seekRelative(const Duration(seconds: 30));

      verify(mockAudio.seek(total)).called(1);
    });

    test('uses Duration.zero as total when totalDuration is null', () async {
      // totalDuration returns null (default stub)
      when(mockAudio.totalDuration).thenReturn(null);

      positionCtrl.add(const Duration(seconds: 10));
      await Future<void>.delayed(Duration.zero);

      // Seeking forward when total is zero → clamps to Duration.zero
      await provider.seekRelative(const Duration(seconds: 5));

      verify(mockAudio.seek(Duration.zero)).called(1);
    });

    test('updates positionNotifier optimistically before seek', () async {
      when(mockAudio.totalDuration)
          .thenReturn(const Duration(minutes: 30));

      positionCtrl.add(const Duration(minutes: 5));
      await Future<void>.delayed(Duration.zero);

      await provider.seekRelative(const Duration(seconds: 15));

      expect(
        provider.positionNotifier.value,
        const Duration(minutes: 5, seconds: 15),
      );
    });
  });

  // ==================== playback controls ====================

  group('playback controls', () {
    test('togglePlayPause delegates to audio service', () async {
      await provider.togglePlayPause();

      verify(mockAudio.togglePlayPause()).called(1);
    });

    test('seek delegates to audio service', () async {
      const target = Duration(minutes: 10);
      await provider.seek(target);

      verify(mockAudio.seek(target)).called(1);
    });

    test('updatePlaybackSpeed calls audioService.setSpeed', () async {
      await provider.updatePlaybackSpeed(2.0);

      verify(mockAudio.setSpeed(2.0)).called(1);
    });

    test('updatePlaybackSpeed updates playbackSpeed getter', () async {
      await provider.updatePlaybackSpeed(1.5);

      expect(provider.playbackSpeed, 1.5);
    });

    test('updatePlaybackSpeed notifies listeners', () async {
      int calls = 0;
      provider.addListener(() => calls++);

      await provider.updatePlaybackSpeed(0.75);

      expect(calls, 1);
    });
  });

  // ==================== stream callbacks ====================

  group('stream callbacks', () {
    test('position stream updates positionNotifier', () async {
      const pos = Duration(minutes: 3, seconds: 42);
      positionCtrl.add(pos);
      await Future<void>.delayed(Duration.zero);

      expect(provider.positionNotifier.value, pos);
    });

    test('playerState stream notifies listeners', () async {
      int calls = 0;
      provider.addListener(() => calls++);

      playerStateCtrl.add(PlayerState(false, ProcessingState.ready));
      await Future<void>.delayed(Duration.zero);

      expect(calls, 1);
    });

    test('buffering stream updates isBuffering and notifies', () async {
      int calls = 0;
      provider.addListener(() => calls++);

      bufferingCtrl.add(true);
      await Future<void>.delayed(Duration.zero);

      expect(provider.isBuffering, true);
      expect(calls, 1);

      bufferingCtrl.add(false);
      await Future<void>.delayed(Duration.zero);

      expect(provider.isBuffering, false);
      expect(calls, 2);
    });

    test('error stream notifies listeners', () async {
      int calls = 0;
      provider.addListener(() => calls++);

      // currentEpisode is null on the service → provider clears its episode
      when(mockAudio.currentEpisode).thenReturn(null);

      errorCtrl.add('Some audio error');
      await Future<void>.delayed(Duration.zero);

      expect(calls, 1);
    });

    test('error stream clears currentEpisode when service has none', () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);
      expect(provider.currentEpisode, isNotNull);

      // Simulate the audio service clearing its episode on error
      when(mockAudio.currentEpisode).thenReturn(null);

      errorCtrl.add('Load failed');
      await Future<void>.delayed(Duration.zero);

      expect(provider.currentEpisode, isNull);
    });

    test('error stream keeps currentEpisode when service still has one',
        () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      // Service still considers the episode loaded
      when(mockAudio.currentEpisode).thenReturn(a);

      errorCtrl.add('Transient error');
      await Future<void>.delayed(Duration.zero);

      // Provider should NOT clear its episode
      expect(provider.currentEpisode?.id, 'a');
    });

    test('position stream resets to zero when error clears episode', () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      // Set position to something
      positionCtrl.add(const Duration(minutes: 5));
      await Future<void>.delayed(Duration.zero);
      expect(provider.positionNotifier.value, const Duration(minutes: 5));

      // Error clears episode
      when(mockAudio.currentEpisode).thenReturn(null);
      errorCtrl.add('Fatal error');
      await Future<void>.delayed(Duration.zero);

      expect(provider.positionNotifier.value, Duration.zero);
    });
  });

  // ==================== fetchEpisodes ====================

  group('fetchEpisodes', () {
    test('delegates to apiService.fetchEpisodesForPodcast', () async {
      final episodes = [ep('a'), ep('b')];
      when(mockApi.fetchEpisodesForPodcast('pod-1'))
          .thenAnswer((_) async => episodes);

      final result = await provider.fetchEpisodes('pod-1');

      verify(mockApi.fetchEpisodesForPodcast('pod-1')).called(1);
      expect(result.length, 2);
      expect(result.first.id, 'a');
    });

    test('clearLoadedPodcastsCache clears the cache', () {
      // This should not throw; it clears the internal _loadedPodcasts map
      provider.clearLoadedPodcastsCache();

      // No assertion beyond "does not throw" — the cache is internal.
      // The observable effect is that loadEpisodesIntoDb would re-fetch,
      // but that requires DB mocking beyond this test's scope.
    });
  });

  // ==================== playNext / playPrevious ====================

  group('playNext', () {
    test('plays next episode in queue', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(a, queue: [a, b]);

      await provider.playNext();

      expect(provider.currentEpisode?.id, 'b');
    });

    test('does nothing when at last episode', () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      await provider.playNext();

      expect(provider.currentEpisode?.id, 'a');
    });

    test('does nothing when no current episode', () async {
      await provider.playNext();

      expect(provider.currentEpisode, isNull);
    });
  });

  group('playPrevious', () {
    test('plays previous episode in queue', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(b, queue: [a, b]);

      await provider.playPrevious();

      expect(provider.currentEpisode?.id, 'a');
    });

    test('does nothing when at first episode', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(a, queue: [a, b]);

      await provider.playPrevious();

      expect(provider.currentEpisode?.id, 'a');
    });

    test('does nothing when no current episode', () async {
      await provider.playPrevious();

      expect(provider.currentEpisode, isNull);
    });
  });

  // ==================== isPlaying getter ====================

  group('isPlaying', () {
    test('delegates to audioPlayerService.isPlaying', () {
      when(mockAudio.isPlaying).thenReturn(true);
      expect(provider.isPlaying, true);

      when(mockAudio.isPlaying).thenReturn(false);
      expect(provider.isPlaying, false);
    });
  });

  // ==================== totalDuration getter ====================

  group('totalDuration', () {
    test('delegates to audioPlayerService.totalDuration', () {
      when(mockAudio.totalDuration)
          .thenReturn(const Duration(minutes: 45));
      expect(provider.totalDuration, const Duration(minutes: 45));

      when(mockAudio.totalDuration).thenReturn(null);
      expect(provider.totalDuration, isNull);
    });
  });
}
