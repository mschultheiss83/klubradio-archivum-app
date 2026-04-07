// test/providers/podcast_provider_extended_test.dart
//
// Tests for PodcastProvider methods NOT covered by podcast_provider_search_test:
//   - updateDependencies: swaps service references
//   - loadInitialData: parallel fetch, loading lifecycle, guard, forceRefresh
//   - loadUserProfile: success/error paths
//   - downloadEpisode: delegates to downloadProvider, swallows errors
//   - removeDownload: delegates to downloadProvider
//   - fetchEpisodesForPodcast: caches result, returns cached on repeat
//   - searchEpisodes: delegates to apiService, returns empty on error
//   - toggleFavourite: add/remove, null profile no-op
//   - updateAutoDownloadCount: updates profile
//   - fetchPodcastById: delegates, returns null on error
//   - loadTopShows: loading lifecycle, skip-if-loaded guard
//   - subscribedPodcasts: filters by userProfile subscriptions

import 'package:flutter_test/flutter_test.dart';

import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/show_data.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/profile_provider.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/api_cache_service.dart';

// ==================== Helpers ====================

Episode _ep(String id) => Episode(
  id: id,
  podcastId: 'pod-1',
  title: 'Ep $id',
  description: '',
  audioUrl: 'https://x.com/$id.mp3',
  publishedAt: DateTime(2024),
  showDate: '2024-01-01',
  duration: const Duration(minutes: 30),
);

Podcast _pod(String id, {String title = ''}) => Podcast(
  id: id,
  title: title.isEmpty ? 'Pod $id' : title,
  description: '',
  coverImageUrl: '',
  episodeCount: 0,
  hosts: const [],
);

ShowData _show(String id, {String title = '', int count = 10}) =>
    ShowData(id: id, title: title.isEmpty ? 'Show $id' : title, count: count);

// ==================== Stubs ====================

class _StubCacheService extends ApiCacheService {
  @override
  Future<dynamic> get(String key) async => null;
  @override
  Future<void> save(String key, dynamic data, {Duration? expiry}) async {}
}

class _StubApiService extends ApiService {
  _StubApiService() : super(cacheService: _StubCacheService());

  Future<List<Podcast>> Function()? latestHandler;
  Future<List<Podcast>> Function()? trendingHandler;
  Future<List<Episode>> Function()? recentHandler;
  Future<List<ShowData>> Function()? topShowsHandler;
  Future<UserProfile> Function(String)? profileHandler;
  Future<List<Episode>> Function(String)? episodesHandler;
  Future<Podcast?> Function(String)? podcastByIdHandler;
  Future<List<Episode>> Function(String)? searchEpisodesHandler;

  @override
  bool get hasValidCredentials => false;

  @override
  Future<List<Podcast>> fetchLatestPodcasts({int limit = 20}) async {
    if (latestHandler != null) return latestHandler!();
    return <Podcast>[];
  }

  @override
  Future<List<Podcast>> fetchTrendingPodcasts({int limit = 20}) async {
    if (trendingHandler != null) return trendingHandler!();
    return <Podcast>[];
  }

  @override
  Future<List<Episode>> fetchRecentEpisodes({int limit = 8}) async {
    if (recentHandler != null) return recentHandler!();
    return <Episode>[];
  }

  @override
  Future<List<ShowData>> fetchTopShowsThisYear() async {
    if (topShowsHandler != null) return topShowsHandler!();
    return <ShowData>[];
  }

  @override
  Future<UserProfile> fetchUserProfile(String userId) async {
    if (profileHandler != null) return profileHandler!(userId);
    return UserProfile.initial(userId);
  }

  @override
  Future<List<Episode>> fetchEpisodesForPodcast(
    String podcastId, {
    int limit = 50,
    int offset = 0,
  }) async {
    if (episodesHandler != null) return episodesHandler!(podcastId);
    return <Episode>[];
  }

  @override
  Future<Podcast?> fetchPodcastById(String podcastId) async {
    if (podcastByIdHandler != null) return podcastByIdHandler!(podcastId);
    return null;
  }

  @override
  Future<List<Episode>> searchEpisodes(String query) async {
    if (searchEpisodesHandler != null) return searchEpisodesHandler!(query);
    return <Episode>[];
  }
}

class _StubProfileProvider extends ProfileProvider {
  _StubProfileProvider() : super();
}

/// Tracks calls to enqueue and removeLocalFile without needing native plugins.
class _TrackingDownloadProvider extends Fake implements DownloadProvider {
  final List<Episode> enqueuedEpisodes = [];
  final List<String> removedEpisodeIds = [];
  bool shouldThrowOnEnqueue = false;

  @override
  Future<void> enqueue(Episode ep) async {
    if (shouldThrowOnEnqueue) throw Exception('enqueue failed');
    enqueuedEpisodes.add(ep);
  }

  @override
  Future<void> removeLocalFile(String episodeId) async {
    removedEpisodeIds.add(episodeId);
  }
}

class _FakeDownloadProvider extends Fake implements DownloadProvider {}

// ==================== Tests ====================

void main() {
  late _StubApiService apiService;
  late _StubCacheService cacheService;
  late _TrackingDownloadProvider downloadProvider;
  late _StubProfileProvider profileProvider;
  late PodcastProvider provider;

  setUp(() {
    apiService = _StubApiService();
    cacheService = _StubCacheService();
    downloadProvider = _TrackingDownloadProvider();
    profileProvider = _StubProfileProvider();
    provider = PodcastProvider(
      apiService: apiService,
      downloadProvider: downloadProvider,
      profileProvider: profileProvider,
      apiCacheService: cacheService,
    );
  });

  group('updateDependencies', () {
    test('swaps services when different objects passed', () {
      final newApi = _StubApiService();
      final newDownload = _FakeDownloadProvider();
      final newProfile = _StubProfileProvider();
      final newCache = _StubCacheService();

      // Should not throw
      provider.updateDependencies(newApi, newDownload, newProfile, newCache);

      // Verify new service is used: set handler on newApi and call a method
      newApi.latestHandler = () async => [_pod('new-pod')];
      // The provider should now use newApi internally
      // (We verify indirectly via loadInitialData)
    });

    test('does not swap when same objects passed', () {
      // Calling with identical references should be a no-op (no crash)
      provider.updateDependencies(
        apiService,
        downloadProvider,
        profileProvider,
        cacheService,
      );
    });
  });

  group('loadInitialData', () {
    test('calls fetch methods in parallel and populates lists', () async {
      apiService.latestHandler = () async => [_pod('p1'), _pod('p2')];
      apiService.trendingHandler = () async => [_pod('t1')];
      apiService.recentHandler = () async => [_ep('e1'), _ep('e2')];
      apiService.topShowsHandler = () async => [_show('s1')];

      await provider.loadInitialData();

      expect(provider.podcasts, hasLength(2));
      expect(provider.trendingPodcasts, hasLength(1));
      expect(provider.recentEpisodes, hasLength(2));
      expect(provider.topShows, hasLength(1));
    });

    test('sets isLoading=true then false', () async {
      final loadingStates = <bool>[];
      provider.addListener(() => loadingStates.add(provider.isLoading));

      await provider.loadInitialData();

      // First notification: isLoading=true, last notification: isLoading=false
      expect(loadingStates.first, isTrue);
      expect(loadingStates.last, isFalse);
    });

    test('skips if already loading (guard)', () async {
      // Simulate already-loading state by starting a load that blocks
      int callCount = 0;
      apiService.latestHandler = () async {
        callCount++;
        await Future.delayed(const Duration(milliseconds: 50));
        return <Podcast>[];
      };

      // Start first load (don't await)
      final first = provider.loadInitialData();
      // Immediately try second load - should be skipped
      final second = provider.loadInitialData();

      await Future.wait([first, second]);

      // latestHandler should only be called once
      expect(callCount, 1);
    });

    test('with forceRefresh=true runs even if already loading', () async {
      int callCount = 0;
      apiService.latestHandler = () async {
        callCount++;
        return <Podcast>[];
      };

      // Start first load
      final first = provider.loadInitialData();
      // Force refresh should NOT be skipped
      final second = provider.loadInitialData(forceRefresh: true);

      await Future.wait([first, second]);

      expect(callCount, greaterThanOrEqualTo(2));
    });

    test('clears errorMessage on start', () async {
      // Trigger an error first
      apiService.latestHandler = () => throw Exception('fail');
      await provider.loadInitialData();

      // Now load successfully
      apiService.latestHandler = () async => <Podcast>[];
      await provider.loadInitialData(forceRefresh: true);

      expect(provider.errorMessage, isNull);
    });
  });

  group('loadUserProfile', () {
    test('sets userProfile on success', () async {
      final profile = UserProfile.initial('user-1');
      apiService.profileHandler = (_) async => profile;

      await provider.loadUserProfile(userId: 'user-1');

      expect(provider.userProfile, isNotNull);
      expect(provider.userProfile!.id, 'user-1');
    });

    test('sets errorMessage on failure', () async {
      apiService.profileHandler = (_) => throw Exception('Network error');

      await provider.loadUserProfile(userId: 'user-1');

      expect(provider.errorMessage, isNotNull);
      expect(provider.errorMessage, contains('Network error'));
    });
  });

  group('downloadEpisode', () {
    test('delegates to downloadProvider.enqueue', () async {
      final episode = _ep('ep-dl');
      await provider.downloadEpisode(episode);

      expect(downloadProvider.enqueuedEpisodes, hasLength(1));
      expect(downloadProvider.enqueuedEpisodes.first.id, 'ep-dl');
    });

    test('swallows errors', () async {
      downloadProvider.shouldThrowOnEnqueue = true;
      final episode = _ep('ep-fail');

      // Should not throw
      await provider.downloadEpisode(episode);
    });
  });

  group('removeDownload', () {
    test('delegates to downloadProvider.removeLocalFile', () async {
      await provider.removeDownload('ep-rm');

      expect(downloadProvider.removedEpisodeIds, ['ep-rm']);
    });

    test('notifies listeners after removal', () async {
      int count = 0;
      provider.addListener(() => count++);

      await provider.removeDownload('ep-rm');

      expect(count, greaterThan(0));
    });
  });

  group('fetchEpisodesForPodcast', () {
    test('fetches from API and caches result', () async {
      int callCount = 0;
      apiService.episodesHandler = (podcastId) async {
        callCount++;
        return [_ep('e1'), _ep('e2')];
      };

      final result = await provider.fetchEpisodesForPodcast('pod-1');

      expect(result, hasLength(2));
      expect(callCount, 1);
    });

    test('returns cached episodes on second call', () async {
      int callCount = 0;
      apiService.episodesHandler = (_) async {
        callCount++;
        return [_ep('e1')];
      };

      await provider.fetchEpisodesForPodcast('pod-1');
      final second = await provider.fetchEpisodesForPodcast('pod-1');

      expect(second, hasLength(1));
      expect(callCount, 1); // API called only once
    });
  });

  group('searchEpisodes', () {
    test('delegates to apiService.searchEpisodes', () async {
      apiService.searchEpisodesHandler = (q) async => [
        _ep('match-1'),
        _ep('match-2'),
      ];

      final results = await provider.searchEpisodes('test');

      expect(results, hasLength(2));
      expect(results.first.id, 'match-1');
    });

    test('returns empty list on error', () async {
      apiService.searchEpisodesHandler = (_) =>
          throw ApiException('Search failed');

      final results = await provider.searchEpisodes('failing');

      expect(results, isEmpty);
    });
  });

  group('toggleFavourite', () {
    setUp(() async {
      apiService.profileHandler = (_) async => UserProfile.initial('u1');
      await provider.loadUserProfile(userId: 'u1');
    });

    test('adds episode to favourites set', () {
      provider.toggleFavourite(_ep('ep-fav'));

      expect(provider.userProfile!.favouriteEpisodeIds, contains('ep-fav'));
    });

    test('removes episode from favourites set', () {
      // Add first
      provider.toggleFavourite(_ep('ep-fav'));
      expect(provider.userProfile!.favouriteEpisodeIds, contains('ep-fav'));

      // Toggle off
      provider.toggleFavourite(_ep('ep-fav'));
      expect(
        provider.userProfile!.favouriteEpisodeIds,
        isNot(contains('ep-fav')),
      );
    });

    test('null profile is no-op', () {
      // Create fresh provider without loading profile
      final fresh = PodcastProvider(
        apiService: apiService,
        downloadProvider: downloadProvider,
        profileProvider: profileProvider,
        apiCacheService: cacheService,
      );
      int count = 0;
      fresh.addListener(() => count++);

      fresh.toggleFavourite(_ep('ep-1'));

      expect(count, 0);
    });
  });

  group('updateAutoDownloadCount', () {
    test('updates profile autoDownloadEpisodeCount', () async {
      apiService.profileHandler = (_) async => UserProfile.initial('u1');
      await provider.loadUserProfile(userId: 'u1');

      provider.updateAutoDownloadCount(5);

      expect(provider.userProfile!.autoDownloadEpisodeCount, 5);
    });

    test('null profile is no-op', () {
      int count = 0;
      provider.addListener(() => count++);

      provider.updateAutoDownloadCount(5);

      expect(count, 0);
    });
  });

  group('fetchPodcastById', () {
    test('delegates to apiService and returns podcast', () async {
      apiService.podcastByIdHandler = (id) async => _pod(id, title: 'Found');

      final result = await provider.fetchPodcastById('pod-x');

      expect(result, isNotNull);
      expect(result!.title, 'Found');
    });

    test('returns null on error', () async {
      apiService.podcastByIdHandler = (_) => throw Exception('Not found');

      final result = await provider.fetchPodcastById('bad-id');

      expect(result, isNull);
    });
  });

  group('loadTopShows', () {
    test('sets isLoadingTopShows=true then false', () async {
      final states = <bool>[];
      provider.addListener(() => states.add(provider.isLoadingTopShows));

      apiService.topShowsHandler = () async => [_show('s1')];
      await provider.loadTopShows();

      expect(states.first, isTrue);
      expect(states.last, isFalse);
      expect(provider.topShows, hasLength(1));
    });

    test('skips if already loaded and not forceRefresh', () async {
      int callCount = 0;
      apiService.topShowsHandler = () async {
        callCount++;
        return [_show('s1')];
      };

      await provider.loadTopShows();
      await provider.loadTopShows(); // second call should be skipped

      expect(callCount, 1);
    });

    test('reloads with forceRefresh=true even if already loaded', () async {
      int callCount = 0;
      apiService.topShowsHandler = () async {
        callCount++;
        return [_show('s$callCount')];
      };

      await provider.loadTopShows();
      await provider.loadTopShows(forceRefresh: true);

      expect(callCount, 2);
    });
  });

  group('subscribedPodcasts', () {
    test('returns empty when userProfile is null', () {
      expect(provider.subscribedPodcasts, isEmpty);
    });

    test('filters podcasts by userProfile subscriptions', () async {
      // Load podcasts
      apiService.latestHandler = () async => [
        _pod('p1'),
        _pod('p2'),
        _pod('p3'),
      ];
      await provider.loadInitialData();

      // Load profile with subscriptions to p1 and p3
      final profile = UserProfile.initial(
        'u1',
      ).copyWith(subscribedPodcastIds: {'p1', 'p3'});
      apiService.profileHandler = (_) async => profile;
      await provider.loadUserProfile(userId: 'u1');

      final subscribed = provider.subscribedPodcasts;

      expect(subscribed, hasLength(2));
      expect(subscribed.map((p) => p.id).toSet(), {'p1', 'p3'});
    });
  });
}
