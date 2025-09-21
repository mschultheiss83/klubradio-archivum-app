import 'package:flutter/material.dart';

import '../../models/podcast.dart';
import '../podcast_detail_screen/podcast_detail_screen.dart';

class TrendingPodcastsList extends StatelessWidget {
  const TrendingPodcastsList({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    if (podcasts.isEmpty) {
      return const Text('Nincs trendi műsor.');
    }

    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: podcasts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int index) {
          final Podcast podcast = podcasts[index];
          return _TrendingPodcastCard(podcast: podcast);
        },
      ),
    );
  }
}

class _TrendingPodcastCard extends StatelessWidget {
  const _TrendingPodcastCard({required this.podcast});

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          PodcastDetailScreen.routeName,
          arguments: PodcastDetailArguments(podcast: podcast),
        );
      },
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                podcast.title.characters.take(2).toString().toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: colorScheme.onPrimaryContainer),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              podcast.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              podcast.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
