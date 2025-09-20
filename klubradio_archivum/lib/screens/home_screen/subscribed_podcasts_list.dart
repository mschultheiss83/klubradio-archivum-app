import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/podcast.dart';
import '../../providers/podcast_provider.dart';
import '../podcast_detail_screen/podcast_detail_screen.dart';
import '../utils/constants.dart';

class SubscribedPodcastsList extends StatelessWidget {
  const SubscribedPodcastsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastProvider>(
      builder: (context, provider, _) {
        final List<Podcast> podcasts = provider.subscribedPodcasts;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Feliratkozott műsorok', style: kSectionTitleStyle),
            const SizedBox(height: kSmallPadding),
            if (podcasts.isEmpty)
              const Text('Még nem iratkoztál fel műsorokra.')
            else
              SizedBox(
                height: 56,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: podcasts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: kSmallPadding),
                  itemBuilder: (context, index) {
                    final podcast = podcasts[index];
                    return ActionChip(
                      label: Text(podcast.title, style: kChipTextStyle),
                      avatar: podcast.coverImageUrl.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(podcast.coverImageUrl),
                            )
                          : const CircleAvatar(child: Icon(Icons.podcasts)),
                      onPressed: () => Navigator.of(context).pushNamed(
                        PodcastDetailScreen.routeName,
                        arguments: PodcastDetailArguments(podcast: podcast),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
