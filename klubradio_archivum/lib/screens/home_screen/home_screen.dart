import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';

import 'recently_played_list.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/episode_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _kickoffDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_kickoffDone) return;
      _kickoffDone = true;

      final podcastProvider = context.read<PodcastProvider>();
      final episodeProvider = context.read<EpisodeProvider>();

      await podcastProvider.loadInitialData();

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

        final List<Episode> recentEpisodes = provider.recentEpisodes;
        final List<Episode> recentlyPlayed =
            provider.userProfile?.recentlyPlayed ?? const <Episode>[];

        return RefreshIndicator(
          onRefresh: () => provider.loadInitialData(forceRefresh: true),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       l10n.homeScreenSubscribedPodcastsTitle,
              //       style: Theme.of(context).textTheme.titleLarge,
              //     ),
              //     const SizedBox(height: 12),
              //     StreamBuilder<List<db.Subscription>>(
              //       stream: context.read<SubscriptionsDao>().watchAllActive(),
              //       builder: (context, subsSnap) {
              //         if (subsSnap.connectionState == ConnectionState.waiting) {
              //           return const SizedBox.shrink();
              //         }
              //         final subs = subsSnap.data ?? const <db.Subscription>[];
              //         if (subs.isEmpty) {
              //           // Leerer Zustand: lokalisierter Hinweis
              //           return Padding(
              //             padding: const EdgeInsets.only(bottom: 24),
              //             child: Text(
              //               l10n.homeScreenSubscribedPodcastsEmptyHint,
              //               style: Theme.of(context).textTheme.bodyMedium
              //                   ?.copyWith(
              //                     color: Theme.of(context).colorScheme.outline,
              //                   ),
              //             ),
              //           );
              //         }
              //
              //         final ids = subs.map((s) => s.podcastId).toList();
              //         return FutureBuilder<List<Podcast?>>(
              //           future: Future.wait(
              //             ids.map((id) => provider.fetchPodcastById(id)),
              //           ),
              //           builder: (context, podSnap) {
              //             if (podSnap.connectionState ==
              //                 ConnectionState.waiting) {
              //               return const SizedBox.shrink();
              //             }
              //             final pods = (podSnap.data ?? const <Podcast?>[])
              //                 .whereType<Podcast>()
              //                 .toList();
              //             if (pods.isEmpty) {
              //               return const SizedBox.shrink();
              //             }
              //
              //             return Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 SubscribedPodcastsList(podcasts: pods),
              //                 const SizedBox(height: 24),
              //               ],
              //             );
              //           },
              //         );
              //       },
              //     ),
              //   ],
              // ),
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

              SizedBox(height: hasCurrentEpisode ? 96 : 24),
            ],
          ),
        );
      },
    );
  }
}
