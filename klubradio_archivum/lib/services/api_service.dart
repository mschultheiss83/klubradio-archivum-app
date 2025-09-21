import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/episode.dart';
import '../models/podcast.dart';
import '../models/show_host.dart';
import '../models/user_profile.dart';

class ApiException implements Exception {
  ApiException(this.message, [this.statusCode]);

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message)';
}

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  // TODO: Replace with the Supabase project REST endpoint once available.
  static const String supabaseUrl =
      'https://todo-project-id.supabase.co';

  // TODO: Replace with the Supabase project's anon/public API key.
  static const String supabaseAnonKey = 'todo-supabase-anon-key';

  static const String _podcastTable = 'podcasts';
  static const String _episodeTable = 'episodes';
  static const String _profileTable = 'profiles';

  bool get _hasSupabaseConfiguration =>
      !supabaseUrl.contains('todo-project-id') &&
      supabaseAnonKey != 'todo-supabase-anon-key';

  Map<String, String> get _headers => <String, String>{
        'Content-Type': 'application/json',
        'apikey': supabaseAnonKey,
        'Authorization': 'Bearer $supabaseAnonKey',
      };

  Future<List<Podcast>> fetchFeaturedPodcasts() async {
    if (!_hasSupabaseConfiguration) {
      return _mockPodcasts.where((podcast) => podcast.isFeatured).toList();
    }

    final uri = Uri.parse(
      '$supabaseUrl/rest/v1/$_podcastTable?select=*&is_featured=eq.true&order=updated_at.desc',
    );
    final response = await _client.get(uri, headers: _headers);
    return _parsePodcastList(response);
  }

  Future<List<Podcast>> fetchTrendingPodcasts() async {
    if (!_hasSupabaseConfiguration) {
      return _mockPodcasts.take(3).toList();
    }

    final uri = Uri.parse(
      '$supabaseUrl/rest/v1/$_podcastTable?select=*&order=weekly_listens.desc&limit=10',
    );
    final response = await _client.get(uri, headers: _headers);
    return _parsePodcastList(response);
  }

  Future<List<Podcast>> fetchRecommendedPodcasts() async {
    if (!_hasSupabaseConfiguration) {
      return _mockPodcasts;
    }

    final uri = Uri.parse(
      '$supabaseUrl/rest/v1/$_podcastTable?select=*&order=recommendation_score.desc.nullslast&limit=12',
    );
    final response = await _client.get(uri, headers: _headers);
    return _parsePodcastList(response);
  }

  Future<List<String>> fetchTopCategories() async {
    if (!_hasSupabaseConfiguration) {
      return _mockPodcasts
          .map((podcast) => podcast.category)
          .toSet()
          .toList()
        ..sort();
    }

    final uri = Uri.parse(
      '$supabaseUrl/rest/v1/$_podcastTable?select=category&order=category.asc',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw ApiException('Failed to load categories', response.statusCode);
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    final categories = decoded
        .whereType<Map<String, dynamic>>()
        .map((entry) => entry['category']?.toString())
        .whereType<String>()
        .toSet()
        .toList();
    categories.sort();
    return categories;
  }

  Future<List<Episode>> fetchLatestEpisodes() async {
    if (!_hasSupabaseConfiguration) {
      return _mockEpisodes
          .toList()
        ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    }

    final uri = Uri.parse(
      '$supabaseUrl/rest/v1/$_episodeTable?select=*&order=published_at.desc&limit=20',
    );
    final response = await _client.get(uri, headers: _headers);
    return _parseEpisodeList(response);
  }

  Future<List<Episode>> fetchEpisodesForPodcast(String podcastId) async {
    if (!_hasSupabaseConfiguration) {
      return _mockEpisodes
          .where((episode) => episode.podcastId == podcastId)
          .toList()
        ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    }

    final uri = Uri.parse(
      '$supabaseUrl/rest/v1/$_episodeTable?select=*&podcast_id=eq.$podcastId&order=published_at.desc',
    );
    final response = await _client.get(uri, headers: _headers);
    return _parseEpisodeList(response);
  }

  Future<List<Episode>> searchEpisodes(String query) async {
    if (query.trim().isEmpty) {
      return const <Episode>[];
    }

    if (!_hasSupabaseConfiguration) {
      final lower = query.toLowerCase();
      return _mockEpisodes
          .where((episode) =>
              episode.title.toLowerCase().contains(lower) ||
              episode.description.toLowerCase().contains(lower))
          .toList();
    }

    final encodedQuery = Uri.encodeComponent('%$query%');
    final uri = Uri.parse(
      '$supabaseUrl/rest/v1/$_episodeTable?select=*&or=(title.ilike.$encodedQuery,description.ilike.$encodedQuery)&order=published_at.desc&limit=25',
    );
    final response = await _client.get(uri, headers: _headers);
    return _parseEpisodeList(response);
  }

  Future<UserProfile> fetchUserProfile() async {
    if (!_hasSupabaseConfiguration) {
      return _mockUserProfile;
    }

    final uri = Uri.parse(
      '$supabaseUrl/rest/v1/$_profileTable?select=*&limit=1',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw ApiException('Failed to load profile', response.statusCode);
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    final profileJson = decoded.firstWhere(
      (dynamic entry) => entry is Map<String, dynamic>,
      orElse: () => const <String, dynamic>{},
    );
    if (profileJson is! Map<String, dynamic> || profileJson.isEmpty) {
      throw ApiException('Profile response was empty');
    }
    return UserProfile.fromJson(profileJson);
  }

  Future<void> dispose() async {
    _client.close();
  }

  List<Podcast> _parsePodcastList(http.Response response) {
    if (response.statusCode != 200) {
      throw ApiException('Failed to load podcasts', response.statusCode);
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Podcast.fromJson)
        .toList();
  }

  List<Episode> _parseEpisodeList(http.Response response) {
    if (response.statusCode != 200) {
      throw ApiException('Failed to load episodes', response.statusCode);
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Episode.fromJson)
        .toList();
  }
}

final List<Podcast> _mockPodcasts = <Podcast>[
  Podcast(
    id: 'esti-gyors',
    title: 'Esti gyors',
    description:
        'Közéleti hírműsor minden hétköznap estére. Válogatás a legfontosabb politikai és társadalmi témákból.',
    category: 'Hírek',
    coverImageUrl:
        'https://images.klubradio.hu/mock/esti-gyors.jpg',
    language: 'hu',
    hosts: const <ShowHost>[
      ShowHost(
        id: 'bolgar-gyorgy',
        name: 'Bolgár György',
        bio: 'Újságíró, a műsor állandó házigazdája.',
      ),
    ],
    episodeCount: 120,
    isFeatured: true,
    weeklyListens: 4200,
  ),
  Podcast(
    id: 'megbeszeljuk',
    title: 'Megbeszéljük',
    description:
        'Napi interaktív műsor hallgatói kérdésekkel, aktualitásokkal és szakértői véleményekkel.',
    category: 'Közélet',
    coverImageUrl:
        'https://images.klubradio.hu/mock/megbeszeljuk.jpg',
    language: 'hu',
    hosts: const <ShowHost>[
      ShowHost(
        id: 'szolnoki-henrietta',
        name: 'Szolnoki Henrietta',
      ),
      ShowHost(
        id: 'para-kovacs-imre',
        name: 'Para-Kovács Imre',
      ),
    ],
    episodeCount: 210,
    isFeatured: true,
    weeklyListens: 5100,
  ),
  Podcast(
    id: 'reggeli-gyors',
    title: 'Reggeli gyors',
    description:
        'Összefoglaló a nap legfontosabb híreiről, interjúkkal és helyszíni tudósításokkal.',
    category: 'Hírek',
    coverImageUrl:
        'https://images.klubradio.hu/mock/reggeli-gyors.jpg',
    language: 'hu',
    hosts: const <ShowHost>[
      ShowHost(
        id: 'szentei-bela',
        name: 'Szénási Sándor',
      ),
    ],
    episodeCount: 185,
    weeklyListens: 4600,
  ),
];

final List<Episode> _mockEpisodes = <Episode>[
  Episode(
    id: 'esti-gyors-2024-01-10',
    podcastId: 'esti-gyors',
    title: 'Esti gyors - 2024. január 10.',
    description:
        'Összefoglaló a nap legfontosabb közéleti eseményeiről interjúkkal és szakértői elemzésekkel.',
    audioUrl:
        'https://cdn.klubradio.hu/mock/esti-gyors-2024-01-10.mp3',
    duration: const Duration(minutes: 52, seconds: 16),
    publishedAt: DateTime(2024, 1, 10, 18, 5),
  ),
  Episode(
    id: 'esti-gyors-2024-01-09',
    podcastId: 'esti-gyors',
    title: 'Esti gyors - 2024. január 9.',
    description:
        'A Klubrádió esti hírmagazinja, fókuszban a hazai politikai élet legfontosabb történései.',
    audioUrl:
        'https://cdn.klubradio.hu/mock/esti-gyors-2024-01-09.mp3',
    duration: const Duration(minutes: 49, seconds: 3),
    publishedAt: DateTime(2024, 1, 9, 18, 5),
  ),
  Episode(
    id: 'megbeszeljuk-2024-01-11',
    podcastId: 'megbeszeljuk',
    title: 'Megbeszéljük - 2024. január 11.',
    description:
        'Hallgatói kérdések és szakértői válaszok a hét fő témáiról: oktatás, egészségügy, EU-politika.',
    audioUrl:
        'https://cdn.klubradio.hu/mock/megbeszeljuk-2024-01-11.mp3',
    duration: const Duration(minutes: 44, seconds: 8),
    publishedAt: DateTime(2024, 1, 11, 17, 30),
  ),
  Episode(
    id: 'reggeli-gyors-2024-01-11',
    podcastId: 'reggeli-gyors',
    title: 'Reggeli gyors - 2024. január 11.',
    description:
        'Reggeli hírösszefoglaló élő bejelentkezésekkel és friss riportokkal Budapest és Brüsszel között.',
    audioUrl:
        'https://cdn.klubradio.hu/mock/reggeli-gyors-2024-01-11.mp3',
    duration: const Duration(minutes: 54, seconds: 12),
    publishedAt: DateTime(2024, 1, 11, 7, 5),
  ),
  Episode(
    id: 'megbeszeljuk-2024-01-10',
    podcastId: 'megbeszeljuk',
    title: 'Megbeszéljük - 2024. január 10.',
    description:
        'Gazdasági helyzetkép, egészségügyi rendszer kihívásai és hallgatói tapasztalatok.',
    audioUrl:
        'https://cdn.klubradio.hu/mock/megbeszeljuk-2024-01-10.mp3',
    duration: const Duration(minutes: 47, seconds: 52),
    publishedAt: DateTime(2024, 1, 10, 17, 30),
  ),
];

final UserProfile _mockUserProfile = UserProfile(
  id: 'demo-user',
  displayName: 'Klubrádió Hallgató',
  email: 'hallgato@example.com',
  preferredLanguage: 'hu',
  avatarUrl: 'https://images.klubradio.hu/mock/listener.png',
  favoritePodcasts: const <String>['esti-gyors', 'megbeszeljuk'],
);
