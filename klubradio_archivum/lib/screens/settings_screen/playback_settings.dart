import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import '../../providers/episode.provider.dart';
import '../../providers/podcast_provider.dart';
import '../utils/constants.dart' as constants;

class PlaybackSettings extends StatelessWidget {
  const PlaybackSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.playbackSettingsTitle, style: textTheme.titleMedium),
            const SizedBox(height: 16), // Consistent spacing
            // --- Playback Speed Setting ---
            Text(l10n.playbackSettingsSpeedLabel, style: textTheme.titleSmall),
            const SizedBox(height: 8),
            Consumer<EpisodeProvider>(
              builder: (context, episodeProvider, child) {
                List<bool> isSelectedSpeed = constants.playbackSpeeds
                    .map((speed) => episodeProvider.playbackSpeed == speed)
                    .toList();

                return ToggleButtons(
                  isSelected: isSelectedSpeed,
                  onPressed: (int index) {
                    if (index >= 0 && index < constants.playbackSpeeds.length) {
                      episodeProvider.updatePlaybackSpeed(
                        constants.playbackSpeeds[index],
                      );
                    }
                  },
                  children: constants.playbackSpeeds.map((speed) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ), // Adjust padding
                      child: Text(l10n.playbackSettingsSpeedValue(speed)),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 16), // Consistent spacing
            // --- Automatic Downloads Setting ---
            Text(
              l10n.playbackSettingsAutoDownloadLabel,
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Consumer<PodcastProvider>(
              builder: (context, podcastProvider, child) {
                final currentAutoDownload =
                    podcastProvider.userProfile?.maxAutoDownload ??
                    constants.defaultAutoDownloadCount;

                List<bool> isSelectedAutoDownload = constants
                    .autoDownloadOptions
                    .map((count) => currentAutoDownload == count)
                    .toList();

                return ToggleButtons(
                  isSelected: isSelectedAutoDownload,
                  onPressed: (int index) {
                    if (index >= 0 &&
                        index < constants.autoDownloadOptions.length) {
                      podcastProvider.updateAutoDownloadCount(
                        constants.autoDownloadOptions[index],
                      );
                    }
                  },
                  children: constants.autoDownloadOptions.map((count) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ), // Adjust padding
                      child: Text(
                        l10n.playbackSettingsAutoDownloadValue(count),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
