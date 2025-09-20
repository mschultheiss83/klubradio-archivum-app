import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/episode.dart';
import '../../../providers/episode_provider.dart';
import '../../utils/constants.dart';
import '../stateless/episode_list_item.dart';

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    super.key,
    required this.podcastId,
    this.podcastTitle,
  });

  final String podcastId;
  final String? podcastTitle;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<EpisodeProvider>()
          .loadEpisodesForPodcast(widget.podcastId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (context, provider, _) {
        final List<Episode> episodes =
            provider.episodesForPodcast(widget.podcastId);
        final isLoading = provider.isLoading && episodes.isEmpty;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (episodes.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text('Jelenleg nincsenek elérhető epizódok.'),
            ),
          );
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: episodes.length,
          separatorBuilder: (_, __) => const SizedBox(height: kSmallPadding),
          itemBuilder: (context, index) {
            final episode = episodes[index];
            final progress = provider.downloadProgress[episode.id];
            return EpisodeListItem(
              episode: episode,
              podcastTitle: widget.podcastTitle,
              showPodcastTitle: widget.podcastTitle != null,
              downloadProgress: progress,
              onPlay: () => provider.playEpisode(episode),
              onDownload: () => provider.downloadEpisode(episode),
              onRemoveDownload: () => provider.removeDownload(episode),
            );
          },
        );
      },
    );
  }
}
