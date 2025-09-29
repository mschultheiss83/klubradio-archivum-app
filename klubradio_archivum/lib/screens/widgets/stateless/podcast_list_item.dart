import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/podcast_detail_screen/podcast_detail_screen.dart';

class PodcastListItem extends StatelessWidget {
  const PodcastListItem({
    super.key,
    required this.podcast,
    this.showSubscribeButton = true,
  });

  final Podcast podcast;
  final bool showSubscribeButton;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PodcastProvider provider = context.watch<PodcastProvider>();
    final bool isSubscribed =
        provider.userProfile?.subscribedPodcastIds.contains(podcast.id) ??
        podcast.isSubscribed;
    final String subtitle = podcast.hosts.isNotEmpty
        ? podcast.hosts.map((host) => host.name).join(', ')
        : 'Klubrádió műsor';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  PodcastDetailScreen(podcast: podcast),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _CoverArt(imageUrl: podcast.coverImageUrl),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(podcast.title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(subtitle, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      podcast.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    if (showSubscribeButton)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: OutlinedButton.icon(
                            icon: Icon(
                              isSubscribed
                                  ? Icons.notifications_active
                                  : Icons.notifications_outlined,
                            ),
                            label: Text(
                              isSubscribed ? 'Feliratkozva' : 'Feliratkozás',
                            ),
                            onPressed: () {
                              if (isSubscribed) {
                                provider.unsubscribe(podcast.id);
                              } else {
                                provider.subscribe(podcast.id);
                              }
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverArt extends StatelessWidget {
  const _CoverArt({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imageUrl.isEmpty
          ? Container(
              width: 72,
              height: 72,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.radio),
            )
          : Image.network(
              imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Container(
                      width: 72,
                      height: 72,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: const Icon(Icons.radio),
                    );
                  },
            ),
    );
  }
}
