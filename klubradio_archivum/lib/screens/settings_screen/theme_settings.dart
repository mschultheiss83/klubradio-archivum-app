import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../utils/constants.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, _) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Téma', style: Theme.of(context).textTheme.titleLarge),
                RadioListTile<ThemeMode>(
                  title: const Text('Rendszer alapértelmezett'),
                  value: ThemeMode.system,
                  groupValue: provider.themeMode,
                  onChanged: provider.setThemeMode,
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Világos mód'),
                  value: ThemeMode.light,
                  groupValue: provider.themeMode,
                  onChanged: provider.setThemeMode,
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Sötét mód'),
                  value: ThemeMode.dark,
                  groupValue: provider.themeMode,
                  onChanged: provider.setThemeMode,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
