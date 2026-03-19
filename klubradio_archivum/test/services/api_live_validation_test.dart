// test/services/api_live_validation_test.dart
//
// Live API validation - uses http.Client directly (no Flutter binding).
// Run with: flutter test --dart-define API_SERVICE_LIVE_TESTS=true test/services/api_live_validation_test.dart
//
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

const bool _runLive = bool.fromEnvironment('API_SERVICE_LIVE_TESTS');

const String _supabaseUrl = 'https://arakbotxgwpyyqyxjhhl.supabase.co';
const String _supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyYWtib3R4Z3dweXlxeXhqaGhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgxMDE0MzUsImV4cCI6MjA3MzY3NzQzNX0.zO__rAZCmPQW26YAC3CYhq_ZSjUAx0Gh0KHXIVHhm7w';

Map<String, String> get _headers => {
  'apikey': _supabaseKey,
  'Authorization': 'Bearer $_supabaseKey',
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

Future<http.Response> _get(String table, {Map<String, String>? params}) async {
  final uri = Uri.parse('$_supabaseUrl/rest/v1/$table')
      .replace(queryParameters: params);
  return http.get(uri, headers: _headers);
}

void main() {
  group('Live API validation', () {
    test('episodes table: inspect raw columns and field mapping', () async {
      if (!_runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final res = await _get(constants.episodesTable, params: {
        'select': '*', 'limit': '5', 'order': 'id.desc',
      });
      expect(res.statusCode, 200, reason: 'Episodes API: ${res.body}');

      final data = jsonDecode(res.body) as List<dynamic>;
      expect(data, isNotEmpty, reason: 'Episodes table should have data');

      final first = data.first as Map<String, dynamic>;

      // ignore: avoid_print
      print('\n=== RAW EPISODE COLUMNS ===');
      for (final key in first.keys) {
        // ignore: avoid_print
        print('  $key: ${first[key]} (${first[key]?.runtimeType})');
      }

      // Check which fields Episode.fromJson expects
      final expectedFields = ['id', 'podcastId', 'title', 'description', 'audioUrl', 'publishedAt', 'showDate', 'duration', 'imageUrl', 'hosts'];
      // ignore: avoid_print
      print('\n=== FIELD MAPPING (Episode.fromJson expects camelCase) ===');
      for (final field in expectedFields) {
        final present = first.containsKey(field);
        // ignore: avoid_print
        print('  $field: ${present ? "PRESENT" : "MISSING"}');
      }

      // Try parsing
      // ignore: avoid_print
      print('\n=== Episode.fromJson on raw API data ===');
      for (final raw in data) {
        final ep = Episode.fromJson(raw as Map<String, dynamic>);
        // ignore: avoid_print
        print('  [${ep.id}] podcastId="${ep.podcastId}" title="${ep.title}" audio=${ep.audioUrl.isNotEmpty ? "OK" : "EMPTY"} showDate="${ep.showDate}" duration=${ep.duration}');
      }
    });

    test('podcasts table: inspect raw columns and field mapping', () async {
      if (!_runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final res = await _get(constants.podcastsTable, params: {
        'select': '*', 'limit': '3',
      });
      expect(res.statusCode, 200, reason: 'Podcasts API: ${res.body}');

      final data = jsonDecode(res.body) as List<dynamic>;
      expect(data, isNotEmpty);

      final first = data.first as Map<String, dynamic>;
      // ignore: avoid_print
      print('\n=== RAW PODCAST COLUMNS ===');
      for (final key in first.keys) {
        // ignore: avoid_print
        print('  $key: ${first[key]} (${first[key]?.runtimeType})');
      }

      // ignore: avoid_print
      print('\n=== Podcast.fromJson ===');
      for (final raw in data) {
        final p = Podcast.fromJson(raw as Map<String, dynamic>);
        // ignore: avoid_print
        print('  [${p.id}] "${p.title}" cover=${p.coverImageUrl.isNotEmpty ? "OK" : "EMPTY"} episodes=${p.episodeCount} hosts=${p.hosts.length}');
      }
    });

    test('episodes filter by podcastId works correctly', () async {
      if (!_runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      // Get a sample episode to find a real podcastId
      final sampleRes = await _get(constants.episodesTable, params: {
        'select': 'id,podcastId', 'limit': '3',
      });
      expect(sampleRes.statusCode, 200);
      final samples = jsonDecode(sampleRes.body) as List<dynamic>;

      if (samples.isEmpty) {
        // ignore: avoid_print
        print('No episodes in table at all');
        return;
      }

      final samplePodcastId = (samples.first as Map)['podcastId']?.toString();
      // ignore: avoid_print
      print('\n=== Sample podcastId values ===');
      for (final s in samples) {
        // ignore: avoid_print
        print('  id=${s['id']} podcastId=${s['podcastId']}');
      }

      if (samplePodcastId == null || samplePodcastId == 'null') {
        // ignore: avoid_print
        print('WARNING: podcastId is null in episodes table');
        return;
      }

      // Test the filter as ApiService uses it
      final filteredRes = await _get(constants.episodesTable, params: {
        'select': '*',
        'podcastId': 'eq.$samplePodcastId',
        'limit': '5',
      });

      // ignore: avoid_print
      print('\n=== Filter Test: podcastId=eq.$samplePodcastId ===');
      // ignore: avoid_print
      print('  Status: ${filteredRes.statusCode}');
      final filtered = jsonDecode(filteredRes.body) as List<dynamic>;
      // ignore: avoid_print
      print('  Results: ${filtered.length}');
      for (final ep in filtered.take(3)) {
        // ignore: avoid_print
        print('  [${ep['id']}] podcastId=${ep['podcastId']} title="${ep['title']}"');
      }
    });

    test('top_shows_this_year table', () async {
      if (!_runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final res = await _get(constants.topShowsTable);
      // ignore: avoid_print
      print('\n=== Top Shows (status=${res.statusCode}) ===');
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as List<dynamic>;
        // ignore: avoid_print
        print('  Count: ${data.length}');
        for (final row in data.take(5)) {
          // ignore: avoid_print
          print('  $row');
        }
      } else {
        // ignore: avoid_print
        print('  Error: ${res.body}');
      }
    });
  });
}
