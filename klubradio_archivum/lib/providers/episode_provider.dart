import 'package:flutter/foundation.dart';

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
    _audioPlayerService.addListener(_forwardAudioChanges);
    _downloadService.addListener(_forwardDownloadChanges);
  }

  ApiService _apiService;
  AudioPlayerService _audioPlayerService;
  DownloadService _downloadService;

  final List<Episode> _episodes = <Episode>[];
  List<Episode> _searchResults = const <Episode>[];
  final List<String> _recentSearches = <String>[];
  final List<Episode> _recentlyPlayed = <Episode>[];
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Episode> get episodes => List<Episode>.unmodifiable(_episodes);
  List<Episode> get searchResults =>
      List<Episode>.unmodifiable(_searchResults);
  List<String> get recentSearches =>
      List<String>.unmodifiable(_recentSearches);
  List<Episode> get recentlyPlayed =>
      List<Episode>.unmodifiable(_recentlyPlayed);

  Episode? get nowPlaying => _audioPlayerService.currentEpisode;
  bool get isPlaying => _audioPlayerService.isPlaying;
  Duration get playbackPosition => _audioPlayerService.position;
  Duration get playbackDuration => _audioPlayerService.duration;

  List<DownloadTask> get downloads => _downloadService.tasks;

  Future<void> loadEpisodesForPodcast(String podcastId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetched =
          await _apiService.fetchEpisodesForPodcast(podcastId);
      _episodes
        ..clear()
        ..addAll(fetched);
    } on ApiException catch (error) {
      _errorMessage = error.message;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _searchResults = const <Episode>[];
      notifyListeners();
      return;
    }

    try {
      final results = await _apiService.searchEpisodes(trimmed);
      _searchResults = results;
      _updateRecentSearches(trimmed);
      notifyListeners();
    } on ApiException catch (error) {
      _errorMessage = error.message;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  void clearSearch() {
    if (_searchResults.isEmpty) {
      return;
    }
    _searchResults = const <Episode>[];
    notifyListeners();
  }

  void playEpisode(Episode episode) {
    _audioPlayerService.play(episode);
    _registerRecentlyPlayed(episode);
    notifyListeners();
  }

  void togglePlayback() {
    _audioPlayerService.togglePlayPause();
    notifyListeners();
  }

  void seek(Duration position) {
    _audioPlayerService.seek(position);
  }

  Future<void> downloadEpisode(Episode episode) async {
    await _downloadService.enqueueDownload(episode);
  }

  void removeDownload(String episodeId) {
    _downloadService.removeDownload(episodeId);
  }

  DownloadTask? downloadForEpisode(String episodeId) {
    return _downloadService.taskForEpisode(episodeId);
  }

  void updateDependencies({
    ApiService? apiService,
    AudioPlayerService? audioPlayerService,
    DownloadService? downloadService,
  }) {
    if (apiService != null && !identical(_apiService, apiService)) {
      _apiService = apiService;
    }
    if (audioPlayerService != null &&
        !identical(_audioPlayerService, audioPlayerService)) {
      _audioPlayerService
          .removeListener(_forwardAudioChanges);
      _audioPlayerService = audioPlayerService;
      _audioPlayerService.addListener(_forwardAudioChanges);
    }
    if (downloadService != null &&
        !identical(_downloadService, downloadService)) {
      _downloadService.removeListener(_forwardDownloadChanges);
      _downloadService = downloadService;
      _downloadService.addListener(_forwardDownloadChanges);
    }
  }

  void _forwardAudioChanges() {
    notifyListeners();
  }

  void _forwardDownloadChanges() {
    notifyListeners();
  }

  void _updateRecentSearches(String query) {
    _recentSearches.remove(query);
    _recentSearches.insert(0, query);
    if (_recentSearches.length > 10) {
      _recentSearches.removeLast();
    }
  }

  void _registerRecentlyPlayed(Episode episode) {
    _recentlyPlayed.removeWhere((Episode item) => item.id == episode.id);
    _recentlyPlayed.insert(0, episode);
    if (_recentlyPlayed.length > 10) {
      _recentlyPlayed.removeLast();
    }
  }

  @override
  void dispose() {
    _audioPlayerService.removeListener(_forwardAudioChanges);
    _downloadService.removeListener(_forwardDownloadChanges);
    super.dispose();
  }
}
