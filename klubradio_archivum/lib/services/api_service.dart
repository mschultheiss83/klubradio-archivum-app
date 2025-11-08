// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:klubradio_archivum/models/show_data.dart';

import '../models/episode.dart';
import '../models/podcast.dart';
import '../models/show_host.dart';
import '../models/user_profile.dart';
import '../screens/utils/constants.dart' as constants;

import 'package:klubradio_archivum/services/api_cache_service.dart';

class ApiService {
  ApiService({http.Client? httpClient, ApiCacheService? cacheService})
    : _httpClient = httpClient ?? http.Client(),
      _cacheService = cacheService ?? ApiCacheService();

  // === Supabase ===
  static const String _supabaseUrl = 'https://arakbotxgwpyyqyxjhhl.supabase.co';
  static const String _supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyYWtib3R4Z3dweXlxeXhqaGhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgxMDE0MzUsImV4cCI6MjA3MzY3NzQzNX0.zO__rAZCmPQW26YAC3CYhq_ZSjUAx0Gh0KHXIVHhm7w';

  // Exponieren, falls andere Schichten das brauchen (Repo etc.)
  String get supabaseUrl => _supabaseUrl;
  String get supabaseKey => _supabaseKey;

  static const Duration _timeout = Duration(seconds: 20);
  static const Duration _longTimeout = Duration(minutes: 1);

  final http.Client _httpClient;
  final ApiCacheService _cacheService;

  bool get hasValidCredentials =>
      !_supabaseUrl.contains('TODO') && !_supabaseKey.contains('TODO');

  Map<String, String> get _headers => <String, String>{
    'apikey': _supabaseKey,
    'Authorization': 'Bearer $_supabaseKey',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // =================== PODCAST LISTS ===================

  Future<List<Podcast>> fetchLatestPodcasts({int limit = 10}) async {
    const String cacheKey = 'latest_podcasts';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .toList();
    }

    if (!hasValidCredentials) return _mockPodcasts();

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'order': 'last_updated.desc',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .toList();
    }
    final serverMsg = getServerErrorMessage(res);
    throw ApiException(
      'Unable to fetch podcasts (${res.statusCode})\n$serverMsg',
    );
  }

  Future<List<Podcast>> fetchTrendingPodcasts({int limit = 10}) async {
    const String cacheKey = 'trending_podcasts';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((p) => p.copyWith(isTrending: true))
          .toList();
    }

    if (!hasValidCredentials) {
      return _mockPodcasts()
          .take(limit)
          .map((p) => p.copyWith(isTrending: true))
          .toList();
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {
            'select': '*',
            // 'order': 'play_count.desc.nullslast',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((p) => p.copyWith(isTrending: true))
          .toList();
    }
    final serverMsg = getServerErrorMessage(res);
    throw ApiException('Unable to fetch trending podcasts\n$serverMsg');
  }

  Future<List<Podcast>> fetchRecommendedPodcasts({int limit = 10}) async {
    const String cacheKey = 'recommended_podcasts';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((p) => p.copyWith(isRecommended: true))
          .toList();
    }

    if (!hasValidCredentials) {
      return _mockPodcasts()
          .take(limit)
          .map((p) => p.copyWith(isRecommended: true))
          .toList();
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'order': 'last_updated.desc.nullslast',
            // 'order': 'recommendation_score.desc.nullslast',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((p) => p.copyWith(isRecommended: true))
          .toList();
    }
    final serverMsg = getServerErrorMessage(res);
    throw ApiException('Unable to fetch recommended podcasts\n$serverMsg');
  }

  // =================== EPISODES ===================

  Future<List<Episode>> fetchEpisodesForPodcast(
    String podcastId, {
    int limit = 500,
  }) async {
    final String cacheKey = 'episodes_for_podcast_$podcastId';
    // Try to get from cache first
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }

    if (!hasValidCredentials) {
      return _mockEpisodes(podcastId).take(limit).toList();
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.episodesTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'podcastId': 'eq.$podcastId',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      // Save to cache with a 2-4 hour expiry (e.g., 3 hours)
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }
    throw ApiException(
      'Unable to fetch episodes for podcast $podcastId, statusCode ${res.statusCode}',
    );
  }

  Future<List<Episode>> fetchRecentEpisodes({int limit = 8}) async {
    const String cacheKey = 'recent_episodes';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }

    if (!hasValidCredentials) {
      final mocked = _mockPodcasts().expand((p) => _mockEpisodes(p.id)).toList()
        ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      return mocked.take(limit).toList();
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.episodesTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'order': 'id.desc',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }
    throw ApiException(
      'Unable to fetch recent episodes statusCode: ${res.statusCode}',
    );
  }

  // =================== SEARCH / TOP SHOWS / LOOKUP ===================

  Future<List<Podcast>> searchPodcasts(String query) async {
    if (query.trim().isEmpty) return const <Podcast>[];

    if (!hasValidCredentials) {
      return _mockPodcasts()
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    final encoded = query.replaceAll("'", "''");
    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {'select': '*', 'title': 'ilike.%25$encoded%25'},
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .toList();
    }
    throw ApiException('Unable to search podcasts');
  }

  Future<List<ShowData>> fetchTopShowsThisYear() async {
    const String cacheKey = 'top_shows_this_year';
    // Try to get from cache first
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(ShowData.fromJson)
          .toList();
    }

    if (!hasValidCredentials) {
      final queryResults = [
        {"id": "3", "title": "A lényeg", "count": 8563},
        {"id": "38", "title": "Reggeli gyors", "count": 1743},
        {"id": "14", "title": "Esti gyors", "count": 1691},
        {"id": "34", "title": "Megbeszéljük.", "count": 1687},
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

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.topShowsTable}');
    final res = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      // Save to cache with a daily expiry
      await _cacheService.save(cacheKey, data, expiry: const Duration(days: 1));
      return data
          .whereType<Map<String, dynamic>>()
          .map(ShowData.fromJson)
          .toList();
    }
    throw ApiException('Unable to fetch top shows');
  }

  Future<Podcast?> fetchPodcastById(String podcastId) async {
    final String cacheKey = 'podcast_by_id_$podcastId';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return Podcast.fromJson(cachedData as Map<String, dynamic>);
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {'select': '*', 'id': 'eq.$podcastId', 'limit': '1'},
        );
    final res = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      if (data.isNotEmpty) {
        await _cacheService.save(cacheKey, data.first, expiry: const Duration(hours: 3));
        return Podcast.fromJson(data.first as Map<String, dynamic>);
      }
    }
    return null;
  }

  // =================== USER / TELEMETRY ===================

  Future<UserProfile> fetchUserProfile(String userId) async {
    final String cacheKey = 'user_profile_$userId';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return UserProfile.fromJson(cachedData as Map<String, dynamic>);
    }

    if (!hasValidCredentials) {
      final podcasts = _mockPodcasts();
      final episodes = podcasts.expand((p) => _mockEpisodes(p.id)).toList();
      return UserProfile(
        id: userId,
        languageCode: 'de',
        playbackSpeed: 1.0,
        maxAutoDownload: 10,
        subscribedPodcastIds: podcasts.take(2).map((p) => p.id).toSet(),
        recentlyPlayed: episodes.take(4).toList(),
        favouriteEpisodeIds: episodes.take(3).map((e) => e.id).toSet(),
      );
    }

    final uri =
        Uri.parse(
          '$_supabaseUrl/rest/v1/${constants.userProfilesTable}',
        ).replace(
          queryParameters: {'select': '*', 'id': 'eq.$userId', 'limit': '1'},
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      if (data.isEmpty) throw ApiException('Profile not found for $userId');
      await _cacheService.save(cacheKey, data.first, expiry: const Duration(hours: 3));
      return UserProfile.fromJson(data.first as Map<String, dynamic>);
    }
    throw ApiException('Unable to fetch user profile ($userId)');
  }

  Future<void> logPlayback({required String episodeId}) async {
    if (!hasValidCredentials) return;

    final uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.playbackEventsTable}',
    );
    final res = await _httpClient
        .post(
          uri,
          headers: _headers,
          body: jsonEncode(<String, dynamic>{
            'episodeId': episodeId,
            'playedAt': DateTime.now().toIso8601String(),
          }),
        )
        .timeout(_timeout);
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ApiException('Unable to log playback event');
    }
  }

  // =================== MISC ===================

  void dispose() => _httpClient.close();

  // ---- Helpers & Mocks ----

  List<Podcast> _mockPodcasts() {
    final ShowHost bolgarGyorgy = ShowHost(name: 'Bolgár György');
    final ShowHost szenteVeronika = ShowHost(name: 'Szente Veronika');

    return <Podcast>[
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
  }

  Iterable<Episode> _mockEpisodes(String podcastId) sync* {
    for (int i = 0; i < 12; i++) {
      yield Episode(
        id: '$podcastId-ep-$i',
        podcastId: podcastId,
        title: 'Epizód #$i',
        description:
            'Ez egy mintapélda epizód leírása a(z) $podcastId műsorhoz.',
        audioUrl: 'https://cdn.klubradio.hu/audio/$podcastId/$i.mp3',
        publishedAt: DateTime.now().subtract(Duration(days: i)),
        showDate: '2023-01-01',
        duration: Duration(minutes: 55 - i.clamp(0, 20)),
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
