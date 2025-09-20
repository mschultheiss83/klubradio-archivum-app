import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/podcast_provider.dart';
import '../podcast_detail_screen/podcast_detail_screen.dart';
import '../utils/constants.dart';
import '../widgets/stateless/podcast_list_item.dart';

class TrendingPodcastsList extends StatelessWidget {
  const TrendingPodcastsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastProvider>(
      builder: (context, provider, _) {
        final podcasts = provider.trendingPodcasts;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Felkapott műsorok', style: kSectionTitleStyle),
            const SizedBox(height: kSmallPadding),
            if (podcasts.isEmpty)
              const Text('Jelenleg nincs felkapott műsor.')
            else
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: podcasts.length,
                itemBuilder: (context, index) {
                  final podcast = podcasts[index];
                  return PodcastListItem(
                    podcast: podcast,
                    onTap: () => Navigator.of(context).pushNamed(
                      PodcastDetailScreen.routeName,
                      arguments: PodcastDetailArguments(podcast: podcast),
                    ),
                    onSubscribeToggle: () {
                      if (provider.isSubscribed(podcast.id)) {
                        provider.unsubscribeFromPodcast(podcast.id);
                      } else {
                        provider.subscribeToPodcast(podcast.id);
                      }
                    },
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
