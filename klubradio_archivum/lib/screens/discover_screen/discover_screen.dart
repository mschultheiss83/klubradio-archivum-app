import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/providers/latest_provider.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/podcast_list_item.dart';

import 'top_shows_list.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool _bootstrapped = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
      final latest = context.read<LatestProvider>();

      // Cache-first sofort anzeigen
      await latest.load(useCacheFirst: true);

      // im Hintergrund frische Daten (UI bleibt sichtbar)
      unawaited(latest.load(useCacheFirst: false));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_bootstrapped) {
      _bootstrapped = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<PodcastProvider>().loadInitialData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final latest = context.watch<LatestProvider>();
    final podcastProvider = context.watch<PodcastProvider>();
    final topShowsData = podcastProvider.topShows;

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          latest.load(useCacheFirst: false),
          context.read<PodcastProvider>().loadTopShows(forceRefresh: true),
        ], eagerError: false);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            l10n.discoverScreenFeaturedCategoriesTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),

          if (podcastProvider.isLoadingTopShows && topShowsData.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            TopShowsList(topShows: topShowsData),
          const SizedBox(height: 24),

          Text(
            l10n.discoverScreenLatestShowsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (latest.loading && latest.items.isEmpty)
            const Center(child: CircularProgressIndicator())
          else if (latest.items.isEmpty)
            Text(
              l10n.discoverScreenNoLatestShows,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: latest.items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  PodcastListItem(podcast: latest.items[index]),
            ),
        ],
      ),
    );
  }
}
