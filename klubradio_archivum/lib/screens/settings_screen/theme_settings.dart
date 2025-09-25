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
          builder: (BuildContext context, ThemeProvider provider, Widget? child) {
            // Determine which button is currently selected
            // The order here must match the order of ToggleButtons children
            List<bool> isSelected = [
              provider.themeMode == ThemeMode.system,
              provider.themeMode == ThemeMode.light,
              provider.themeMode == ThemeMode.dark,
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.themeSettingsSectionTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12), // Spacing after title
                ToggleButtons(
                  isSelected: isSelected,
                  onPressed: (int index) {
                    // Update the theme based on which button was pressed
                    if (index == 0) {
                      provider.setThemeMode(ThemeMode.system);
                    } else if (index == 1) {
                      provider.setThemeMode(ThemeMode.light);
                    } else if (index == 2) {
                      provider.setThemeMode(ThemeMode.dark);
                    }
                  },
                  // borderRadius: BorderRadius.circular(8.0), // Optional: for rounded corners
                  // constraints: BoxConstraints( // Optional: to make buttons fill more width if desired
                  //   minHeight: 40.0,
                  //   minWidth: (MediaQuery.of(context).size.width - 32 - 32) / 3, // Example: fill available width
                  // ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(l10n.themeSettingSystemDefault),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(l10n.themeSettingLight),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(l10n.themeSettingDark),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
