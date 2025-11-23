import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/providers/latest_provider.dart';
import 'package:klubradio_archivum/providers/recommended_provider.dart';

import 'recommended_podcasts_list.dart';
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
      final rec = context.read<RecommendedProvider>();

      // Cache-first sofort anzeigen
      await Future.wait([
        latest.load(useCacheFirst: true),
        rec.load(useCacheFirst: true),
      ], eagerError: false);

      // im Hintergrund frische Daten (UI bleibt sichtbar)
      unawaited(latest.load(useCacheFirst: false));
      unawaited(rec.load(useCacheFirst: false));
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

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        final latest = context.read<LatestProvider>();
        final rec = context.read<RecommendedProvider>();

        // Cache-first schnell, danach still fresh
        await Future.wait([
          latest.load(useCacheFirst: true),
          rec.load(useCacheFirst: true),
        ], eagerError: false);

        // Silent refresh (UI bleibt sichtbar)
        latest.load(useCacheFirst: false);
        rec.load(useCacheFirst: false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final latest = context.watch<LatestProvider>();
    final rec = context.watch<RecommendedProvider>();
    final topShowsData = context
        .watch<PodcastProvider>()
        .topShows; // bleibt wie gehabt

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          latest.load(useCacheFirst: false),
          rec.load(useCacheFirst: false),
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

          if (latest.loading && latest.items.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            TopShowsList(topShows: topShowsData),
          const SizedBox(height: 24),

          Text(
            l10n.discoverScreenRecommendedShowsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (rec.loading && rec.items.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            RecommendedPodcastsList(podcasts: rec.items),
          const SizedBox(height: 24),

          Text(
            l10n.discoverScreenRecommendedShowsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (latest.loading && latest.items.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            RecommendedPodcastsList(podcasts: latest.items),
        ],
      ),
    );
  }
}
