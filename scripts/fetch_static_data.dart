#!/usr/bin/env dart
// scripts/fetch_static_data.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Script to fetch commonly accessed data from Supabase and save as static bundles.
///
/// This script runs via GitHub Actions daily to keep bundled data fresh.
/// Usage:
///   SUPABASE_URL=<url> SUPABASE_KEY=<key> dart run scripts/fetch_static_data.dart
void main() async {
  final supabaseUrl = Platform.environment['SUPABASE_URL'];
  final supabaseKey = Platform.environment['SUPABASE_KEY'];

  if (supabaseUrl == null || supabaseKey == null) {
    stderr.writeln('Error: SUPABASE_URL and SUPABASE_KEY environment variables must be set');
    exit(1);
  }

  final fetcher = DataFetcher(
    baseUrl: supabaseUrl,
    apiKey: supabaseKey,
  );

  try {
    await fetcher.fetchAndSaveAll();
    print('✅ All static data bundles updated successfully');
  } catch (e, stack) {
    stderr.writeln('❌ Failed to fetch static data: $e');
    stderr.writeln(stack);
    exit(1);
  }
}

class DataFetcher {
  DataFetcher({required this.baseUrl, required this.apiKey});

  final String baseUrl;
  final String apiKey;
  final client = http.Client();

  static const outputDir = 'klubradio_archivum/assets/data';

  Map<String, String> get headers => {
    'apikey': apiKey,
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<void> fetchAndSaveAll() async {
    // Create output directory if it doesn't exist
    final dir = Directory(outputDir);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    print('📦 Fetching static data bundles...');

    // Fetch all data in parallel for speed
    await Future.wait([
      _fetchAndSave(
        'latest_podcasts',
        '$baseUrl/rest/v1/podcasts?select=*&order=last_updated.desc&limit=50',
      ),
      _fetchAndSave(
        'trending_podcasts',
        '$baseUrl/rest/v1/podcasts?select=*&limit=50',
      ),
      _fetchAndSave(
        'recommended_podcasts',
        '$baseUrl/rest/v1/podcasts?select=*&order=last_updated.desc.nullslast&limit=50',
      ),
      _fetchAndSave(
        'recent_episodes',
        '$baseUrl/rest/v1/episodes?select=*&order=id.desc&limit=100',
      ),
      _fetchAndSave(
        'top_shows_this_year',
        '$baseUrl/rest/v1/top_shows_this_year',
      ),
      _fetchAndSave(
        'all_podcasts_index',
        '$baseUrl/rest/v1/podcasts?select=id,title,description,coverImageUrl,episodeCount',
      ),
    ]);

    // Save metadata about when the bundle was generated
    await _saveMetadata();

    client.close();
  }

  Future<void> _fetchAndSave(String name, String url) async {
    print('  Fetching $name...');

    try {
      final response = await client
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);

        // Wrap data with metadata
        final bundle = {
          'items': data,
          'fetchedAt': DateTime.now().toIso8601String(),
        };

        final file = File('$outputDir/$name.json');
        await file.writeAsString(
          const JsonEncoder.withIndent('  ').convert(bundle),
        );

        final itemCount = data is List ? data.length : 1;
        print('    ✓ Saved $name.json ($itemCount items)');
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      stderr.writeln('    ✗ Failed to fetch $name: $e');
      rethrow;
    }
  }

  Future<void> _saveMetadata() async {
    final metadata = {
      'updatedAt': DateTime.now().toIso8601String(),
      'version': '1.0.0',
      'bundles': [
        'latest_podcasts',
        'trending_podcasts',
        'recommended_podcasts',
        'recent_episodes',
        'top_shows_this_year',
        'all_podcasts_index',
      ],
    };

    final file = File('$outputDir/metadata.json');
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(metadata),
    );

    print('  ✓ Saved metadata.json');
  }
}
