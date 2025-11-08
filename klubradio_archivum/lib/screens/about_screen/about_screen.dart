import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:klubradio_archivum/screens/about_screen/legal_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? versionText;

  @override
  void initState() {
    super.initState();
    _loadVersion();
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
                  // open LEGAL.md or a dedicated License screen
                },
              ),
            ),

            const SizedBox(height: 16),

            // Version Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.code_outlined),
                title: Text(l10n.aboutScreenVersionTitle),
                subtitle: Text(versionText ?? '…'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
