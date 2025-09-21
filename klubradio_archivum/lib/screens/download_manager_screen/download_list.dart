import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../providers/episode_provider.dart';
import '../../services/download_service.dart';
import '../now_playing_screen/now_playing_screen.dart';
import '../utils/helpers.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key, required this.downloads});

  final List<DownloadTask> downloads;

  @override
  Widget build(BuildContext context) {
    if (downloads.isEmpty) {
      return const Center(
        child: Text('Még nincs letöltött epizód.'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: downloads.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final DownloadTask task = downloads[index];
        return _DownloadListTile(task: task);
      },
    );
  }
}

class _DownloadListTile extends StatelessWidget {
  const _DownloadListTile({required this.task});

  final DownloadTask task;

  @override
  Widget build(BuildContext context) {
    final Episode episode = task.episode;
    final EpisodeProvider provider =
        Provider.of<EpisodeProvider>(context, listen: false);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(episode.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(formatEpisodeDate(episode.publishedAt)),
            Text(formatDuration(episode.duration)),
            if (task.status != DownloadStatus.completed)
              LinearProgressIndicator(value: task.progress),
            if (task.localPath != null)
              Text(
                'Mentve: ${task.localPath}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == 'remove') {
              provider.removeDownload(episode.id);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'remove',
              child: Text('Törlés'),
            ),
          ],
        ),
        onTap: () {
          provider.playEpisode(episode);
          Navigator.of(context).pushNamed(NowPlayingScreen.routeName);
        },
      ),
    );
  }
}
