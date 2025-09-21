import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../providers/episode_provider.dart';
import '../now_playing_screen/now_playing_screen.dart';
import '../widgets/stateless/episode_list_item.dart';

class RecentlyPlayedList extends StatelessWidget {
  const RecentlyPlayedList({super.key, required this.episodes});

  final List<Episode> episodes;

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) {
      return const Text('Még nem hallgattál meg epizódot.');
    }

    return Column(
      children: episodes
          .map(
            (Episode episode) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EpisodeListItem(
                episode: episode,
                onTap: () {
                  context.read<EpisodeProvider>().playEpisode(episode);
                  Navigator.of(context).pushNamed(NowPlayingScreen.routeName);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
