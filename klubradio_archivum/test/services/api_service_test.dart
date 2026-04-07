import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';


import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/show_data.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/api_cache_service.dart'; // Explicit import
import 'package:shared_preferences/shared_preferences.dart'; // Direct import for setMockInitialValues

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock initial values for SharedPreferences
  setUpAll(() {
    // Helper to simulate ApiCacheService's double JSON encoding
    String createMockCacheEntry(dynamic data) { // Changed to dynamic
      final String encodedData = jsonEncode(data);
      final Map<String, dynamic> cacheEntry = {
        'data': encodedData,
        'expiry': DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      return jsonEncode(cacheEntry);
    }

    final String latestPodcastsCache = createMockCacheEntry(
      _samplePodcastResponse(count: 2)
    );
    final String trendingPodcastsCache = createMockCacheEntry(
      _samplePodcastResponse(count: 1) // Reverted count to 1
    );
    final String userProfileCache = createMockCacheEntry(
      _sampleProfileJson('user-123') // Pass single map directly
    );
    final String episodesForPodcastCache = createMockCacheEntry(
      [_sampleEpisodeJson(id: 'episode-1', podcastId: 'series-1', seed: 3)]
    );


    SharedPreferences.setMockInitialValues({
      'api_cache_latest_podcasts': latestPodcastsCache,
      'api_cache_trending_podcasts': trendingPodcastsCache,
      'api_cache_user_profile_user-123': userProfileCache,
      'api_cache_episodes_for_podcast_series-1': episodesForPodcastCache,
    });
  });
  group('ApiService network behaviour', () {
    test('fetchLatestPodcasts returns parsed podcasts on success', () async {
      late http.Request capturedRequest;
      final client = MockClient((http.Request request) async {
        capturedRequest = request;
        expect(request.method, 'GET');
        expect(request.url.path, contains('/rest/v1/podcasts'));
        return http.Response(
          jsonEncode(_samplePodcastResponse(count: 2)),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final List<Podcast> podcasts = await service.fetchLatestPodcasts(
        limit: 2,
      );

      expect(podcasts, hasLength(2));
      expect(podcasts.first.title, 'Podcast 0');
      expect(podcasts.first.latestEpisode?.id, 'episode-0');
      expect(capturedRequest.url.queryParameters['limit'], '2');
      expect(capturedRequest.headers['Authorization'], isNotNull);
    });

    test(
      'fetchLatestPodcasts throws ApiException when response not successful',
      () async {
        final client = MockClient((http.Request request) async {
          return http.Response('server error', 500);
        });
        final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

        await expectLater(
          service.fetchLatestPodcasts(),
          throwsA(
            isA<ApiException>().having(
              (ApiException e) => e.message,
              'message',
              contains('500'),
            ),
          ),
        );
      },
    );

    test('fetchTrendingPodcasts marks returned podcasts as trending', () async {
      final client = MockClient((http.Request request) async {
        expect(request.url.path, contains('/rest/v1/podcasts'));
        return http.Response(jsonEncode(_samplePodcastResponse(count: 1)), 200);
      });
      final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final List<Podcast> trending = await service.fetchTrendingPodcasts(
        limit: 1,
      );

      expect(trending, hasLength(1));
      expect(trending.single.isTrending, isTrue);
    });

    test('fetchEpisodesForPodcast returns parsed episodes', () async {
      late http.Request capturedRequest;
      final client = MockClient((http.Request request) async {
        capturedRequest = request;
        return http.Response(
          jsonEncode(<Map<String, dynamic>>[
            _sampleEpisodeJson(id: 'episode-1', podcastId: 'series-uncached', seed: 3),
          ]),
          200,
        );
      });
      final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final List<Episode> episodes = await service.fetchEpisodesForPodcast(
        'series-uncached',
        limit: 1,
      );

      expect(episodes, hasLength(1));
      expect(episodes.single.id, 'episode-1');
      expect(capturedRequest.url.queryParameters['podcastId'], 'eq.series-uncached');
      expect(capturedRequest.url.queryParameters['limit'], '1');
    });

    test(
      'searchPodcasts returns empty list when query is blank without calling API',
      () async {
        final client = MockClient((http.Request request) async {
          fail('HTTP client should not be invoked for blank queries');
        });
        final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

        final List<Podcast> results = await service.searchPodcasts('   ');

        expect(results, isEmpty);
      },
    );

    test('searchPodcasts encodes apostrophes and parses response', () async {
      late http.Request capturedRequest;
      final client = MockClient((http.Request request) async {
        capturedRequest = request;
        return http.Response(jsonEncode(_samplePodcastResponse(count: 1)), 200);
      });
      final ApiService service = ApiService(httpClient: client);

      final List<Podcast> results = await service.searchPodcasts("O'Connor");

      expect(results, hasLength(1));
      final String? titleQuery = capturedRequest.url.queryParameters['title'];
      expect(titleQuery, isNotNull);
      expect(titleQuery!, contains("O''Connor"));
    });

    test('fetchUserProfile returns parsed profile when data exists', () async {
      final client = MockClient((http.Request request) async {
        return http.Response(
          jsonEncode(<Map<String, dynamic>>[_sampleProfileJson('user-123')]),
          200,
        );
      });
      final ApiService service = ApiService(httpClient: client);

      final UserProfile profile = await service.fetchUserProfile('user-123');

      expect(profile.id, 'user-123');
      expect(profile.subscribedPodcastIds, contains('podcast-0'));
      expect(profile.recentlyPlayed, isNotEmpty);
    });

    test('fetchUserProfile throws when profile is missing', () async {
      final client = MockClient((http.Request request) async {
        return http.Response(jsonEncode(<dynamic>[]), 200);
      });
      final ApiService service = ApiService(httpClient: client);

      await expectLater(
        service.fetchUserProfile('missing'),
        throwsA(
          isA<ApiException>().having(
            (ApiException e) => e.message,
            'message',
            contains('missing'),
          ),
        ),
      );
    });

    test(
      'logPlayback posts payload with episodeId and ISO timestamp',
      () async {
        late http.Request capturedRequest;
        final client = MockClient((http.Request request) async {
          capturedRequest = request;
          final Map<String, dynamic> body =
              jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['episodeId'], 'episode-10');
          expect(
            () => DateTime.parse(body['playedAt'] as String),
            returnsNormally,
          );
          return http.Response('', 201);
        });
        final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

        await service.logPlayback(episodeId: 'episode-10');

        expect(capturedRequest.method, 'POST');
        expect(capturedRequest.url.path, contains('/rest/v1/playback_events'));
      },
    );

    test('logPlayback throws ApiException when server returns error', () async {
      final client = MockClient((http.Request request) async {
        return http.Response('failure', 500);
      });
      final ApiService service = ApiService(httpClient: client);

      await expectLater(
        service.logPlayback(episodeId: 'episode-11'),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group('ApiService fallback mocks', () {
    test(
      'fetchTrendingPodcasts uses mock data when credentials invalid',
      () async {
        final ApiService service = _OfflineApiService(
          httpClient: MockClient((http.Request request) async {
            fail('No network call expected when credentials are invalid');
          }),
        );

        final List<Podcast> trending = await service.fetchTrendingPodcasts(
          limit: 2,
        );

        expect(trending, hasLength(2));
        expect(trending.every((Podcast podcast) => podcast.isTrending), isTrue);
      },
    );

    test(
      'searchPodcasts returns filtered mock data without network access',
      () async {
        final ApiService service = _OfflineApiService(
          httpClient: MockClient((http.Request request) async {
            fail('No HTTP call expected when credentials are invalid');
          }),
        );

        final List<Podcast> results = await service.searchPodcasts('esti');

        expect(results, isNotEmpty);
        expect(results.first.id, 'esti-gyors');
      },
    );
  });

  test('dispose closes the injected http client', () {
    final _ClosingClient client = _ClosingClient();
    final ApiService service = ApiService(httpClient: client);

    service.dispose();

    expect(client.isClosed, isTrue);
  });

  // =================== CACHE HIT TESTS ===================

  group('ApiService cache hit paths', () {
    test('fetchLatestPodcasts returns cached data without HTTP call', () async {
      final cache = _CachingApiCacheService();
      cache.seed('latest_podcasts', _samplePodcastResponse(count: 2));
      final client = MockClient((http.Request request) async {
        fail('HTTP client should not be called when cache has data');
      });
      final service = _TestApiService(httpClient: client, cacheService: cache);

      final podcasts = await service.fetchLatestPodcasts();

      expect(podcasts, hasLength(2));
      expect(podcasts.first.title, 'Podcast 0');
    });

    test('fetchTrendingPodcasts returns cached data, marks as trending', () async {
      final cache = _CachingApiCacheService();
      cache.seed('trending_podcasts', _samplePodcastResponse(count: 1));
      final client = MockClient((http.Request request) async {
        fail('HTTP client should not be called when cache has data');
      });
      final service = _TestApiService(httpClient: client, cacheService: cache);

      final trending = await service.fetchTrendingPodcasts(limit: 1);

      expect(trending, hasLength(1));
      expect(trending.single.isTrending, isTrue);
    });

    test('fetchRecentEpisodes returns cached data', () async {
      final cache = _CachingApiCacheService();
      cache.seed('recent_episodes', [
        _sampleEpisodeJson(id: 'ep-1', podcastId: 'pod-1', seed: 0),
        _sampleEpisodeJson(id: 'ep-2', podcastId: 'pod-1', seed: 1),
      ]);
      final client = MockClient((http.Request request) async {
        fail('HTTP client should not be called when cache has data');
      });
      final service = _TestApiService(httpClient: client, cacheService: cache);

      final episodes = await service.fetchRecentEpisodes();

      expect(episodes, hasLength(2));
      expect(episodes.first.id, 'ep-1');
    });

    test('fetchEpisodesForPodcast returns cached data', () async {
      final cache = _CachingApiCacheService();
      cache.seed('episodes_for_podcast_series-1', [
        _sampleEpisodeJson(id: 'ep-cached', podcastId: 'series-1', seed: 0),
      ]);
      final client = MockClient((http.Request request) async {
        fail('HTTP client should not be called when cache has data');
      });
      final service = _TestApiService(httpClient: client, cacheService: cache);

      final episodes = await service.fetchEpisodesForPodcast('series-1');

      expect(episodes, hasLength(1));
      expect(episodes.single.id, 'ep-cached');
    });

    test('fetchTopShowsThisYear returns cached data', () async {
      final cache = _CachingApiCacheService();
      cache.seed('top_shows_this_year', _sampleTopShowsResponse());
      final client = MockClient((http.Request request) async {
        fail('HTTP client should not be called when cache has data');
      });
      final service = _TestApiService(httpClient: client, cacheService: cache);

      final shows = await service.fetchTopShowsThisYear();

      expect(shows, hasLength(2));
      expect(shows.first.title, 'A lényeg');
      expect(shows.first.count, 8563);
    });

    test('fetchPodcastById returns cached data', () async {
      final cache = _CachingApiCacheService();
      cache.seed('podcast_by_id_podcast-0', _samplePodcastResponse(count: 1).first);
      final client = MockClient((http.Request request) async {
        fail('HTTP client should not be called when cache has data');
      });
      final service = _TestApiService(httpClient: client, cacheService: cache);

      final podcast = await service.fetchPodcastById('podcast-0');

      expect(podcast, isNotNull);
      expect(podcast!.title, 'Podcast 0');
    });

    test('fetchUserProfile returns cached data', () async {
      final cache = _CachingApiCacheService();
      cache.seed('user_profile_user-42', _sampleProfileJson('user-42'));
      final client = MockClient((http.Request request) async {
        fail('HTTP client should not be called when cache has data');
      });
      final service = _TestApiService(httpClient: client, cacheService: cache);

      final profile = await service.fetchUserProfile('user-42');

      expect(profile.id, 'user-42');
      expect(profile.subscribedPodcastIds, contains('podcast-0'));
    });
  });

  // =================== OFFLINE MOCK TESTS ===================

  group('ApiService offline mock paths', () {
    test('fetchLatestPodcasts returns mock podcasts', () async {
      final service = _OfflineApiService(
        httpClient: MockClient((http.Request request) async {
          fail('No network call expected when credentials are invalid');
        }),
      );

      final podcasts = await service.fetchLatestPodcasts();

      expect(podcasts, isNotEmpty);
      expect(podcasts.first.id, 'esti-gyors');
    });

    test('fetchRecentEpisodes returns mock episodes', () async {
      final service = _OfflineApiService(
        httpClient: MockClient((http.Request request) async {
          fail('No network call expected when credentials are invalid');
        }),
      );

      final episodes = await service.fetchRecentEpisodes();

      expect(episodes, isNotEmpty);
      // Mock episodes are sorted by publishedAt desc, limited to 8
      expect(episodes.length, lessThanOrEqualTo(8));
    });

    test('fetchEpisodesForPodcast returns mock episodes for podcast', () async {
      final service = _OfflineApiService(
        httpClient: MockClient((http.Request request) async {
          fail('No network call expected when credentials are invalid');
        }),
      );

      final episodes = await service.fetchEpisodesForPodcast('esti-gyors', limit: 5);

      expect(episodes, isNotEmpty);
      expect(episodes.length, lessThanOrEqualTo(5));
      expect(episodes.every((e) => e.podcastId == 'esti-gyors'), isTrue);
    });

    test('searchEpisodes returns filtered mock episodes', () async {
      final service = _OfflineApiService(
        httpClient: MockClient((http.Request request) async {
          fail('No network call expected when credentials are invalid');
        }),
      );

      final episodes = await service.searchEpisodes('Epizód');

      expect(episodes, isNotEmpty);
    });

    test('searchEpisodes returns empty for blank query', () async {
      final service = _OfflineApiService(
        httpClient: MockClient((http.Request request) async {
          fail('No network call expected for blank query');
        }),
      );

      final episodes = await service.searchEpisodes('   ');

      expect(episodes, isEmpty);
    });

    test('fetchTopShowsThisYear returns mock top shows', () async {
      final service = _OfflineApiService(
        httpClient: MockClient((http.Request request) async {
          fail('No network call expected when credentials are invalid');
        }),
      );

      final shows = await service.fetchTopShowsThisYear();

      expect(shows, isNotEmpty);
      expect(shows.first.title, 'A lényeg');
    });

    test('fetchUserProfile returns mock profile', () async {
      final service = _OfflineApiService(
        httpClient: MockClient((http.Request request) async {
          fail('No network call expected when credentials are invalid');
        }),
      );

      final profile = await service.fetchUserProfile('mock-user');

      expect(profile.id, 'mock-user');
      expect(profile.subscribedPodcastIds, isNotEmpty);
      expect(profile.recentlyPlayed, isNotEmpty);
    });

    test('logPlayback is no-op when credentials invalid', () async {
      final service = _OfflineApiService(
        httpClient: MockClient((http.Request request) async {
          fail('No network call expected when credentials are invalid');
        }),
      );

      // Should complete without error or network call
      await service.logPlayback(episodeId: 'episode-1');
    });
  });

  // =================== ERROR HANDLING TESTS ===================

  group('ApiService error handling', () {
    test('fetchTrendingPodcasts throws on server error', () async {
      final client = MockClient((http.Request request) async {
        return http.Response('server error', 500);
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      await expectLater(
        service.fetchTrendingPodcasts(),
        throwsA(isA<ApiException>()),
      );
    });

    test('fetchRecentEpisodes throws on server error', () async {
      final client = MockClient((http.Request request) async {
        return http.Response('server error', 500);
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      await expectLater(
        service.fetchRecentEpisodes(),
        throwsA(isA<ApiException>().having(
          (e) => e.message,
          'message',
          contains('500'),
        )),
      );
    });

    test('fetchEpisodesForPodcast throws on server error', () async {
      final client = MockClient((http.Request request) async {
        return http.Response('server error', 500);
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      await expectLater(
        service.fetchEpisodesForPodcast('pod-1'),
        throwsA(isA<ApiException>().having(
          (e) => e.message,
          'message',
          contains('500'),
        )),
      );
    });

    test('searchPodcasts throws on server error', () async {
      final client = MockClient((http.Request request) async {
        return http.Response('server error', 500);
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      await expectLater(
        service.searchPodcasts('test'),
        throwsA(isA<ApiException>()),
      );
    });

    test('searchEpisodes throws on server error', () async {
      final client = MockClient((http.Request request) async {
        return http.Response('server error', 500);
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      await expectLater(
        service.searchEpisodes('test'),
        throwsA(isA<ApiException>()),
      );
    });

    test('fetchTopShowsThisYear throws on server error', () async {
      final client = MockClient((http.Request request) async {
        return http.Response('server error', 500);
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      await expectLater(
        service.fetchTopShowsThisYear(),
        throwsA(isA<ApiException>()),
      );
    });

    test('fetchPodcastById returns null on server error', () async {
      final client = MockClient((http.Request request) async {
        return http.Response('server error', 500);
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final result = await service.fetchPodcastById('nonexistent');

      expect(result, isNull);
    });

    test('getServerErrorMessage parses JSON error body', () async {
      final service = ApiService();
      final response = http.Response(
        jsonEncode({'message': 'Rate limit exceeded'}),
        429,
        headers: {'content-type': 'application/json'},
      );

      final msg = service.getServerErrorMessage(response);

      expect(msg, contains('429'));
      expect(msg, contains('Rate limit exceeded'));
    });

    test('getServerErrorMessage handles non-JSON body', () async {
      final service = ApiService();
      final response = http.Response('plain text error', 500);

      final msg = service.getServerErrorMessage(response);

      expect(msg, contains('500'));
      expect(msg, contains('plain text error'));
    });

    test('getServerErrorMessage handles JSON without message key', () async {
      final service = ApiService();
      final response = http.Response(
        jsonEncode({'detail': 'something went wrong'}),
        400,
        headers: {'content-type': 'application/json'},
      );

      final msg = service.getServerErrorMessage(response);

      expect(msg, contains('400'));
      // Falls back to response.body since no message/error/hint key
      expect(msg, contains('detail'));
    });
  });

  // =================== NETWORK SUCCESS TESTS (UNCOVERED) ===================

  group('ApiService network success paths', () {
    test('fetchRecentEpisodes returns parsed episodes', () async {
      final client = MockClient((http.Request request) async {
        expect(request.url.path, contains('/rest/v1/'));
        return http.Response(
          jsonEncode([
            _sampleEpisodeJson(id: 'recent-1', podcastId: 'pod-1', seed: 0),
            _sampleEpisodeJson(id: 'recent-2', podcastId: 'pod-2', seed: 1),
          ]),
          200,
        );
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final episodes = await service.fetchRecentEpisodes(limit: 2);

      expect(episodes, hasLength(2));
      expect(episodes.first.id, 'recent-1');
      expect(episodes.last.id, 'recent-2');
    });

    test('fetchTopShowsThisYear returns parsed top shows', () async {
      final client = MockClient((http.Request request) async {
        return http.Response(
          jsonEncode(_sampleTopShowsResponse()),
          200,
        );
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final shows = await service.fetchTopShowsThisYear();

      expect(shows, hasLength(2));
      expect(shows.first, isA<ShowData>());
      expect(shows.first.title, 'A lényeg');
      expect(shows.first.count, 8563);
      expect(shows.last.title, 'Reggeli gyors');
    });

    test('searchEpisodes returns parsed episodes', () async {
      final client = MockClient((http.Request request) async {
        expect(request.url.queryParameters['title'], contains('test'));
        return http.Response(
          jsonEncode([
            _sampleEpisodeJson(id: 'search-1', podcastId: 'pod-1', seed: 0),
          ]),
          200,
        );
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final episodes = await service.searchEpisodes('test');

      expect(episodes, hasLength(1));
      expect(episodes.single.id, 'search-1');
    });

    test('fetchPodcastById returns parsed podcast', () async {
      final client = MockClient((http.Request request) async {
        expect(request.url.queryParameters['id'], 'eq.podcast-0');
        return http.Response(
          jsonEncode(_samplePodcastResponse(count: 1)),
          200,
        );
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final podcast = await service.fetchPodcastById('podcast-0');

      expect(podcast, isNotNull);
      expect(podcast!.title, 'Podcast 0');
    });

    test('fetchPodcastById returns null on empty result', () async {
      final client = MockClient((http.Request request) async {
        return http.Response(jsonEncode([]), 200);
      });
      final service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final podcast = await service.fetchPodcastById('nonexistent');

      expect(podcast, isNull);
    });
  });
}

List<Map<String, dynamic>> _samplePodcastResponse({int count = 2}) {
  return List<Map<String, dynamic>>.generate(count, (int index) {
    final String podcastId = 'podcast-$index';
    return <String, dynamic>{
      'id': podcastId,
      'title': 'Podcast $index',
      'description': 'Description for podcast $index',
      'cover_image_url': 'https://example.com/cover-$index.jpg',
      'episode_count': index + 1,
      'hosts': <Map<String, dynamic>>[
        <String, dynamic>{'id': 'host-$index', 'name': 'Host $index'},
      ],
      'latest_episode': _sampleEpisodeJson(
        id: 'episode-$index',
        podcastId: podcastId,
        seed: index,
      ),
      'last_updated': DateTime(2024, 1, index + 1).toIso8601String(),
    };
  });
}

Map<String, dynamic> _sampleEpisodeJson({
  required String id,
  required String podcastId,
  int seed = 0,
}) {
  final DateTime publishedAt = DateTime(2024, 2, 1).add(Duration(days: seed));
  return <String, dynamic>{
    'id': id,
    'podcastId': podcastId,
    'title': 'Episode $id',
    'description': 'Description for $id',
    'audioUrl': 'https://example.com/audio/$id.mp3',
    'publishedAt': publishedAt.toIso8601String(),
    'duration': 1800 + seed,
    'hosts': <String>['Host $seed'],
  };
}

Map<String, dynamic> _sampleProfileJson(String userId) {
  return <String, dynamic>{
    'id': userId,
    'displayName': 'User $userId',
    'email': '$userId@example.com',
    'subscribedPodcastIds': <String>['podcast-0'],
    'recentlyPlayed': <Map<String, dynamic>>[
      _sampleEpisodeJson(id: 'recent-episode', podcastId: 'podcast-0', seed: 5),
    ],
    'favouriteEpisodeIds': <String>['recent-episode'],
  };
}

class _ClosingClient extends http.BaseClient {
  bool isClosed = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError('send should not be called in this test');
  }

  @override
  void close() {
    isClosed = true;
    super.close();
  }
}

class _OfflineApiService extends ApiService {
  _OfflineApiService({super.httpClient})
      : super(cacheService: _MockApiCacheService());

  @override
  bool get hasValidCredentials => false;
}

class _MockApiCacheService extends ApiCacheService {
  @override
  Future<dynamic> get(String key) async {
    return null; // Always return null to force network call
  }

  @override
  Future<void> save(String key, dynamic data, {Duration? expiry}) async {
    // Do nothing, don't cache
  }
}

class _TestApiService extends ApiService {
  _TestApiService({super.httpClient, super.cacheService});

  @override
  bool get hasValidCredentials => true; // Override to true for network tests
}

class _CachingApiCacheService extends ApiCacheService {
  final Map<String, dynamic> _store = {};

  void seed(String key, dynamic data) {
    _store[key] = data;
  }

  @override
  Future<dynamic> get(String key) async => _store[key];

  @override
  Future<void> save(String key, dynamic data, {Duration? expiry}) async {
    _store[key] = data;
  }
}

List<Map<String, dynamic>> _sampleTopShowsResponse() => [
  {'id': '3', 'title': 'A lényeg', 'count': 8563},
  {'id': '38', 'title': 'Reggeli gyors', 'count': 1743},
];

