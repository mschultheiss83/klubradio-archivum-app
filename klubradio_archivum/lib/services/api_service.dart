import 'dart:convert';

import 'package:http/http.dart' as http;

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

  final http.Client _httpClient;

  bool get hasValidCredentials =>
      !_supabaseUrl.contains('TODO') && !_supabaseKey.contains('TODO');

  Map<String, String> get _headers => <String, String>{
    'apikey': _supabaseKey,
    'Authorization': 'Bearer $_supabaseKey',
    'Content-Type': 'application/json',
  };

  Future<List<Podcast>> fetchLatestPodcasts({int limit = 20}) async {
    if (!hasValidCredentials) {
      return _mockPodcasts();
    }

    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.podcastsTable}'
      '?select=*,hosts(*),latestEpisode:episodes(*)'
      '&order=lastUpdated.desc'
      '&limit=$limit',
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

    throw ApiException('Unable to fetch podcasts (${response.statusCode})');
  }

  Future<List<Podcast>> fetchTrendingPodcasts({int limit = 10}) async {
    if (!hasValidCredentials) {
      return _mockPodcasts().take(limit).map((Podcast podcast) {
        return podcast.copyWith(isTrending: true);
      }).toList();
    }

    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.podcastsTable}'
      '?select=*,hosts(*)'
      '&order=playCount.desc.nullslast'
      '&limit=$limit',
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

    throw ApiException('Unable to fetch trending podcasts');
  }

  Future<List<Podcast>> fetchRecommendedPodcasts({int limit = 10}) async {
    if (!hasValidCredentials) {
      return _mockPodcasts().take(limit).map((Podcast podcast) {
        return podcast.copyWith(isRecommended: true);
      }).toList();
    }

    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.podcastsTable}'
      '?select=*,hosts(*)'
      '&order=recommendationScore.desc.nullslast'
      '&limit=$limit',
    );
    final http.Response response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((Podcast podcast) => podcast.copyWith(isRecommended: true))
          .toList();
    }

    throw ApiException('Unable to fetch recommended podcasts');
  }

  Future<List<Episode>> fetchEpisodesForPodcast(
    String podcastId, {
    int limit = 50,
  }) async {
    if (!hasValidCredentials) {
      return _mockEpisodes(podcastId).take(limit).toList();
    }

    final Uri uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.episodesTable}'
      '?select=*'
      '&podcastId=eq.$podcastId'
      '&order=publishedAt.desc'
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

    throw ApiException('Unable to fetch episodes for podcast $podcastId');
  }

  Future<List<Episode>> fetchRecentEpisodes({int limit = 20}) async {
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
      '&order=publishedAt.desc'
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

    throw ApiException('Unable to fetch recent episodes');
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
      '?select=*,hosts(*)'
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
    final ShowHost bolgarGyorgy = ShowHost(
      id: '1',
      name: 'Bolgár György',
      bio:
          'Ikonikus újságíró és műsorvezető, a Klubrádió egyik legismertebb hangja.',
    );
    final ShowHost szenteVeronika = ShowHost(
      id: '2',
      name: 'Szente Veronika',
      bio: 'Kultúra és közélet szakértő.',
    );

    final List<Podcast> podcasts = <Podcast>[
      Podcast(
        id: 'esti-gyors',
        title: 'Esti gyors',
        description:
            'Az Esti gyors napi közéleti összefoglalója a legfontosabb hírekkel.',
        categories: const <String>['politika', 'közélet'],
        coverImageUrl: 'https://images.klubradio.hu/podcasts/esti-gyors.jpg',
        language: 'hu',
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
        categories: const <String>['politika', 'vélemény'],
        coverImageUrl: 'https://images.klubradio.hu/podcasts/megbeszeljuk.jpg',
        language: 'hu',
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
        categories: const <String>['kultúra'],
        coverImageUrl:
            'https://images.klubradio.hu/podcasts/hangos-irodalom.jpg',
        language: 'hu',
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
        duration: Duration(minutes: 55 - index.clamp(0, 20)),
        hosts: const <String>['Klubrádió stáb'],
      );
    }
  }
}

class ApiException implements Exception {
  ApiException(this.message);

  final String message;

  @override
  String toString() => 'ApiException: $message';
}
