import 'package:flutter/material.dart';

import '../../../models/episode.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({
    super.key,
    required this.episode,
    this.onPlay,
    this.onDownload,
    this.onRemoveDownload,
    this.onTap,
    this.downloadProgress,
    this.showPodcastTitle = false,
    this.podcastTitle,
  });

  final Episode episode;
  final VoidCallback? onPlay;
  final VoidCallback? onDownload;
  final VoidCallback? onRemoveDownload;
  final VoidCallback? onTap;
  final double? downloadProgress;
  final bool showPodcastTitle;
  final String? podcastTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final durationText = formatDuration(episode.duration);
    final dateText = formatDate(episode.publishedAt);
    final relative = formatRelativeTime(episode.publishedAt);

    final subtitleText = <String>[
      if (showPodcastTitle && (podcastTitle?.isNotEmpty ?? false))
        podcastTitle!,
      '$dateText · $durationText',
      relative,
    ].where((value) => value.isNotEmpty).join(' · ');

    final progress = downloadProgress ??
        (episode.playbackPosition.inSeconds > 0 &&
                episode.duration.inSeconds > 0
            ? episode.playbackPosition.inSeconds / episode.duration.inSeconds
            : null);

    return Card(
      elevation: kCardElevation,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap ?? onPlay,
        child: Padding(
          padding: const EdgeInsets.all(kSmallPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: onPlay,
                    icon: const Icon(Icons.play_arrow_rounded),
                    tooltip: 'Lejátszás',
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          episode.title,
                          style: theme.textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitleText,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: kSmallPadding),
                  _DownloadButton(
                    isDownloaded: episode.isDownloaded,
                    onDownload: onDownload,
                    onRemoveDownload: onRemoveDownload,
                  ),
                ],
              ),
              if (progress != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0, 1),
                    color: progressColor(progress, colorScheme),
                    backgroundColor: colorScheme.surfaceVariant,
                  ),
                ),
              if (episode.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    ellipsize(episode.description, maxLength: 150),
                    style: theme.textTheme.bodySmall,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({
    required this.isDownloaded,
    this.onDownload,
    this.onRemoveDownload,
  });

  final bool isDownloaded;
  final VoidCallback? onDownload;
  final VoidCallback? onRemoveDownload;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isDownloaded ? onRemoveDownload : onDownload,
      tooltip: isDownloaded ? 'Letöltés törlése' : 'Letöltés offline meghallgatáshoz',
      icon: Icon(isDownloaded ? Icons.download_done : Icons.download),
    );
  }
}
