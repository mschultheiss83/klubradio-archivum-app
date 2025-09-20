import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/podcast_provider.dart';
import '../../services/download_service.dart';
import '../utils/helpers.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key, required this.downloads});

  final List<DownloadTask> downloads;

  @override
  Widget build(BuildContext context) {
    if (downloads.isEmpty) {
      return Center(
        child: Text(
          'Nincsenek letöltött epizódok.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      itemCount: downloads.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        final DownloadTask task = downloads[index];
        final statusLabel = formatDownloadStatus(task.status);
        final progressLabel = formatProgress(task.progress);
        return ListTile(
          leading: Icon(_statusIcon(task.status)),
          title: Text(task.episode.title),
          subtitle: Text('$statusLabel • ${task.episode.podcastId}'),
          trailing: _buildTrailing(context, task, progressLabel),
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
                value: task.progress,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 4),
            Text(progressLabel),
          ],
        );
      case DownloadStatus.downloaded:
        return IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            provider.removeDownload(task.episode.id);
          },
        );
      case DownloadStatus.failed:
        return IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            provider.downloadEpisode(task.episode);
          },
        );
      case DownloadStatus.notDownloaded:
      case DownloadStatus.queued:
        return Text(progressLabel);
    }
  }
}
