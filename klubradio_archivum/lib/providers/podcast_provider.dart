import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/episode.dart';
import '../models/podcast.dart';
import '../models/user_profile.dart';
import '../screens/utils/constants.dart' as constants;
import '../services/api_service.dart';
import '../services/download_service.dart';

class PodcastProvider extends ChangeNotifier {
  PodcastProvider({
    required ApiService apiService,
    required DownloadService downloadService,
  })  : _apiService = apiService,
        _downloadService = downloadService {
    _downloadSubscription =
        _downloadService.downloadStream.listen(_handleDownloadUpdate);
  }

  ApiService _apiService;
  DownloadService _downloadService;
  StreamSubscription<DownloadTask>? _downloadSubscription;

  final Map<String, List<Episode>> _episodesByPodcast =
      <String, List<Episode>>{};
  final Map<String, DownloadTask> _downloads = <String, DownloadTask>{};
  final List<String> _recentSearches = <String>[];

  List<Podcast> _podcasts = <Podcast>[];
  List<Podcast> _trendingPodcasts = <Podcast>[];
  List<Podcast> _recommendedPodcasts = <Podcast>[];
  List<Episode> _recentEpisodes = <Episode>[];

  UserProfile? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;
  bool _initialised = false;

  List<Podcast> get podcasts => _podcasts;
  List<Podcast> get trendingPodcasts => _trendingPodcasts;
  List<Podcast> get recommendedPodcasts => _recommendedPodcasts;
  List<Episode> get recentEpisodes => _recentEpisodes;
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get recentSearches => List<String>.unmodifiable(_recentSearches);
  List<DownloadTask> get downloads => _downloads.values.toList();

  List<Podcast> get subscribedPodcasts {
    if (_userProfile == null) {
      return const <Podcast>[];
    }
    return _podcasts
        .where((Podcast podcast) =>
            _userProfile!.subscribedPodcastIds.contains(podcast.id))
        .toList();
  }

  void updateDependencies(
    ApiService apiService,
    DownloadService downloadService,
  ) {
    if (!identical(_apiService, apiService)) {
      _apiService = apiService;
    }
    if (!identical(_downloadService, downloadService)) {
      _downloadSubscription?.cancel();
      _downloadService = downloadService;
      _downloadSubscription =
          _downloadService.downloadStream.listen(_handleDownloadUpdate);
    }
  }

  Future<void> loadInitialData({bool forceRefresh = false}) async {
    if (_isLoading) {
      return;
    }
    if (_initialised && !forceRefresh) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final List<Podcast> fetchedPodcasts =
          await _apiService.fetchLatestPodcasts();
      final List<Podcast> trending =
          await _apiService.fetchTrendingPodcasts();
      final List<Podcast> recommended =
          await _apiService.fetchRecommendedPodcasts();
      final List<Episode> latestEpisodes =
          await _apiService.fetchRecentEpisodes();

      _podcasts = fetchedPodcasts;
      _trendingPodcasts = trending;
      _recommendedPodcasts = recommended;
      _recentEpisodes = latestEpisodes;
      _initialised = true;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserProfile({String userId = constants.demoUserId}) async {
    try {
      _userProfile = await _apiService.fetchUserProfile(userId);
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  Future<void> subscribe(String podcastId) async {
    final UserProfile? profile = _userProfile;
    if (profile == null) {
      return;
    }
    if (!profile.subscribedPodcastIds.contains(podcastId)) {
      _userProfile = profile.copyWith(
        subscribedPodcastIds:
            Set<String>.from(profile.subscribedPodcastIds)..add(podcastId),
      );
      _updatePodcastSubscription(podcastId, isSubscribed: true);
      notifyListeners();
      await _scheduleAutoDownloadForPodcast(podcastId);
    }
  }

  Future<void> unsubscribe(String podcastId) async {
    final UserProfile? profile = _userProfile;
    if (profile == null) {
      return;
    }
    if (profile.subscribedPodcastIds.contains(podcastId)) {
      final Set<String> updated =
          Set<String>.from(profile.subscribedPodcastIds)..remove(podcastId);
      _userProfile = profile.copyWith(subscribedPodcastIds: updated);
      _updatePodcastSubscription(podcastId, isSubscribed: false);
      notifyListeners();
    }
  }

  Future<void> downloadEpisode(Episode episode) async {
    try {
      await _downloadService.downloadEpisode(episode);
    } catch (_) {
      // Errors are surfaced via the download stream and UI indicators.
    }
  }

  Future<void> removeDownload(String episodeId) async {
    await _downloadService.removeDownload(episodeId);
    _downloads.remove(episodeId);
    notifyListeners();
  }

  Future<void> _scheduleAutoDownloadForPodcast(String podcastId) async {
    final int maxDownloads =
        _userProfile?.maxAutoDownload ?? constants.defaultAutoDownloadCount;
    final List<Episode> episodes =
        await _apiService.fetchEpisodesForPodcast(podcastId, limit: maxDownloads);
    _episodesByPodcast[podcastId] = episodes;
    for (final Episode episode in episodes.take(maxDownloads)) {
      if (!_downloads.containsKey(episode.id)) {
        unawaited(_downloadService.downloadEpisode(episode));
      }
    }
    notifyListeners();
  }

  Future<List<Episode>> fetchEpisodesForPodcast(String podcastId) async {
    List<Episode>? episodes = _episodesByPodcast[podcastId];
    if (episodes == null || episodes.isEmpty) {
      episodes = await _apiService.fetchEpisodesForPodcast(podcastId);
      _episodesByPodcast[podcastId] = episodes;
    }
    return episodes;
  }

  void addRecentSearch(String query) {
    final String trimmed = query.trim();
    if (trimmed.isEmpty) {
      return;
    }
    _recentSearches.remove(trimmed);
    _recentSearches.insert(0, trimmed);
    if (_recentSearches.length > constants.maxRecentSearches) {
      _recentSearches.removeLast();
    }
    notifyListeners();
  }

  Future<List<Podcast>> searchPodcasts(String query) async {
    addRecentSearch(query);
    try {
      return await _apiService.searchPodcasts(query);
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
      return const <Podcast>[];
    }
  }

  void addRecentlyPlayed(Episode episode) {
    final UserProfile? profile = _userProfile;
    if (profile == null) {
      return;
    }
    final List<Episode> updated = List<Episode>.from(profile.recentlyPlayed);
    updated.removeWhere((Episode item) => item.id == episode.id);
    updated.insert(0, episode);
    if (updated.length > constants.maxRecentlyPlayed) {
      updated.removeLast();
    }
    _userProfile = profile.copyWith(recentlyPlayed: updated);
    notifyListeners();
  }

  void toggleFavourite(Episode episode) {
    final UserProfile? profile = _userProfile;
    if (profile == null) {
      return;
    }
    final Set<String> favourites =
        Set<String>.from(profile.favouriteEpisodeIds);
    if (favourites.contains(episode.id)) {
      favourites.remove(episode.id);
    } else {
      favourites.add(episode.id);
    }
    _userProfile = profile.copyWith(favouriteEpisodeIds: favourites);
    notifyListeners();
  }

  void updateAutoDownloadCount(int count) {
    final UserProfile? profile = _userProfile;
    if (profile == null) {
      return;
    }
    _userProfile = profile.copyWith(maxAutoDownload: count);
    notifyListeners();
  }

  void _updatePodcastSubscription(String podcastId, {required bool isSubscribed}) {
    _podcasts = _podcasts
        .map(
          (Podcast podcast) => podcast.id == podcastId
              ? podcast.copyWith(isSubscribed: isSubscribed)
              : podcast,
        )
        .toList();
  }

  void _handleDownloadUpdate(DownloadTask task) {
    _downloads[task.episode.id] = task;
    notifyListeners();
  }

  DownloadTask? getDownloadTask(String episodeId) => _downloads[episodeId];

  @override
  void dispose() {
    _downloadSubscription?.cancel();
    super.dispose();
  }
}
