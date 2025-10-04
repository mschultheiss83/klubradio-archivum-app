import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:klubradio_archivum/models/show_data.dart';

import '../models/episode.dart';
import '../models/podcast.dart';
import '../models/show_host.dart';
import '../models/user_profile.dart';
import '../screens/utils/constants.dart' as constants;

class ApiService {
  ApiService({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  static const String _supabaseUrl = 'https://arakbotxgwpyyqyxjhhl.supabase.co';
  static const String _supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyYWtib3R4Z3dweXlxeXhqaGhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgxMDE0MzUsImV4cCI6MjA3MzY3NzQzNX0.zO__rAZCmPQW26YAC3CYhq_ZSjUAx0Gh0KHXIVHhm7w';
  static const Duration _timeout = Duration(seconds: 20);
  static const Duration _longTimeout = Duration(minutes: 1);

  final http.Client _httpClient;

  bool get hasValidCredentials =>
      !_supabaseUrl.contains('TODO') && !_supabaseKey.contains('TODO');

  Map<String, String> get _headers => <String, String>{
    'apikey': _supabaseKey,
    'Authorization': 'Bearer $_supabaseKey',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<Podcast>> fetchLatestPodcasts({int limit = 10}) async {
    if (!hasValidCredentials) {
      return _mockPodcasts();
    }

    final Uri uri =
        Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}').replace(
          queryParameters: {
            'select': '*',
            'order': 'last_updated.desc',
            'limit': limit.toString(),
          },
        );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .toList();
    }

    String serverMsg = getServerErrorMessage(response);

    throw ApiException(
      'Unable to fetch podcasts (${response.statusCode})\n$serverMsg',
    );
  }

  Future<List<Podcast>> fetchTrendingPodcasts({int limit = 10}) async {
    if (!hasValidCredentials) {
      return _mockPodcasts().take(limit).map((Podcast podcast) {
        return podcast.copyWith(isTrending: true);
      }).toList();
    }

    final Uri uri =
        Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}').replace(
          queryParameters: {
            'select': '*',
            // 'order': 'play_count.desc.nullslast',
            'limit': limit.toString(),
          },
        );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((Podcast podcast) => podcast.copyWith(isTrending: true))
          .toList();
    }
    String serverMsg = getServerErrorMessage(response);
    throw ApiException('Unable to fetch trending podcasts\n$serverMsg');
  }

  Future<List<Podcast>> fetchRecommendedPodcasts({int limit = 10}) async {
    if (!hasValidCredentials) {
      return _mockPodcasts().take(limit).map((Podcast podcast) {
        return podcast.copyWith(isRecommended: true);
      }).toList();
    }
    final Uri uri =
        Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}').replace(
          queryParameters: {
            'select': '*',
            'order': 'last_updated.desc.nullslast',
            // 'order': 'recommendation_score.desc.nullslast',
            'limit': limit.toString(),
          },
        );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((Podcast podcast) => podcast.copyWith(isRecommended: true))
          .toList();
    }
    String serverMsg = getServerErrorMessage(response);

    throw ApiException('Unable to fetch recommended podcasts\n$serverMsg');
  }

  Future<List<Episode>> fetchEpisodesForPodcast(
    String podcastId, {
    int limit = 500,
  }) async {
    if (!hasValidCredentials) {
      return _mockEpisodes(podcastId).take(limit).toList();
    }

    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.episodesTable}'
      '?select=*'
      '&podcastId=eq.$podcastId'
      '&limit=$limit',
    );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }

    throw ApiException(
      'Unable to fetch episodes for podcast $podcastId, statusCode ${response.statusCode}',
    );
  }

  Future<List<Episode>> fetchRecentEpisodes({int limit = 8}) async {
    if (!hasValidCredentials) {
      final List<Episode> mocked =
          _mockPodcasts()
              .expand((Podcast podcast) => _mockEpisodes(podcast.id))
              .toList()
            ..sort(
              (Episode a, Episode b) => b.publishedAt.compareTo(a.publishedAt),
            );
      return mocked.take(limit).toList();
    }

    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.episodesTable}'
      '?select=*'
      '&order=id.desc'
      '&limit=$limit',
    );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }
    final errorMessage =
        'Unable to fetch recent episodes statusCode: ${response.statusCode}';
    throw ApiException(errorMessage);
  }

  Future<List<Podcast>> searchPodcasts(String query) async {
    if (query.trim().isEmpty) {
      return const <Podcast>[];
    }

    if (!hasValidCredentials) {
      return _mockPodcasts()
          .where(
            (Podcast podcast) =>
                podcast.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    final encodedQuery = query.replaceAll("'", "''");
    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.podcastsTable}'
      '?select=*'
      '&title=ilike.%25$encodedQuery%25',
    );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .toList();
    }

    throw ApiException('Unable to search podcasts');
  }

  Future<List<ShowData>> fetchTopShowsThisYear() async {
    if (!hasValidCredentials) {
      final List<Map<String, dynamic>> queryResults = [
        {"id": "3", "title": "A lényeg", "count": 8563}, //8605
        {"id": "38", "title": "Reggeli gyors", "count": 1743},
        {"id": "14", "title": "Esti gyors", "count": 1691},
        {"id": "34", "title": "Megbeszéljük...", "count": 1687},
        {"id": "91", "title": "Ezitta Fórum", "count": 1628},
        {"id": "78", "title": "Reggeli gyors/Reggeli személy", "count": 1446},
        {"id": "22", "title": "Hetes Stúdió", "count": 356},
        {"id": "29", "title": "Klubdélelőtt", "count": 351},
      ];
      return queryResults
          .map(
            (row) => ShowData(
              id: row['id'] as String,
              title: row['title'] as String,
              count: row['count'] as int,
            ),
          )
          .toList();
    }
    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.topShowsTable}',
    );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(ShowData.fromJson)
          .toList();
    }

    throw ApiException('Unable to fetch top shows');
  }

  // In your ApiService class
  Future<Podcast?> fetchPodcastById(String podcastId) async {
    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.podcastsTable}'
      '?select=*' // Select all necessary fields
      '&id=eq.$podcastId'
      '&limit=1',
    );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      if (data.isNotEmpty) {
        return Podcast.fromJson(data.first as Map<String, dynamic>);
      }
    }
    return null; // Return null if not found or if there's an error
  }

  Future<UserProfile> fetchUserProfile(String userId) async {
    if (!hasValidCredentials) {
      final List<Podcast> podcasts = _mockPodcasts();
      final List<Episode> episodes = podcasts
          .expand((Podcast podcast) => _mockEpisodes(podcast.id))
          .toList();
      return UserProfile(
        id: userId,
        displayName: 'Vendég felhasználó',
        subscribedPodcastIds: podcasts.take(2).map((Podcast p) => p.id).toSet(),
        recentlyPlayed: episodes.take(4).toList(),
        favouriteEpisodeIds: episodes.take(3).map((Episode e) => e.id).toSet(),
      );
    }

    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.userProfilesTable}'
      '?select=*'
      '&id=eq.$userId'
      '&limit=1',
    );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      if (data.isEmpty) {
        throw ApiException('Profile not found for $userId');
      }
      return UserProfile.fromJson(data.first as Map<String, dynamic>);
    }

    throw ApiException('Unable to fetch user profile ($userId)');
  }

  Future<void> logPlayback({required String episodeId}) async {
    if (!hasValidCredentials) {
      return;
    }

    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.playbackEventsTable}',
    );
    final http.Response response = await _httpClient
        .post(
          uri,
          headers: _headers,
          body: jsonEncode(<String, dynamic>{
            'episodeId': episodeId,
            'playedAt': DateTime.now().toIso8601String(),
          }),
        )
        .timeout(_timeout);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException('Unable to log playback event');
    }
  }

  void dispose() {
    _httpClient.close();
  }

  List<Podcast> _mockPodcasts() {
    final ShowHost bolgarGyorgy = ShowHost(name: 'Bolgár György');
    final ShowHost szenteVeronika = ShowHost(name: 'Szente Veronika');

    final List<Podcast> podcasts = <Podcast>[
      Podcast(
        id: 'esti-gyors',
        title: 'Esti gyors',
        description:
            'Az Esti gyors napi közéleti összefoglalója a legfontosabb hírekkel.',
        coverImageUrl: 'https://images.klubradio.hu/podcasts/esti-gyors.jpg',
        episodeCount: 1200,
        hosts: <ShowHost>[bolgarGyorgy],
        latestEpisode: _mockEpisodes('esti-gyors').first,
        lastUpdated: DateTime.now(),
        isTrending: true,
      ),
      Podcast(
        id: 'megbeszeljuk',
        title: 'Megbeszéljük',
        description:
            'Bolgár György legendás betelefonálós műsora a hallgatók kérdéseivel.',
        coverImageUrl: 'https://images.klubradio.hu/podcasts/megbeszeljuk.jpg',
        episodeCount: 1800,
        hosts: <ShowHost>[bolgarGyorgy],
        latestEpisode: _mockEpisodes('megbeszeljuk').first,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 3)),
        isRecommended: true,
      ),
      Podcast(
        id: 'hangos-irodalom',
        title: 'Hangos irodalom',
        description:
            'Kulturális műsor irodalmi érdekességekkel és felolvasásokkal.',
        coverImageUrl:
            'https://images.klubradio.hu/podcasts/hangos-irodalom.jpg',
        episodeCount: 540,
        hosts: <ShowHost>[szenteVeronika],
        latestEpisode: _mockEpisodes('hangos-irodalom').first,
        lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    return podcasts;
  }

  Iterable<Episode> _mockEpisodes(String podcastId) sync* {
    for (int index = 0; index < 12; index++) {
      yield Episode(
        id: '$podcastId-ep-$index',
        podcastId: podcastId,
        title: 'Epizód #$index',
        description:
            'Ez egy mintapélda epizód leírása a(z) $podcastId műsorhoz.',
        audioUrl: 'https://cdn.klubradio.hu/audio/$podcastId/$index.mp3',
        publishedAt: DateTime.now().subtract(Duration(days: index)),
        showDate: '2023-01-01',
        duration: Duration(minutes: 55 - index.clamp(0, 20)),
        hosts: const <String>['Klubrádió stáb'],
      );
    }
  }

  String getServerErrorMessage(http.Response response) {
    String serverMsg = 'status ${response.statusCode}';
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        final msg = decoded['message'] ?? decoded['error'] ?? decoded['hint'];
        serverMsg = '$serverMsg — ${msg ?? response.body}';
      } else {
        serverMsg = '$serverMsg — ${response.body}';
      }
    } catch (_) {
      serverMsg = '$serverMsg — ${response.body}';
    }
    return serverMsg;
  }
}

class ApiException implements Exception {
  ApiException(this.message);

  final String message;

  @override
  String toString() => 'ApiException: $message';
}
