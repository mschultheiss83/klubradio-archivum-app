import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import '../../models/episode.dart';
import '../../providers/podcast_provider.dart';
import '../../services/download_service.dart';
import '../utils/helpers.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key, required this.downloads});

  final List<DownloadTask> downloads;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (downloads.isEmpty) {
      return Center(
        child: Text(
          l10n.noDownloads,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      itemCount: downloads.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        final DownloadTask task = downloads[index];
        final statusLabel = formatDownloadStatus(context, task.status);
        final progressLabel = formatProgress(task.progress);
        return ListTile(
          leading: Icon(_statusIcon(task.status)),
          title: Text(task.episode.title),
          subtitle: Text('$statusLabel • ${task.episode.podcastId}'),
          trailing: _buildTrailing(context, task, progressLabel, l10n),
        );
      },
    );
  }

  IconData _statusIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.downloading:
        return Icons.downloading;
      case DownloadStatus.downloaded:
        return Icons.check_circle_outline;
      case DownloadStatus.failed:
        return Icons.error_outline;
      case DownloadStatus.notDownloaded:
        return Icons.download_outlined;
      case DownloadStatus.queued:
        return Icons.schedule;
    }
  }

  Widget _buildTrailing(
    BuildContext context,
    DownloadTask task,
    String progressLabel,
    AppLocalizations l10n,
  ) {
    final PodcastProvider provider = context.read<PodcastProvider>();
    switch (task.status) {
      case DownloadStatus.downloading:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: task.progress / 100,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.downloadProgressLabel(task.progress.toInt()),
            ), // Using the full localized string
          ],
        );
      case DownloadStatus.downloaded:
        return IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: l10n.downloadActionDelete,
          onPressed: () {
            provider.removeDownload(task.episode.id);
          },
        );
      case DownloadStatus.failed:
        return IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: l10n.downloadActionRetry,
          onPressed: () {
            provider.downloadEpisode(task.episode);
          },
        );
      case DownloadStatus.notDownloaded:
      case DownloadStatus.queued:
        return Text(formatDownloadStatus(context, task.status));
    }
  }
}
