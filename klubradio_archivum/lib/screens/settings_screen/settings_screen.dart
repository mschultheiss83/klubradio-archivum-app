import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'playback_settings.dart';
import 'theme_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ThemeSettings(),
        const SizedBox(height: 16),
        const PlaybackSettings(),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text('Támogasd a Klubrádiót'),
            subtitle: const Text(
              'Nyisd meg a támogatási oldalt a böngészőben.',
            ),
            onTap: () {
              launchUrl(
                Uri.parse('https://www.klubradio.hu/tamogatas'),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.coffee),
            title: const Text('Támogasd az alkalmazás fejlesztőjét'),
            subtitle: const Text('Önkéntes adomány a további fejlesztésekhez.'),
            onTap: () {
              launchUrl(
                Uri.parse('https://buymeacoffee.com/mschultheiss83'),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ),
      ],
    );
  }
}
