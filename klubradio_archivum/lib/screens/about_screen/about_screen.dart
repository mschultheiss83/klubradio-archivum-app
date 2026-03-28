import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:klubradio_archivum/screens/about_screen/legal_screen.dart';
import 'package:klubradio_archivum/screens/widgets/privacy_dialog.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? versionText;
  List<String> _contributors = [];

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _loadContributors();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      versionText = l10n.aboutScreenVersionFormat(
        info.version,
        info.buildNumber,
      );
    });
  }

  Future<void> _loadContributors() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/contributions.json');
      final List<dynamic> data = json.decode(jsonString) as List<dynamic>;
      if (!mounted) return;
      setState(() {
        _contributors = data
            .map((e) => (e as Map<String, dynamic>)['name'] as String)
            .toList();
      });
    } catch (_) {
      // If the file can't be loaded, keep the list empty.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutScreenAppBarTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Main About Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: cs.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.aboutScreenAppNameDetail,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(l10n.aboutScreenPurpose, style: textTheme.bodyMedium),
                    const SizedBox(height: 12),
                    Text(
                      l10n.aboutScreenCommunityProjectInfo,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    SelectableText(
                      l10n.aboutScreenContactInfo,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Privacy & Security Notice Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.shield_outlined),
                title: Text(l10n.privacySettingsRow),
                subtitle: Text(l10n.privacySettingsRowSubtitle),
                onTap: () => showPrivacyDialog(context),
              ),
            ),

            const SizedBox(height: 16),

            // License Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(l10n.aboutScreenLicenseTitle),
                subtitle: Text(l10n.aboutScreenLicenseSummary),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LegalScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Impressum Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.business_outlined),
                title: Text(l10n.aboutScreenImpressumTitle),
                subtitle: Text(l10n.aboutScreenImpressumSummary),
                trailing: const Icon(Icons.open_in_new, size: 18),
                onTap: () => launchUrl(
                  Uri.parse('https://multilevelstudios.de/impressum.html'),
                  mode: LaunchMode.externalApplication,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Privacy Policy Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.policy_outlined),
                title: Text(l10n.aboutScreenPrivacyPolicyTitle),
                subtitle: Text(l10n.aboutScreenPrivacyPolicySummary),
                trailing: const Icon(Icons.open_in_new, size: 18),
                onTap: () => launchUrl(
                  Uri.parse('https://multilevelstudios.de/datenschutz.html'),
                  mode: LaunchMode.externalApplication,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Version Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.code_outlined),
                title: Text(l10n.aboutScreenVersionTitle),
                subtitle: Text(versionText ?? '...'),
              ),
            ),

            const SizedBox(height: 16),

            // App-ID Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.fingerprint),
                title: Text(l10n.aboutScreenAppIdLabel),
                subtitle: const SelectableText('hu.klubradio.archivum'),
              ),
            ),

            const SizedBox(height: 16),

            // Supporters Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.volunteer_activism_outlined,
                            color: cs.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.aboutScreenContributionsTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (_contributors.isEmpty)
                      Text(
                        l10n.aboutScreenContributionsEmpty,
                        style: textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      )
                    else
                      ...List.generate(_contributors.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Icon(Icons.favorite,
                                  size: 16, color: cs.primary),
                              const SizedBox(width: 8),
                              Text(
                                _contributors[index],
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
