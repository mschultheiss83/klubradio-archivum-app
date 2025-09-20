import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/podcast.dart';
import '../../providers/podcast_provider.dart';
import '../widgets/stateless/podcast_list_item.dart';
import 'recommended_podcasts_list.dart';
import 'top_categories_list.dart';
import 'trending_podcasts_list.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastProvider>(
      builder: (BuildContext context, PodcastProvider provider, Widget? child) {
        final List<Podcast> trending = provider.trendingPodcasts;
        final List<Podcast> recommended = provider.recommendedPodcasts;

        return RefreshIndicator(
          onRefresh: () => provider.loadInitialData(forceRefresh: true),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Text(
                'Kiemelt kategóriák',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const TopCategoriesList(),
              const SizedBox(height: 24),
              Text(
                'Ajánlott műsorok',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              RecommendedPodcastsList(podcasts: recommended),
              const SizedBox(height: 24),
              Text(
                'Felkapott',
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
