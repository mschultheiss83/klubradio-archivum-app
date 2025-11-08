import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/services/api_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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
      final ApiService service = ApiService(httpClient: client);

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
        final ApiService service = ApiService(httpClient: client);

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
        expect(
          request.url.queryParameters['order'],
          'playCount.desc.nullslast',
        );
        return http.Response(jsonEncode(_samplePodcastResponse(count: 1)), 200);
      });
      final ApiService service = ApiService(httpClient: client);

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
            _sampleEpisodeJson(id: 'episode-1', podcastId: 'series-1', seed: 3),
          ]),
          200,
        );
      });
      final ApiService service = ApiService(httpClient: client);

      final List<Episode> episodes = await service.fetchEpisodesForPodcast(
        'series-1',
        limit: 1,
      );

      expect(episodes, hasLength(1));
      expect(episodes.single.id, 'episode-1');
      expect(capturedRequest.url.queryParameters['podcastId'], 'eq.series-1');
      expect(capturedRequest.url.queryParameters['limit'], '1');
    });

    test(
      'searchPodcasts returns empty list when query is blank without calling API',
      () async {
        final client = MockClient((http.Request request) async {
          fail('HTTP client should not be invoked for blank queries');
        });
        final ApiService service = ApiService(httpClient: client);

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
        final ApiService service = ApiService(httpClient: client);

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
}

List<Map<String, dynamic>> _samplePodcastResponse({int count = 2}) {
  return List<Map<String, dynamic>>.generate(count, (int index) {
    final String podcastId = 'podcast-$index';
    return <String, dynamic>{
      'id': podcastId,
      'title': 'Podcast $index',
      'description': 'Description for podcast $index',
      'coverImageUrl': 'https://example.com/cover-$index.jpg',
      'episodeCount': index + 1,
      'hosts': <Map<String, dynamic>>[
        <String, dynamic>{'id': 'host-$index', 'name': 'Host $index'},
      ],
      'latestEpisode': _sampleEpisodeJson(
        id: 'episode-$index',
        podcastId: podcastId,
        seed: index,
      ),
      'lastUpdated': DateTime(2024, 1, index + 1).toIso8601String(),
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
  _OfflineApiService({super.httpClient});

  @override
  bool get hasValidCredentials => false;
}
