import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/theme_provider.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<ThemeProvider>(
          builder: (context, provider, _) {
            final items = <_ThemeOption>[
              _ThemeOption(
                label: l10n.themeSettingSystemDefault,
                mode: ThemeMode.system,
              ),
              _ThemeOption(
                label: l10n.themeSettingLight,
                mode: ThemeMode.light,
              ),
              _ThemeOption(label: l10n.themeSettingDark, mode: ThemeMode.dark),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.themeSettingsSectionTitle,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: items.map((opt) {
                    final selected = provider.themeMode == opt.mode;
                    return ChoiceChip(
                      label: Text(opt.label),
                      selected: selected,
                      onSelected: (_) => provider.setThemeMode(opt.mode),
                      selectedColor: cs.primary.withAlpha((255 * 0.16).round()),
                      labelStyle: TextStyle(
                        color: selected ? cs.onPrimaryContainer : cs.onSurface,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      side: BorderSide(
                        color: selected
                            ? cs.primary
                            : cs.outlineVariant.withAlpha((255 * 0.7).round()),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ThemeOption {
  const _ThemeOption({required this.label, required this.mode});
  final String label;
  final ThemeMode mode;
}
