import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/episode.dart';
import '../../../providers/episode.provider.dart';
import '../../../providers/podcast_provider.dart';
import '../../../services/download_service.dart';
import '../stateless/episode_list_item.dart';

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    super.key,
    required this.episodes,
    this.enableDownloads = true,
  });

  final List<Episode> episodes;
  final bool enableDownloads;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<EpisodeProvider, PodcastProvider>(
      builder: (
        BuildContext context,
        EpisodeProvider episodeProvider,
        PodcastProvider podcastProvider,
        Widget? child,
      ) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.episodes.length,
          itemBuilder: (BuildContext context, int index) {
            final Episode episode = widget.episodes[index];
            final DownloadTask? task =
                podcastProvider.getDownloadTask(episode.id);
            final DownloadStatus status =
                task?.status ?? episode.downloadStatus;

            return EpisodeListItem(
              episode: episode,
              onTap: () async {
                await episodeProvider.playEpisode(
                  episode,
                  queue: widget.episodes,
                );
                podcastProvider.addRecentlyPlayed(episode);
              },
              trailing: widget.enableDownloads
                  ? _DownloadButton(status: status, episode: episode)
                  : null,
            );
          },
        );
      },
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({required this.status, required this.episode});

  final DownloadStatus status;
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final PodcastProvider provider = context.read<PodcastProvider>();

    switch (status) {
      case DownloadStatus.downloading:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case DownloadStatus.downloaded:
        return IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: () {
            // TODO: Open the downloaded file via local player integration.
          },
        );
      case DownloadStatus.failed:
        return IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            provider.downloadEpisode(episode);
          },
        );
      case DownloadStatus.notDownloaded:
      case DownloadStatus.queued:
        return IconButton(
          icon: const Icon(Icons.download_for_offline_outlined),
          onPressed: () {
            provider.downloadEpisode(episode);
          },
        );
    }
  }
}
