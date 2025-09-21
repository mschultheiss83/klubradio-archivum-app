import 'package:flutter/material.dart';

import 'playback_settings.dart';
import 'theme_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beállítások')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          ThemeSettings(),
          SizedBox(height: 24),
          PlaybackSettings(),
          SizedBox(height: 24),
          _DonationSettings(),
        ],
      ),
    );
  }
}

class _DonationSettings extends StatelessWidget {
  const _DonationSettings();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Támogatás',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'TODO: Adjuk hozzá a Klubrádió és a fejlesztő támogatási linkjeit '
              'például PayPal vagy Stripe használatával.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
