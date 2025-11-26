// lib/api/top_shows_api.dart
import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for fetching top shows statistics.
///
/// Handles retrieving aggregated statistics about most popular shows.
class TopShowsApi {
  TopShowsApi({
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

  /// Fetches top shows for this year.
  ///
  /// Returns raw JSON data with show statistics (id, title, count).
  Future<List<Map<String, dynamic>>> thisYear() async {
    final url = '$baseUrl/rest/v1/${constants.topShowsTable}';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  // Future enhancement: add methods for different time periods
  // Future<List<Map<String, dynamic>>> thisMonth() async { ... }
  // Future<List<Map<String, dynamic>>> thisWeek() async { ... }
}
