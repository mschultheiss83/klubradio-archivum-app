import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart'; // Corrected package import

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutScreenAppBarTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Text(
              l10n.aboutScreenAppNameDetail,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(l10n.aboutScreenPurpose),
            const SizedBox(height: 12),
            Text(l10n.aboutScreenCommunityProjectInfo),
            const SizedBox(height: 12),
            Text(l10n.aboutScreenContactInfo),
          ],
        ),
      ),
    );
  }
}
