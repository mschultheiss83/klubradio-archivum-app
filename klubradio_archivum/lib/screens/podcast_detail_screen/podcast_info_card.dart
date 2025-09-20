import 'package:flutter/material.dart';

import '../../models/podcast.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class PodcastInfoCard extends StatelessWidget {
  const PodcastInfoCard({super.key, required this.podcast});

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: kCardElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: podcast.coverImageUrl.isNotEmpty
                      ? Image.network(
                          podcast.coverImageUrl,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 120,
                          height: 120,
                          color: colorScheme.surfaceVariant,
                          child: Icon(Icons.podcasts, size: 48, color: colorScheme.primary),
                        ),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        podcast.title,
                        style: theme.textTheme.headlineSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${podcast.category} · ${podcast.episodeCount} epizód',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      if (podcast.hosts.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: podcast.hosts
                              .map(
                                (host) => Chip(
                                  avatar: host.avatarUrl.isNotEmpty
                                      ? CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(host.avatarUrl),
                                        )
                                      : const CircleAvatar(child: Icon(Icons.mic)),
                                  label: Text(host.name),
                                ),
                              )
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            Text(
              podcast.description.isEmpty
                  ? 'Ehhez a műsorhoz nem tartozik részletes leírás.'
                  : ellipsize(podcast.description, maxLength: 220),
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
