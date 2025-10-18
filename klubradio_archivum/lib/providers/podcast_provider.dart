// lib/providers/podcast_provider.dart
import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/show_data.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';

class PodcastProvider extends ChangeNotifier {
  PodcastProvider({
    required ApiService apiService,
    required DownloadProvider downloadProvider,
  }) : _apiService = apiService,
       _downloadProvider = downloadProvider;

  ApiService _apiService;
  DownloadProvider _downloadProvider;

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
  ) {
    if (!identical(_apiService, apiService)) {
      _apiService = apiService;
    }
    if (!identical(_downloadProvider, downloadProvider)) {
      _downloadProvider = downloadProvider;
    }
  }

  Future<void> loadInitialData({bool forceRefresh = false}) async {
    // ── Performance-Messpunkte ────────────────────────────────────────────────
    final t0 = DateTime.now();
    if (kDebugMode) debugPrint('LOAD ▶ start');

    _isLoading = true;
    _errorMessage = null;
    if (forceRefresh && kDebugMode) debugPrint('LOAD ▷ forceRefresh=true');
    notifyListeners();

    try {
      final t1 = DateTime.now();
      if (kDebugMode) debugPrint('LOAD … fetching');

      // final profileFuture = _apiService.fetchUserProfile(constants.demoUserId); // todo add later
      // _userProfile = profileFuture;

      final fetchedPodcasts = await _apiService.fetchLatestPodcasts();
      final trending = await _apiService.fetchTrendingPodcasts();
      final recommended = await _apiService.fetchRecommendedPodcasts();
      final latestEpisodes = await _apiService.fetchRecentEpisodes();

      final t2 = DateTime.now();
      if (kDebugMode) {
        debugPrint('LOAD ✓ fetched   Δ=${t2.difference(t1).inMilliseconds}ms');
      }

      await loadTopShows(forceRefresh: forceRefresh);

      final t3 = DateTime.now();
      _recentEpisodes = latestEpisodes;
      _recommendedPodcasts = recommended;
      _trendingPodcasts = trending;
      _podcasts = fetchedPodcasts;

      if (kDebugMode) {
        debugPrint('LOAD ✓ mapped    Δ=${t3.difference(t2).inMilliseconds}ms');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
      final t4 = DateTime.now();
      if (kDebugMode) {
        debugPrint(
          'LOAD ■ done      total=${t4.difference(t0).inMilliseconds}ms',
        );
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

  Future<void> subscribe(String podcastId) async {
    debugPrint('[Provider] subscribe/unsubscribe $podcastId');
    final profile = _userProfile;
    if (profile == null) return;

    if (!profile.subscribedPodcastIds.contains(podcastId)) {
      _userProfile = profile.copyWith(
        subscribedPodcastIds: Set<String>.from(profile.subscribedPodcastIds)
          ..add(podcastId),
      );
      _updatePodcastSubscription(podcastId, isSubscribed: true);
      notifyListeners();
      await _scheduleAutoDownloadForPodcast(podcastId);
    }
  }

  Future<void> unsubscribe(String podcastId) async {
    debugPrint('[Provider] subscribe/unsubscribe $podcastId');
    final profile = _userProfile;
    if (profile == null) return;

    if (profile.subscribedPodcastIds.contains(podcastId)) {
      final updated = Set<String>.from(profile.subscribedPodcastIds)
        ..remove(podcastId);
      _userProfile = profile.copyWith(subscribedPodcastIds: updated);
      _updatePodcastSubscription(podcastId, isSubscribed: false);
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

  Future<void> _scheduleAutoDownloadForPodcast(String podcastId) async {
    final maxDownloads =
        _userProfile?.maxAutoDownload ?? constants.defaultAutoDownloadCount;
    final episodes = await _apiService.fetchEpisodesForPodcast(
      podcastId,
      limit: maxDownloads,
    );
    _episodesByPodcast[podcastId] = episodes;

    for (final episode in episodes.take(maxDownloads)) {
      unawaited(_downloadProvider.enqueue(episode));
    }
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

  void addRecentlyPlayed(Episode episode) {
    final profile = _userProfile;
    if (profile == null) return;

    final updated = List<Episode>.from(profile.recentlyPlayed);
    updated.removeWhere((e) => e.id == episode.id);
    updated.insert(0, episode);
    if (updated.length > constants.maxRecentlyPlayed) {
      updated.removeLast();
    }
    _userProfile = profile.copyWith(recentlyPlayed: updated);
    notifyListeners();
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
      debugPrint('Error fetching podcast by ID: $e');
      return null;
    }
  }

  Future<void> loadTopShows({bool forceRefresh = false}) async {
    if (!forceRefresh && _topShows.isNotEmpty) return;

    _isLoadingTopShows = true;
    notifyListeners();

    try {
      _topShows = await _apiService.fetchTopShowsThisYear();
    } catch (e) {
      debugPrint('Error loading top shows: $e');
    } finally {
      _isLoadingTopShows = false;
      notifyListeners();
    }
  }

  void _updatePodcastSubscription(
    String podcastId, {
    required bool isSubscribed,
  }) {
    _podcasts = _podcasts
        .map(
          (p) => p.id == podcastId ? p.copyWith(isSubscribed: isSubscribed) : p,
        )
        .toList();
  }

  bool isSubscribed(String podcastId) {
    final profile = _userProfile;
    if (profile == null) return false;
    return profile.subscribedPodcastIds.contains(podcastId);
  }
}
