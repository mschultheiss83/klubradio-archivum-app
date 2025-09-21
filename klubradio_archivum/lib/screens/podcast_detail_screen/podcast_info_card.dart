import 'package:flutter/material.dart';

import '../../models/podcast.dart';
import '../../models/show_host.dart';

class PodcastInfoCard extends StatelessWidget {
  const PodcastInfoCard({super.key, required this.podcast});

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              podcast.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(podcast.description),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: <Widget>[
                Chip(label: Text('Kategória: ${podcast.category}')),
                Chip(label: Text('Epizódok: ${podcast.episodeCount}')),
                Chip(label: Text('Nyelv: ${podcast.language.toUpperCase()}')),
              ],
            ),
            if (podcast.hosts.isNotEmpty) ...<Widget>[
              const SizedBox(height: 12),
              Text(
                'Műsorvezetők',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: podcast.hosts
                    .map((ShowHost host) => Chip(label: Text(host.name)))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
