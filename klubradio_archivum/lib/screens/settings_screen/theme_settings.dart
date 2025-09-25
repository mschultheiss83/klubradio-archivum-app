import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<ThemeProvider>(
          builder:
              (BuildContext context, ThemeProvider provider, Widget? child) {
                // Helper function to create each radio item
                Widget buildRadioItem(
                  ThemeMode value,
                  String title,
                  ThemeProvider provider,
                ) {
                  return InkWell(
                    onTap: () {
                      provider.setThemeMode(value);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ), // Adjust padding as needed
                      child: Row(
                        children: <Widget>[
                          Radio<ThemeMode>.adaptive(
                            value: value,
                            groupValue: provider.themeMode,
                            onChanged: (ThemeMode? newValue) {
                              if (newValue != null) {
                                provider.setThemeMode(newValue);
                              }
                            },
                            // Optional: for better visual alignment with text
                            visualDensity: VisualDensity.compact,
                            activeColor: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            width: 8,
                          ), // Spacing between radio and text
                          Expanded(
                            // Allow text to take available space
                            child: Text(title),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l10n.themeSettingsSectionTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8), // Reduced spacing after title
                    buildRadioItem(
                      ThemeMode.system,
                      l10n.themeSettingSystemDefault,
                      provider,
                    ),
                    buildRadioItem(
                      ThemeMode.light,
                      l10n.themeSettingLight,
                      provider,
                    ),
                    buildRadioItem(
                      ThemeMode.dark,
                      l10n.themeSettingDark,
                      provider,
                    ),
                  ],
                );
              },
        ),
      ),
    );
  }
}
