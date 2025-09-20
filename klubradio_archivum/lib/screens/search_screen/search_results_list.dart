import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../providers/episode_provider.dart';
import '../../providers/podcast_provider.dart';
import '../utils/constants.dart';
import '../widgets/stateless/episode_list_item.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key, required this.episodes});

  final List<Episode> episodes;

  @override
  Widget build(BuildContext context) {
    final episodeProvider = context.read<EpisodeProvider>();
    final podcastProvider = context.read<PodcastProvider>();

    return ListView.separated(
      itemCount: episodes.length,
      separatorBuilder: (_, __) => const SizedBox(height: kSmallPadding),
      itemBuilder: (context, index) {
        final episode = episodes[index];
        final podcastTitle = podcastProvider
                .findPodcastById(episode.podcastId)
                ?.title ??
            episode.podcastId;

        return EpisodeListItem(
          episode: episode,
          onPlay: () => episodeProvider.playEpisode(episode),
          onDownload: () => episodeProvider.downloadEpisode(episode),
          onRemoveDownload: () => episodeProvider.removeDownload(episode),
          downloadProgress: episodeProvider.downloadProgress[episode.id],
          showPodcastTitle: true,
          podcastTitle: podcastTitle,
        );
      },
    );
  }
}
