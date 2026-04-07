import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/utils/episode_cache_reader.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('episode_cache_test_');
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  /// Helper: write JSON content to a file in [tempDir] and return the path.
  String writeJsonFile(String filename, dynamic content) {
    final path = p.join(tempDir.path, filename);
    File(path).writeAsStringSync(jsonEncode(content));
    return path;
  }

  /// Minimal valid JSON map that the reader accepts.
  Map<String, dynamic> validMinimalJson() {
    return {
      'schemaVersion': 1,
      'id': 'ep-100',
      'podcastId': 'pod-42',
      'title': '',
      'description': '',
      'audioUrl': '',
      'publishedAt': '2025-03-01T10:00:00.000Z',
      'duration': 0,
      'showDate': '',
      'hosts': <String>[],
    };
  }

  /// Full valid JSON with all optional fields populated.
  Map<String, dynamic> validCompleteJson({
    String? cachedImageFile,
    String? mp3File,
  }) {
    return {
      'schemaVersion': 1,
      'id': 'ep-200',
      'podcastId': 'pod-77',
      'title': 'Reggeli Gyors',
      'description': 'A test episode description.',
      'audioUrl': 'https://cdn.klubradio.hu/audio/ep200.mp3',
      'imageUrl': 'https://www.klubradio.hu/img/cover.jpg',
      'publishedAt': '2025-06-15T08:00:00.000Z',
      'duration': 1800,
      'showDate': '2025-06-15',
      'hosts': ['Host A', 'Host B'],
      'cachedImageFile': ?cachedImageFile,
      'mp3File': ?mp3File,
    };
  }

  // -------------------------------------------------------------------
  // Tests
  // -------------------------------------------------------------------

  group('readEpisodeFromCacheJson', () {
    test('returns null for non-existent file', () async {
      final result = await readEpisodeFromCacheJson(
        p.join(tempDir.path, 'does_not_exist.json'),
      );
      expect(result, isNull);
    });

    test('returns null for invalid JSON content', () async {
      final path = writeJsonFile('bad.json', null);
      // Overwrite with truly invalid JSON text
      File(path).writeAsStringSync('{{not valid json');
      final result = await readEpisodeFromCacheJson(path);
      expect(result, isNull);
    });

    test('returns null when JSON is a list instead of a map', () async {
      final path = p.join(tempDir.path, 'array.json');
      File(path).writeAsStringSync(jsonEncode([1, 2, 3]));
      final result = await readEpisodeFromCacheJson(path);
      expect(result, isNull);
    });

    test('returns null when id is empty', () async {
      final json = validMinimalJson()..['id'] = '';
      final path = writeJsonFile('empty_id.json', json);
      final result = await readEpisodeFromCacheJson(path);
      expect(result, isNull);
    });

    test('returns null when podcastId is empty', () async {
      final json = validMinimalJson()..['podcastId'] = '';
      final path = writeJsonFile('empty_podcast.json', json);
      final result = await readEpisodeFromCacheJson(path);
      expect(result, isNull);
    });

    test('parses valid complete JSON into Episode', () async {
      final json = validCompleteJson();
      final path = writeJsonFile('complete.json', json);
      final episode = await readEpisodeFromCacheJson(path);

      expect(episode, isNotNull);
      expect(episode!.id, 'ep-200');
      expect(episode.podcastId, 'pod-77');
      expect(episode.title, 'Reggeli Gyors');
      expect(episode.description, 'A test episode description.');
      expect(episode.audioUrl, 'https://cdn.klubradio.hu/audio/ep200.mp3');
      expect(episode.imageUrl, 'https://www.klubradio.hu/img/cover.jpg');
      expect(episode.publishedAt, DateTime.utc(2025, 6, 15, 8));
      expect(episode.duration, const Duration(seconds: 1800));
      expect(episode.showDate, '2025-06-15');
      expect(episode.hosts, ['Host A', 'Host B']);
      expect(episode.cachedMetaPath, path);
    });

    test('parses minimal JSON with only required fields', () async {
      final json = validMinimalJson();
      final path = writeJsonFile('minimal.json', json);
      final episode = await readEpisodeFromCacheJson(path);

      expect(episode, isNotNull);
      expect(episode!.id, 'ep-100');
      expect(episode.podcastId, 'pod-42');
      expect(episode.title, '');
      expect(episode.description, '');
      expect(episode.audioUrl, '');
      expect(episode.duration, Duration.zero);
    });

    test('handles missing optional fields gracefully', () async {
      // Only id, podcastId, and a publishedAt -- everything else missing
      final json = <String, dynamic>{
        'id': 'ep-300',
        'podcastId': 'pod-99',
        'publishedAt': '2025-01-01T00:00:00.000Z',
      };
      final path = writeJsonFile('sparse.json', json);
      final episode = await readEpisodeFromCacheJson(path);

      expect(episode, isNotNull);
      expect(episode!.id, 'ep-300');
      expect(episode.podcastId, 'pod-99');
      expect(episode.title, '');
      expect(episode.description, '');
      expect(episode.audioUrl, '');
      expect(episode.hosts, isEmpty);
      expect(episode.showDate, '');
      expect(episode.localFilePath, isNull);
      expect(episode.cachedImagePath, isNull);
    });

    test('resolves relative image path to absolute when file exists', () async {
      // Create the image file so the existsSync check passes
      final imageFileName = 'ep-200_cover.jpg';
      File(p.join(tempDir.path, imageFileName)).writeAsBytesSync([0xFF, 0xD8]);

      final json = validCompleteJson(cachedImageFile: imageFileName);
      final path = writeJsonFile('with_image.json', json);
      final episode = await readEpisodeFromCacheJson(path);

      expect(episode, isNotNull);
      expect(episode!.cachedImagePath, isNotNull);
      expect(episode.cachedImagePath, p.join(tempDir.path, imageFileName));
    });

    test('resolves relative mp3 path to absolute when file exists', () async {
      // Create the mp3 file so the existsSync check passes
      final mp3FileName = 'ep-200.mp3';
      File(p.join(tempDir.path, mp3FileName)).writeAsBytesSync([0x00]);

      final json = validCompleteJson(mp3File: mp3FileName);
      final path = writeJsonFile('with_mp3.json', json);
      final episode = await readEpisodeFromCacheJson(path);

      expect(episode, isNotNull);
      expect(episode!.localFilePath, isNotNull);
      expect(episode.localFilePath, p.join(tempDir.path, mp3FileName));
    });

    test('sets localFilePath to null when mp3 file does not exist', () async {
      // Reference a file that does not exist on disk
      final json = validCompleteJson(mp3File: 'missing.mp3');
      final path = writeJsonFile('missing_mp3.json', json);
      final episode = await readEpisodeFromCacheJson(path);

      expect(episode, isNotNull);
      expect(episode!.localFilePath, isNull);
    });

    test(
      'sets cachedImagePath to null when image file does not exist',
      () async {
        final json = validCompleteJson(cachedImageFile: 'missing_cover.jpg');
        final path = writeJsonFile('missing_img.json', json);
        final episode = await readEpisodeFromCacheJson(path);

        expect(episode, isNotNull);
        expect(episode!.cachedImagePath, isNull);
      },
    );

    test('falls back to createdAt when publishedAt is missing', () async {
      final json = validMinimalJson()
        ..remove('publishedAt')
        ..['createdAt'] = '2024-12-25T12:00:00.000Z';
      final path = writeJsonFile('created_at.json', json);
      final episode = await readEpisodeFromCacheJson(path);

      expect(episode, isNotNull);
      expect(episode!.publishedAt, DateTime.utc(2024, 12, 25, 12));
    });

    test('tolerates schemaVersion 0 (old format)', () async {
      final json = validMinimalJson()..['schemaVersion'] = 0;
      final path = writeJsonFile('old_schema.json', json);
      final episode = await readEpisodeFromCacheJson(path);

      expect(episode, isNotNull);
      expect(episode!.id, 'ep-100');
    });
  });
}
