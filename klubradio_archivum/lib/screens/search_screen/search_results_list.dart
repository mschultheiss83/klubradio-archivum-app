import 'package:flutter/material.dart';

import '../../models/episode.dart';
import '../widgets/stateless/episode_list_item.dart';

typedef EpisodeTapCallback = void Function(Episode episode);

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({
    super.key,
    required this.episodes,
    required this.onEpisodeTap,
  });

  final List<Episode> episodes;
  final EpisodeTapCallback onEpisodeTap;

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) {
      return const Center(child: Text('Nincs találat.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: episodes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final Episode episode = episodes[index];
        return EpisodeListItem(
          episode: episode,
          onTap: () => onEpisodeTap(episode),
        );
      },
    );
  }
}
