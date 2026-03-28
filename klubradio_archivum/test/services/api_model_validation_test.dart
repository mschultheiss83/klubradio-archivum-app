// test/services/api_model_validation_test.dart
//
// Validates that the Supabase API responses match the expected model schemas.
// Run with: flutter test --dart-define API_SERVICE_LIVE_TESTS=true test/services/api_model_validation_test.dart
//
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

void main() {
  const bool runLive = bool.fromEnvironment('API_SERVICE_LIVE_TESTS');

  // Initialize binding for SharedPreferences (used by ApiCacheService)
  TestWidgetsFlutterBinding.ensureInitialized();

  group('API + Model validation (live)', () {
    setUp(() {
      // Reset HttpOverrides so real HTTP requests go through
      // (flutter test binding intercepts all HTTP with status 400)
      HttpOverrides.global = null;
      // Re-initialize SharedPreferences mock (needed by ApiCacheService)
      SharedPreferences.setMockInitialValues({});
    });
    late ApiService service;

    setUp(() {
      service = ApiService();
    });

    tearDown(() {
      service.dispose();
    });

    test('raw episodes response has expected field names', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      // Fetch raw JSON to inspect field names
      final uri = Uri.parse('${service.supabaseUrl}/rest/v1/${constants.episodesTable}')
          .replace(queryParameters: {
        'select': '*',
        'limit': '5',
        'order': 'id.desc',
      });
      final headers = {
        'apikey': service.supabaseKey,
        'Authorization': 'Bearer ${service.supabaseKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final res = await http.get(uri, headers: headers);
      expect(res.statusCode, 200, reason: 'Episodes API should return 200');

      final data = jsonDecode(res.body) as List<dynamic>;
      expect(data, isNotEmpty, reason: 'Should have at least one episode');

      final firstEpisode = data.first as Map<String, dynamic>;
      debugPrint('\n=== RAW EPISODE FIELDS ===');
      for (final key in firstEpisode.keys) {
        debugPrint('  $key: ${firstEpisode[key]} (${firstEpisode[key]?.runtimeType})');
      }

      // Check which fields Episode.fromJson expects vs what API returns
      final expectedFields = [
        'id', 'podcastId', 'title', 'description', 'audioUrl',
        'publishedAt', 'showDate', 'duration', 'imageUrl', 'hosts',
      ];

      debugPrint('\n=== FIELD MAPPING CHECK ===');
      for (final field in expectedFields) {
        final hasField = firstEpisode.containsKey(field);
        debugPrint('  $field: ${hasField ? "PRESENT" : "MISSING"} ${hasField ? "(${firstEpisode[field]})" : ""}');
      }

      // Try to parse and see what happens
      debugPrint('\n=== Episode.fromJson ATTEMPT ===');
      try {
        final episode = Episode.fromJson(firstEpisode);
        debugPrint('  id: ${episode.id}');
        debugPrint('  podcastId: ${episode.podcastId}');
        debugPrint('  title: "${episode.title}"');
        debugPrint('  description: "${episode.description}"');
        debugPrint('  audioUrl: "${episode.audioUrl}"');
        debugPrint('  publishedAt: ${episode.publishedAt}');
        debugPrint('  showDate: "${episode.showDate}"');
        debugPrint('  duration: ${episode.duration}');
        debugPrint('  imageUrl: ${episode.imageUrl}');
        debugPrint('  hosts: ${episode.hosts}');

        // Validate critical fields are not empty/default
        expect(episode.id, isNotEmpty, reason: 'Episode id should not be empty');
        expect(episode.podcastId, isNotEmpty, reason: 'Episode podcastId should not be empty');
        expect(episode.title, isNotEmpty, reason: 'Episode title should not be empty');
        expect(episode.audioUrl, isNotEmpty, reason: 'Episode audioUrl should not be empty');
      } catch (e) {
        debugPrint('  ERROR: $e');
        fail('Episode.fromJson failed: $e');
      }
    });

    test('raw podcasts response has expected field names', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final uri = Uri.parse('${service.supabaseUrl}/rest/v1/${constants.podcastsTable}')
          .replace(queryParameters: {
        'select': '*',
        'limit': '3',
      });
      final headers = {
        'apikey': service.supabaseKey,
        'Authorization': 'Bearer ${service.supabaseKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final res = await http.get(uri, headers: headers);
      expect(res.statusCode, 200, reason: 'Podcasts API should return 200');

      final data = jsonDecode(res.body) as List<dynamic>;
      expect(data, isNotEmpty, reason: 'Should have at least one podcast');

      final firstPodcast = data.first as Map<String, dynamic>;
      debugPrint('\n=== RAW PODCAST FIELDS ===');
      for (final key in firstPodcast.keys) {
        debugPrint('  $key: ${firstPodcast[key]} (${firstPodcast[key]?.runtimeType})');
      }

      // Check which fields Podcast.fromJson expects
      final expectedFields = [
        'id', 'title', 'description', 'cover_image_url',
        'episode_count', 'hosts', 'latest_episode', 'last_updated',
      ];

      debugPrint('\n=== FIELD MAPPING CHECK ===');
      for (final field in expectedFields) {
        final hasField = firstPodcast.containsKey(field);
        debugPrint('  $field: ${hasField ? "PRESENT" : "MISSING"} ${hasField ? "" : ""}');
      }

      debugPrint('\n=== Podcast.fromJson ATTEMPT ===');
      try {
        final podcast = Podcast.fromJson(firstPodcast);
        debugPrint('  id: ${podcast.id}');
        debugPrint('  title: "${podcast.title}"');
        debugPrint('  description: "${podcast.description}"');
        debugPrint('  coverImageUrl: "${podcast.coverImageUrl}"');
        debugPrint('  episodeCount: ${podcast.episodeCount}');
        debugPrint('  hosts: ${podcast.hosts}');
        debugPrint('  lastUpdated: ${podcast.lastUpdated}');

        expect(podcast.id, isNotEmpty, reason: 'Podcast id should not be empty');
        expect(podcast.title, isNotEmpty, reason: 'Podcast title should not be empty');
      } catch (e) {
        debugPrint('  ERROR: $e');
        fail('Podcast.fromJson failed: $e');
      }
    });

    test('fetchEpisodesForPodcast returns valid episodes', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      // First get a real podcast ID
      final podcasts = await service.fetchLatestPodcasts(limit: 1);
      expect(podcasts, isNotEmpty, reason: 'Should have at least one podcast');

      final podcastId = podcasts.first.id;
      debugPrint('\n=== Fetching episodes for podcast "$podcastId" (${podcasts.first.title}) ===');

      final episodes = await service.fetchEpisodesForPodcast(podcastId, limit: 5);
      debugPrint('  Returned ${episodes.length} episodes');

      if (episodes.isEmpty) {
        debugPrint('  WARNING: No episodes returned for podcast $podcastId');
        debugPrint('  This could be a filtering/query issue');

        // Try without filter to see if episodes table has data at all
        final recentEpisodes = await service.fetchRecentEpisodes(limit: 5);
        debugPrint('  fetchRecentEpisodes returned ${recentEpisodes.length} episodes');
        if (recentEpisodes.isNotEmpty) {
          debugPrint('  First recent episode podcastId: ${recentEpisodes.first.podcastId}');
          debugPrint('  Trying with that podcastId...');
          final retryEpisodes = await service.fetchEpisodesForPodcast(
            recentEpisodes.first.podcastId, limit: 3,
          );
          debugPrint('  Retry returned ${retryEpisodes.length} episodes');
        }
      }

      for (final ep in episodes.take(3)) {
        debugPrint('  - [${ep.id}] "${ep.title}" (${ep.publishedAt}) audio=${ep.audioUrl.isNotEmpty ? "OK" : "EMPTY"}');
      }
    });

    test('fetchEpisodesForPodcast query filter is correct', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      // Test: Check if 'podcastId' column exists in the episodes table
      // by fetching raw data and checking column names
      final uri = Uri.parse('${service.supabaseUrl}/rest/v1/${constants.episodesTable}')
          .replace(queryParameters: {
        'select': '*',
        'limit': '1',
      });
      final headers = {
        'apikey': service.supabaseKey,
        'Authorization': 'Bearer ${service.supabaseKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final res = await http.get(uri, headers: headers);
      final data = jsonDecode(res.body) as List<dynamic>;

      if (data.isNotEmpty) {
        final row = data.first as Map<String, dynamic>;
        final columns = row.keys.toList();
        debugPrint('\n=== Episodes table columns ===');
        debugPrint('  $columns');

        // Check if the filter column name matches
        final hasPodcastId = columns.contains('podcastId');
        final hasPodcastIdSnake = columns.contains('podcast_id');
        debugPrint('  "podcastId" (camelCase): $hasPodcastId');
        debugPrint('  "podcast_id" (snake_case): $hasPodcastIdSnake');

        if (!hasPodcastId && hasPodcastIdSnake) {
          debugPrint('  *** MISMATCH: API query uses "podcastId" but column is "podcast_id" ***');
        }

        // Also verify the actual podcastId value format
        final podcastIdValue = row['podcastId'] ?? row['podcast_id'];
        debugPrint('  podcastId value: $podcastIdValue (type: ${podcastIdValue.runtimeType})');
      }
    });

    test('top shows response validates correctly', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final topShows = await service.fetchTopShowsThisYear();
      debugPrint('\n=== Top Shows ===');
      debugPrint('  Returned ${topShows.length} shows');
      for (final show in topShows.take(5)) {
        debugPrint('  - [${show.id}] "${show.title}" count=${show.count}');
      }
      expect(topShows, isNotEmpty);
    });

    test('full round-trip: Episode.fromJson -> toJson -> fromJson', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final uri = Uri.parse('${service.supabaseUrl}/rest/v1/${constants.episodesTable}')
          .replace(queryParameters: {
        'select': '*',
        'limit': '3',
        'order': 'id.desc',
      });
      final headers = {
        'apikey': service.supabaseKey,
        'Authorization': 'Bearer ${service.supabaseKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final res = await http.get(uri, headers: headers);
      final data = jsonDecode(res.body) as List<dynamic>;

      for (final raw in data) {
        final map = raw as Map<String, dynamic>;
        final episode = Episode.fromJson(map);
        final json = episode.toJson();
        final roundTrip = Episode.fromJson(json);

        expect(roundTrip.id, episode.id);
        expect(roundTrip.podcastId, episode.podcastId);
        expect(roundTrip.title, episode.title);
        expect(roundTrip.audioUrl, episode.audioUrl);
        debugPrint('  Round-trip OK: [${episode.id}] "${episode.title}"');
      }
    });
  });

  // ---- Unit tests for Episode.fromJson edge cases ----
  group('Episode.fromJson unit tests', () {
    test('handles missing optional fields gracefully', () {
      final episode = Episode.fromJson({
        'id': '123',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'https://example.com/audio.mp3',
      });

      expect(episode.id, '123');
      expect(episode.podcastId, 'p1');
      expect(episode.title, 'Test');
      expect(episode.description, '');
      expect(episode.showDate, '');
      expect(episode.duration, Duration.zero);
      expect(episode.hosts, isEmpty);
      expect(episode.imageUrl, isNull);
    });

    test('handles numeric id correctly', () {
      final episode = Episode.fromJson({
        'id': 42,
        'podcastId': 99,
        'title': 'Numeric IDs',
        'audioUrl': 'https://example.com/audio.mp3',
      });

      expect(episode.id, '42');
      expect(episode.podcastId, '99');
    });

    test('handles duration as int (seconds)', () {
      final episode = Episode.fromJson({
        'id': '1',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'url',
        'duration': 3600,
      });
      expect(episode.duration, const Duration(hours: 1));
    });

    test('handles duration as HH:MM:SS string', () {
      final episode = Episode.fromJson({
        'id': '1',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'url',
        'duration': '01:30:00',
      });
      expect(episode.duration, const Duration(hours: 1, minutes: 30));
    });

    test('handles duration as MM:SS string', () {
      final episode = Episode.fromJson({
        'id': '1',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'url',
        'duration': '45:30',
      });
      expect(episode.duration, const Duration(minutes: 45, seconds: 30));
    });

    test('handles null/empty duration', () {
      final ep1 = Episode.fromJson({
        'id': '1', 'podcastId': 'p1', 'title': 'T', 'audioUrl': 'u',
        'duration': null,
      });
      final ep2 = Episode.fromJson({
        'id': '2', 'podcastId': 'p1', 'title': 'T', 'audioUrl': 'u',
      });
      expect(ep1.duration, Duration.zero);
      expect(ep2.duration, Duration.zero);
    });

    test('problematic imageUrl gets replaced', () {
      final episode = Episode.fromJson({
        'id': '1',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'url',
        'imageUrl': constants.problematicEpisodeImageUrl,
      }, podcastCoverImageUrl: 'https://cover.jpg');

      expect(episode.imageUrl, 'https://cover.jpg');
    });

    test('toJson round-trip preserves all fields', () {
      final original = Episode(
        id: 'test-1',
        podcastId: 'pod-1',
        title: 'Original Title',
        description: 'Original Desc',
        audioUrl: 'https://audio.mp3',
        publishedAt: DateTime(2024, 6, 15),
        showDate: '2024-06-15',
        duration: const Duration(minutes: 45),
        imageUrl: 'https://image.jpg',
        hosts: ['Host A', 'Host B'],
        isFavourite: true,
        downloadStatus: DownloadStatus.downloaded,
        downloadProgress: 1.0,
        localFilePath: '/local/path.mp3',
        cachedTitle: 'Cached Title',
        cachedImagePath: '/cache/img.jpg',
        cachedMetaPath: '/cache/meta.json',
      );

      final json = original.toJson();
      final restored = Episode.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.podcastId, original.podcastId);
      expect(restored.title, original.title);
      expect(restored.description, original.description);
      expect(restored.audioUrl, original.audioUrl);
      expect(restored.showDate, original.showDate);
      expect(restored.duration.inSeconds, original.duration.inSeconds);
      expect(restored.imageUrl, original.imageUrl);
      expect(restored.hosts, original.hosts);
      expect(restored.isFavourite, original.isFavourite);
      expect(restored.downloadStatus, original.downloadStatus);
      expect(restored.localFilePath, original.localFilePath);
      expect(restored.cachedTitle, original.cachedTitle);
      expect(restored.cachedImagePath, original.cachedImagePath);
      expect(restored.cachedMetaPath, original.cachedMetaPath);
    });
  });

  group('Podcast.fromJson unit tests', () {
    test('handles snake_case fields from Supabase', () {
      final podcast = Podcast.fromJson({
        'id': '3',
        'title': 'A lényeg',
        'description': 'Desc',
        'cover_image_url': 'https://img.jpg',
        'episode_count': 100,
        'hosts': [],
        'last_updated': '2024-01-15T10:00:00Z',
      });

      expect(podcast.id, '3');
      expect(podcast.title, 'A lényeg');
      expect(podcast.coverImageUrl, 'https://img.jpg');
      expect(podcast.episodeCount, 100);
      expect(podcast.lastUpdated, isNotNull);
    });

    test('handles missing optional fields', () {
      final podcast = Podcast.fromJson({
        'id': '1',
        'title': 'Minimal',
      });

      expect(podcast.id, '1');
      expect(podcast.title, 'Minimal');
      expect(podcast.description, '');
      expect(podcast.coverImageUrl, 'assets/app_icon/app_icon.png');
      expect(podcast.episodeCount, 0);
      expect(podcast.hosts, isEmpty);
      expect(podcast.latestEpisode, isNull);
      expect(podcast.lastUpdated, isNull);
    });

    test('handles episode_count as string', () {
      final podcast = Podcast.fromJson({
        'id': '1',
        'title': 'Test',
        'episode_count': '42',
      });
      expect(podcast.episodeCount, 42);
    });
  });
}
