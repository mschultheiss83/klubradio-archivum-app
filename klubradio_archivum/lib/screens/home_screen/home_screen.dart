import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode_provider.dart';
import '../../providers/podcast_provider.dart';
import '../utils/constants.dart';
import '../widgets/stateful/episode_list.dart';
import '../search_screen/search_screen.dart';
import 'recently_played_list.dart';
import 'subscribed_podcasts_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Klubrádió Archívum'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                Navigator.of(context).pushNamed(SearchScreen.routeName),
          ),
        ],
      ),
      body: Consumer2<PodcastProvider, EpisodeProvider>(
        builder: (
          BuildContext context,
          PodcastProvider podcastProvider,
          EpisodeProvider episodeProvider,
          _,
        ) {
          if (podcastProvider.isLoading && podcastProvider.featured.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: podcastProvider.loadHomeContent,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                if (podcastProvider.featured.isNotEmpty) ...<Widget>[
                  const _SectionTitle(title: 'Kiemelt műsorok'),
                  SubscribedPodcastsList(podcasts: podcastProvider.featured),
                  const SizedBox(height: 24),
                ],
                const _SectionTitle(title: 'Legfrissebb epizódok'),
                EpisodeList(episodes: podcastProvider.latestEpisodes),
                const SizedBox(height: 24),
                const _SectionTitle(
                  title: 'Legutóbb hallgatott epizódok',
                ),
                RecentlyPlayedList(episodes: episodeProvider.recentlyPlayed),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

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
