import 'package:flutter/material.dart';

import '../../models/podcast.dart';
import '../widgets/stateless/podcast_list_item.dart';

class SubscribedPodcastsList extends StatelessWidget {
  const SubscribedPodcastsList({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    if (podcasts.isEmpty) {
      return Text(
        'Még nem iratkoztál fel egy műsorra sem.',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: podcasts.length,
      itemBuilder: (BuildContext context, int index) {
        final Podcast podcast = podcasts[index];
        return PodcastListItem(podcast: podcast);
      },
    );
  }
}
