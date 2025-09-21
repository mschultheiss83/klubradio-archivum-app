import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/podcast_provider.dart';
import '../utils/constants.dart';
import '../widgets/stateful/episode_list.dart';
import 'recommended_podcasts_list.dart';
import 'top_categories_list.dart';
import 'trending_podcasts_list.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  static const String routeName = '/discover';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Felfedezés')),
      body: Consumer<PodcastProvider>(
        builder: (BuildContext context, PodcastProvider provider, _) {
          if (provider.isLoading && provider.featured.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              await provider.loadHomeContent();
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                if (provider.trending.isNotEmpty) ...<Widget>[
                  SectionHeader(title: 'Heti kedvencek'),
                  TrendingPodcastsList(podcasts: provider.trending),
                  const SizedBox(height: 24),
                ],
                if (provider.recommended.isNotEmpty) ...<Widget>[
                  SectionHeader(title: 'Ajánlott műsorok'),
                  RecommendedPodcastsList(podcasts: provider.recommended),
                  const SizedBox(height: 24),
                ],
                if (provider.categories.isNotEmpty) ...<Widget>[
                  SectionHeader(title: 'Témakörök'),
                  TopCategoriesList(categories: provider.categories),
                  const SizedBox(height: 24),
                ],
                SectionHeader(title: 'Legfrissebb epizódok'),
                EpisodeList(episodes: provider.latestEpisodes),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.sectionTitle,
            ),
      ),
    );
  }
}
