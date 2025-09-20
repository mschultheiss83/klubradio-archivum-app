import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/episode.dart';
import '../services/api_service.dart';
import '../services/audio_player_service.dart';
import '../services/download_service.dart';

class EpisodeProvider extends ChangeNotifier {
  EpisodeProvider({
    required ApiService apiService,
    required AudioPlayerService audioPlayerService,
    required DownloadService downloadService,
  })  : _apiService = apiService,
        _audioPlayerService = audioPlayerService,
        _downloadService = downloadService {
    _playerStateSubscription =
        _audioPlayerService.playerStateStream.listen(_onPlayerStateChanged);
    _positionSubscription =
        _audioPlayerService.positionStream.listen(_onPositionChanged);
  }

  ApiService _apiService;
  AudioPlayerService _audioPlayerService;
  DownloadService _downloadService;

  late StreamSubscription<PlayerState> _playerStateSubscription;
  StreamSubscription<Duration>? _positionSubscription;

  final Map<String, List<Episode>> _episodesByPodcast =
      <String, List<Episode>>{};
  final List<Episode> _recentlyPlayed = <Episode>[];
  final List<Episode> _downloadedEpisodes = <Episode>[];
  final Map<String, double> _downloadProgress = <String, double>{};
  final List<Episode> _searchResults = <Episode>[];
  final List<String> _recentSearches = <String>[];

  Episode? _nowPlaying;
  bool _isLoading = false;
  bool _isSearching = false;
  bool _isPlaying = false;
  String? _errorMessage;
  Duration _currentPosition = Duration.zero;
  int _maxAutoDownloadEpisodes = 5;

  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  bool get isPlaying => _isPlaying;
  String? get errorMessage => _errorMessage;
  Duration get currentPosition => _currentPosition;
  Episode? get nowPlaying => _nowPlaying;
  int get maxAutoDownloadEpisodes => _maxAutoDownloadEpisodes;

  List<Episode> episodesForPodcast(String podcastId) =>
      List<Episode>.unmodifiable(_episodesByPodcast[podcastId] ??
          const <Episode>[]);

  List<Episode> get recentlyPlayed =>
      List<Episode>.unmodifiable(_recentlyPlayed);

  List<Episode> get downloadedEpisodes =>
      List<Episode>.unmodifiable(_downloadedEpisodes);

  Map<String, double> get downloadProgress =>
      Map<String, double>.unmodifiable(_downloadProgress);

  List<Episode> get searchResults =>
      List<Episode>.unmodifiable(_searchResults);

  List<String> get recentSearches =>
      List<String>.unmodifiable(_recentSearches);

  void updateDependencies({
    required ApiService apiService,
    required AudioPlayerService audioPlayerService,
    required DownloadService downloadService,
  }) {
    if (!identical(_audioPlayerService, audioPlayerService)) {
      _playerStateSubscription.cancel();
      _positionSubscription?.cancel();
      _audioPlayerService = audioPlayerService;
      _playerStateSubscription =
          _audioPlayerService.playerStateStream.listen(_onPlayerStateChanged);
      _positionSubscription =
          _audioPlayerService.positionStream.listen(_onPositionChanged);
    }

    _apiService = apiService;
    _downloadService = downloadService;
  }

  Future<void> loadEpisodesForPodcast(String podcastId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final episodes = await _apiService.fetchEpisodesForPodcast(podcastId);
      _episodesByPodcast[podcastId] = episodes.map(_mergeDownloadState).toList();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> playEpisode(Episode episode) async {
    await _audioPlayerService.playEpisode(episode);
    _nowPlaying = episode;
    _isPlaying = true;
    _addToRecentlyPlayed(episode);
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_nowPlaying == null) {
      return;
    }

    if (_isPlaying) {
      await _audioPlayerService.pause();
      _isPlaying = false;
    } else {
      await _audioPlayerService.play();
      _isPlaying = true;
    }
    notifyListeners();
  }

  Future<void> pause() async {
    if (!_isPlaying) {
      return;
    }
    await _audioPlayerService.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> resume() async {
    if (_isPlaying || _nowPlaying == null) {
      return;
    }
    await _audioPlayerService.play();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayerService.seek(position);
  }

  Future<void> stop() async {
    await _audioPlayerService.stop();
    _isPlaying = false;
    _currentPosition = Duration.zero;
    notifyListeners();
  }

  Future<void> downloadEpisode(Episode episode) async {
    _downloadProgress[episode.id] = 0;
    _errorMessage = null;
    notifyListeners();

    try {
      final filePath = await _downloadService.downloadEpisode(
        episode,
        onProgress: (received, total) {
          if (total > 0) {
            _downloadProgress[episode.id] = received / total;
            notifyListeners();
          }
        },
      );

      final updatedEpisode = episode.copyWith(
        isDownloaded: true,
        localFilePath: filePath,
      );

      _downloadedEpisodes
        ..removeWhere((item) => item.id == episode.id)
        ..insert(0, updatedEpisode);

      _replaceEpisodeInCollections(updatedEpisode);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _downloadProgress.remove(episode.id);
      notifyListeners();
    }
  }

  Future<void> removeDownload(Episode episode) async {
    if (episode.localFilePath == null) {
      return;
    }

    await _downloadService.deleteDownloadedFile(episode.localFilePath!);
    _downloadedEpisodes.removeWhere((item) => item.id == episode.id);
    final updatedEpisode = episode.copyWith(
      isDownloaded: false,
      localFilePath: null,
    );
    _replaceEpisodeInCollections(updatedEpisode);
    notifyListeners();
  }

  Future<void> searchEpisodes(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _searchResults.clear();
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await _apiService.searchEpisodes(trimmed);
      _searchResults
        ..clear()
        ..addAll(results.map(_mergeDownloadState));
      _recentSearches.remove(trimmed);
      _recentSearches.insert(0, trimmed);
      if (_recentSearches.length > 10) {
        _recentSearches.removeLast();
      }
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults.clear();
    _isSearching = false;
    notifyListeners();
  }

  void setMaxAutoDownloadEpisodes(int value) {
    if (value == _maxAutoDownloadEpisodes) {
      return;
    }
    _maxAutoDownloadEpisodes = value.clamp(1, 10);
    notifyListeners();
  }

  void _addToRecentlyPlayed(Episode episode) {
    _recentlyPlayed.removeWhere((item) => item.id == episode.id);
    _recentlyPlayed.insert(0, episode);
    if (_recentlyPlayed.length > 20) {
      _recentlyPlayed.removeLast();
    }
  }

  Episode _mergeDownloadState(Episode episode) {
    final existing = _downloadedEpisodes.firstWhere(
      (downloaded) => downloaded.id == episode.id,
      orElse: () => episode,
    );
    if (existing.localFilePath != null && existing.localFilePath!.isNotEmpty) {
      return episode.copyWith(
        isDownloaded: true,
        localFilePath: existing.localFilePath,
      );
    }
    return episode;
  }

  void _replaceEpisodeInCollections(Episode episode) {
    final podcastEpisodes = _episodesByPodcast[episode.podcastId];
    if (podcastEpisodes != null) {
      for (var index = 0; index < podcastEpisodes.length; index++) {
        if (podcastEpisodes[index].id == episode.id) {
          podcastEpisodes[index] = episode;
          break;
        }
      }
    }

    for (var index = 0; index < _recentlyPlayed.length; index++) {
      if (_recentlyPlayed[index].id == episode.id) {
        _recentlyPlayed[index] = episode;
      }
    }

    for (var index = 0; index < _searchResults.length; index++) {
      if (_searchResults[index].id == episode.id) {
        _searchResults[index] = episode;
      }
    }

    if (_nowPlaying?.id == episode.id) {
      _nowPlaying = episode;
    }
  }

  void _onPlayerStateChanged(PlayerState state) {
    final playing = state.playing &&
        state.processingState != ProcessingState.completed &&
        state.processingState != ProcessingState.idle;
    if (_isPlaying != playing) {
      _isPlaying = playing;
      notifyListeners();
    }

    if (state.processingState == ProcessingState.completed) {
      _isPlaying = false;
      _currentPosition = Duration.zero;
      notifyListeners();
    }
  }

  void _onPositionChanged(Duration position) {
    _currentPosition = position;
    if (_nowPlaying != null) {
      _nowPlaying = _nowPlaying!.copyWith(playbackPosition: position);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _positionSubscription?.cancel();
    super.dispose();
  }
}
