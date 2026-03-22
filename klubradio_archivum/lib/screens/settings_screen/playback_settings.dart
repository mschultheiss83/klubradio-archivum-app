import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
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
                  selectedColor: cs.primary.withAlpha((255 * 0.16).round()),
                  labelStyle: TextStyle(
                    color: selected ? cs.onPrimaryContainer : cs.onSurface,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  side: BorderSide(
                    color: selected
                        ? cs.primary
                        : cs.outlineVariant.withAlpha((255 * 0.7).round()),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // --- Episode Order ---
            Text(l10n.settings_episode_order_label, style: textTheme.titleSmall),
            const SizedBox(height: 8),
            _EpisodeOrderChips(cs: cs),
          ],
        ),
      ),
    );
  }
}

class _EpisodeOrderChips extends StatelessWidget {
  const _EpisodeOrderChips({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.watch<AppDatabase>();
    final settingsStream = (db.select(db.settings)
          ..where((s) => s.id.equals(1)))
        .watchSingleOrNull();

    return StreamBuilder<Setting?>(
      stream: settingsStream,
      builder: (context, snap) {
        final current = snap.data?.playOrder ?? 'newest';
        final dao = SettingsDao(db);

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _orderChip(
              label: l10n.settings_episode_order_newest,
              selected: current == 'newest',
              onSelected: () => dao.setPlayOrder('newest'),
            ),
            _orderChip(
              label: l10n.settings_episode_order_oldest,
              selected: current == 'oldest',
              onSelected: () => dao.setPlayOrder('oldest'),
            ),
          ],
        );
      },
    );
  }

  Widget _orderChip({
    required String label,
    required bool selected,
    required VoidCallback onSelected,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: cs.primary.withAlpha((255 * 0.16).round()),
      labelStyle: TextStyle(
        color: selected ? cs.onPrimaryContainer : cs.onSurface,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
      ),
      side: BorderSide(
        color: selected
            ? cs.primary
            : cs.outlineVariant.withAlpha((255 * 0.7).round()),
      ),
    );
  }
}
