import 'package:flutter/material.dart';

import '../../../models/episode.dart';
import '../../utils/helpers.dart';

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({super.key, required this.episode, this.onTap});

  final Episode episode;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          episode.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${formatEpisodeDate(episode.publishedAt)} • ${formatDuration(episode.duration)}',
        ),
        trailing: const Icon(Icons.play_arrow),
        onTap: onTap,
      ),
    );
  }
}
