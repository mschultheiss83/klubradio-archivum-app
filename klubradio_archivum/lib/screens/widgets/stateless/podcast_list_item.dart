import 'package:flutter/material.dart';

import '../../../models/podcast.dart';
import '../../../models/show_host.dart';

class PodcastListItem extends StatelessWidget {
  const PodcastListItem({super.key, required this.podcast, this.onTap});

  final Podcast podcast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final String hosts = podcast.hosts.isEmpty
        ? 'Ismeretlen műsorvezető'
        : podcast.hosts.map((ShowHost host) => host.name).join(', ');

    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            podcast.title.characters.take(2).toString().toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        ),
        title: Text(podcast.title),
        subtitle: Text('$hosts • ${podcast.category}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
