import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/screens/now_playing_screen/now_playing_screen.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/queue_sheet.dart';

class NowPlayingBar extends StatelessWidget {
  const NowPlayingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (BuildContext context, EpisodeProvider provider, Widget? child) {
        final currentEpisode = provider.currentEpisode;
        if (currentEpisode == null) {
          return const SizedBox.shrink();
        }

        return ValueListenableBuilder<Duration>(
          valueListenable: provider.positionNotifier,
          builder: (context, position, child) {
            final Duration? total = provider.totalDuration;
            final double progress = total == null || total.inMilliseconds == 0
                ? 0
                : position.inMilliseconds / total.inMilliseconds;

            final cs = Theme.of(context).colorScheme;

            return Material(
              color: cs.surface,
              elevation: 4,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const NowPlayingScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              provider.isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              size: 32,
                            ),
                            onPressed: provider.togglePlayPause,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  currentEpisode.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  '${formatDurationPrecise(position)} - ${currentEpisode.showDate}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  currentEpisode.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.queue_music),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return QueueSheet(provider: provider);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: progress.clamp(0, 1)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
