// lib/api/user_api.dart
import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for user profile operations.
///
/// Handles fetching and updating user profile data.
class UserApi {
  UserApi({
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

  /// Fetches a user profile by ID.
  ///
  /// Returns raw JSON data for the user profile, or null if not found.
  Future<Map<String, dynamic>?> profile(String userId) async {
    final url =
        '$baseUrl/rest/v1/${constants.userProfilesTable}?select=*&id=eq.$userId&limit=1';
    final json = await _requester.getJson(url);

    final list = json as List;
    if (list.isEmpty) {
      return null;
    }

    return list.first as Map<String, dynamic>;
  }

  // Future enhancement: add update and create methods
  // Future<void> updateProfile(String userId, Map<String, dynamic> data) async { ... }
  // Future<void> createProfile(Map<String, dynamic> data) async { ... }
}
