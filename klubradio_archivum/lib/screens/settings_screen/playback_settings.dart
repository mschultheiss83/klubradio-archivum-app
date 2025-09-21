import 'package:flutter/material.dart';

class PlaybackSettings extends StatefulWidget {
  const PlaybackSettings({super.key});

  @override
  State<PlaybackSettings> createState() => _PlaybackSettingsState();
}

class _PlaybackSettingsState extends State<PlaybackSettings> {
  double _autoDownloadCount = 5;
  bool _wifiOnly = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Lejátszás és letöltés',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Automatikus letöltés epizódonként: ${_autoDownloadCount.toInt()}'),
            Slider(
              min: 1,
              max: 10,
              divisions: 9,
              value: _autoDownloadCount,
              label: _autoDownloadCount.toInt().toString(),
              onChanged: (double value) {
                setState(() => _autoDownloadCount = value);
              },
            ),
            SwitchListTile(
              title: const Text('Csak Wi-Fi-n töltsön le'),
              value: _wifiOnly,
              onChanged: (bool value) => setState(() => _wifiOnly = value),
            ),
            const SizedBox(height: 8),
            const Text(
              'TODO: Mentés Supabase vagy helyi Hive adatbázis segítségével, '
              'és kapcsolódás a letöltéskezelőhöz.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
