import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart'; // Import l10n
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/show_data.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';

import 'recommended_podcasts_list.dart';
import 'top_shows_list.dart';
import 'trending_podcasts_list.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<PodcastProvider>(
      builder: (BuildContext context, PodcastProvider provider, Widget? child) {
        final List<ShowData> topShowsData = provider.topShows;
        final List<Podcast> trending = provider.trendingPodcasts;
        final List<Podcast> recommended = provider.recommendedPodcasts;

        return RefreshIndicator(
          onRefresh: () => provider.loadInitialData(forceRefresh: true),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Text(
                l10n.discoverScreenFeaturedCategoriesTitle, // Localized
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (provider.isLoadingTopShows && topShowsData.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (!provider.isLoadingTopShows && topShowsData.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    // TODO: Localize this "no data" message
                    child: Text(
                      l10n.discoverScreenNoTopShows,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
              else
                TopShowsList(topShows: topShowsData),

              const SizedBox(height: 24),
              Text(
                l10n.discoverScreenRecommendedShowsTitle, // Localized
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              RecommendedPodcastsList(podcasts: recommended),
              const SizedBox(height: 24),
              Text(
                l10n.discoverScreenTrendingTitle, // Localized
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TrendingPodcastsList(podcasts: trending),
            ],
          ),
        );
      },
    );
  }
}
