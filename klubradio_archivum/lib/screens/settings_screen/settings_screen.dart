import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './../../l10n/app_localizations.dart';
import 'playback_settings.dart';
import 'theme_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ThemeSettings(), // ThemeSettings will handle its own localization
        const SizedBox(height: 16),
        const PlaybackSettings(), // Assuming PlaybackSettings handles its own
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: Text(l10n.settingsScreenSupportKlubradioTitle), // Localized
            subtitle: Text(
              l10n.settingsScreenSupportKlubradioSubtitle,
            ), // Localized
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
            title: Text(l10n.settingsScreenSupportDeveloperTitle), // Localized
            subtitle: Text(
              l10n.settingsScreenSupportDeveloperSubtitle,
            ), // Localized
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
