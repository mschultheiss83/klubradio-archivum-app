import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/screens/download_manager_screen/download_list_entries.dart';

void main() {
  Episode ep(String id, {required int status}) => Episode(
    id: id,
    podcastId: 'pod-$id',
    title: 'Episode $id',
    audioUrl: 'https://example.com/$id.mp3',
    publishedAt: DateTime(2026, 3, 23),
    durationSeconds: 60,
    description: 'desc',
    showDate: '2026-03-23',
    imageUrl: null,
    status: status,
    progress: status == 3 ? 1 : 0.5,
    localPath: status == 3 ? 'C:/tmp/$id.mp3' : null,
    bytesDownloaded: null,
    totalBytes: null,
    playedAt: null,
    completedAt: status == 3 ? DateTime(2026, 3, 23, 12) : null,
    createdAt: DateTime(2026, 3, 23, 10),
    updatedAt: DateTime(2026, 3, 23, 11),
    cachedTitle: null,
    cachedImagePath: null,
    cachedMetaPath: null,
    resumable: null,
  );

  group('buildDownloadListEntries', () {
    test('creates section headers and items in order', () {
      final entries = buildDownloadListEntries(
        activeItems: [ep('a1', status: 1), ep('a2', status: 2)],
        completedItems: [ep('c1', status: 3)],
      );

      expect(entries.length, 5);
      expect(entries[0].type, DownloadListEntryType.activeHeader);
      expect(entries[1].type, DownloadListEntryType.activeItem);
      expect(entries[1].episode!.id, 'a1');
      expect(entries[2].type, DownloadListEntryType.activeItem);
      expect(entries[3].type, DownloadListEntryType.completedHeader);
      expect(entries[4].type, DownloadListEntryType.completedItem);
      expect(entries[4].episode!.id, 'c1');
    });

    test('omits empty sections', () {
      final entries = buildDownloadListEntries(
        activeItems: const [],
        completedItems: [ep('c1', status: 3)],
      );

      expect(entries.length, 2);
      expect(entries[0].type, DownloadListEntryType.completedHeader);
      expect(entries[1].type, DownloadListEntryType.completedItem);
    });
  });
}
