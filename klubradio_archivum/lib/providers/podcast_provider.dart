import 'package:flutter/material.dart';

import '../models/podcast.dart';
import '../models/user_profile.dart';
import '../services/api_service.dart';

class PodcastProvider extends ChangeNotifier {
  PodcastProvider({required ApiService apiService})
      : _apiService = apiService,
        _userProfile = const UserProfile(
          id: 'hallgato-001',
          displayName: 'Klubrádió Hallgató',
          email: 'hallgato@example.com',
          avatarUrl:
              'https://images.klubradio.hu/archivum/default-avatar.png',
          subscribedPodcastIds: <String>['esti-gyors', 'megbeszeljuk'],
        ) {
    _subscribedPodcastIds.addAll(_userProfile.subscribedPodcastIds);
  }

  ApiService _apiService;

  final List<Podcast> _featuredPodcasts = <Podcast>[];
  final List<Podcast> _trendingPodcasts = <Podcast>[];
  final List<Podcast> _recommendedPodcasts = <Podcast>[];
  final Set<String> _subscribedPodcastIds = <String>{};
  final List<String> _topCategories = <String>[];

  bool _isLoading = false;
  String? _errorMessage;
  UserProfile _userProfile;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<Podcast> get featuredPodcasts => List<Podcast>.unmodifiable(_featuredPodcasts);
  List<Podcast> get trendingPodcasts => List<Podcast>.unmodifiable(_trendingPodcasts);
  List<Podcast> get recommendedPodcasts =>
      List<Podcast>.unmodifiable(_recommendedPodcasts);
  List<String> get topCategories => List<String>.unmodifiable(_topCategories);
  UserProfile get userProfile => _userProfile;

  List<Podcast> get allPodcasts {
    final Map<String, Podcast> combined = <String, Podcast>{};
    for (final podcast in <Podcast>[
      ..._featuredPodcasts,
      ..._trendingPodcasts,
      ..._recommendedPodcasts,
    ]) {
      combined[podcast.id] = podcast;
    }
    return combined.values.toList();
  }

  List<Podcast> get subscribedPodcasts => allPodcasts
      .where((podcast) => _subscribedPodcastIds.contains(podcast.id))
      .toList();

  Future<void> loadHomeContent() async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait<dynamic>(<Future<dynamic>>[
        _apiService.fetchFeaturedPodcasts(),
        _apiService.fetchTrendingPodcasts(),
        _apiService.fetchRecommendedPodcasts(),
        _apiService.fetchTopCategories(),
      ]);

      final featured = _withSubscriptionFlag(
        (results[0] as List<Podcast>),
      );
      final trending = _withSubscriptionFlag(
        (results[1] as List<Podcast>),
      );
      final recommended = _withSubscriptionFlag(
        (results[2] as List<Podcast>),
      );
      final categories = (results[3] as List<String>);

      _featuredPodcasts
        ..clear()
        ..addAll(featured);
      _trendingPodcasts
        ..clear()
        ..addAll(trending);
      _recommendedPodcasts
        ..clear()
        ..addAll(recommended);

      _topCategories
        ..clear()
        ..addAll(categories);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateApiService(ApiService apiService) {
    if (identical(_apiService, apiService)) {
      return;
    }
    _apiService = apiService;
  }

  void subscribeToPodcast(String podcastId) {
    _subscribedPodcastIds.add(podcastId);
    _updateSubscriptionFlags();
    _userProfile = _userProfile.copyWith(
      subscribedPodcastIds: _subscribedPodcastIds.toList(),
    );
    notifyListeners();
  }

  void unsubscribeFromPodcast(String podcastId) {
    _subscribedPodcastIds.remove(podcastId);
    _updateSubscriptionFlags();
    _userProfile = _userProfile.copyWith(
      subscribedPodcastIds: _subscribedPodcastIds.toList(),
    );
    notifyListeners();
  }

  bool isSubscribed(String podcastId) =>
      _subscribedPodcastIds.contains(podcastId);

  Podcast? findPodcastById(String podcastId) {
    try {
      return allPodcasts.firstWhere((podcast) => podcast.id == podcastId);
    } catch (_) {
      return null;
    }
  }

  void updateUserProfile(UserProfile profile) {
    _userProfile = profile;
    _subscribedPodcastIds
      ..clear()
      ..addAll(profile.subscribedPodcastIds);
    _updateSubscriptionFlags();
    notifyListeners();
  }

  List<Podcast> _withSubscriptionFlag(List<Podcast> podcasts) {
    return podcasts
        .map(
          (podcast) => podcast.copyWith(
            isSubscribed: _subscribedPodcastIds.contains(podcast.id),
          ),
        )
        .toList();
  }

  void _updateSubscriptionFlags() {
    void updateList(List<Podcast> list) {
      for (var index = 0; index < list.length; index++) {
        final podcast = list[index];
        list[index] = podcast.copyWith(
          isSubscribed: _subscribedPodcastIds.contains(podcast.id),
        );
      }
    }

    updateList(_featuredPodcasts);
    updateList(_trendingPodcasts);
    updateList(_recommendedPodcasts);
  }
}
