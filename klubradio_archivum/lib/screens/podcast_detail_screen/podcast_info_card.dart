import 'package:flutter/material.dart';

import '../../models/podcast.dart';

class PodcastInfoCard extends StatelessWidget {
  const PodcastInfoCard({super.key, required this.podcast});

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: podcast.coverImageUrl.isEmpty
                      ? Container(
                          width: 100,
                          height: 100,
                          color: theme.colorScheme.primaryContainer,
                          child: const Icon(Icons.radio, size: 48),
                        )
                      : Image.network(
                          podcast.coverImageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(podcast.title, style: theme.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(
                        podcast.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      if (podcast.hosts.isNotEmpty)
                        Text(
                          'Műsorvezetők: ${podcast.hosts.map((host) => host.name).join(', ')}',
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
