import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/screens/settings_screen/playback_settings.dart';
import 'package:klubradio_archivum/screens/settings_screen/theme_settings.dart';
import 'package:klubradio_archivum/screens/settings_screen/download_settings_panel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ThemeSettings(),
        const SizedBox(height: 16),
        const DownloadSettingsPanel(),
        const SizedBox(height: 16),
        const PlaybackSettings(),
        const SizedBox(height: 16),
        Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: Text(l10n.settingsScreenSupportKlubradioTitle),
            subtitle: Text(l10n.settingsScreenSupportKlubradioSubtitle),
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
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: const Icon(Icons.coffee),
            title: Text(l10n.settingsScreenSupportDeveloperTitle),
            subtitle: Text(l10n.settingsScreenSupportDeveloperSubtitle),
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
