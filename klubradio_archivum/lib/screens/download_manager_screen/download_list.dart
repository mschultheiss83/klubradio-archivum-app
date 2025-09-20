import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../providers/episode_provider.dart';
import '../utils/constants.dart';
import '../widgets/stateless/episode_list_item.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (context, provider, _) {
        final List<Episode> downloads = provider.downloadedEpisodes;
        if (downloads.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text('Nem található letöltött epizód.'),
            ),
          );
        }

        return ListView.separated(
          itemCount: downloads.length,
          separatorBuilder: (_, __) => const SizedBox(height: kSmallPadding),
          itemBuilder: (context, index) {
            final episode = downloads[index];
            return EpisodeListItem(
              episode: episode,
              downloadProgress: provider.downloadProgress[episode.id],
              onPlay: () => provider.playEpisode(episode),
              onRemoveDownload: () => provider.removeDownload(episode),
              onDownload: null,
            );
          },
        );
      },
    );
  }
}
