import 'package:flutter/material.dart';

import 'package:klubradio_archivum/models/episode.dart' as model; // Use alias for Episode
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({
    super.key,
    required this.episode,
    this.onTap,
    this.trailing,
  });

  final model.Episode episode; // Use aliased type
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: ImageUrl(
          url: episode.imageUrl ?? "",
          path: episode.cachedImagePath,
        ),
        title: Text(
          '${episode.id} ${episode.title}',
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          '${episode.showDate} • ${formatDuration(context, episode.duration)}',
        ),
        onTap: onTap,
        trailing: trailing,
      ),
    );
  }
}
