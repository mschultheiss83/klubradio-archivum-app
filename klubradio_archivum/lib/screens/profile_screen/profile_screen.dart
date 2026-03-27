// lib/screens/profile_screen/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/profile_screen/subscriptions_panel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Text(
          l10n.homeScreenSubscribedPodcastsTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        // Subscriptions: direkt aus lokaler DB
        StreamBuilder<List<db.Subscription>>(
          stream: context.read<SubscriptionsDao>().watchAllActive(),
          builder: (context, subsSnap) {
            if (subsSnap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final subs = subsSnap.data ?? const <db.Subscription>[];
            if (subs.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  l10n.homeScreenSubscribedPodcastsEmptyHint,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              );
            }

            final ids = subs.map((s) => s.podcastId).toList();
            return FutureBuilder<List<Podcast?>>(
              future: Future.wait(
                ids.map(
                  (id) => context.read<PodcastProvider>().fetchPodcastById(id),
                ),
              ),
              builder: (context, podSnap) {
                if (podSnap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (podSnap.hasError) {
                  return Center(child: Text('Error: ${podSnap.error}'));
                }
                final pods = (podSnap.data ?? const <Podcast?>[])
                    .whereType<Podcast>()
                    .toList();
                if (pods.isEmpty) {
                  return const SizedBox.shrink();
                }
                return SubscriptionsPanel(podcasts: pods);
              },
            );
          },
        ),
      ],
    );
  }
}
