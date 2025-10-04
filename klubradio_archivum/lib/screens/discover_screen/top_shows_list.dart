import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/models/show_data.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/podcast_detail_screen/podcast_detail_screen.dart';

class TopShowsList extends StatelessWidget {
  final List<ShowData> topShows;

  const TopShowsList({super.key, required this.topShows});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // Get l10n instance

    if (topShows.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: topShows.map((ShowData show) {
        return FilterChip(
          label: Text('${show.title} (${show.count})'),
          onSelected: (bool selected) async {
            if (!selected) {
              return;
            }
            final provider = context.read<PodcastProvider>();
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            final navigator = Navigator.of(context);

            // 1. Optionally, add the selected show title to recent searches
            provider.addRecentSearch(show.title);

            // 2. Fetch the full Podcast object using the show.id
            // This assumes you have a method `fetchPodcastById` in your provider.
            final Podcast? podcast = await provider.fetchPodcastById(show.id);

            // 3. Navigate to the PodcastDetailScreen if the podcast was found
            if (podcast != null) {
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => PodcastDetailScreen(podcast: podcast),
                ),
              );
            } else {
              // Handle case where podcast could not be fetched
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(l10n.podcastNotFoundError),
                ), // Assuming you add this l10n key
              );
            }
          },
        );
      }).toList(),
    );
  }
}
