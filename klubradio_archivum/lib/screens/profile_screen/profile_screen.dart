import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/podcast_provider.dart';
import '../widgets/stateful/episode_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastProvider>(
      builder: (
        BuildContext context,
        PodcastProvider provider,
        Widget? child,
      ) {
        final profile = provider.userProfile;
        if (profile == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 32,
                backgroundImage:
                    profile.avatarUrl != null ? NetworkImage(profile.avatarUrl!) : null,
                child: profile.avatarUrl == null
                    ? const Icon(Icons.person)
                    : null,
              ),
              title: Text(profile.displayName),
              subtitle: Text(profile.email ?? 'Nincs megadva e-mail cím'),
            ),
            const SizedBox(height: 16),
            Text(
              'Letöltési beállítások',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ListTile(
              leading: const Icon(Icons.download_for_offline_outlined),
              title: const Text('Automatikus letöltések'),
              subtitle: Text('Epizódok száma: ${profile.maxAutoDownload}'),
            ),
            const SizedBox(height: 16),
            Text(
              'Legutóbb hallgatott epizódok',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            EpisodeList(episodes: profile.recentlyPlayed, enableDownloads: false),
            const SizedBox(height: 16),
            Text(
              'Kedvencek',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (profile.favouriteEpisodeIds.isEmpty)
              Text(
                'Nincsenek kedvenc epizódok.',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: profile.favouriteEpisodeIds
                    .map((String id) => Chip(label: Text(id)))
                    .toList(),
              ),
          ],
        );
      },
    );
  }
}
