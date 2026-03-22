import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

void main() {
  // ===================== Helpers =====================
  Episode makeEpisode({
    String id = 'ep-1',
    String podcastId = 'pod-1',
    String title = 'Test Episode',
    String description = 'Desc',
    String audioUrl = 'https://example.com/ep.mp3',
    DateTime? publishedAt,
    String showDate = '2024-06-15',
    Duration duration = const Duration(minutes: 30),
    String? imageUrl,
    List<String> hosts = const [],
    bool isFavourite = false,
    DownloadStatus downloadStatus = DownloadStatus.notDownloaded,
    double downloadProgress = 0,
    String? localFilePath,
    String? cachedTitle,
    String? cachedImagePath,
    String? cachedMetaPath,
  }) {
    return Episode(
      id: id,
      podcastId: podcastId,
      title: title,
      description: description,
      audioUrl: audioUrl,
      publishedAt: publishedAt ?? DateTime(2024, 6, 15),
      showDate: showDate,
      duration: duration,
      imageUrl: imageUrl,
      hosts: hosts,
      isFavourite: isFavourite,
      downloadStatus: downloadStatus,
      downloadProgress: downloadProgress,
      localFilePath: localFilePath,
      cachedTitle: cachedTitle,
      cachedImagePath: cachedImagePath,
      cachedMetaPath: cachedMetaPath,
    );
  }

  // ===================== fromJson =====================
  group('Episode.fromJson', () {
    test('parses minimal required fields', () {
      final ep = Episode.fromJson({
        'id': '123',
        'podcastId': 'p1',
        'title': 'Hello',
        'audioUrl': 'https://a.mp3',
      });

      expect(ep.id, '123');
      expect(ep.podcastId, 'p1');
      expect(ep.title, 'Hello');
      expect(ep.audioUrl, 'https://a.mp3');
      expect(ep.description, '');
      expect(ep.showDate, '');
      expect(ep.duration, Duration.zero);
      expect(ep.hosts, isEmpty);
      expect(ep.isFavourite, isFalse);
      expect(ep.downloadStatus, DownloadStatus.notDownloaded);
      expect(ep.downloadProgress, 0);
      expect(ep.imageUrl, isNull);
      expect(ep.localFilePath, isNull);
    });

    test('converts numeric id and podcastId to String', () {
      final ep = Episode.fromJson({
        'id': 42,
        'podcastId': 99,
        'title': 'Numeric',
        'audioUrl': 'u',
      });
      expect(ep.id, '42');
      expect(ep.podcastId, '99');
    });

    test('parses duration as int (seconds)', () {
      final ep = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'duration': 7200,
      });
      expect(ep.duration, const Duration(hours: 2));
    });

    test('parses duration as HH:MM:SS string', () {
      final ep = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'duration': '01:30:45',
      });
      expect(ep.duration, const Duration(hours: 1, minutes: 30, seconds: 45));
    });

    test('parses duration as MM:SS string', () {
      final ep = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'duration': '45:30',
      });
      expect(ep.duration, const Duration(minutes: 45, seconds: 30));
    });

    test('parses duration as plain seconds string', () {
      final ep = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'duration': '120',
      });
      expect(ep.duration, const Duration(seconds: 120));
    });

    test('handles null and missing duration', () {
      final ep1 = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'duration': null,
      });
      final ep2 = Episode.fromJson({
        'id': '2', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
      });
      expect(ep1.duration, Duration.zero);
      expect(ep2.duration, Duration.zero);
    });

    test('handles empty duration string', () {
      final ep = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'duration': '',
      });
      expect(ep.duration, Duration.zero);
    });

    test('parses hosts as list of strings', () {
      final ep = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'hosts': ['Host A', 'Host B'],
      });
      expect(ep.hosts, ['Host A', 'Host B']);
    });

    test('handles non-list hosts gracefully', () {
      final ep = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'hosts': 'not a list',
      });
      expect(ep.hosts, isEmpty);
    });

    test('replaces problematic imageUrl with podcast cover', () {
      final ep = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'imageUrl': constants.problematicEpisodeImageUrl,
      }, podcastCoverImageUrl: 'https://cover.jpg');
      expect(ep.imageUrl, 'https://cover.jpg');
    });

    test('replaces problematic imageUrl with default when no cover provided', () {
      final ep = Episode.fromJson({
        'id': '1', 'podcastId': 'p', 'title': 'T', 'audioUrl': 'u',
        'imageUrl': constants.problematicEpisodeImageUrl,
      });
      expect(ep.imageUrl, constants.defaultEpisodeImageUrl);
    });

    test('parses all optional fields', () {
      final ep = Episode.fromJson({
        'id': '1',
        'podcastId': 'p',
        'title': 'Full',
        'audioUrl': 'u',
        'description': 'desc',
        'publishedAt': '2024-06-15T10:00:00Z',
        'showDate': '2024-06-15',
        'isFavourite': true,
        'downloadProgress': 0.75,
        'localFilePath': '/local/file.mp3',
        'cachedTitle': 'Cached',
        'cachedImagePath': '/cache/img.jpg',
        'cachedMetaPath': '/cache/meta.json',
      });
      expect(ep.description, 'desc');
      expect(ep.showDate, '2024-06-15');
      expect(ep.isFavourite, isTrue);
      expect(ep.downloadProgress, 0.75);
      expect(ep.localFilePath, '/local/file.mp3');
      expect(ep.cachedTitle, 'Cached');
      expect(ep.cachedImagePath, '/cache/img.jpg');
      expect(ep.cachedMetaPath, '/cache/meta.json');
    });
  });

  // ===================== toJson =====================
  group('Episode.toJson', () {
    test('serializes all fields', () {
      final ep = makeEpisode(
        id: 'x1',
        podcastId: 'px',
        title: 'Title',
        description: 'Desc',
        audioUrl: 'https://audio.mp3',
        publishedAt: DateTime.utc(2024, 6, 15, 10),
        showDate: '2024-06-15',
        duration: const Duration(minutes: 45, seconds: 30),
        imageUrl: 'https://img.jpg',
        hosts: ['H1'],
        isFavourite: true,
        downloadStatus: DownloadStatus.downloaded,
        downloadProgress: 1.0,
        localFilePath: '/path.mp3',
        cachedTitle: 'CT',
        cachedImagePath: '/ci.jpg',
        cachedMetaPath: '/cm.json',
      );
      final json = ep.toJson();

      expect(json['id'], 'x1');
      expect(json['podcastId'], 'px');
      expect(json['title'], 'Title');
      expect(json['description'], 'Desc');
      expect(json['audioUrl'], 'https://audio.mp3');
      expect(json['publishedAt'], '2024-06-15T10:00:00.000Z');
      expect(json['showDate'], '2024-06-15');
      expect(json['duration'], 2730); // 45*60 + 30
      expect(json['imageUrl'], 'https://img.jpg');
      expect(json['hosts'], ['H1']);
      expect(json['isFavourite'], isTrue);
      expect(json['downloadStatus'], 'downloaded');
      expect(json['downloadProgress'], 1.0);
      expect(json['localFilePath'], '/path.mp3');
      expect(json['cachedTitle'], 'CT');
      expect(json['cachedImagePath'], '/ci.jpg');
      expect(json['cachedMetaPath'], '/cm.json');
    });

    test('duration serializes as seconds integer', () {
      final json = makeEpisode(duration: const Duration(hours: 1, minutes: 5)).toJson();
      expect(json['duration'], 3900);
    });

    test('downloadStatus serializes as enum name string', () {
      for (final status in DownloadStatus.values) {
        final json = makeEpisode(downloadStatus: status).toJson();
        expect(json['downloadStatus'], status.name);
      }
    });
  });

  // ===================== copyWith =====================
  group('Episode.copyWith', () {
    test('copies with overridden fields', () {
      final original = makeEpisode(title: 'Original', isFavourite: false);
      final copied = original.copyWith(title: 'Changed', isFavourite: true);

      expect(copied.title, 'Changed');
      expect(copied.isFavourite, isTrue);
      expect(copied.id, original.id); // unchanged
      expect(copied.podcastId, original.podcastId);
      expect(copied.audioUrl, original.audioUrl);
    });

    test('returns new instance with same values when no overrides', () {
      final original = makeEpisode();
      final copied = original.copyWith();

      expect(copied.id, original.id);
      expect(copied.title, original.title);
      expect(copied.duration, original.duration);
    });
  });

  // ===================== Display helpers =====================
  group('Episode display helpers', () {
    test('displayTitle prefers cachedTitle when non-empty', () {
      final ep = makeEpisode(title: 'Remote', cachedTitle: 'Cached');
      expect(ep.displayTitle, 'Cached');
    });

    test('displayTitle falls back to title when cachedTitle is null', () {
      final ep = makeEpisode(title: 'Remote');
      expect(ep.displayTitle, 'Remote');
    });

    test('displayTitle falls back to title when cachedTitle is empty', () {
      final ep = makeEpisode(title: 'Remote', cachedTitle: '');
      expect(ep.displayTitle, 'Remote');
    });

    test('displayImagePathOrUrl prefers cachedImagePath', () {
      final ep = makeEpisode(
        imageUrl: 'https://remote.jpg',
        cachedImagePath: '/local/cover.jpg',
      );
      expect(ep.displayImagePathOrUrl, '/local/cover.jpg');
      expect(ep.isDisplayImageLocal, isTrue);
    });

    test('displayImagePathOrUrl falls back to imageUrl', () {
      final ep = makeEpisode(imageUrl: 'https://remote.jpg');
      expect(ep.displayImagePathOrUrl, 'https://remote.jpg');
      expect(ep.isDisplayImageLocal, isFalse);
    });

    test('displayImagePathOrUrl returns null when both absent', () {
      final ep = makeEpisode();
      expect(ep.displayImagePathOrUrl, isNull);
      expect(ep.isDisplayImageLocal, isFalse);
    });

    test('hasCachedImage is true only when cachedImagePath is non-empty', () {
      expect(makeEpisode(cachedImagePath: '/img.jpg').hasCachedImage, isTrue);
      expect(makeEpisode(cachedImagePath: '').hasCachedImage, isFalse);
      expect(makeEpisode().hasCachedImage, isFalse);
    });
  });

  // ===================== DownloadStatus =====================
  group('DownloadStatus', () {
    test('has 6 values', () {
      expect(DownloadStatus.values.length, 6);
    });

    test('index mapping matches DB convention', () {
      expect(DownloadStatus.notDownloaded.index, 0);
      expect(DownloadStatus.queued.index, 1);
      expect(DownloadStatus.downloading.index, 2);
      expect(DownloadStatus.downloaded.index, 3);
      expect(DownloadStatus.failed.index, 4);
      expect(DownloadStatus.canceled.index, 5);
    });
  });

  // ===================== toString =====================
  group('Episode.toString', () {
    test('returns valid JSON string', () {
      final ep = makeEpisode();
      final str = ep.toString();
      expect(str, isNotEmpty);
      expect(str, contains('"id"'));
      expect(str, contains('"title"'));
    });
  });
}
