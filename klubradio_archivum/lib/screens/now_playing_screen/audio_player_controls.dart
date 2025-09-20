import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode_provider.dart';

class AudioPlayerControls extends StatelessWidget {
  const AudioPlayerControls({super.key});

  static const Duration _skipInterval = Duration(seconds: 15);

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (context, provider, _) {
        final hasEpisode = provider.nowPlaying != null;
        final isPlaying = provider.isPlaying;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.replay_10),
              onPressed: hasEpisode
                  ? () {
                      final newPosition = provider.currentPosition - _skipInterval;
                      provider.seek(newPosition.isNegative
                          ? Duration.zero
                          : newPosition);
                    }
                  : null,
              tooltip: 'Vissza 15 másodperc',
            ),
            const SizedBox(width: 12),
            IconButton(
              iconSize: 56,
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              ),
              onPressed: hasEpisode ? provider.togglePlayPause : null,
              tooltip: isPlaying ? 'Szünet' : 'Lejátszás',
            ),
            const SizedBox(width: 12),
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.forward_10),
              onPressed: hasEpisode
                  ? () {
                      final duration = provider.nowPlaying?.duration ?? Duration.zero;
                      final newPosition =
                          provider.currentPosition + _skipInterval;
                      provider.seek(newPosition > duration
                          ? duration
                          : newPosition);
                    }
                  : null,
              tooltip: 'Előre 15 másodperc',
            ),
          ],
        );
      },
    );
  }
}
