import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/db/daos.dart' as daos;
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/audio_player_service.dart';
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
  }

  late db.AppDatabase _db;
  ApiService _apiService;
  AudioPlayerService _audioPlayerService;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<bool>? _bufferingSubscription;

  model.Episode? _currentEpisode;
  List<model.Episode> _queue = <model.Episode>[];
  Duration _currentPosition = Duration.zero;
  bool _isBuffering = false;
  double _playbackSpeed = 1.0;

  model.Episode? get currentEpisode => _currentEpisode;
  Duration get currentPosition => _currentPosition;
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
    }
  }

  Future<List<model.Episode>> fetchEpisodes(String podcastId) async {
    return _apiService.fetchEpisodesForPodcast(podcastId);
  }

  Future<void> playEpisode(
    model.Episode episode, {
    List<model.Episode>? queue,
    bool preferLocal = true,
  }) async {
    if (queue != null) {
      _queue = queue;
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

    try {
      final subsDao = daos.SubscriptionsDao(_db);
      final sub = await subsDao.getById(episodeForPlay.podcastId);
      if (sub == null || sub.active == false) {
        await subsDao.toggleSubscribe(
          podcastId: episodeForPlay.podcastId,
          active: true,
        );
      }
    } catch (_) {
      // still: Abo ist „nice-to-have“, Playback darf nicht blockieren
    }

    await _audioPlayerService.loadEpisode(episodeForPlay);
    notifyListeners();
  }

  /// Jumps the playback position relative to the current position.
  /// Use a positive [duration] to seek forward, and a negative one to seek backward.
  Future<void> seekRelative(Duration duration) async {
    // Use the provider's own `_currentPosition` property
    Duration newPosition = _currentPosition + duration;

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
    _currentPosition = newPosition;
    notifyListeners();

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
    if (_currentEpisode == null) {
      return null;
    }
    final int index = _queue.indexWhere(
      (model.Episode episode) => episode.id == _currentEpisode!.id,
    );
    if (index != -1 && index + 1 < _queue.length) {
      return _queue[index + 1];
    }
    return null;
  }

  model.Episode? getPreviousEpisode() {
    if (_currentEpisode == null) {
      return null;
    }
    final int index = _queue.indexWhere(
      (model.Episode episode) => episode.id == _currentEpisode!.id,
    );
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

  void _onPositionChanged(Duration position) {
    _currentPosition = position;
    notifyListeners();
  }

  void _onPlayerStateChanged(PlayerState state) {
    notifyListeners();
  }

  void _onBufferingChanged(bool isBuffering) {
    _isBuffering = isBuffering;
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    await _positionSubscription?.cancel();
    await _playerStateSubscription?.cancel();
    await _bufferingSubscription?.cancel();
    super.dispose();
  }
}
