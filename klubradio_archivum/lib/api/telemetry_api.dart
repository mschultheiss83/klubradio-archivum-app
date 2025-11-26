// lib/api/telemetry_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for telemetry and analytics operations.
///
/// Handles logging user events like playback, downloads, and searches.
/// These operations are fire-and-forget and should not block user interactions.
class TelemetryApi {
  TelemetryApi({
    required this.baseUrl,
    required String apiKey,
    http.Client? client,
  })  : _apiKey = apiKey,
        _client = client ?? http.Client();

  final String baseUrl;
  final String _apiKey;
  final http.Client _client;

  static const Duration _timeout = Duration(seconds: 5);

  Map<String, String> get _headers => {
        'apikey': _apiKey,
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// Logs a playback event for an episode.
  ///
  /// This is a fire-and-forget operation that records when a user plays an episode.
  /// Failures are silently ignored to not impact user experience.
  Future<void> logPlayback({required String episodeId}) async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/${constants.playbackEventsTable}');
      await _client
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              'episodeId': episodeId,
              'playedAt': DateTime.now().toIso8601String(),
            }),
          )
          .timeout(_timeout);
    } catch (_) {
      // Silently ignore telemetry errors
    }
  }

  /// Logs a download event for an episode.
  ///
  /// Records when a user downloads an episode for offline playback.
  Future<void> logDownload({required String episodeId}) async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/download_events');
      await _client
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              'episodeId': episodeId,
              'downloadedAt': DateTime.now().toIso8601String(),
            }),
          )
          .timeout(_timeout);
    } catch (_) {
      // Silently ignore telemetry errors
    }
  }

  /// Logs a search event.
  ///
  /// Records search queries and result counts for analytics.
  Future<void> logSearch({
    required String query,
    required int resultCount,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/search_events');
      await _client
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              'query': query,
              'resultCount': resultCount,
              'searchedAt': DateTime.now().toIso8601String(),
            }),
          )
          .timeout(_timeout);
    } catch (_) {
      // Silently ignore telemetry errors
    }
  }

  /// Disposes of the HTTP client.
  void dispose() {
    _client.close();
  }
}
