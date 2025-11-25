import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/retention_mode.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart'; // Import PlatformUtils

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
    // Only ensure defaults if downloads are supported
    if (PlatformUtils.supportsDownloads) {
      _dao.ensureDefaults();
    }
  }

  RetentionMode _modeFrom(Setting s) {
    if ((s.keepLatestN ?? 0) > 0) return RetentionMode.keepLatestN;
    if ((s.deleteAfterHours ?? 0) > 0) return RetentionMode.deleteAfterHeard;
    return RetentionMode.keepAll;
  }

  @override
  Widget build(BuildContext context) {
    if (!PlatformUtils.supportsDownloads) {
      return const SizedBox.shrink();
    }

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

        final mode = _modeFrom(s);

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
                  subtitle: Text(
                    !kIsWeb
                        ? l10n.settings_wifi_only_mobile_default
                        : l10n.settings_wifi_only_desktop_default,
                  ),
                  value: s.wifiOnly,
                  onChanged: (v) => _dao.setWifiOnly(v),
                ),
                const SizedBox(height: 8),

                // Autodownload subscribed episodes
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.settings_autodownload_subscriptions),
                  subtitle: Text(l10n.settings_autodownload_subscriptions_hint),
                  value: s.autodownloadSubscribed,
                  onChanged: (v) => _dao.setAutodownloadSubscribed(v),
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
                const SizedBox(height: 16),

                Text(
                  l10n.settings_retention_section,
                  style: textTheme.titleSmall,
                ),
                const SizedBox(height: 8),

                // Retention-Modus wie Theme-ChoiceChips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _ModeChip(
                      label: l10n.settings_keep_all,
                      selected: mode == RetentionMode.keepAll,
                      onSelected: () async {
                        await _dao.setKeepLatestN(null);
                        await _dao.setDeleteAfterHours(null);
                      },
                    ),
                    _ModeChip(
                      label: l10n
                          .settings_keep_latest_label, // „Nur die letzten n“
                      selected: mode == RetentionMode.keepLatestN,
                      onSelected: () async {
                        // wenn aktivieren und noch 0/null → auf 5 setzen als Startwert
                        final next = (s.keepLatestN ?? 0) > 0
                            ? s.keepLatestN
                            : 5;
                        await _dao.setDeleteAfterHours(null);
                        await _dao.setKeepLatestN(next);
                      },
                    ),
                    _ModeChip(
                      label: l10n
                          .settings_delete_after_heard_label, // „Nach gehört in x h“
                      selected: mode == RetentionMode.deleteAfterHeard,
                      onSelected: () async {
                        final next = (s.deleteAfterHours ?? 0) > 0
                            ? s.deleteAfterHours
                            : 24;
                        await _dao.setKeepLatestN(null);
                        await _dao.setDeleteAfterHours(next);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Nur die zugehörige Zahl editierbar machen
                if (mode == RetentionMode.keepLatestN)
                  _StepperRow(
                    label: l10n.settings_keep_latest,
                    hint: l10n
                        .settings_keep_latest_hint, // z.B. „Behalte die neuesten n Episoden“
                    valueText: '${s.keepLatestN ?? 0}',
                    onMinus: (s.keepLatestN ?? 0) > 1
                        ? () => _dao.setKeepLatestN((s.keepLatestN ?? 0) - 1)
                        : null,
                    onPlus: () => _dao.setKeepLatestN((s.keepLatestN ?? 0) + 1),
                    cs: cs,
                  ),
                if (mode == RetentionMode.deleteAfterHeard)
                  _StepperRow(
                    label: l10n.settings_delete_after_hours,
                    hint: l10n
                        .settings_delete_after_hint, // „Nach gehört, erst nach x h löschen“
                    valueText: '${s.deleteAfterHours ?? 0}',
                    onMinus: (s.deleteAfterHours ?? 0) > 1
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

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
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
        color: selected ? cs.primary : cs.outlineVariant.withAlpha((255 * 0.7).round()),
      ),
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
