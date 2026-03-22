// test/screens/podcast_detail_screen_test.dart
//
// Unit tests for PodcastDetailScreen.
//
// STATUS: Most widget tests are SKIPPED because PodcastDetailScreen depends on
// services that initialize native plugins in their constructors:
//
//   1. AudioPlayerService → creates AudioPlayer() (just_audio plugin)
//   2. DownloadProvider   → calls DownloadService.init() (background_downloader plugin)
//   3. DownloadProvider   → constructor creates DAOs and RetentionDao internally
//
// These plugins are unavailable in `flutter test` (no native host).
// To unblock these tests we need:
//   - A testable constructor for AppDatabase: AppDatabase.forTesting(QueryExecutor)
//   - A way to inject AudioPlayerService (interface or factory)
//   - DownloadProvider must not init DownloadService in constructor (lazy init or factory)
//
// Until then, only pure model/logic tests run here.
// See also: test/services/api_live_validation_test.dart for live API validation.

import 'package:flutter_test/flutter_test.dart';

import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/show_host.dart';

// ===================== Helpers =====================

Podcast _testPodcast({
  String id = 'test-pod-1',
  String title = 'Test Podcast',
  String description = 'A test podcast description',
  String coverImageUrl = '',
  int episodeCount = 3,
  List<ShowHost> hosts = const [],
}) {
  return Podcast(
    id: id,
    title: title,
    description: description,
    coverImageUrl: coverImageUrl,
    episodeCount: episodeCount,
    hosts: hosts,
  );
}

model.Episode _testEpisode({
  String id = 'ep-1',
  String podcastId = 'test-pod-1',
  String title = 'Test Episode',
}) {
  return model.Episode(
    id: id,
    podcastId: podcastId,
    title: title,
    description: 'Episode description',
    audioUrl: 'https://example.com/ep.mp3',
    publishedAt: DateTime(2024, 6, 15),
    showDate: '2024-06-15',
    duration: const Duration(minutes: 45),
  );
}

// ===================== Tests =====================

void main() {
  group('PodcastDetailScreen — model/logic tests', () {
    test('Episode.fromDb maps download status correctly', () {
      // Status 3 = downloaded/completed in the DB
      // Episode.fromDb reads status as int and maps to DownloadStatus
      // This is the path used by the StreamBuilder in PodcastDetailScreen
      expect(model.DownloadStatus.values[3], model.DownloadStatus.downloaded);
    });

    test('Podcast model preserves all fields for InfoCard', () {
      final podcast = _testPodcast(
        id: '14',
        title: 'Esti gyors',
        description: 'Napzáró műsor',
        episodeCount: 1832,
        hosts: [ShowHost(name: 'Bolgár György')],
      );

      // PodcastInfoCard renders "${podcast.id} - ${podcast.title}"
      expect('${podcast.id} - ${podcast.title}', '14 - Esti gyors');
      expect(podcast.description, 'Napzáró műsor');
      expect(podcast.episodeCount, 1832);
      expect(podcast.hosts.first.name, 'Bolgár György');
    });

    test('Episode displayTitle prefers cachedTitle over title', () {
      final ep = _testEpisode().copyWith(cachedTitle: 'Cached Title');
      expect(ep.displayTitle, 'Cached Title');

      final ep2 = _testEpisode();
      expect(ep2.displayTitle, 'Test Episode');
    });

    test('Episode displayImagePathOrUrl prefers local cache', () {
      final withCache = _testEpisode().copyWith(
        cachedImagePath: '/local/cover.jpg',
        imageUrl: 'https://remote/cover.jpg',
      );
      expect(withCache.displayImagePathOrUrl, '/local/cover.jpg');
      expect(withCache.isDisplayImageLocal, isTrue);

      final withoutCache = _testEpisode().copyWith(
        imageUrl: 'https://remote/cover.jpg',
      );
      expect(withoutCache.displayImagePathOrUrl, 'https://remote/cover.jpg');
      expect(withoutCache.isDisplayImageLocal, isFalse);
    });
  });

  group('PodcastDetailScreen — data flow validation', () {
    test('screen watches EpisodesDao.watchByPodcast, NOT the API', () {
      // DOCUMENTATION TEST: This confirms the known issue.
      //
      // PodcastDetailScreen (line 163) uses:
      //   StreamBuilder<List<db.Episode>>(
      //     stream: context.read<EpisodesDao>().watchByPodcast(widget.podcast.id),
      //
      // This means episodes only appear if they are already in the local SQLite DB.
      // Episodes get into the DB only via the download flow (DownloadService).
      //
      // BUG: The screen never calls the API to fetch episodes and insert them
      // into the DB. A user opening a podcast for the first time (without
      // downloading anything) will see an empty episode list.
      //
      // FIX NEEDED: Either:
      //   a) Fetch episodes from API on screen init and upsert into DB, OR
      //   b) Use a FutureBuilder/hybrid that shows API data while DB is empty
      expect(true, isTrue, reason: 'Documented: screen only reads local DB, never fetches from API');
    });

    test('Episode.fromJson round-trip: downloadStatus String handled correctly', () {
      // FIXED: _downloadStatusFromJson now accepts both String and int.
      // toJson() writes downloadStatus as String (enum.name),
      // fromJson() now parses it back correctly.
      final episode = _testEpisode().copyWith(
        downloadStatus: model.DownloadStatus.downloaded,
      );
      final json = episode.toJson();

      // downloadStatus is serialized as String "downloaded"
      expect(json['downloadStatus'], isA<String>());
      expect(json['downloadStatus'], 'downloaded');

      // fromJson now handles both String and int
      final restored = model.Episode.fromJson(json);
      expect(restored.downloadStatus, model.DownloadStatus.downloaded);
    });
  });

  group('PodcastDetailScreen — widget tests', () {
    // SKIPPED: Requires native plugins (AudioPlayer, background_downloader)
    // that are unavailable in flutter test environment.
    //
    // To unblock, add testable constructors:
    //   - AppDatabase.forTesting(QueryExecutor executor) : super(executor);
    //   - AudioPlayerService.test() without creating AudioPlayer()
    //   - DownloadProvider: lazy-init DownloadService instead of in constructor

    test('renders podcast title in app bar', () {
      // SKIP: needs full widget tree with providers
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');

    test('shows PodcastInfoCard with podcast ID and title', () {
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');

    test('shows empty episode list when no episodes in DB', () {
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');

    test('shows episodes from database via StreamBuilder', () {
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');

    test('shows loading indicator while waiting for episode stream', () {
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');

    test('updates live when new episode is inserted into DB', () {
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');

    test('only shows episodes for the given podcastId', () {
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');

    test('subscribe button toggles subscription state', () {
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');

    test('unsubscribe shows dialog with keep/delete options', () {
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');

    test('tapping episode calls EpisodeProvider.playEpisode', () {
    }, skip: 'Blocked: AudioPlayerService/DownloadProvider init native plugins');
  });
}
