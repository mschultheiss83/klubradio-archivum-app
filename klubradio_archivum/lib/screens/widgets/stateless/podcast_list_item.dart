import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/podcast.dart';

import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'package:klubradio_archivum/screens/podcast_detail_screen/podcast_detail_screen.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final subscriptionProvider = context.watch<SubscriptionProvider>();



    final String subtitle = podcast.hosts.isNotEmpty
        ? podcast.hosts.map((h) => h.name).join(', ')
        : l10n.podcastListItem_subtitleFallback;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => PodcastDetailScreen(podcast: podcast),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ImageUrl(url: podcast.coverImageUrl),
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
                          child: StreamBuilder<Subscription?>(
                            stream: subscriptionProvider.watchSubscription(podcast.id),
                            builder: (context, snapshot) {
                              final bool currentIsSubscribed = snapshot.data?.active ?? false;
                              return OutlinedButton.icon(
                                icon: Icon(
                                  currentIsSubscribed
                                      ? Icons.notifications_active
                                      : Icons.notifications_outlined,
                                ),
                                label: Text(
                                  currentIsSubscribed
                                      ? l10n.podcastListItem_subscribed
                                      : l10n.podcastListItem_subscribe,
                                ),
                                onPressed: () {
                                  context.read<SubscriptionProvider>().toggleSubscription(podcast.id, currentIsSubscribed);
                                },
                              );
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
