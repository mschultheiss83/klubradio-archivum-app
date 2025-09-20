import 'package:intl/intl.dart';

import '../../models/episode.dart';

String formatDate(DateTime dateTime, {String locale = 'hu'}) {
  final DateFormat formatter = DateFormat.yMMMMEEEEd(locale).add_Hm();
  return formatter.format(dateTime.toLocal());
}

String formatDuration(Duration duration) {
  final int hours = duration.inHours;
  final int minutes = duration.inMinutes.remainder(60);
  final int seconds = duration.inSeconds.remainder(60);
  if (hours > 0) {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

String formatDownloadStatus(DownloadStatus status) {
  switch (status) {
    case DownloadStatus.notDownloaded:
      return 'Nincs letöltve';
    case DownloadStatus.queued:
      return 'Sorban';
    case DownloadStatus.downloading:
      return 'Letöltés alatt';
    case DownloadStatus.downloaded:
      return 'Kész';
    case DownloadStatus.failed:
      return 'Hiba történt';
  }
}

String formatProgress(double progress) {
  final int percentage = (progress * 100).clamp(0, 100).round();
  return '$percentage%';
}
