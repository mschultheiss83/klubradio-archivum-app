import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for podcast-related operations.
///
/// Handles fetching podcast lists, individual podcasts, and related data.
class PodcastApi {
  PodcastApi({
    required this.baseUrl,
    required String apiKey,
    HttpRequester? requester,
  }) : _requester =
           requester ??
           HttpRequester(
             defaultHeaders: {
               'apikey': apiKey,
               'Authorization': 'Bearer $apiKey',
               'Content-Type': 'application/json',
               'Accept': 'application/json',
             },
           );

  final String baseUrl;
  final HttpRequester _requester;

  /// Fetches the latest podcasts ordered by last updated date.
  ///
  /// Returns raw JSON data that can be parsed into Podcast models.
  /// The [limit] parameter controls the maximum number of podcasts returned.
  Future<List<Map<String, dynamic>>> latest({int limit = 10}) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&order=last_updated.desc&limit=$limit';
    debugPrint('latest url: $url');
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches recommended podcasts.
  ///
  /// Returns raw JSON data that can be parsed into Podcast models.
  Future<List<Map<String, dynamic>>> recommended({int limit = 10}) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&order=last_updated.desc.nullslast&limit=$limit';
    debugPrint('recommended url: $url');
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches trending podcasts.
  ///
  /// Returns raw JSON data that can be parsed into Podcast models.
  Future<List<Map<String, dynamic>>> trending({int limit = 10}) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&order=id.desc&limit=$limit';
    debugPrint('trending url: $url');
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches recent episodes across all podcasts.
  ///
  /// Returns raw JSON data that can be parsed into Episode models.
  /// Note: This method may be moved to EpisodeApi in the future.
  Future<List<Map<String, dynamic>>> recentEpisodes({int limit = 8}) async {
    final url =
        '$baseUrl/rest/v1/${constants.episodesTable}?select=*&order=id.desc&limit=$limit';
    debugPrint('recentEpisodes url: $url');
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches a single podcast by ID.
  ///
  /// Returns raw JSON data for the podcast, or null if not found.
  Future<Map<String, dynamic>?> byId(String podcastId) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&id=eq.$podcastId&limit=1';
    final json = await _requester.getJson(url);

    final list = json as List;
    if (list.isEmpty) {
      return null;
    }

    return list.first as Map<String, dynamic>;
  }

  /// Searches for podcasts by title.
  ///
  /// Performs a case-insensitive partial match search.
  /// Returns raw JSON data that can be parsed into Podcast models.
  /// Note: This method may be moved to SearchApi in the future.
  Future<List<Map<String, dynamic>>> search(String query) async {
    if (query.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    // Escape single quotes for SQL ILIKE query
    final encoded = query.replaceAll("'", "''");
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&title=ilike.%25$encoded%25';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }
}
