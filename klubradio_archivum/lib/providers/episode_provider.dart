import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:drift/drift.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/audio_player_service.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;
import 'package:klubradio_archivum/utils/episode_cache_reader.dart';

class EpisodeProvider extends ChangeNotifier {
  EpisodeProvider({
    required ApiService apiService,
    required AudioPlayerService audioPlayerService,
    required db.AppDatabase db,
  }) : _apiService = apiService,
       _db = db,
       _audioPlayerService = audioPlayerService {
    _positionSubscription = _audioPlayerService.positionStream.listen(
      _onPositionChanged,
    );
    _playerStateSubscription = _audioPlayerService.playerStateStream.listen(
      _onPlayerStateChanged,
    );
    _bufferingSubscription = _audioPlayerService.bufferingStream.listen(
      _onBufferingChanged,
    );
    _errorSubscription = _audioPlayerService.errorStream.listen(_onAudioError);
  }

  late db.AppDatabase _db;
  ApiService _apiService;
  AudioPlayerService _audioPlayerService;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<bool>? _bufferingSubscription;
  StreamSubscription<String?>? _errorSubscription;

  final ValueNotifier<Duration> _positionNotifier = ValueNotifier<Duration>(
    Duration.zero,
  );

  model.Episode? _currentEpisode;
  List<model.Episode> _queue = <model.Episode>[];
  bool _isBuffering = false;
  double _playbackSpeed = 1.0;
  bool _playBusy = false;

  model.Episode? get currentEpisode => _currentEpisode;
  ValueNotifier<Duration> get positionNotifier => _positionNotifier;

  bool get isPlaying => _audioPlayerService.isPlaying;
  bool get isBuffering => _isBuffering;
  Duration? get totalDuration => _audioPlayerService.totalDuration;
  List<model.Episode> get queue => List<model.Episode>.unmodifiable(_queue);
  double get playbackSpeed => _playbackSpeed;

  void updateDependencies(
    ApiService apiService,
    AudioPlayerService audioPlayerService,
    db.AppDatabase db,
  ) {
    if (!identical(_apiService, apiService)) {
      _apiService = apiService;
    }
    if (!identical(_db, db)) _db = db;
    if (!identical(_audioPlayerService, audioPlayerService)) {
      _positionSubscription?.cancel();
      _playerStateSubscription?.cancel();
      _bufferingSubscription?.cancel();
      _errorSubscription?.cancel();
      _audioPlayerService = audioPlayerService;
      _positionSubscription = _audioPlayerService.positionStream.listen(
        _onPositionChanged,
      );
      _playerStateSubscription = _audioPlayerService.playerStateStream.listen(
        _onPlayerStateChanged,
      );
      _bufferingSubscription = _audioPlayerService.bufferingStream.listen(
        _onBufferingChanged,
      );
      _errorSubscription = _audioPlayerService.errorStream.listen(
        _onAudioError,
      );
    }
  }

  Future<List<model.Episode>> fetchEpisodes(String podcastId) async {
    return _apiService.fetchEpisodesForPodcast(podcastId);
  }

  /// Tracks when each podcast's episodes were last loaded into DB.
  /// Entries expire after [episodeCacheMaxAge] so new episodes are picked up
  /// without requiring an app restart.
  final Map<String, DateTime> _loadedPodcasts = {};

  /// Clears the loaded-podcasts cache so the next call to
  /// [loadEpisodesIntoDb] will fetch fresh data from the API.
  void clearLoadedPodcastsCache() {
    _loadedPodcasts.clear();
  }

  /// Fetches episodes from the API and upserts them into the local DB.
  /// Skips if already loaded within [episodeCacheMaxAge]. The StreamBuilder in
  /// PodcastDetailScreen will reactively update.
  Future<void> loadEpisodesIntoDb(
    String podcastId, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final loadedAt = _loadedPodcasts[podcastId];
      if (loadedAt != null &&
          DateTime.now().difference(loadedAt) < constants.episodeCacheMaxAge) {
        return;
      }
    }
    _loadedPodcasts[podcastId] = DateTime.now();
    try {
      final episodes = await _apiService.fetchEpisodesForPodcast(podcastId);
      final companions = episodes
          .map(
            (ep) => db.EpisodesCompanion(
              id: Value(ep.id),
              podcastId: Value(ep.podcastId),
              title: Value(ep.title),
              audioUrl: Value(ep.audioUrl),
              publishedAt: Value(ep.publishedAt),
              durationSeconds: Value(ep.duration.inSeconds),
              description: Value(ep.description),
              showDate: Value(ep.showDate),
              imageUrl: Value(ep.imageUrl),
            ),
          )
          .toList();
      if (companions.isNotEmpty) {
        await EpisodesDao(_db).upsertAll(companions);
      }
    } catch (e) {
      _loadedPodcasts.remove(podcastId); // allow retry on next call
      debugPrint('loadEpisodesIntoDb($podcastId): $e');
    }
  }

  Future<void> playEpisode(
    model.Episode episode, {
    List<model.Episode>? queue,
    bool preferLocal = true,
  }) async {
    if (_playBusy) {
      debugPrint('playEpisode: busy, ignoring call for ${episode.id}');
      return;
    }
    _playBusy = true;
    try {
      if (queue != null) {
        _queue = List<model.Episode>.of(queue);
      } else if (!_queue.any((model.Episode item) => item.id == episode.id)) {
        _queue.insert(0, episode);
      }

      model.Episode episodeForPlay = episode;
      if (preferLocal && (episode.cachedMetaPath?.isNotEmpty ?? false)) {
        final fromCache = await readEpisodeFromCacheJson(episode.cachedMetaPath!);
        if (fromCache != null) {
          episodeForPlay = fromCache;
        }
      }

      _currentEpisode = episodeForPlay;
      notifyListeners();

      await _audioPlayerService.loadEpisode(episodeForPlay);
      await _audioPlayerService.setSpeed(_playbackSpeed);
      notifyListeners();
    } catch (e) {
      debugPrint('playEpisode(${episode.id}): $e');
      _currentEpisode = null;
      notifyListeners();
    } finally {
      _playBusy = false;
    }
  }

  Future<void> onEpisodeDownloaded(String episodeId, String localPath) async {
    try {
      // Snapshot current state before any async gap
      final current = _currentEpisode;
      if (current != null && current.id == episodeId && !_playBusy) {
        final currentPosition = _positionNotifier.value;
        await _audioPlayerService.stop();

        // Re-check after async gap — episode may have changed
        if (_currentEpisode?.id == episodeId) {
          _currentEpisode = _currentEpisode!.copyWith(localFilePath: localPath);
          await _audioPlayerService.loadEpisode(_currentEpisode!);
          await _audioPlayerService.seek(currentPosition);
          await _audioPlayerService.togglePlayPause();
        }
      }
    } catch (e) {
      debugPrint('onEpisodeDownloaded($episodeId): $e');
    }
    notifyListeners();
  }

  /// Jumps the playback position relative to the current position.
  /// Use a positive [duration] to seek forward, and a negative one to seek backward.
  Future<void> seekRelative(Duration duration) async {
    // Use the provider's own `_currentPosition` property
    Duration newPosition = _positionNotifier.value + duration;

    // --- Boundary Checks ---
    // Ensure the new position is not negative
    if (newPosition.isNegative) {
      newPosition = Duration.zero;
    }

    // Ensure the new position does not exceed the episode duration
    // Use the provider's `totalDuration` getter
    final episodeDuration = totalDuration ?? Duration.zero;
    if (newPosition > episodeDuration) {
      newPosition = episodeDuration;
    }

    // --- FIX: Optimistically update the local state ---
    // Update the internal position immediately and notify listeners.
    // This allows consecutive seek calls to work as expected.
    _positionNotifier.value = newPosition;

    // Now, tell the audio player to perform the actual seek.
    await _audioPlayerService.seek(newPosition);
  }

  Future<void> playNext() async {
    final model.Episode? nextEpisode = getNextEpisode();
    if (nextEpisode != null) {
      await playEpisode(nextEpisode);
    }
  }

  Future<void> playPrevious() async {
    final model.Episode? previousEpisode = getPreviousEpisode();
    if (previousEpisode != null) {
      await playEpisode(previousEpisode);
    }
  }

  model.Episode? getNextEpisode() {
    final current = _currentEpisode;
    if (current == null) return null;
    final int index = _queue.indexWhere((e) => e.id == current.id);
    if (index != -1 && index + 1 < _queue.length) {
      return _queue[index + 1];
    }
    return null;
  }

  model.Episode? getPreviousEpisode() {
    final current = _currentEpisode;
    if (current == null) return null;
    final int index = _queue.indexWhere((e) => e.id == current.id);
    if (index > 0) {
      return _queue[index - 1];
    }
    return null;
  }

  Future<void> togglePlayPause() => _audioPlayerService.togglePlayPause();

  Future<void> seek(Duration position) => _audioPlayerService.seek(position);

  Future<void> updatePlaybackSpeed(double speed) async {
    _playbackSpeed = speed;
    await _audioPlayerService.setSpeed(speed);
    notifyListeners();
  }

  void addToQueue(model.Episode episode) {
    if (_queue.any((model.Episode item) => item.id == episode.id)) {
      return;
    }
    _queue.add(episode);
    notifyListeners();
  }

  void removeFromQueue(String episodeId) {
    _queue.removeWhere((model.Episode episode) => episode.id == episodeId);
    notifyListeners();
  }

  void reorderQueue(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final model.Episode item = _queue.removeAt(oldIndex);
    _queue.insert(newIndex, item);
    notifyListeners();
  }

  void _onPositionChanged(Duration position) {
    _positionNotifier.value = position;
  }

  void _onPlayerStateChanged(PlayerState state) {
    notifyListeners();
  }

  void _onBufferingChanged(bool isBuffering) {
    _isBuffering = isBuffering;
    notifyListeners();
  }

  void _onAudioError(String? errorMessage) {
    // Sync provider state with service: clear stale episode on load failure
    if (_audioPlayerService.currentEpisode == null) {
      _currentEpisode = null;
      _positionNotifier.value = Duration.zero;
      debugPrint(
        'EpisodeProvider: cleared stale episode after audio error: $errorMessage',
      );
    }
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    await _positionSubscription?.cancel();
    await _playerStateSubscription?.cancel();
    await _bufferingSubscription?.cancel();
    await _errorSubscription?.cancel();
    _positionNotifier.dispose();
    super.dispose();
  }
}
