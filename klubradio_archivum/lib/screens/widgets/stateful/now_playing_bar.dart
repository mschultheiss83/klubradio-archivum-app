import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/episode.dart';
import '../../../providers/episode_provider.dart';
import '../../now_playing_screen/now_playing_screen.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class NowPlayingBar extends StatelessWidget {
  const NowPlayingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (context, provider, _) {
        final Episode? episode = provider.nowPlaying;
        if (episode == null) {
          return const SizedBox.shrink();
        }

        final theme = Theme.of(context);
        final position = provider.currentPosition;
        final progress = episode.duration.inSeconds > 0
            ? (position.inSeconds / episode.duration.inSeconds).clamp(0.0, 1.0)
            : 0.0;

        return Material(
          elevation: 8,
          color: theme.colorScheme.surface,
          child: InkWell(
            onTap: () => Navigator.of(context)
                .pushNamed(NowPlayingScreen.routeName),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kSmallPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: provider.togglePlayPause,
                        iconSize: 32,
                        icon: Icon(
                          provider.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                        ),
                      ),
                      const SizedBox(width: kSmallPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              episode.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge,
                            ),
                            Text(
                              '${formatRelativeTime(episode.publishedAt)} · ${formatDuration(episode.duration)}',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(NowPlayingScreen.routeName),
                        icon: const Icon(Icons.open_in_full),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
