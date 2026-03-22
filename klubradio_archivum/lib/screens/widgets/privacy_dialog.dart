import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

/// Shows a dialog with privacy notice and disclaimer text.
///
/// Used in three places:
/// 1. First app start (after install or update) — one-time per version
/// 2. Settings → About → "Datenschutz & Sicherheitshinweis" row
/// 3. About button in AppBar on every tab
Future<void> showPrivacyDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final textTheme = Theme.of(context).textTheme;

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(l10n.privacyDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.privacyNoticeHeadline,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(l10n.privacyNoticeBody, style: textTheme.bodyMedium),
            const SizedBox(height: 20),
            Text(
              l10n.disclaimerHeadline,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(l10n.disclaimerBody, style: textTheme.bodyMedium),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonOk),
        ),
      ],
    ),
  );
}
