import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:markdown_widget/markdown_widget.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  Future<String> _loadLegal() => rootBundle.loadString('assets/legal/LEGAL.md');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    // Helper for alpha (supports both withValues and withOpacity)
    Color _alpha(Color c, double a) {
      try {
        // ignore: deprecated_member_use
        return c.withValues(alpha: a);
      } catch (_) {
        return c.withOpacity(a);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutScreenLicenseTitle)),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: _loadLegal(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snap.hasData || snap.data!.isEmpty) {
              return Center(
                child: Text(
                  'LEGAL.md not found',
                  style: textTheme.bodyMedium?.copyWith(color: cs.error),
                ),
              );
            }

            // MarkdownWidget handles links; keep layout consistent with our cards
            return Card(
              margin: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: MarkdownWidget(
                  data: snap.data!,
                  config: MarkdownConfig(
                    // TODO MarkdownConfig
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
