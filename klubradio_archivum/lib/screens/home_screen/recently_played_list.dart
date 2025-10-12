import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../providers/episode_provider.dart';
import '../../providers/podcast_provider.dart';
import '../utils/helpers.dart';

class RecentlyPlayedList extends StatelessWidget {
  const RecentlyPlayedList({super.key, required this.episodes});

  final List<Episode> episodes;

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: episodes.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int index) {
          final Episode episode = episodes[index];
          return _EpisodeCard(episode: episode);
        },
      ),
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  const _EpisodeCard({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () async {
        final EpisodeProvider episodeProvider = context.read<EpisodeProvider>();
        final PodcastProvider podcastProvider = context.read<PodcastProvider>();
        await episodeProvider.playEpisode(episode);
        podcastProvider.addRecentlyPlayed(episode);
      },
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              episode.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
            const Spacer(),
            Text(formatDuration(context, episode.duration)),
            Text(
              formatDate(episode.publishedAt),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
