import 'package:klubradio_archivum/db/app_database.dart';

enum DownloadListEntryType {
  activeHeader,
  activeItem,
  completedHeader,
  completedItem,
}

class DownloadListEntry {
  const DownloadListEntry.header(this.type) : episode = null;
  const DownloadListEntry.item(this.type, this.episode);

  final DownloadListEntryType type;
  final Episode? episode;
}

List<DownloadListEntry> buildDownloadListEntries({
  required List<Episode> activeItems,
  required List<Episode> completedItems,
}) {
  final entries = <DownloadListEntry>[];

  if (activeItems.isNotEmpty) {
    entries.add(
      const DownloadListEntry.header(DownloadListEntryType.activeHeader),
    );
    entries.addAll(
      activeItems.map(
        (episode) =>
            DownloadListEntry.item(DownloadListEntryType.activeItem, episode),
      ),
    );
  }

  if (completedItems.isNotEmpty) {
    entries.add(
      const DownloadListEntry.header(DownloadListEntryType.completedHeader),
    );
    entries.addAll(
      completedItems.map(
        (episode) => DownloadListEntry.item(
          DownloadListEntryType.completedItem,
          episode,
        ),
      ),
    );
  }

  return entries;
}
