import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/podcast.dart';
import '../../providers/podcast_provider.dart';
import '../utils/constants.dart';
import '../widgets/stateful/episode_list.dart';
import 'podcast_info_card.dart';

class PodcastDetailArguments {
  const PodcastDetailArguments({required this.podcast});

  final Podcast podcast;
}

class PodcastDetailScreen extends StatelessWidget {
  const PodcastDetailScreen({super.key, required this.podcast});

  static const String routeName = '/podcast-detail';

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(podcast.title),
        actions: <Widget>[
          Consumer<PodcastProvider>(
            builder: (context, provider, _) {
              final subscribed = provider.isSubscribed(podcast.id);
              return IconButton(
                icon: Icon(subscribed ? Icons.favorite : Icons.favorite_border),
                tooltip: subscribed ? 'Leiratkozás' : 'Feliratkozás',
                onPressed: () {
                  if (subscribed) {
                    provider.unsubscribeFromPodcast(podcast.id);
                  } else {
                    provider.subscribeToPodcast(podcast.id);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PodcastInfoCard(podcast: podcast),
            const SizedBox(height: kDefaultPadding),
            Text('Epizódok', style: kSectionTitleStyle),
            const SizedBox(height: kSmallPadding),
            EpisodeList(
              podcastId: podcast.id,
              podcastTitle: podcast.title,
            ),
          ],
        ),
      ),
    );
  }
}
