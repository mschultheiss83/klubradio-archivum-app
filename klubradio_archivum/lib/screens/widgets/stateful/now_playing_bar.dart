import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/providers/episode.provider.dart';
import 'package:klubradio_archivum/screens/now_playing_screen/now_playing_screen.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';

class NowPlayingBar extends StatelessWidget {
  const NowPlayingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (BuildContext context, EpisodeProvider provider, Widget? child) {
        final currentEpisode = provider.currentEpisode;
        final Duration? total = provider.totalDuration;
        final Duration position = provider.currentPosition;
        final double progress = total == null || total.inMilliseconds == 0
            ? 0
            : position.inMilliseconds / total.inMilliseconds;

        if (currentEpisode == null) {
          return const SizedBox.shrink();
        }

        final cs = Theme.of(context).colorScheme;

        return Material(
          color: cs.surface,
          elevation: 4,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const NowPlayingScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '${formatDurationPrecise(position)} - ${currentEpisode.showDate}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              currentEpisode.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
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
                              return _QueueSheet(provider: provider);
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
  }
}

class _QueueSheet extends StatelessWidget {
  const _QueueSheet({required this.provider});

  final EpisodeProvider provider;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.queue.length,
      itemBuilder: (BuildContext context, int index) {
        final episode = provider.queue[index];
        final bool isCurrent = provider.currentEpisode?.id == episode.id;
        final hosts = episode.hosts
            .join('')
            .split('\n')
            .where((s) => s.isNotEmpty)
            .join(' ');
        return ListTile(
          selected: isCurrent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isCurrent ? cs.outline : Colors.transparent,
              width: 1,
            ),
          ),

          // Material 3-friendly colors
          tileColor: cs.surfaceContainerLow, // unselected bg
          selectedTileColor: cs.secondaryContainer, // selected bg
          textColor: isCurrent ? cs.onSecondaryContainer : cs.onSurface,
          iconColor: isCurrent ? cs.onSecondaryContainer : cs.onSurfaceVariant,

          leading: Icon(isCurrent ? Icons.play_arrow : Icons.queue_music),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImageUrl(url: episode.imageUrl ?? "", width: 56, height: 56),
          ),
          title: Text('${episode.title}, ${episode.showDate}'),
          subtitle: Text(
            '${formatDuration(context, episode.duration)} - $hosts',
          ),

          // Nice pressed/hover overlay
          hoverColor: cs.onSurface.withValues(alpha: 0.12),

          onTap: () async {
            Navigator.of(context).pop();
            await provider.playEpisode(episode, queue: provider.queue);
          },
        );
      },
    );
  }
}
