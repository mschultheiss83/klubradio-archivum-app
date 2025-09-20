import 'package:flutter/material.dart';

import '../../../models/podcast.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class PodcastListItem extends StatelessWidget {
  const PodcastListItem({
    super.key,
    required this.podcast,
    this.onTap,
    this.onSubscribeToggle,
    this.trailing,
  });

  final Podcast podcast;
  final VoidCallback? onTap;
  final VoidCallback? onSubscribeToggle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final coverImage = podcast.coverImageUrl.isNotEmpty
        ? Image.network(
            podcast.coverImageUrl,
            width: 72,
            height: 72,
            fit: BoxFit.cover,
          )
        : Container(
            width: 72,
            height: 72,
            color: colorScheme.surfaceVariant,
            child: Icon(Icons.podcasts, color: colorScheme.primary),
          );

    return Card(
      elevation: kCardElevation,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(kSmallPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: coverImage,
              ),
              const SizedBox(width: kSmallPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      podcast.title,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ellipsize(podcast.description, maxLength: 110),
                      style: theme.textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${podcast.category} · ${podcast.episodeCount} epizód',
                      style: kSecondaryTextStyle.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: kSmallPadding),
              trailing ??
                  IconButton(
                    onPressed: onSubscribeToggle,
                    icon: Icon(
                      podcast.isSubscribed
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    tooltip: podcast.isSubscribed
                        ? 'Leiratkozás'
                        : 'Feliratkozás',
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
