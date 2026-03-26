import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';

/// Shows a confirmation dialog when unsubscribing from a podcast.
///
/// Asks the user whether to keep or delete downloaded episodes.
/// Returns `true` if the user confirmed unsubscription, `false` otherwise.
Future<bool> showUnsubscribeDialog(
  BuildContext context,
  String podcastId,
) async {
  final l10n = AppLocalizations.of(context)!;
  final subscriptionProvider = context.read<SubscriptionProvider>();
  final downloadProvider = context.read<DownloadProvider>();

  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(l10n.unsubscribeDialogTitle),
      content: Text(l10n.unsubscribeDialogContent),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.unsubscribeDialogKeepButton),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.unsubscribeDialogDeleteButton),
        ),
      ],
    ),
  );

  if (result == null) return false;

  if (result) {
    await downloadProvider.deleteEpisodesForPodcast(podcastId);
  }
  await subscriptionProvider.toggleSubscription(podcastId, true);
  return true;
}
