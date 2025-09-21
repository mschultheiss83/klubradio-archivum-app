import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/episode_provider.dart';
import '../../now_playing_screen/now_playing_screen.dart';
import '../../utils/helpers.dart';

class NowPlayingBar extends StatelessWidget {
  const NowPlayingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (BuildContext context, EpisodeProvider provider, _) {
        final episode = provider.nowPlaying;
        if (episode == null) {
          return const SizedBox.shrink();
        }

        return Material(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(NowPlayingScreen.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: <Widget>[
                  Icon(
                    provider.isPlaying ? Icons.equalizer : Icons.play_circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          episode.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          formatEpisodeDate(episode.publishedAt),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(provider.isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: provider.togglePlayback,
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
