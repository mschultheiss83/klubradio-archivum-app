import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart';

String formatDate(DateTime dateTime, {String locale = 'hu'}) {
  final DateFormat formatter = DateFormat.yMMMMEEEEd(locale).add_Hm();
  return formatter.format(dateTime.toLocal());
}

String formatDurationPrecise(Duration duration) {
  final int hours = duration.inHours;
  final int minutes = duration.inMinutes.remainder(60);
  final int seconds = duration.inSeconds.remainder(60);
  if (hours > 0) {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

String formatDuration(BuildContext context, Duration duration) {
  final l10n = AppLocalizations.of(context)!;
  final int hours = duration.inHours;
  final int minutes = duration.inMinutes.remainder(60);

  if (duration.inMinutes < 1) {
    return l10n.durationInMinutes(1);
  }

  if (hours > 0) {
    return l10n.durationInHoursAndMinutes(hours, minutes);
  }

  return l10n.durationInMinutes(minutes);
}

String formatDownloadStatus(BuildContext context, DownloadStatus status) {
  final l10n = AppLocalizations.of(context)!;
  switch (status) {
    case DownloadStatus.downloading:
      return l10n.downloadStatusDownloading;
    case DownloadStatus.downloaded:
      return l10n.downloadStatusDownloaded;
    case DownloadStatus.failed:
      return l10n.downloadStatusFailed;
    case DownloadStatus.notDownloaded:
      return l10n.downloadStatusNotDownloaded;
    case DownloadStatus.queued:
      return l10n.downloadStatusQueued;
    case DownloadStatus.canceled:
      return 'Canceled'; // Placeholder until localization is added
  }
}

String formatProgress(double progress) {
  final int percentage = (progress * 100).clamp(0, 100).round();
  return '$percentage%';
}

// Hilfsfunktion (kannst du in einen Utils-Helper auslagern)
String displayTitleFor(Episode e) =>
    (e.cachedTitle?.isNotEmpty ?? false) ? e.cachedTitle! : e.title;
