import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../models/episode.dart';
import '../services/api_service.dart';
import '../services/audio_player_service.dart';

class EpisodeProvider extends ChangeNotifier {
  EpisodeProvider({
    required ApiService apiService,
    required AudioPlayerService audioPlayerService,
  })  : _apiService = apiService,
        _audioPlayerService = audioPlayerService {
    _positionSubscription =
        _audioPlayerService.positionStream.listen(_onPositionChanged);
    _playerStateSubscription =
        _audioPlayerService.playerStateStream.listen(_onPlayerStateChanged);
    _bufferingSubscription =
        _audioPlayerService.bufferingStream.listen(_onBufferingChanged);
  }

  ApiService _apiService;
  AudioPlayerService _audioPlayerService;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<bool>? _bufferingSubscription;

  Episode? _currentEpisode;
  List<Episode> _queue = <Episode>[];
  Duration _currentPosition = Duration.zero;
  bool _isBuffering = false;
  double _playbackSpeed = 1.0;

  Episode? get currentEpisode => _currentEpisode;
  Duration get currentPosition => _currentPosition;
  bool get isPlaying => _audioPlayerService.isPlaying;
  bool get isBuffering => _isBuffering;
  Duration? get totalDuration => _audioPlayerService.totalDuration;
  List<Episode> get queue => List<Episode>.unmodifiable(_queue);
  double get playbackSpeed => _playbackSpeed;

  void updateDependencies(
    ApiService apiService,
    AudioPlayerService audioPlayerService,
  ) {
    if (!identical(_apiService, apiService)) {
      _apiService = apiService;
    }
    if (!identical(_audioPlayerService, audioPlayerService)) {
      _positionSubscription?.cancel();
      _playerStateSubscription?.cancel();
      _bufferingSubscription?.cancel();
      _audioPlayerService = audioPlayerService;
      _positionSubscription =
          _audioPlayerService.positionStream.listen(_onPositionChanged);
      _playerStateSubscription =
          _audioPlayerService.playerStateStream.listen(_onPlayerStateChanged);
      _bufferingSubscription =
          _audioPlayerService.bufferingStream.listen(_onBufferingChanged);
    }
  }

  Future<List<Episode>> fetchEpisodes(String podcastId) async {
    return _apiService.fetchEpisodesForPodcast(podcastId);
  }

  Future<void> playEpisode(Episode episode, {List<Episode>? queue}) async {
    _currentEpisode = episode;
    if (queue != null) {
      _queue = queue;
    } else if (!_queue.any((Episode item) => item.id == episode.id)) {
      _queue.insert(0, episode);
    }
    await _audioPlayerService.loadEpisode(episode);
    notifyListeners();
  }

  Future<void> playNext() async {
    final Episode? nextEpisode = getNextEpisode();
    if (nextEpisode != null) {
      await playEpisode(nextEpisode);
    }
  }

  Future<void> playPrevious() async {
    final Episode? previousEpisode = getPreviousEpisode();
    if (previousEpisode != null) {
      await playEpisode(previousEpisode);
    }
  }

  Episode? getNextEpisode() {
    if (_currentEpisode == null) {
      return null;
    }
    final int index =
        _queue.indexWhere((Episode episode) => episode.id == _currentEpisode!.id);
    if (index != -1 && index + 1 < _queue.length) {
      return _queue[index + 1];
    }
    return null;
  }

  Episode? getPreviousEpisode() {
    if (_currentEpisode == null) {
      return null;
    }
    final int index =
        _queue.indexWhere((Episode episode) => episode.id == _currentEpisode!.id);
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

  void addToQueue(Episode episode) {
    if (_queue.any((Episode item) => item.id == episode.id)) {
      return;
    }
    _queue.add(episode);
    notifyListeners();
  }

  void removeFromQueue(String episodeId) {
    _queue.removeWhere((Episode episode) => episode.id == episodeId);
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
