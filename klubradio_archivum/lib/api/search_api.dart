// lib/api/search_api.dart
import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for search operations.
///
/// Handles searching podcasts and episodes by query string.
class SearchApi {
  SearchApi({
    required this.baseUrl,
    required String apiKey,
    HttpRequester? requester,
  }) : _requester = requester ??
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

  /// Searches for podcasts by title.
  ///
  /// Performs a case-insensitive partial match search on podcast titles.
  /// Returns raw JSON data that can be parsed into Podcast models.
  Future<List<Map<String, dynamic>>> podcasts(String query) async {
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

  /// Searches for episodes by title.
  ///
  /// Performs a case-insensitive partial match search on episode titles.
  /// Returns raw JSON data that can be parsed into Episode models.
  Future<List<Map<String, dynamic>>> episodes(String query) async {
    if (query.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    // Escape single quotes for SQL ILIKE query
    final encoded = query.replaceAll("'", "''");
    final url =
        '$baseUrl/rest/v1/${constants.episodesTable}?select=*&title=ilike.%25$encoded%25';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  // Future enhancement: full-text search across descriptions, hosts, etc.
  // Future<List<Map<String, dynamic>>> fullText(String query) async { ... }
}
