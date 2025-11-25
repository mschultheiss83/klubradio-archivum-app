// lib/providers/podcast_provider.dart
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../models/episode.dart';
import '../models/podcast.dart';
import '../models/show_data.dart';
import '../models/user_profile.dart';
import '../screens/utils/constants.dart' as constants;
import '../services/api_service.dart';
import '../providers/download_provider.dart';

import '../providers/profile_provider.dart';

import '../services/api_cache_service.dart';

class PodcastProvider extends ChangeNotifier {
  PodcastProvider({
    required ApiService apiService,
    required DownloadProvider downloadProvider,
    required ProfileProvider profileProvider,
    required ApiCacheService apiCacheService,
  }) : _apiService = apiService,
       _downloadProvider = downloadProvider,
       _profileProvider = profileProvider,
       _apiCacheService = apiCacheService;

  ApiService _apiService;
  DownloadProvider _downloadProvider;
  ProfileProvider _profileProvider;
  ApiCacheService _apiCacheService;

  final Map<String, List<Episode>> _episodesByPodcast =
      <String, List<Episode>>{};
  final List<String> _recentSearches = <String>[];

  List<Podcast> _podcasts = <Podcast>[];
  List<Podcast> _trendingPodcasts = <Podcast>[];
  List<Podcast> _recommendedPodcasts = <Podcast>[];
  List<Episode> _recentEpisodes = <Episode>[];

  List<ShowData> _topShows = [];
  List<ShowData> get topShows => _topShows;
  bool _isLoadingTopShows = false;
  bool get isLoadingTopShows => _isLoadingTopShows;

  UserProfile? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;

  List<Podcast> get podcasts => _podcasts;
  List<Podcast> get trendingPodcasts => _trendingPodcasts;
  List<Podcast> get recommendedPodcasts => _recommendedPodcasts;
  List<Episode> get recentEpisodes => _recentEpisodes;
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get recentSearches => List<String>.unmodifiable(_recentSearches);

  List<Podcast> get subscribedPodcasts {
    if (_userProfile == null) return const <Podcast>[];
    return _podcasts
        .where((p) => _userProfile!.subscribedPodcastIds.contains(p.id))
        .toList();
  }

  void updateDependencies(
    ApiService apiService,
    DownloadProvider downloadProvider,
    ProfileProvider profileProvider,
    ApiCacheService apiCacheService,
  ) {
    if (!identical(_apiService, apiService)) {
      _apiService = apiService;
    }
    if (!identical(_downloadProvider, downloadProvider)) {
      _downloadProvider = downloadProvider;
    }
    if (!identical(_profileProvider, profileProvider)) {
      _profileProvider = profileProvider;
    }
    if (!identical(_apiCacheService, apiCacheService)) {
      _apiCacheService = apiCacheService;
    }
  }

  /// Kleiner Mess-Helper: protokolliert Dauer + Fehler je Call.
  Future<T?> _measure<T>(String label, Future<T> Function() call) async {
    final t0 = DateTime.now();
    if (kDebugMode) debugPrint('LOAD → $label start');
    try {
      final res = await call();
      final t1 = DateTime.now();
      if (kDebugMode) {
        debugPrint('LOAD ← $label ok  Δ=${t1.difference(t0).inMilliseconds}ms');
      }
      return res;
    } catch (e) {
      final t1 = DateTime.now();
      if (kDebugMode) {
        debugPrint(
          'LOAD ← $label ERR Δ=${t1.difference(t0).inMilliseconds}ms  $e',
        );
      }
      return null; // andere Calls sollen weiterlaufen
    }
  }

  Future<void> loadInitialData({bool forceRefresh = false}) async {
    if (_isLoading && !forceRefresh) {
      if (kDebugMode) debugPrint('LOAD ✋ already running – skip');
      return;
    }
    final t0 = DateTime.now();
    if (kDebugMode) debugPrint('LOAD ▶ start');
    _isLoading = true;
    _errorMessage = null;
    if (forceRefresh && kDebugMode) debugPrint('LOAD ▷ forceRefresh=true');
    notifyListeners();

    try {
      // Alle Fetches PARALLEL starten – jede mit eigener Messung/Fehlerlogik
      final fLatest = _measure<List<Podcast>>(
        'latestPodcasts',
        () => _apiService.fetchLatestPodcasts(),
      );

      final fRecommended = _measure<List<Podcast>>(
        'recommended',
        () => _apiService.fetchRecommendedPodcasts(),
      );

      final fTrending = _measure<List<Podcast>>(
        'trending',
        () => _apiService.fetchTrendingPodcasts(),
      );

      final fRecent = _measure<List<Episode>>(
        'recentEpisodes',
        () => _apiService.fetchRecentEpisodes(),
      );

      // TopShows separat (mit interner Messung)
      final fTopShows = loadTopShows(forceRefresh: forceRefresh);

      // Warten bis alles fertig (Fehler sind bereits im Helper geloggt)
      final results = await Future.wait([
        fLatest,
        fTrending,
        fRecommended,
        fRecent,
        fTopShows,
      ]);

      // Zuordnen, was da ist
      final latestPodcasts = results[0] as List<Podcast>?;
      final trending = results[1] as List<Podcast>?;
      final recommended = results[2] as List<Podcast>?;
      final recent = results[3] as List<Episode>?;

      if (latestPodcasts != null) _podcasts = latestPodcasts;
      if (trending != null) _trendingPodcasts = trending;
      if (recommended != null) _recommendedPodcasts = recommended;
      if (recent != null) _recentEpisodes = recent;

      if (kDebugMode) {
        debugPrint('LOAD ✓ mapped');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
      final t1 = DateTime.now();
      if (kDebugMode) {
        debugPrint('LOAD ■ done total=${t1.difference(t0).inMilliseconds}ms');
      }
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





  Future<void> downloadEpisode(Episode episode) async {
    try {
      await _downloadProvider.enqueue(episode);
    } catch (_) {
      // Fehler werden über UI/DB sichtbar; hier keine Exception werfen
    }
  }

  Future<void> removeDownload(String episodeId) async {
    await _downloadProvider.removeLocalFile(episodeId);
    notifyListeners();
  }



  Future<List<Episode>> fetchEpisodesForPodcast(String podcastId) async {
    var episodes = _episodesByPodcast[podcastId];
    if (episodes == null || episodes.isEmpty) {
      episodes = await _apiService.fetchEpisodesForPodcast(podcastId);
      _episodesByPodcast[podcastId] = episodes;
    }
    return episodes;
  }

  void addRecentSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
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

  Future<void> addRecentlyPlayed(Episode episode) async {
    await _profileProvider.addRecentlyPlayed(episode);
    notifyListeners(); // Notify listeners in PodcastProvider as well, if needed for UI updates
  }

  void toggleFavourite(Episode episode) {
    final profile = _userProfile;
    if (profile == null) return;

    final favourites = Set<String>.from(profile.favouriteEpisodeIds);
    if (favourites.contains(episode.id)) {
      favourites.remove(episode.id);
    } else {
      favourites.add(episode.id);
    }
    _userProfile = profile.copyWith(favouriteEpisodeIds: favourites);
    notifyListeners();
  }

  void updateAutoDownloadCount(int count) {
    final profile = _userProfile;
    if (profile == null) return;
    _userProfile = profile.copyWith(maxAutoDownload: count);
    notifyListeners();
  }

  Future<Podcast?> fetchPodcastById(String podcastId) async {
    try {
      final podcast = await _apiService.fetchPodcastById(podcastId);
      return podcast;
    } catch (e) {
      debugPrint('Error fetching podcast $podcastId by ID: $e');
      return null;
    }
  }

  Future<void> loadTopShows({bool forceRefresh = false}) async {
    if (!forceRefresh && _topShows.isNotEmpty) return;

    _isLoadingTopShows = true;
    notifyListeners();

    try {
      final s0 = DateTime.now();
      _topShows = await _apiService.fetchTopShowsThisYear();
      final s1 = DateTime.now();
      if (kDebugMode) {
        debugPrint(
          'LOAD ← topShows ok  Δ=${s1.difference(s0).inMilliseconds}ms',
        );
      }
    } catch (e) {
      final s1 = DateTime.now();
      debugPrint(
        'LOAD ← topShows ERR Δ=${s1.difference(s1).inMilliseconds}ms  $e',
      );
    } finally {
      _isLoadingTopShows = false;
      notifyListeners();
    }
  }




}
