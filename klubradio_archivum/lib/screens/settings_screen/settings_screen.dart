import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// TODO: Declare the url_launcher dependency in pubspec.yaml if it is missing.

import '../about_screen/about_screen.dart';
import '../utils/constants.dart';
import 'playback_settings.dart';
import 'theme_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

  Future<void> _launchExternalUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Nem sikerült megnyitni a hivatkozást: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beállítások'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(kDefaultPadding),
        children: <Widget>[
          const ThemeSettings(),
          const SizedBox(height: kDefaultPadding),
          const PlaybackSettings(),
          const SizedBox(height: kDefaultPadding),
          ListTile(
            leading: const Icon(Icons.volunteer_activism),
            title: const Text('Támogasd a Klubrádiót'),
            subtitle: const Text('A hivatalos Klubrádió támogatási oldalra visz.'),
            onTap: () => _launchExternalUrl(kDonationUrlStation),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Támogasd az alkalmazás fejlesztését'),
            subtitle: const Text('PayPal adomány a fejlesztőnek.'),
            onTap: () => _launchExternalUrl(kDonationUrlDeveloper),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Névjegy'),
            onTap: () => Navigator.of(context).pushNamed(AboutScreen.routeName),
          ),
        ],
      ),
    );
  }
}
