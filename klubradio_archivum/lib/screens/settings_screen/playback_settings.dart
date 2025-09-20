import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/episode.provider.dart';
import '../../providers/podcast_provider.dart';
import '../utils/constants.dart' as constants;

class PlaybackSettings extends StatelessWidget {
  const PlaybackSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Lejátszási beállítások',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Consumer<EpisodeProvider>(
              builder: (
                BuildContext context,
                EpisodeProvider provider,
                Widget? child,
              ) {
                return Row(
                  children: <Widget>[
                    const Text('Lejátszási sebesség:'),
                    const SizedBox(width: 12),
                    DropdownButton<double>(
                      value: provider.playbackSpeed,
                      items: constants.playbackSpeeds.map((double speed) {
                        return DropdownMenuItem<double>(
                          value: speed,
                          child: Text('${speed}x'),
                        );
                      }).toList(),
                      onChanged: (double? value) {
                        if (value != null) {
                          provider.updatePlaybackSpeed(value);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            Consumer<PodcastProvider>(
              builder: (
                BuildContext context,
                PodcastProvider provider,
                Widget? child,
              ) {
                final autoDownload =
                    provider.userProfile?.maxAutoDownload ??
                        constants.defaultAutoDownloadCount;
                return Row(
                  children: <Widget>[
                    const Text('Automatikus letöltések:'),
                    const SizedBox(width: 12),
                    DropdownButton<int>(
                      value: autoDownload,
                      items: constants.autoDownloadOptions.map((int count) {
                        return DropdownMenuItem<int>(
                          value: count,
                          child: Text('$count epizód'),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        if (value != null) {
                          provider.updateAutoDownloadCount(value);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
