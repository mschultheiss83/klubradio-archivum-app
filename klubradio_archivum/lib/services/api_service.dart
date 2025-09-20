import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/episode.dart';
import '../models/podcast.dart';
import '../models/show_host.dart';

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

  // TODO: Replace with the actual Supabase REST endpoint for the project.
  static const String _supabaseUrl =
      'https://your-supabase-project.supabase.co';

  // TODO: Replace with the project's Supabase anon/public API key.
  static const String _supabaseAnonKey = 'supabase-anon-key';

  static const String _podcastTable = 'podcasts';
  static const String _episodeTable = 'episodes';

  bool get _usingPlaceholderCredentials =>
      _supabaseUrl.contains('your-supabase-project') ||
      _supabaseAnonKey == 'supabase-anon-key';

  Map<String, String> get _headers => <String, String>{
        'Content-Type': 'application/json',
        'apikey': _supabaseAnonKey,
        'Authorization': 'Bearer $_supabaseAnonKey',
        'Accept': 'application/json',
      };

  Future<List<Podcast>> fetchFeaturedPodcasts() async {
    if (_usingPlaceholderCredentials) {
      return _mockPodcasts.take(5).toList();
    }

    final uri = Uri.parse(
      '$_supabaseUrl/rest/v1/$_podcastTable?select=*&is_featured=eq.true&order=updated_at.desc.nullslast',
    );
    final response = await _client.get(uri, headers: _headers);
    return _parsePodcastResponse(response);
  }

  Future<List<Podcast>> fetchTrendingPodcasts() async {
    if (_usingPlaceholderCredentials) {
      return _mockPodcasts
          .skip(1)
          .take(5)
          .map((podcast) => podcast.copyWith())
          .toList();
    }

    final uri = Uri.parse(
      '$_supabaseUrl/rest/v1/$_podcastTable?select=*&order=weekly_listens.desc.nullslast&limit=10',
    );
    final response = await _client.get(uri, headers: _headers);
    return _parsePodcastResponse(response);
  }

  Future<List<Podcast>> fetchRecommendedPodcasts() async {
    if (_usingPlaceholderCredentials) {
      return _mockPodcasts;
    }

    final uri = Uri.parse(
      '$_supabaseUrl/rest/v1/$_podcastTable?select=*&order=recommendation_score.desc.nullslast&limit=12',
    );
    final response = await _client.get(uri, headers: _headers);
    return _parsePodcastResponse(response);
  }

  Future<List<String>> fetchTopCategories() async {
    if (_usingPlaceholderCredentials) {
      final categories = _mockPodcasts.map((podcast) => podcast.category).toSet();
      return categories.toList();
    }

    final uri = Uri.parse(
      '$_supabaseUrl/rest/v1/$_podcastTable?select=category&order=category.asc',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw ApiException('Failed to fetch categories', response.statusCode);
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    final categories = decoded
        .map((entry) => entry is Map<String, dynamic>
            ? entry['category']?.toString()
            : entry.toString())
        .whereType<String>()
        .toSet()
        .toList();
    categories.sort();
    return categories;
  }

  Future<List<Episode>> fetchEpisodesForPodcast(String podcastId) async {
    if (_usingPlaceholderCredentials) {
      return _mockEpisodesByPodcast[podcastId]?.toList() ??
          const <Episode>[];
    }

    final uri = Uri.parse(
      '$_supabaseUrl/rest/v1/$_episodeTable?select=*&podcast_id=eq.$podcastId&order=published_at.desc',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw ApiException('Failed to load episodes', response.statusCode);
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Episode.fromJson)
        .toList();
  }

  Future<List<Episode>> searchEpisodes(String query) async {
    if (query.trim().isEmpty) {
      return const <Episode>[];
    }

    if (_usingPlaceholderCredentials) {
      final lower = query.toLowerCase();
      return _mockEpisodesByPodcast.values
          .expand((episodes) => episodes)
          .where(
            (episode) =>
                episode.title.toLowerCase().contains(lower) ||
                episode.description.toLowerCase().contains(lower),
          )
          .toList();
    }

    final encodedQuery = Uri.encodeComponent('%$query%');
    final uri = Uri.parse(
      '$_supabaseUrl/rest/v1/$_episodeTable?select=*&or=(title.ilike.$encodedQuery,description.ilike.$encodedQuery)&order=published_at.desc&limit=25',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw ApiException('Failed to search episodes', response.statusCode);
    }
    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Episode.fromJson)
        .toList();
  }

  Future<void> dispose() async {
    _client.close();
  }

  List<Podcast> _parsePodcastResponse(http.Response response) {
    if (response.statusCode != 200) {
      throw ApiException('Failed to fetch podcasts', response.statusCode);
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Podcast.fromJson)
        .toList();
  }
}

final List<Podcast> _mockPodcasts = <Podcast>[
  Podcast(
    id: 'esti-gyors',
    title: 'Esti gyors',
    description:
        'Hírműsor a Klubrádió archívumából: naprakész politikai és közéleti beszélgetések.',
    category: 'Hírek',
    coverImageUrl:
        'https://images.klubradio.hu/archivum/esti-gyors.jpg',
    language: 'hu',
    hosts: const <ShowHost>[
      ShowHost(
        id: 'bolgar-gyorgy',
        name: 'Bolgár György',
        bio: 'Klubrádió műsorvezető és újságíró.',
      ),
    ],
    episodeCount: 180,
  ),
  Podcast(
    id: 'megbeszeljuk',
    title: 'Megbeszéljük...!',
    description:
        'Bolgár György ikonikus műsora hallgatói betelefonálásokkal és közéleti elemzéssel.',
    category: 'Közélet',
    coverImageUrl:
        'https://images.klubradio.hu/archivum/megbeszeljuk.jpg',
    language: 'hu',
    hosts: const <ShowHost>[
      ShowHost(
        id: 'bolgar-gyorgy',
        name: 'Bolgár György',
      ),
    ],
    episodeCount: 240,
  ),
  Podcast(
    id: 'reggeli-gyors',
    title: 'Reggeli gyors',
    description:
        'Reggeli hírműsor elemzésekkel, interjúkkal és friss tudósításokkal.',
    category: 'Hírek',
    coverImageUrl:
        'https://images.klubradio.hu/archivum/reggeli-gyors.jpg',
    language: 'hu',
    hosts: const <ShowHost>[
      ShowHost(
        id: 'simon-andras',
        name: 'Simon András',
      ),
    ],
    episodeCount: 200,
  ),
  Podcast(
    id: 'sport-hela',
    title: 'Hosszabbítás',
    description: 'Sportmagazin a legfrissebb hírekkel és interjúkkal.',
    category: 'Sport',
    coverImageUrl: 'https://images.klubradio.hu/archivum/hosszabbitas.jpg',
    language: 'hu',
    hosts: const <ShowHost>[
      ShowHost(
        id: 'sajo-ando',
        name: 'Sajó Andor',
      ),
    ],
    episodeCount: 120,
  ),
  Podcast(
    id: 'szabad-sajto',
    title: 'Szabad Sáv',
    description: 'Kultúra és társadalom a Klubrádió archívumából.',
    category: 'Kultúra',
    coverImageUrl: 'https://images.klubradio.hu/archivum/szabad-sav.jpg',
    language: 'hu',
    hosts: const <ShowHost>[
      ShowHost(
        id: 'musorvezeto',
        name: 'Klubrádió műsorvezetők',
      ),
    ],
    episodeCount: 95,
  ),
];

final Map<String, List<Episode>> _mockEpisodesByPodcast =
    <String, List<Episode>>{
  'esti-gyors': <Episode>[
    Episode(
      id: 'esti-gyors-2025-09-16',
      podcastId: 'esti-gyors',
      title: 'Esti gyors - 2025. szeptember 16.',
      description:
          'Az esti műsor legfontosabb közéleti témái a Klubrádió archívumából.',
      audioUrl:
          'https://cdn.klubradio.hu/audio/esti-gyors-2025-09-16.mp3',
      duration: const Duration(minutes: 52, seconds: 18),
      publishedAt: DateTime(2025, 9, 16, 18, 30),
      imageUrl: 'https://images.klubradio.hu/archivum/esti-gyors.jpg',
    ),
    Episode(
      id: 'esti-gyors-2025-09-15',
      podcastId: 'esti-gyors',
      title: 'Esti gyors - 2025. szeptember 15.',
      description:
          'Napi összefoglaló gazdasági és politikai fókuszban a Klubrádióban.',
      audioUrl:
          'https://cdn.klubradio.hu/audio/esti-gyors-2025-09-15.mp3',
      duration: const Duration(minutes: 49, seconds: 10),
      publishedAt: DateTime(2025, 9, 15, 18, 30),
      imageUrl: 'https://images.klubradio.hu/archivum/esti-gyors.jpg',
    ),
  ],
  'megbeszeljuk': <Episode>[
    Episode(
      id: 'megbeszeljuk-2025-09-16',
      podcastId: 'megbeszeljuk',
      title: 'Megbeszéljük...! - 2025. szeptember 16.',
      description:
          'Bolgár György és a hallgatók beszélgetése a legfontosabb hírekről.',
      audioUrl:
          'https://cdn.klubradio.hu/audio/megbeszeljuk-2025-09-16.mp3',
      duration: const Duration(minutes: 58, seconds: 2),
      publishedAt: DateTime(2025, 9, 16, 15, 5),
      imageUrl: 'https://images.klubradio.hu/archivum/megbeszeljuk.jpg',
    ),
    Episode(
      id: 'megbeszeljuk-2025-09-15',
      podcastId: 'megbeszeljuk',
      title: 'Megbeszéljük...! - 2025. szeptember 15.',
      description: 'Hallgatói betelefonálások és elemzések a Klubrádióból.',
      audioUrl:
          'https://cdn.klubradio.hu/audio/megbeszeljuk-2025-09-15.mp3',
      duration: const Duration(minutes: 54, seconds: 30),
      publishedAt: DateTime(2025, 9, 15, 15, 5),
      imageUrl: 'https://images.klubradio.hu/archivum/megbeszeljuk.jpg',
    ),
  ],
  'reggeli-gyors': <Episode>[
    Episode(
      id: 'reggeli-gyors-2025-09-16',
      podcastId: 'reggeli-gyors',
      title: 'Reggeli gyors - 2025. szeptember 16.',
      description:
          'Reggeli műsor friss politikai és gazdasági témákkal.',
      audioUrl:
          'https://cdn.klubradio.hu/audio/reggeli-gyors-2025-09-16.mp3',
      duration: const Duration(minutes: 45, seconds: 44),
      publishedAt: DateTime(2025, 9, 16, 7, 5),
      imageUrl: 'https://images.klubradio.hu/archivum/reggeli-gyors.jpg',
    ),
  ],
  'sport-hela': <Episode>[
    Episode(
      id: 'sport-hela-2025-09-16',
      podcastId: 'sport-hela',
      title: 'Hosszabbítás - 2025. szeptember 16.',
      description: 'Heti sportösszefoglaló interjúkkal a Klubrádióból.',
      audioUrl:
          'https://cdn.klubradio.hu/audio/hosszabbitas-2025-09-16.mp3',
      duration: const Duration(minutes: 43, seconds: 12),
      publishedAt: DateTime(2025, 9, 16, 20),
      imageUrl: 'https://images.klubradio.hu/archivum/hosszabbitas.jpg',
    ),
  ],
  'szabad-sajto': <Episode>[
    Episode(
      id: 'szabad-sav-2025-09-15',
      podcastId: 'szabad-sajto',
      title: 'Szabad Sáv - 2025. szeptember 15.',
      description:
          'Kultúra, társadalom, művészet a Klubrádió archívumában.',
      audioUrl:
          'https://cdn.klubradio.hu/audio/szabad-sav-2025-09-15.mp3',
      duration: const Duration(minutes: 38, seconds: 27),
      publishedAt: DateTime(2025, 9, 15, 19, 30),
      imageUrl: 'https://images.klubradio.hu/archivum/szabad-sav.jpg',
    ),
  ],
};
