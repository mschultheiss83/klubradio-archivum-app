import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/episode.provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';

import 'recently_played_list.dart';
import 'subscribed_podcasts_list.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/episode_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load data once this widget is mounted inside the AppShell.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final podcastProvider = context.read<PodcastProvider>();
      final episodeProvider = context.read<EpisodeProvider>();

      await podcastProvider.loadInitialData();

      // Optional: autoplay first recent episode if nothing is playing yet.
      if (episodeProvider.currentEpisode == null &&
          podcastProvider.recentEpisodes.isNotEmpty) {
        await episodeProvider.playEpisode(
          podcastProvider.recentEpisodes.first,
          queue: podcastProvider.recentEpisodes,
        );
        await episodeProvider.togglePlayPause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool hasCurrentEpisode =
        context.watch<EpisodeProvider>().currentEpisode != null;

    return Consumer<PodcastProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading && provider.podcasts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null && provider.podcasts.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                provider.errorMessage!,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final List<Podcast> subscribed = provider.subscribedPodcasts;
        final List<Episode> recentEpisodes = provider.recentEpisodes;
        final List<Episode> recentlyPlayed =
            provider.userProfile?.recentlyPlayed ?? const <Episode>[];

        return RefreshIndicator(
          onRefresh: () => provider.loadInitialData(forceRefresh: true),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              if (subscribed.isNotEmpty) ...[
                Text(
                  l10n.homeScreenSubscribedPodcastsTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                SubscribedPodcastsList(podcasts: subscribed),
                const SizedBox(height: 24),
              ],
              Text(
                l10n.homeScreenRecentEpisodesTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              EpisodeList(episodes: recentEpisodes),

              if (recentlyPlayed.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  l10n.homeScreenRecentlyPlayedTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                RecentlyPlayedList(episodes: recentlyPlayed),
              ],

              // Keep content above the persistent NowPlayingBar in AppShell.
              SizedBox(height: hasCurrentEpisode ? 96 : 24),
            ],
          ),
        );
      },
    );
  }
}
