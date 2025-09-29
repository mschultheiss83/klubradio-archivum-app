import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart'; // Import l10n
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/episode_list.dart';
// If UserProfile is defined elsewhere, you might need to import it
// import 'package:klubradio_archivum/models/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // Get l10n instance

    return Consumer<PodcastProvider>(
      builder: (BuildContext context, PodcastProvider provider, Widget? child) {
        final profile = provider.userProfile; // UserProfile? profile

        if (profile == null) {
          // This typically means user data is still loading or user is not logged in
          // Depending on your app's auth flow, you might show a login prompt
          // or a more specific loading state.
          return const Center(child: CircularProgressIndicator());
        }

        // Handle displayName (optional: use a localized fallback if it can be null/empty)
        // final String displayName = profile.displayName ?? l10n.profileScreenGuestUserDisplayName;
        // For this example, assuming profile.displayName is always what you want to show if available
        // or it's acceptably empty if the user hasn't set one and you don't use a fallback.
        // If your UserProfile model has a non-nullable displayName, this check is not needed.

        return ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 32,
                backgroundImage: profile.avatarUrl != null
                    ? NetworkImage(profile.avatarUrl!)
                    : null,
                child: profile.avatarUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 32,
                      ) // Ensure icon size is appropriate
                    : null,
              ),
              title: Text(profile.displayName),
              subtitle: Text(
                profile.email ?? l10n.profileScreenNoEmail,
              ), // Localized
            ),
            const SizedBox(height: 24), // Increased spacing a bit
            Text(
              l10n.profileScreenDownloadSettingsTitle, // Localized
              style: Theme.of(
                context,
              ).textTheme.titleLarge, // Using titleLarge for section headers
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.download_for_offline_outlined),
              title: Text(l10n.profileScreenAutoDownloadsTitle), // Localized
              subtitle: Text(
                l10n.profileScreenAutoDownloadsSubtitle(
                  profile.maxAutoDownload,
                ), // Localized
              ),
              // onTap: () {
              //   // TODO: Navigate to download settings screen or show a dialog
              // },
            ),
            const SizedBox(height: 24),
            Text(
              l10n.profileScreenRecentlyPlayedTitle, // Localized
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (profile.recentlyPlayed.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  // TODO: Add l10n key for "No recently played episodes"
                  child: Text(
                    'Nincsenek legutóbb hallgatott epizódok.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            else
              EpisodeList(
                episodes: profile.recentlyPlayed,
                enableDownloads:
                    false, // Assuming this is intentional for this context
              ),
            const SizedBox(height: 24),
            Text(
              l10n.profileScreenFavoritesTitle, // Localized
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (profile.favouriteEpisodeIds.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    l10n.profileScreenNoFavoriteEpisodes, // Localized
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: profile.favouriteEpisodeIds.map((String id) {
                  // TODO: Consider fetching episode details to show titles instead of just IDs
                  // For now, displaying ID as per original code.
                  return Chip(label: Text(id));
                }).toList(),
              ),
          ],
        );
      },
    );
  }
}
