import 'package:flutter/material.dart';

import '../../../models/episode.dart';
import '../../utils/helpers.dart';

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({
    super.key,
    required this.episode,
    this.onTap,
    this.trailing,
  });

  final Episode episode;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.podcasts_outlined),
        title: Text(
          episode.title,
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          '${formatDate(episode.publishedAt)} • ${formatDuration(episode.duration)}',
        ),
        onTap: onTap,
        trailing: trailing,
      ),
    );
  }
}
