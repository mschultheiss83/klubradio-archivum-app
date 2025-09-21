import 'package:flutter/material.dart';

import '../../models/podcast.dart';
import '../podcast_detail_screen/podcast_detail_screen.dart';
import '../widgets/stateless/podcast_list_item.dart';

class RecommendedPodcastsList extends StatelessWidget {
  const RecommendedPodcastsList({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    if (podcasts.isEmpty) {
      return const Text('Nincs ajánlott műsor.');
    }

    return Column(
      children: podcasts
          .map(
            (Podcast podcast) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PodcastListItem(
                podcast: podcast,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    PodcastDetailScreen.routeName,
                    arguments: PodcastDetailArguments(podcast: podcast),
                  );
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
