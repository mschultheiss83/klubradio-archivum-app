import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/episode.dart';
import '../../../providers/episode_provider.dart';
import '../../now_playing_screen/now_playing_screen.dart';
import '../stateless/episode_list_item.dart';

typedef EpisodeTap = void Function(Episode episode);

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    super.key,
    required this.episodes,
    this.onEpisodeTap,
  });

  final List<Episode> episodes;
  final EpisodeTap? onEpisodeTap;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  Widget build(BuildContext context) {
    if (widget.episodes.isEmpty) {
      return const Text('Nincs megjeleníthető epizód.');
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.episodes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final Episode episode = widget.episodes[index];
        return EpisodeListItem(
          episode: episode,
          onTap: () {
            if (widget.onEpisodeTap != null) {
              widget.onEpisodeTap!(episode);
            } else {
              context.read<EpisodeProvider>().playEpisode(episode);
              Navigator.of(context).pushNamed(NowPlayingScreen.routeName);
            }
          },
        );
      },
    );
  }
}
