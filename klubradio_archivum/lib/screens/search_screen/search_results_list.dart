import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import '../../models/podcast.dart';
import '../widgets/stateless/podcast_list_item.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key, required this.results});

  final List<Podcast> results;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (results.isEmpty) {
      return Center(
        child: Text(
          l10n.searchResultsNoResults, // Use localized string
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center, // Optional for better display
        ),
      );
    }

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final Podcast podcast = results[index];
        return PodcastListItem(podcast: podcast);
      },
    );
  }
}
