import 'package:flutter/material.dart';

import '../../providers/episode.provider.dart';
import '../utils/constants.dart' as constants;

class AudioPlayerControls extends StatelessWidget {
  const AudioPlayerControls({super.key, required this.provider});

  final EpisodeProvider provider;

  @override
  Widget build(BuildContext context) {
    final bool hasPrevious = provider.getPreviousEpisode() != null;
    final bool hasNext = provider.getNextEpisode() != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.skip_previous),
              onPressed: hasPrevious
                  ? () {
                      provider.playPrevious();
                    }
                  : null,
            ),
            IconButton(
              iconSize: 48,
              icon: Icon(
                provider.isPlaying ? Icons.pause_circle : Icons.play_circle,
              ),
              onPressed: () {
                provider.togglePlayPause();
              },
            ),
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.skip_next),
              onPressed: hasNext
                  ? () {
                      provider.playNext();
                    }
                  : null,
            ),
          ],
        ),
        const SizedBox(height: 16),
        DropdownButton<double>(
          value: provider.playbackSpeed,
          onChanged: (double? value) {
            if (value != null) {
              provider.updatePlaybackSpeed(value);
            }
          },
          items: constants.playbackSpeeds.map((double speed) {
            return DropdownMenuItem<double>(
              value: speed,
              child: Text('${speed}x'),
            );
          }).toList(),
        ),
      ],
    );
  }
}
