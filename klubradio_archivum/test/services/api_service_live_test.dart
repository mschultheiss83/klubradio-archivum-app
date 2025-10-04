import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/services/api_service.dart';

void main() {
  const bool runLive = bool.fromEnvironment('API_SERVICE_LIVE_TESTS');
  const String outputPath = 'assets/api/response.json';

  group('ApiService live Supabase snapshot', () {
    late ApiService service;

    setUp(() {
      service = ApiService();
    });

    tearDown(() {
      service.dispose();
    });

    test(
      'writes Supabase data to assets/api/response.json',
      () async {
        if (!runLive) {
          expect(
            runLive,
            isTrue,
            reason: 'Enable with --dart-define API_SERVICE_LIVE_TESTS=true',
          );
          return;
        }
        expect(
          service.hasValidCredentials,
          isTrue,
          reason:
              'Supabase credentials missing or placeholder values are in use',
        );
        final latest = await service.fetchLatestPodcasts(limit: 5);
        // final recentEpisodes = await service.fetchRecentEpisodes(limit: 20);
        final trending = await service.fetchTrendingPodcasts(limit: 10);
        final recommended = await service.fetchRecommendedPodcasts(limit: 10);

        final latestEpisodes = await service.fetchEpisodesForPodcast(
          latest.first.id,
          limit: 10,
        );
        final topPodcasts = await service.fetchTopShowsThisYear();
        final podcastById = await service.fetchPodcastById(
          topPodcasts.first.id,
        );
        final Map<String, dynamic> payload = <String, dynamic>{
          'generatedAt': DateTime.now().toIso8601String(),
          'latestPodcasts': latest.map((podcast) => podcast.toJson()).toList(),
          'trendingPodcasts': trending
              .map((podcast) => podcast.toJson())
              .toList(),
          'recommendedPodcasts': recommended
              .map((podcast) => podcast.toJson())
              .toList(),
          'latestEpisodes': latestEpisodes
              .map((episode) => episode.toJson())
              .toList(),
          'topShows': topPodcasts.map((show) => show.toJson()).toList(),
          'podcastById': podcastById?.toJson(),
          // 'recentEpisodes': recentEpisodes
          //     .map((episode) => episode.toJson())
          //     .toList(),
        };
        final Directory outputDir = Directory('assets/api');
        if (!outputDir.existsSync()) {
          outputDir.createSync(recursive: true);
        }

        final File outputFile = File(outputPath);
        outputFile.writeAsStringSync(
          const JsonEncoder.withIndent('  ').convert(payload),
        );

        expect(outputFile.existsSync(), isTrue);
        expect(outputFile.readAsStringSync(), isNotEmpty);
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );
  });
}
