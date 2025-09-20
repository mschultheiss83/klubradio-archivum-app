import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/podcast_provider.dart';
import '../utils/constants.dart';
import 'recommended_podcasts_list.dart';
import 'top_categories_list.dart';
import 'trending_podcasts_list.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Felfedezés'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<PodcastProvider>().loadHomeContent();
        },
        child: Consumer<PodcastProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading &&
                provider.recommendedPodcasts.isEmpty &&
                provider.trendingPodcasts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: const EdgeInsets.all(kDefaultPadding),
              children: const <Widget>[
                TopCategoriesList(),
                SizedBox(height: kDefaultPadding),
                RecommendedPodcastsList(),
                SizedBox(height: kDefaultPadding),
                TrendingPodcastsList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
