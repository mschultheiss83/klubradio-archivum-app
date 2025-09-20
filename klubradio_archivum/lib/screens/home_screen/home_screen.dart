import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/podcast_provider.dart';
import '../podcast_detail_screen/podcast_detail_screen.dart';
import '../search_screen/search_screen.dart';
import '../utils/constants.dart';
import '../widgets/stateless/podcast_list_item.dart';
import 'recently_played_list.dart';
import 'subscribed_podcasts_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Klubrádió Archívum'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Keresés',
            onPressed: () => Navigator.of(context).pushNamed(
              SearchScreen.routeName,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<PodcastProvider>().loadHomeContent();
        },
        child: Consumer<PodcastProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading && provider.featuredPodcasts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final featured = provider.featuredPodcasts;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SubscribedPodcastsList(),
                  const SizedBox(height: kDefaultPadding),
                  const RecentlyPlayedList(),
                  const SizedBox(height: kDefaultPadding),
                  Text('Kiemelt műsorok', style: kSectionTitleStyle),
                  const SizedBox(height: kSmallPadding),
                  if (featured.isEmpty)
                    const Text('A kiemelt műsorok listája jelenleg üres.')
                  else
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: featured.length,
                      itemBuilder: (context, index) {
                        final podcast = featured[index];
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
              ),
            );
          },
        ),
      ),
    );
  }
}
