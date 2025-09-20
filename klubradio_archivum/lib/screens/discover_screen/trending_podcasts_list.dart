import 'package:flutter/material.dart';

import '../../models/podcast.dart';
import '../widgets/stateless/podcast_list_item.dart';

class TrendingPodcastsList extends StatelessWidget {
  const TrendingPodcastsList({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    if (podcasts.isEmpty) {
      return Text(
        'Nincs felkapott műsor a listán.',
        style: Theme.of(context).textTheme.bodyMedium,
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
