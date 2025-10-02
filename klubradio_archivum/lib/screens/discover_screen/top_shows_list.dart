import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/models/show_data.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';

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
          label: Text(show.title.toUpperCase()),
          onSelected: (bool selected) {
            if (!selected) {
              return;
            }
            // --- Action on selecting a show chip ---
            // context.read<PodcastProvider>().addRecentSearch(show.title);
            // TODO: Trigger show-specific filtering or navigation.

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  l10n.showSelectedFeedback(show.title), // Localized feedback
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
