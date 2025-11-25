# API Performance Refactoring

**Status:** Planning
**Priority:** High
**Created:** 2025-11-12

## Problem Statement

Database queries via the Supabase API are frequently timing out, impacting app performance and user experience. The current `api_service.dart` is a monolithic 500+ line service that handles all API concerns, making it difficult to maintain and optimize.

### Current Issues

1. **Timeout Problems:**
   - Long timeout (60s) used for: `fetchLatestPodcasts`, `fetchRecommendedPodcasts`, `fetchTopShowsThisYear`, `fetchPodcastById` (lines 68, 154, 316, 343)
   - Standard timeout (20s) still too long for mobile UX
   - No retry logic or fallback strategies

2. **Code Organization:**
   - Single 506-line file handles 5 different concerns (podcasts, episodes, search, user, telemetry)
   - Mixed responsibilities: HTTP client management, caching, mocking, error handling
   - Duplicate patterns across methods (caching logic repeated 10+ times)

3. **Performance:**
   - Every call requires network roundtrip even for mostly static data
   - Cache TTL (3 hours) helps but doesn't solve cold start problem
   - No pre-fetching or bundling of frequently accessed data

## Proposed Solution

### Part 1: Pre-Generate Static Data Bundle

Create a GitHub Action that pre-fetches commonly accessed "static" data into JSON files that ship with the app.

#### Static Data Candidates

Data that rarely changes and can be bundled:
- Latest podcasts (top 50)
- Trending podcasts
- Recommended podcasts
- Top shows this year
- Recent episodes (last 100)
- All podcast metadata (for search indexing)

#### GitHub Action Workflow

```yaml
name: Update Static Data Bundle
on:
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM UTC
  workflow_dispatch:       # Manual trigger

jobs:
  update-data:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: dart-lang/setup-dart@v1
      - name: Install dependencies
        run: |
          cd klubradio_archivum
          flutter pub get
      - name: Run data fetcher script
        env:
          SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
          SUPABASE_KEY: ${{ secrets.SUPABASE_KEY }}
        run: |
          dart run scripts/fetch_static_data.dart
      - name: Commit and push if changed
        run: |
          git config user.name "GitHub Actions"
          git config user.email "actions@github.com"
          git add klubradio_archivum/assets/data/
          git diff --staged --quiet || git commit -m "chore: Update static data bundle"
          git push
```

#### Data Fetcher Script

Create `scripts/fetch_static_data.dart`:
```dart
// Fetch and save to:
// assets/data/latest_podcasts.json
// assets/data/trending_podcasts.json
// assets/data/recommended_podcasts.json
// assets/data/recent_episodes.json
// assets/data/top_shows_this_year.json
// assets/data/all_podcasts_index.json  // For client-side search
```

#### App Changes

1. Add asset declarations in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/data/
```

2. Create `StaticDataService` to load bundled data:
```dart
class StaticDataService {
  Future<List<Podcast>> loadLatestPodcasts() async {
    final json = await rootBundle.loadString('assets/data/latest_podcasts.json');
    // Parse and return
  }
  // Similar methods for other bundles
}
```

3. Modify repositories to use static data first, API as fallback:
```dart
class PodcastRepository {
  Future<List<Podcast>> getLatestPodcasts() async {
    try {
      // Try static bundle first (instant, no network)
      return await _staticDataService.loadLatestPodcasts();
    } catch (e) {
      // Fallback to API if bundle missing/corrupted
      return await _apiService.fetchLatestPodcasts();
    }
  }
}
```

### Part 2: Refactor API Service into Modular Structure

Split `api_service.dart` into smaller, focused API classes following the `podcast_api.dart` pattern.

#### Current Structure

```
lib/services/
  api_service.dart (506 lines)
    - Podcast lists
    - Episodes
    - Search
    - User profiles
    - Telemetry
    - Mocks
    - Error handling
```

#### Proposed Structure

```
lib/api/
  podcast_api.dart (existing - 57 lines)
  episode_api.dart (new)
  search_api.dart (new)
  user_api.dart (new)
  telemetry_api.dart (new)
  top_shows_api.dart (new)

lib/services/
  api_client.dart (new - shared HTTP client + config)
  http_requester.dart (existing)
  api_cache_service.dart (existing)
  static_data_service.dart (new)
```

#### File Breakdown

**lib/api/api_client.dart** (shared configuration):
```dart
class ApiClient {
  static const String supabaseUrl = 'https://...';
  static const String supabaseKey = '...';

  static Map<String, String> get headers => {
    'apikey': supabaseKey,
    'Authorization': 'Bearer $supabaseKey',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static bool get hasValidCredentials =>
    !supabaseUrl.contains('TODO') && !supabaseKey.contains('TODO');
}
```

**lib/api/podcast_api.dart** (already exists - enhance):
- `latest({int limit})`
- `trending({int limit})`
- `recommended({int limit})`
- `byId(String podcastId)`
- `search(String query)`

**lib/api/episode_api.dart** (new):
```dart
class EpisodeApi {
  EpisodeApi({required this.baseUrl, required String apiKey, HttpRequester? requester});

  Future<List<Map<String, dynamic>>> forPodcast(String podcastId, {int limit = 500});
  Future<List<Map<String, dynamic>>> recent({int limit = 8});
}
```

**lib/api/search_api.dart** (new):
```dart
class SearchApi {
  SearchApi({required this.baseUrl, required String apiKey, HttpRequester? requester});

  Future<List<Map<String, dynamic>>> podcasts(String query);
  Future<List<Map<String, dynamic>>> episodes(String query);
  // Future: full-text search across descriptions, hosts, etc.
}
```

**lib/api/top_shows_api.dart** (new):
```dart
class TopShowsApi {
  TopShowsApi({required this.baseUrl, required String apiKey, HttpRequester? requester});

  Future<List<Map<String, dynamic>>> thisYear();
  Future<List<Map<String, dynamic>>> thisMonth();
}
```

**lib/api/user_api.dart** (new):
```dart
class UserApi {
  UserApi({required this.baseUrl, required String apiKey, HttpRequester? requester});

  Future<Map<String, dynamic>?> profile(String userId);
  Future<void> updateProfile(String userId, Map<String, dynamic> data);
}
```

**lib/api/telemetry_api.dart** (new):
```dart
class TelemetryApi {
  TelemetryApi({required this.baseUrl, required String apiKey, HttpRequester? requester});

  Future<void> logPlayback({required String episodeId});
  Future<void> logDownload({required String episodeId});
  Future<void> logSearch({required String query, required int resultCount});
}
```

**lib/services/static_data_service.dart** (new):
```dart
class StaticDataService {
  Future<List<Map<String, dynamic>>> loadLatestPodcasts();
  Future<List<Map<String, dynamic>>> loadTrendingPodcasts();
  Future<List<Map<String, dynamic>>> loadRecommendedPodcasts();
  Future<List<Map<String, dynamic>>> loadRecentEpisodes();
  Future<List<Map<String, dynamic>>> loadTopShows();
  Future<List<Map<String, dynamic>>> loadAllPodcastsIndex();
}
```

#### Migration Strategy

**Phase 1: Extract API Classes (No Breaking Changes)**
1. Create new API classes in `lib/api/`
2. Keep `api_service.dart` as facade that delegates to new classes
3. Update tests to use new classes directly
4. Verify all functionality works

**Phase 2: Update Repositories**
1. Modify `PodcastRepository` to use `PodcastApi` + `StaticDataService`
2. Modify other repositories similarly
3. Add fallback logic (static → API → mock)

**Phase 3: Remove api_service.dart**
1. Update all direct `ApiService` consumers to use specific API classes
2. Delete `api_service.dart`
3. Move mock data to test fixtures

**Phase 4: Implement GitHub Action**
1. Create `scripts/fetch_static_data.dart`
2. Add GitHub Action workflow
3. Run manually first, then schedule daily

## Implementation Checklist

### Part 1: Static Data Bundle
- [ ] Create `lib/services/static_data_service.dart`
- [ ] Create `scripts/fetch_static_data.dart`
- [ ] Add `assets/data/` directory
- [ ] Update `pubspec.yaml` with asset declarations
- [ ] Create GitHub Action workflow `.github/workflows/update-static-data.yml`
- [ ] Test manual workflow run
- [ ] Update repositories to use static data first

### Part 2: API Refactoring
- [ ] Create `lib/api/api_client.dart` (shared config)
- [ ] Enhance existing `lib/api/podcast_api.dart`
- [ ] Create `lib/api/episode_api.dart`
- [ ] Create `lib/api/search_api.dart`
- [ ] Create `lib/api/top_shows_api.dart`
- [ ] Create `lib/api/user_api.dart`
- [ ] Create `lib/api/telemetry_api.dart`
- [ ] Update `api_service.dart` to delegate to new classes (facade pattern)
- [ ] Update tests
- [ ] Update repositories to use new API classes
- [ ] Remove `api_service.dart` facade
- [ ] Move mock data to `test/fixtures/`

### Part 3: Performance Improvements
- [ ] Add client-side search using bundled index (no API call needed)
- [ ] Implement retry logic with exponential backoff
- [ ] Add request deduplication (prevent duplicate concurrent requests)
- [ ] Monitor and log timeout occurrences
- [ ] Consider implementing request prioritization

## Benefits

### Immediate
- **No timeout on app launch**: Latest/trending/recommended podcasts load instantly from bundle
- **Better offline experience**: Core browse functionality works without network
- **Reduced API load**: 70-80% fewer API calls for read-heavy operations

### Long-term
- **Maintainability**: Smaller, focused classes easier to understand and modify
- **Testability**: Mock individual API classes instead of monolithic service
- **Scalability**: Add new endpoints without bloating single file
- **Type safety**: Each API class has specific return types
- **Parallel development**: Multiple developers can work on different API classes

## Risks & Mitigations

### Risk: Stale bundled data
- **Mitigation**: Daily GitHub Action updates + API fallback
- **Mitigation**: Show "last updated" timestamp in UI
- **Mitigation**: Pull-to-refresh always uses live API

### Risk: Larger app size
- **Mitigation**: JSON is highly compressible
- **Mitigation**: Estimate ~500KB for all bundles (acceptable for podcast app)
- **Mitigation**: Consider gzip compression in assets

### Risk: Breaking changes during refactor
- **Mitigation**: Use facade pattern during migration
- **Mitigation**: Comprehensive integration tests
- **Mitigation**: Gradual rollout via feature flags

## Related Files

- `lib/services/api_service.dart` (current monolith - 506 lines)
- `lib/api/podcast_api.dart` (example of target pattern - 57 lines)
- `lib/services/http_requester.dart` (HTTP abstraction)
- `lib/services/api_cache_service.dart` (Hive-based cache)
- `lib/repositories/podcast_repository.dart` (will integrate static data)
- `lib/repositories/profile_repository.dart` (will integrate static data)

## Notes

- The term "scrambler" likely refers to a data scraping/seeding tool that populates the Supabase database
- Consider adding a `flutter run --dart-define SKIP_STATIC_DATA=true` flag for development
- Client-side search can use Fuse.js-style fuzzy matching on bundled index
- For search queries (dynamic), keep using live API but add request debouncing
