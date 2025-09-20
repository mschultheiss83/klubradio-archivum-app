import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode_provider.dart';
import '../../providers/podcast_provider.dart';
import '../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastProvider>(
      builder: (context, provider, _) {
        final profile = provider.userProfile;
        final theme = Theme.of(context);
        final downloadedCount =
            context.watch<EpisodeProvider>().downloadedEpisodes.length;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profil'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: kLargeAvatarRadius,
                      backgroundImage: profile.avatarUrl.isNotEmpty
                          ? NetworkImage(profile.avatarUrl)
                          : null,
                      child: profile.avatarUrl.isEmpty
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(width: kDefaultPadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          profile.displayName,
                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.email,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Feliratkozott műsorok'),
                    trailing: Text(
                      provider.subscribedPodcasts.length.toString(),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.download),
                    title: const Text('Letöltött epizódok'),
                    trailing: Text(
                      downloadedCount.toString(),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                Text(
                  kPaymentWarningText,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
