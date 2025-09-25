import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/podcast_list_item.dart';

class RecommendedPodcastsList extends StatelessWidget {
  const RecommendedPodcastsList({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    // Get l10n instance
    final l10n = AppLocalizations.of(context)!;

    if (podcasts.isEmpty) {
      return Text(
        l10n.recommendedPodcastsNoRecommendations, // Use localized string
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign
            .center, // Optional: for better display of multi-line messages
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: podcasts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final Podcast podcast = podcasts[index];
        return PodcastListItem(podcast: podcast);
      },
    );
  }
}
