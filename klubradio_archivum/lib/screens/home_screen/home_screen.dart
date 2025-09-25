import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/episode.provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/about_screen/about_screen.dart';
import 'package:klubradio_archivum/screens/discover_screen/discover_screen.dart';
import 'package:klubradio_archivum/screens/download_manager_screen/download_manager_screen.dart';
import 'package:klubradio_archivum/screens/profile_screen/profile_screen.dart';
import 'package:klubradio_archivum/screens/search_screen/search_screen.dart';
import 'package:klubradio_archivum/screens/settings_screen/settings_screen.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/episode_list.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/now_playing_bar.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/bottom_navigation_bar.dart';
import 'recently_played_list.dart';
import 'subscribed_podcasts_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final PodcastProvider podcastProvider = context.read<PodcastProvider>();
      final EpisodeProvider episodeProvider = context.read<EpisodeProvider>();
      await podcastProvider.loadInitialData();
      await podcastProvider.loadUserProfile();
      if (episodeProvider.currentEpisode == null &&
          podcastProvider.recentEpisodes.isNotEmpty) {
        // Preload the latest episode without autoplay to provide metadata for UI.
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
    final EpisodeProvider episodeProvider = context.watch<EpisodeProvider>();
    final bool hasCurrentEpisode = episodeProvider.currentEpisode != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          _buildHomeTab(context),
          const DiscoverScreen(),
          const SearchScreen(),
          const DownloadManagerScreen(),
          const ProfileScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (hasCurrentEpisode) const NowPlayingBar(),
            AppBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<PodcastProvider>(
      builder: (BuildContext context, PodcastProvider provider, Widget? child) {
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
            children: <Widget>[
              if (subscribed.isNotEmpty) ...<Widget>[
                Text(
                  l10n.homeScreenSubscribedPodcastsTitle, // Localized
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
              if (recentlyPlayed.isNotEmpty) ...<Widget>[
                const SizedBox(height: 24),
                Text(
                  l10n.homeScreenRecentlyPlayedTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                RecentlyPlayedList(episodes: recentlyPlayed),
              ],
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
