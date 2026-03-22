import 'package:flutter/material.dart';

import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';

class QueueSheet extends StatelessWidget {
  const QueueSheet({super.key, required this.provider});

  final EpisodeProvider provider;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) => _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      padding: const EdgeInsets.all(16),
      itemCount: provider.queue.length,
      onReorder: (int oldIndex, int newIndex) {
        provider.reorderQueue(oldIndex, newIndex);
      },
      itemBuilder: (BuildContext context, int index) {
        final episode = provider.queue[index];
        final bool isCurrent = provider.currentEpisode?.id == episode.id;
        final hosts = episode.hosts
            .join('')
            .split('\n')
            .where((s) => s.isNotEmpty)
            .join(' ');
        return Dismissible(
          key: ValueKey(episode.id),
          direction: isCurrent
              ? DismissDirection.none
              : DismissDirection.endToStart,
          onDismissed: (_) => provider.removeFromQueue(episode.id),
          background: ColoredBox(
            color: cs.errorContainer,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.delete_outline, color: cs.onErrorContainer),
              ),
            ),
          ),
          child: ListTile(
          key: ValueKey('tile-${episode.id}'),
          selected: isCurrent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isCurrent ? cs.outline : Colors.transparent,
              width: 1,
            ),
          ),
          tileColor: cs.surfaceContainerLow,
          selectedTileColor: cs.secondaryContainer,
          textColor: isCurrent ? cs.onSecondaryContainer : cs.onSurface,
          iconColor:
              isCurrent ? cs.onSecondaryContainer : cs.onSurfaceVariant,
          leading: ReorderableDragStartListener(
            index: index,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.drag_indicator),
                const SizedBox(width: 8),
                Icon(isCurrent ? Icons.play_arrow : Icons.queue_music),
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isCurrent)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Entfernen',
                  onPressed: () => provider.removeFromQueue(episode.id),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ImageUrl(
                    url: episode.imageUrl ?? '',
                    path: episode.cachedImagePath ?? '',
                    width: 56,
                    height: 56,
                  ),
                ),
              ),
            ],
          ),
          title: Text('${episode.title}, ${episode.showDate}'),
          subtitle: Text(
            '${formatDuration(context, episode.duration)} - $hosts',
          ),
          hoverColor: cs.onSurface.withValues(alpha: 0.12),
          onTap: () async {
            Navigator.of(context).pop();
            await provider.playEpisode(episode, queue: provider.queue);
          },
        ),
        );
      },
    );
  }
}
