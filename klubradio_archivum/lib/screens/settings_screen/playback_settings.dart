import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/providers/episode.provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

class PlaybackSettings extends StatelessWidget {
  const PlaybackSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias, // ensure rounded corners clip children
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.playbackSettingsTitle, style: textTheme.titleMedium),
            const SizedBox(height: 16),

            // --- Playback Speed ---
            Text(l10n.playbackSettingsSpeedLabel, style: textTheme.titleSmall),
            const SizedBox(height: 8),
            Consumer<EpisodeProvider>(
              builder: (context, episodeProvider, _) {
                final current = episodeProvider.playbackSpeed;

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: constants.playbackSpeeds.map((speed) {
                    final selected = current == speed;
                    return ChoiceChip(
                      label: Text(l10n.playbackSettingsSpeedValue(speed)),
                      selected: selected,
                      onSelected: (_) =>
                          episodeProvider.updatePlaybackSpeed(speed),
                      selectedColor: cs.primary.withOpacity(0.16),
                      labelStyle: TextStyle(
                        color: selected ? cs.onPrimaryContainer : cs.onSurface,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      side: BorderSide(
                        color: selected
                            ? cs.primary
                            : cs.outlineVariant.withOpacity(0.7),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 16),

            // --- Automatic Downloads ---
            Text(
              l10n.playbackSettingsAutoDownloadLabel,
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Consumer<PodcastProvider>(
              builder: (context, podcastProvider, _) {
                final currentAutoDownload =
                    podcastProvider.userProfile?.maxAutoDownload ??
                    constants.defaultAutoDownloadCount;

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: constants.autoDownloadOptions.map((count) {
                    final selected = currentAutoDownload == count;
                    return ChoiceChip(
                      label: Text(
                        l10n.playbackSettingsAutoDownloadValue(count),
                      ),
                      selected: selected,
                      onSelected: (_) =>
                          podcastProvider.updateAutoDownloadCount(count),
                      selectedColor: cs.primary.withOpacity(0.16),
                      labelStyle: TextStyle(
                        color: selected ? cs.onPrimaryContainer : cs.onSurface,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      side: BorderSide(
                        color: selected
                            ? cs.primary
                            : cs.outlineVariant.withOpacity(0.7),
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
