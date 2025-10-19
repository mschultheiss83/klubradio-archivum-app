import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/profile_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

class PlaybackSettings extends StatelessWidget {
  const PlaybackSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final profile = context.watch<ProfileProvider>().profileOrNull;
    if (profile == null) {
      return const Card(
        child: SizedBox(
          height: 96,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    final currentSpeed = profile.playbackSpeed;
    final currentAuto = profile.maxAutoDownload;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.playbackSettingsTitle, style: textTheme.titleMedium),
            const SizedBox(height: 16),

            // --- Playback Speed (Chips) ---
            Text(l10n.playbackSettingsSpeedLabel, style: textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: constants.playbackSpeeds.map((speed) {
                final selected = currentSpeed == speed;
                return ChoiceChip(
                  label: Text(l10n.playbackSettingsSpeedValue(speed)),
                  selected: selected,
                  onSelected: (_) async {
                    await context.read<ProfileProvider>().setPlaybackSpeed(
                      speed,
                    ); // Persistenz
                    if (!context.mounted) return;
                    context.read<EpisodeProvider>().updatePlaybackSpeed(
                      speed,
                    ); // Live-Player
                  },
                  selectedColor: cs.primary.withOpacity(0.16),
                  labelStyle: TextStyle(
                    color: selected ? cs.onPrimaryContainer : cs.onSurface,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  side: BorderSide(
                    color: selected
                        ? cs.primary
                        : cs.outlineVariant.withOpacity(0.7),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // --- Automatic Downloads (Chips) ---
            Text(
              l10n.playbackSettingsAutoDownloadLabel,
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: constants.autoDownloadOptions.map((count) {
                final selected = currentAuto == count;
                return ChoiceChip(
                  label: Text(l10n.playbackSettingsAutoDownloadValue(count)),
                  selected: selected,
                  onSelected: (_) =>
                      context.read<ProfileProvider>().setMaxAutoDownload(count),
                  selectedColor: cs.primary.withOpacity(0.16),
                  labelStyle: TextStyle(
                    color: selected ? cs.onPrimaryContainer : cs.onSurface,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  side: BorderSide(
                    color: selected
                        ? cs.primary
                        : cs.outlineVariant.withOpacity(0.7),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
