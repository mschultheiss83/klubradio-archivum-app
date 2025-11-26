// lib/api/api_client.dart

/// Shared API configuration and utilities for all API classes.
///
/// This class provides centralized configuration for Supabase API access,
/// including credentials, headers, and validation helpers.
class ApiClient {
  /// Base URL for Supabase instance
  static const String supabaseUrl = 'https://arakbotxgwpyyqyxjhhl.supabase.co';

  /// Anonymous API key for Supabase
  static const String supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyYWtib3R4Z3dweXlxeXhqaGhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgxMDE0MzUsImV4cCI6MjA3MzY3NzQzNX0.zO__rAZCmPQW26YAC3CYhq_ZSjUAx0Gh0KHXIVHhm7w';

  /// Standard HTTP headers for Supabase API requests
  static Map<String, String> get headers => {
        'apikey': supabaseKey,
        'Authorization': 'Bearer $supabaseKey',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// Checks if the API credentials are properly configured.
  ///
  /// Returns false if credentials contain placeholder values like 'TODO'.
  static bool get hasValidCredentials =>
      !supabaseUrl.contains('TODO') && !supabaseKey.contains('TODO');
}
