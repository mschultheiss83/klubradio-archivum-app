// test/providers/podcast_provider_search_test.dart
//
// Tests for PodcastProvider search functionality:
//   - searchPodcasts: delegates to ApiService, handles errors, adds to recent
//   - addRecentSearch: dedup, ordering, max limit, empty/whitespace guard
//   - recentSearches: unmodifiable, initial state

import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/profile_provider.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/api_cache_service.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

// ==================== Minimal stubs ====================

/// Stub ApiService where searchPodcasts can be configured per test.
class _StubApiService extends ApiService {
  _StubApiService() : super(cacheService: _StubCacheService());

  Future<List<Podcast>> Function(String)? searchHandler;

  @override
  bool get hasValidCredentials => false; // avoid real HTTP

  @override
  Future<List<Podcast>> searchPodcasts(String query) async {
    if (searchHandler != null) return searchHandler!(query);
    // Default: return mock data filtered by query (same as offline fallback)
    return super.searchPodcasts(query);
  }
}

class _StubCacheService extends ApiCacheService {
  @override
  Future<dynamic> get(String key) async => null;
  @override
  Future<void> save(String key, dynamic data, {Duration? expiry}) async {}
}

/// Stub ProfileProvider that doesn't require ProfileRepository.
class _StubProfileProvider extends ProfileProvider {
  _StubProfileProvider() : super();
}

// ==================== Helpers ====================

Podcast _pod(String id, {String title = ''}) => Podcast(
      id: id,
      title: title.isEmpty ? 'Podcast $id' : title,
      description: '',
      coverImageUrl: '',
      episodeCount: 0,
      hosts: const [],
    );

// ==================== Tests ====================

void main() {
  late _StubApiService apiService;
  late _StubCacheService cacheService;
  late PodcastProvider provider;
  // Track notifyListeners calls
  int notifyCount = 0;

  setUp(() {
    apiService = _StubApiService();
    cacheService = _StubCacheService();
    // PodcastProvider needs a DownloadProvider which requires native plugins.
    // We can't instantiate it. But PodcastProvider only stores the reference
    // and search tests never touch it, so we pass a minimal value.
    // Using a workaround: create PodcastProvider with required deps.
    // DownloadProvider can't be instantiated without DB, so we use a trick:
    // PodcastProvider constructor only assigns fields, no init logic.

    // Since we can't create DownloadProvider without native deps,
    // we test search logic at the unit level by checking ApiService calls
    // and recentSearches directly. PodcastProvider's search methods only
    // use _apiService and _recentSearches.
  });

  group('PodcastProvider.addRecentSearch & recentSearches', () {
    // We need a real PodcastProvider instance. Since DownloadProvider can't
    // be created, let's test the search logic via ApiService.searchPodcasts
    // tests (already covered) and focus on the addRecentSearch logic here.
    //
    // For addRecentSearch testing, we test the actual PodcastProvider behavior
    // using the offline mock path (hasValidCredentials = false).

    late PodcastProvider provider;

    setUp(() {
      apiService = _StubApiService();
      cacheService = _StubCacheService();
      // We need to work around the DownloadProvider dependency.
      // PodcastProvider stores it but search never uses it.
      // Use Dart's noSuchMethod to create a stub.
      provider = PodcastProvider(
        apiService: apiService,
        downloadProvider: _FakeDownloadProvider(),
        profileProvider: _StubProfileProvider(),
        apiCacheService: cacheService,
      );
      notifyCount = 0;
      provider.addListener(() => notifyCount++);
    });

    test('recentSearches is initially empty', () {
      expect(provider.recentSearches, isEmpty);
    });

    test('recentSearches is unmodifiable', () {
      expect(
        () => provider.recentSearches.add('hack'),
        throwsUnsupportedError,
      );
    });

    test('addRecentSearch adds a term and notifies', () {
      provider.addRecentSearch('Klubrádió');
      expect(provider.recentSearches, ['Klubrádió']);
      expect(notifyCount, 1);
    });

    test('addRecentSearch trims whitespace', () {
      provider.addRecentSearch('  lényeg  ');
      // The stored value should be trimmed
      expect(provider.recentSearches.first, 'lényeg');
    });

    test('addRecentSearch ignores empty/whitespace-only input', () {
      provider.addRecentSearch('');
      provider.addRecentSearch('   ');
      provider.addRecentSearch('\t');
      expect(provider.recentSearches, isEmpty);
      expect(notifyCount, 0);
    });

    test('addRecentSearch moves duplicate to front (MRU order)', () {
      provider.addRecentSearch('alpha');
      provider.addRecentSearch('beta');
      provider.addRecentSearch('gamma');
      expect(provider.recentSearches, ['gamma', 'beta', 'alpha']);

      // Re-add 'alpha' — should move to front, not duplicate
      provider.addRecentSearch('alpha');
      expect(provider.recentSearches, ['alpha', 'gamma', 'beta']);
      // No duplicates
      expect(
        provider.recentSearches.where((s) => s == 'alpha').length,
        1,
      );
    });

    test('addRecentSearch respects maxRecentSearches limit', () {
      // Fill to max
      for (int i = 0; i < constants.maxRecentSearches + 5; i++) {
        provider.addRecentSearch('search-$i');
      }
      expect(provider.recentSearches.length, constants.maxRecentSearches);
      // Most recent should be first
      final lastAdded = constants.maxRecentSearches + 5 - 1;
      expect(provider.recentSearches.first, 'search-$lastAdded');
    });

    test('addRecentSearch evicts oldest when exceeding limit', () {
      for (int i = 0; i < constants.maxRecentSearches; i++) {
        provider.addRecentSearch('term-$i');
      }
      // 'term-0' is the oldest
      expect(provider.recentSearches.last, 'term-0');

      // Add one more — 'term-0' should be evicted
      provider.addRecentSearch('new-term');
      expect(provider.recentSearches.first, 'new-term');
      expect(provider.recentSearches.length, constants.maxRecentSearches);
      expect(provider.recentSearches.contains('term-0'), isFalse);
    });

    test('addRecentSearch preserves order for unique terms', () {
      provider.addRecentSearch('one');
      provider.addRecentSearch('two');
      provider.addRecentSearch('three');
      expect(provider.recentSearches, ['three', 'two', 'one']);
    });
  });

  group('PodcastProvider.searchPodcasts', () {
    late PodcastProvider provider;

    setUp(() {
      apiService = _StubApiService();
      cacheService = _StubCacheService();
      provider = PodcastProvider(
        apiService: apiService,
        downloadProvider: _FakeDownloadProvider(),
        profileProvider: _StubProfileProvider(),
        apiCacheService: cacheService,
      );
    });

    test('delegates to ApiService and returns results', () async {
      apiService.searchHandler = (query) async => [
            _pod('3', title: 'A lényeg'),
            _pod('14', title: 'Esti gyors'),
          ];

      final results = await provider.searchPodcasts('lényeg');
      expect(results, hasLength(2));
      expect(results.first.title, 'A lényeg');
    });

    test('adds query to recent searches', () async {
      apiService.searchHandler = (_) async => [];

      await provider.searchPodcasts('test query');
      expect(provider.recentSearches, contains('test query'));
    });

    test('returns empty list on API error (does not throw)', () async {
      apiService.searchHandler = (_) => throw ApiException('Server error');

      final results = await provider.searchPodcasts('failing');
      expect(results, isEmpty);
    });

    test('still adds to recent searches even on error', () async {
      apiService.searchHandler = (_) => throw ApiException('Error');

      await provider.searchPodcasts('error-query');
      expect(provider.recentSearches, contains('error-query'));
    });

    test('uses offline mock data when credentials invalid', () async {
      // _StubApiService has hasValidCredentials = false
      // ApiService.searchPodcasts will filter _mockPodcasts() by query
      final results = await provider.searchPodcasts('esti');
      // 'Esti gyors' is in mock data
      expect(results, isNotEmpty);
      expect(results.first.id, 'esti-gyors');
    });

    test('returns empty for blank query via offline path', () async {
      final results = await provider.searchPodcasts('   ');
      expect(results, isEmpty);
    });
  });
}

/// Fake DownloadProvider that extends it with noSuchMethod to avoid
/// needing real AppDatabase/EpisodeProvider constructors.
class _FakeDownloadProvider extends Fake implements DownloadProvider {}
