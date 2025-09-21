import 'package:flutter/foundation.dart';

import '../models/episode.dart';
import '../models/podcast.dart';
import '../services/api_service.dart';

class PodcastProvider extends ChangeNotifier {
  PodcastProvider({required ApiService apiService})
      : _apiService = apiService;

  ApiService _apiService;
  bool _isLoading = false;
  String? _errorMessage;
  List<Podcast> _featured = const <Podcast>[];
  List<Podcast> _trending = const <Podcast>[];
  List<Podcast> _recommended = const <Podcast>[];
  List<Episode> _latestEpisodes = const <Episode>[];
  List<String> _categories = const <String>[];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Podcast> get featured => List<Podcast>.unmodifiable(_featured);
  List<Podcast> get trending => List<Podcast>.unmodifiable(_trending);
  List<Podcast> get recommended =>
      List<Podcast>.unmodifiable(_recommended);
  List<Episode> get latestEpisodes =>
      List<Episode>.unmodifiable(_latestEpisodes);
  List<String> get categories => List<String>.unmodifiable(_categories);

  Future<void> loadHomeContent() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait<dynamic>(<Future<dynamic>>[
        _apiService.fetchFeaturedPodcasts(),
        _apiService.fetchTrendingPodcasts(),
        _apiService.fetchRecommendedPodcasts(),
        _apiService.fetchLatestEpisodes(),
        _apiService.fetchTopCategories(),
      ]);

      _featured = (results[0] as List<Podcast>?) ?? const <Podcast>[];
      _trending = (results[1] as List<Podcast>?) ?? const <Podcast>[];
      _recommended = (results[2] as List<Podcast>?) ?? const <Podcast>[];
      _latestEpisodes = (results[3] as List<Episode>?) ?? const <Episode>[];
      _categories = (results[4] as List<String>?) ?? const <String>[];
    } on ApiException catch (error) {
      _errorMessage = error.message;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCategories() async {
    try {
      _categories = await _apiService.fetchTopCategories();
      notifyListeners();
    } catch (_) {
      // keep previous values, surface error through errorMessage if needed
    }
  }

  Future<void> refreshLatestEpisodes() async {
    try {
      _latestEpisodes = await _apiService.fetchLatestEpisodes();
      notifyListeners();
    } catch (_) {
      // keep current cache
    }
  }

  void updateApiService(ApiService apiService) {
    if (identical(_apiService, apiService)) {
      return;
    }
    _apiService = apiService;
  }
}
