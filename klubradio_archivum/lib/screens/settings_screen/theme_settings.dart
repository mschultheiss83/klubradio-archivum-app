import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<ThemeProvider>(
          builder: (
            BuildContext context,
            ThemeProvider provider,
            Widget? child,
          ) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Téma beállítások',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Rendszerbeállítás'),
                  value: ThemeMode.system,
                  groupValue: provider.themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      provider.setThemeMode(value);
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Világos mód'),
                  value: ThemeMode.light,
                  groupValue: provider.themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      provider.setThemeMode(value);
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Sötét mód'),
                  value: ThemeMode.dark,
                  groupValue: provider.themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      provider.setThemeMode(value);
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
