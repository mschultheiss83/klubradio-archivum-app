import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../providers/episode_provider.dart';
import '../now_playing_screen/now_playing_screen.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class RecentlyPlayedList extends StatelessWidget {
  const RecentlyPlayedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (context, provider, _) {
        final List<Episode> episodes = provider.recentlyPlayed;
        if (episodes.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nemrég hallgatott epizódok', style: kSectionTitleStyle),
            const SizedBox(height: kSmallPadding),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: episodes.length,
                separatorBuilder: (_, __) => const SizedBox(width: kSmallPadding),
                itemBuilder: (context, index) {
                  final episode = episodes[index];
                  return _RecentlyPlayedCard(episode: episode);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RecentlyPlayedCard extends StatelessWidget {
  const _RecentlyPlayedCard({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        context.read<EpisodeProvider>().playEpisode(episode);
        Navigator.of(context).pushNamed(NowPlayingScreen.routeName);
      },
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(kSmallPadding),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                episode.title,
                style: theme.textTheme.titleMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              formatRelativeTime(episode.publishedAt),
              style: theme.textTheme.bodySmall,
            ),
            Text(
              formatDuration(episode.duration),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
