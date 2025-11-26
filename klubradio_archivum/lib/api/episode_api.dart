// lib/api/episode_api.dart
import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for episode-related operations.
///
/// Handles fetching episodes for specific podcasts and recent episodes.
class EpisodeApi {
  EpisodeApi({
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

  /// Fetches episodes for a specific podcast.
  ///
  /// Returns raw JSON data that can be parsed into Episode models.
  /// The [limit] parameter controls the maximum number of episodes returned.
  Future<List<Map<String, dynamic>>> forPodcast(
    String podcastId, {
    int limit = 500,
  }) async {
    final url =
        '$baseUrl/rest/v1/${constants.episodesTable}?select=*&podcastId=eq.$podcastId&limit=$limit';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches the most recent episodes across all podcasts.
  ///
  /// Returns raw JSON data ordered by ID descending (most recent first).
  /// The [limit] parameter controls the maximum number of episodes returned.
  Future<List<Map<String, dynamic>>> recent({int limit = 8}) async {
    final url =
        '$baseUrl/rest/v1/${constants.episodesTable}?select=*&order=id.desc&limit=$limit';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }
}
