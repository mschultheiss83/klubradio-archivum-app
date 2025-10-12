import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';

class DownloadSettingsPanel extends StatefulWidget {
  const DownloadSettingsPanel({super.key});
  @override
  State<DownloadSettingsPanel> createState() => _DownloadSettingsPanelState();
}

class _DownloadSettingsPanelState extends State<DownloadSettingsPanel> {
  late final SettingsDao _dao;

  @override
  void initState() {
    super.initState();
    final db = context.read<AppDatabase>();
    _dao = SettingsDao(db);
    _dao.ensureDefaults();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.watch<AppDatabase>();
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final settingsStream = (db.select(
      db.settings,
    )..where((s) => s.id.equals(1))).watchSingleOrNull();

    return StreamBuilder<Setting?>(
      stream: settingsStream,
      builder: (context, snap) {
        final s = snap.data;
        if (s == null) return const SizedBox.shrink();

        return Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settings_title_downloads,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 12),

                // WLAN only
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.settings_wifi_only),
                  value: s.wifiOnly,
                  onChanged: (v) => _dao.setWifiOnly(v),
                ),
                const SizedBox(height: 8),

                // Max parallel
                _StepperRow(
                  label: l10n.settings_max_parallel,
                  valueText: '${s.maxParallel}',
                  onMinus: s.maxParallel > 1
                      ? () => _dao.setMaxParallel(s.maxParallel - 1)
                      : null,
                  onPlus: () => _dao.setMaxParallel(s.maxParallel + 1),
                  cs: cs,
                ),
                const SizedBox(height: 8),

                // Letzte Episoden behalten (global)
                _StepperRow(
                  label: l10n.settings_keep_latest,
                  hint: l10n.settings_zero_off, // „0 = aus“
                  valueText: '${s.keepLatestN ?? 0}',
                  onMinus: (s.keepLatestN ?? 0) > 0
                      ? () => _dao.setKeepLatestN((s.keepLatestN ?? 0) - 1)
                      : null,
                  onPlus: () => _dao.setKeepLatestN((s.keepLatestN ?? 0) + 1),
                  cs: cs,
                ),
                const SizedBox(height: 8),

                // Löschen nach (Stunden)
                _StepperRow(
                  label: l10n.settings_delete_after_hours,
                  hint: l10n.settings_zero_off,
                  valueText: '${s.deleteAfterHours ?? 0}',
                  onMinus: (s.deleteAfterHours ?? 0) > 0
                      ? () => _dao.setDeleteAfterHours(
                          (s.deleteAfterHours ?? 0) - 1,
                        )
                      : null,
                  onPlus: () =>
                      _dao.setDeleteAfterHours((s.deleteAfterHours ?? 0) + 1),
                  cs: cs,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StepperRow extends StatelessWidget {
  const _StepperRow({
    required this.label,
    required this.valueText,
    required this.cs,
    this.hint,
    this.onMinus,
    this.onPlus,
  });

  final String label;
  final String valueText;
  final String? hint;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: textTheme.titleSmall),
              if (hint != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    hint!,
                    style: textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onMinus, icon: const Icon(Icons.remove)),
            Text(valueText, style: textTheme.titleMedium),
            IconButton(onPressed: onPlus, icon: const Icon(Icons.add)),
          ],
        ),
      ],
    );
  }
}
