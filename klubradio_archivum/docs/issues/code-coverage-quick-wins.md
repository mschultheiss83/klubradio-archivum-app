# Code Coverage Quick Wins

**Current overall coverage**: 26.9% (1112/4129 lines)
**Date**: 2026-03-29
**Goal**: Identify low-effort, high-impact test additions to raise coverage significantly.

Each quick-win below is ordered by effort (lowest first). Estimated gains assume the overall denominator stays at 4129 lines.

---

## 1. Web Image Proxy (`lib/utils/web_image_proxy.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | 0% |
| Uncovered lines | 13 |
| Effort | Very low (10 min) |
| Coverage gain | +0.3% (13 lines) |

### Methods to test

- `WebImageProxy.transform(null)` -- returns `''`
- `WebImageProxy.transform('')` -- returns `''`
- `WebImageProxy.transform(validNonKlubradioUrl)` -- returns original (non-web)
- `WebImageProxy.transform(klubradioUrl)` -- returns original on non-web platform

Since `kIsWeb` is a compile-time constant that is `false` in tests, we can only test the non-web branch. The private `_isKlubradioImage` and `_proxyViaSupabase` methods are exercised indirectly through `transform`.

### Test file: `test/utils/web_image_proxy_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/utils/web_image_proxy.dart';

void main() {
  group('WebImageProxy.transform (non-web platform)', () {
    test('returns empty string for null input', () {
      expect(WebImageProxy.transform(null), '');
    });

    test('returns empty string for empty input', () {
      expect(WebImageProxy.transform(''), '');
    });

    test('returns original URL for non-klubradio host', () {
      const url = 'https://example.com/image.jpg';
      expect(WebImageProxy.transform(url), url);
    });

    test('returns original URL for klubradio.hu on non-web', () {
      const url = 'https://www.klubradio.hu/data/musorkepek/foo.jpeg';
      // kIsWeb is false in unit tests, so URL is returned unchanged
      expect(WebImageProxy.transform(url), url);
    });

    test('returns original URL for cdn.klubradio.hu on non-web', () {
      const url = 'https://cdn.klubradio.hu/covers/show.jpg';
      expect(WebImageProxy.transform(url), url);
    });

    test('returns original URL for invalid URI', () {
      const url = 'not a valid url at all :::';
      // Uri.tryParse returns null for some malformed URIs, but Dart is lenient
      // Test that it does not throw
      expect(() => WebImageProxy.transform(url), returnsNormally);
    });
  });
}
```

### Dependencies to mock

None -- pure static method with no external dependencies.

---

## 2. Profile Repository (`lib/repositories/profile_repository.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | 0% |
| Uncovered lines | 13 |
| Effort | Low (20 min) |
| Coverage gain | +0.3% (13 lines) |

### Methods to test

- `load()` -- no saved profile returns `UserProfile.initial(...)` and saves it
- `load()` -- valid JSON string returns parsed profile
- `load()` -- corrupted JSON falls back to `UserProfile.initial(...)` and re-saves
- `save()` -- stores JSON in SharedPreferences

### Challenge

`ProfileRepository.load()` calls `AppIdentity.getAppId()` which uses `PackageInfo.fromPlatform()` and `DeviceInfoPlugin()`. These fail in test environments. Two approaches:

**Approach A**: Make `ProfileRepository` accept an injectable ID generator (cleanest, requires small refactor).

**Approach B**: Test `save()` and `load()` round-trip by pre-populating SharedPreferences so the `raw != null` branch is taken, bypassing `AppIdentity`.

### Test file: `test/repositories/profile_repository_test.dart`

```dart
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/repositories/profile_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProfileRepository repo;

  setUp(() {
    repo = ProfileRepository();
  });

  group('ProfileRepository', () {
    test('save then load round-trip preserves profile', () async {
      SharedPreferences.setMockInitialValues({});

      final profile = UserProfile(
        id: 'test-id-42',
        languageCode: 'en',
        playbackSpeed: 1.5,
        autoDownloadEpisodeCount: 3,
        subscribedPodcastIds: {'pod-1', 'pod-2'},
        favouriteEpisodeIds: {'ep-5'},
        recentlyPlayed: const [],
      );

      await repo.save(profile);
      // Now load should return the saved profile (not call AppIdentity)
      final loaded = await repo.load();
      expect(loaded.id, 'test-id-42');
      expect(loaded.languageCode, 'en');
      expect(loaded.playbackSpeed, 1.5);
      expect(loaded.autoDownloadEpisodeCount, 3);
      expect(loaded.subscribedPodcastIds, contains('pod-1'));
    });

    test('load with pre-populated valid JSON returns parsed profile', () async {
      final profile = UserProfile.initial('pre-existing-id');
      SharedPreferences.setMockInitialValues({
        'user_profile.json': jsonEncode(profile.toJson()),
      });

      final loaded = await repo.load();
      expect(loaded.id, 'pre-existing-id');
    });

    test('load with corrupted JSON returns fresh profile', () async {
      // This branch calls AppIdentity.getAppId() which may fail in tests.
      // Skip if platform plugins are unavailable, or mock at a higher level.
      SharedPreferences.setMockInitialValues({
        'user_profile.json': 'NOT VALID JSON {{{{',
      });

      // This will throw because AppIdentity uses platform plugins.
      // Mark as skip until AppIdentity is refactored to be injectable.
    }, skip: 'Requires AppIdentity mock -- see device_id refactoring');
  });
}
```

---

## 3. API Cache Service (`lib/services/api_cache_service.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | ~28% (approx 19/69 lines via indirect use) |
| Uncovered lines | ~21 direct method lines |
| Effort | Low (20 min) |
| Coverage gain | +0.5% (~21 lines) |

### Methods to test

- `save()` -- stores data with expiry and timestamp
- `get()` -- returns data when cache is valid
- `get()` -- returns null for missing key
- `get()` -- returns null and removes entry when expired
- `remove()` -- removes cached key
- `isCached()` -- returns true/false correctly
- `isExpired()` -- returns true for missing key
- `isExpired()` -- returns true for expired entry
- `isExpired()` -- returns false for valid entry
- `isExpired()` -- returns false for entry with no expiry (`-1`)

### Test file: `test/services/api_cache_service_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:klubradio_archivum/services/api_cache_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ApiCacheService cache;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    cache = ApiCacheService();
  });

  group('ApiCacheService', () {
    test('save and get round-trip returns stored data', () async {
      await cache.save('key1', {'name': 'test'});
      final result = await cache.get('key1');
      expect(result, isA<Map>());
      expect(result['name'], 'test');
    });

    test('get returns null for missing key', () async {
      final result = await cache.get('nonexistent');
      expect(result, isNull);
    });

    test('get returns null for expired entry and removes it', () async {
      // Save with a very short (already-past) expiry
      await cache.save('expiring', 'data',
          expiry: const Duration(milliseconds: -1));
      // Entry was saved with timestamp in the past
      final result = await cache.get('expiring');
      expect(result, isNull);

      // Verify it was removed
      final stillCached = await cache.isCached('expiring');
      expect(stillCached, isFalse);
    });

    test('save with no expiry keeps data indefinitely', () async {
      await cache.save('forever', [1, 2, 3]);
      final result = await cache.get('forever');
      expect(result, [1, 2, 3]);
    });

    test('save with future expiry returns data before expiry', () async {
      await cache.save('valid', 'hello', expiry: const Duration(hours: 1));
      final result = await cache.get('valid');
      expect(result, 'hello');
    });

    test('remove deletes cached entry', () async {
      await cache.save('removable', 'data');
      await cache.remove('removable');
      final result = await cache.get('removable');
      expect(result, isNull);
    });

    test('isCached returns true for existing key', () async {
      await cache.save('exists', 42);
      expect(await cache.isCached('exists'), isTrue);
    });

    test('isCached returns false for missing key', () async {
      expect(await cache.isCached('missing'), isFalse);
    });

    test('isExpired returns true for missing key', () async {
      expect(await cache.isExpired('missing'), isTrue);
    });

    test('isExpired returns false for non-expiring entry', () async {
      await cache.save('noExpiry', 'data'); // no expiry param
      expect(await cache.isExpired('noExpiry'), isFalse);
    });

    test('isExpired returns false for entry with future expiry', () async {
      await cache.save('future', 'data', expiry: const Duration(hours: 1));
      expect(await cache.isExpired('future'), isFalse);
    });

    test('isExpired returns true for expired entry', () async {
      await cache.save('past', 'data',
          expiry: const Duration(milliseconds: -1));
      expect(await cache.isExpired('past'), isTrue);
    });

    test('save overwrites existing entry', () async {
      await cache.save('key', 'first');
      await cache.save('key', 'second');
      final result = await cache.get('key');
      expect(result, 'second');
    });
  });
}
```

### Dependencies to mock

`SharedPreferences` -- use `SharedPreferences.setMockInitialValues({})` (built-in mock support, no additional packages needed).

---

## 4. Device ID Utility (`lib/utils/device_id.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | 0% |
| Uncovered lines | 28 |
| Effort | Medium (30 min) |
| Coverage gain | +0.7% (28 lines) |

### Methods to test

- `getAppId()` -- generates and persists a UUID-based ID
- `getAppId()` -- returns same ID on second call (persistence)
- `_osTag()` -- returns platform-specific tag

### Challenge

`PackageInfo.fromPlatform()` and `DeviceInfoPlugin()` are platform-channel plugins that do not work in pure unit tests. You need to either:

1. **Refactor** `AppIdentity` to accept injected dependencies (recommended)
2. **Use method channel mocks** for `package_info_plus` and `device_info_plus`

### Recommended refactoring

```dart
// Refactored signature to accept injectable deps:
class AppIdentity {
  static const _kAnonId = 'anon.genId';

  static Future<String> getAppId({
    Future<SharedPreferences> Function()? prefsFactory,
    Future<PackageInfo> Function()? pkgFactory,
    Future<String> Function()? osTagFactory,
  }) async {
    final prefs = await (prefsFactory ?? SharedPreferences.getInstance)();
    // ... rest uses injected factories
  }
}
```

### Test file: `test/utils/device_id_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// NOTE: This test requires the refactoring above, or method channel mocks.
// Below shows the method channel mock approach for package_info_plus:

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppIdentity', () {
    test('getAppId generates and persists ID', () async {
      // To test without refactoring, mock the method channels:
      // 1. PackageInfo: TestDefaultBinaryMessengerBinding
      //    .instance.defaultBinaryMessenger
      //    .setMockMethodCallHandler(channel, handler)
      // 2. DeviceInfo: similar mock
      //
      // This is fragile. Prefer the refactoring approach above.
    }, skip: 'Requires platform plugin mocks or refactoring');
  });
}
```

### Practical alternative (no refactor)

Test only the SharedPreferences persistence logic by pre-seeding `anon.genId` and verifying it is reused:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getAppId reuses persisted genId', () async {
    SharedPreferences.setMockInitialValues({'anon.genId': 'abc12345'});
    // Still fails on PackageInfo.fromPlatform() without channel mock
    // Mark skip until refactored
  }, skip: 'PackageInfo.fromPlatform requires platform channel');
}
```

---

## 5. Episode Cache Reader (`lib/utils/episode_cache_reader.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | 0% |
| Uncovered lines | 45 |
| Effort | Medium (30 min) |
| Coverage gain | +1.1% (45 lines) |

### Methods to test

- `readEpisodeFromCacheJson(path)` -- returns null for nonexistent file
- `readEpisodeFromCacheJson(path)` -- returns null for invalid JSON
- `readEpisodeFromCacheJson(path)` -- returns null when `id` or `podcastId` is empty
- `readEpisodeFromCacheJson(path)` -- parses valid JSON into Episode
- `readEpisodeFromCacheJson(path)` -- resolves relative image/mp3 paths to absolute

### Test file: `test/utils/episode_cache_reader_test.dart`

```dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/utils/episode_cache_reader.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('cache_reader_test_');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  test('returns null for nonexistent file', () async {
    final result = await readEpisodeFromCacheJson('/nonexistent/path.json');
    expect(result, isNull);
  });

  test('returns null for non-JSON content', () async {
    final file = File('${tempDir.path}/bad.json');
    file.writeAsStringSync('NOT JSON AT ALL');
    final result = await readEpisodeFromCacheJson(file.path);
    expect(result, isNull);
  });

  test('returns null for JSON array (not map)', () async {
    final file = File('${tempDir.path}/array.json');
    file.writeAsStringSync('[1, 2, 3]');
    final result = await readEpisodeFromCacheJson(file.path);
    expect(result, isNull);
  });

  test('returns null when id is empty', () async {
    final file = File('${tempDir.path}/noid.json');
    file.writeAsStringSync(jsonEncode({
      'id': '',
      'podcastId': 'pod-1',
      'schemaVersion': 1,
    }));
    final result = await readEpisodeFromCacheJson(file.path);
    expect(result, isNull);
  });

  test('returns null when podcastId is empty', () async {
    final file = File('${tempDir.path}/nopod.json');
    file.writeAsStringSync(jsonEncode({
      'id': 'ep-1',
      'podcastId': '',
      'schemaVersion': 1,
    }));
    final result = await readEpisodeFromCacheJson(file.path);
    expect(result, isNull);
  });

  test('parses valid minimal JSON into Episode', () async {
    final file = File('${tempDir.path}/valid.json');
    file.writeAsStringSync(jsonEncode({
      'schemaVersion': 1,
      'id': 'ep-42',
      'podcastId': 'pod-7',
      'title': 'Test Episode',
      'description': 'A test',
      'audioUrl': 'https://example.com/audio.mp3',
      'publishedAt': '2025-06-15T10:00:00.000Z',
      'duration': 3600,
      'showDate': '2025-06-15',
      'hosts': ['Host A', 'Host B'],
      'imageUrl': 'https://example.com/cover.jpg',
    }));

    final ep = await readEpisodeFromCacheJson(file.path);
    expect(ep, isNotNull);
    expect(ep!.id, 'ep-42');
    expect(ep.podcastId, 'pod-7');
    expect(ep.title, 'Test Episode');
    expect(ep.duration, const Duration(seconds: 3600));
    expect(ep.hosts, ['Host A', 'Host B']);
    expect(ep.cachedMetaPath, file.path);
    // No local mp3/image files exist, so paths should be null
    expect(ep.localFilePath, isNull);
    expect(ep.cachedImagePath, isNull);
  });

  test('resolves relative mp3 and image paths when files exist', () async {
    // Create actual files so existsSync() returns true
    final mp3 = File('${tempDir.path}/audio.mp3');
    mp3.writeAsStringSync('fake mp3');
    final img = File('${tempDir.path}/cover.jpg');
    img.writeAsStringSync('fake jpg');

    final metaFile = File('${tempDir.path}/meta.json');
    metaFile.writeAsStringSync(jsonEncode({
      'schemaVersion': 1,
      'id': 'ep-99',
      'podcastId': 'pod-5',
      'title': 'With Files',
      'audioUrl': 'https://example.com/audio.mp3',
      'mp3File': 'audio.mp3',
      'cachedImageFile': 'cover.jpg',
      'imageUrl': 'https://example.com/cover.jpg',
    }));

    final ep = await readEpisodeFromCacheJson(metaFile.path);
    expect(ep, isNotNull);
    expect(ep!.localFilePath, endsWith('audio.mp3'));
    expect(ep.cachedImagePath, endsWith('cover.jpg'));
  });

  test('handles missing optional fields gracefully', () async {
    final file = File('${tempDir.path}/minimal.json');
    file.writeAsStringSync(jsonEncode({
      'id': 'ep-min',
      'podcastId': 'pod-min',
      // No title, description, audioUrl, duration, etc.
    }));

    final ep = await readEpisodeFromCacheJson(file.path);
    expect(ep, isNotNull);
    expect(ep!.title, '');
    expect(ep.description, '');
    expect(ep.audioUrl, '');
    expect(ep.duration, Duration.zero);
    expect(ep.hosts, isEmpty);
  });

  test('publishedAt falls back to createdAt', () async {
    final file = File('${tempDir.path}/fallback_date.json');
    file.writeAsStringSync(jsonEncode({
      'id': 'ep-date',
      'podcastId': 'pod-date',
      'createdAt': '2024-01-15T08:00:00.000Z',
      // No publishedAt
    }));

    final ep = await readEpisodeFromCacheJson(file.path);
    expect(ep, isNotNull);
    expect(ep!.publishedAt.year, 2024);
    expect(ep.publishedAt.month, 1);
    expect(ep.publishedAt.day, 15);
  });
}
```

### Dependencies to mock

None -- uses real temp files. Clean up via `tearDown`.

---

## 6. HTTP Requester (`lib/services/http_requester.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | 0% |
| Uncovered lines | 28 |
| Effort | Medium (30 min) |
| Coverage gain | +0.7% (28 lines) |

### Methods to test

- `getJson()` -- successful 200 response returns parsed JSON
- `getJson()` -- merges `defaultHeaders` and per-call `headers`
- `getJson()` -- retries on `TimeoutException` up to `maxRetries`
- `getJson()` -- retries on `SocketException` up to `maxRetries`
- `getJson()` -- retries on HTTP 5xx errors
- `getJson()` -- does NOT retry on HTTP 4xx errors (throws immediately)
- `getJson()` -- throws after exhausting retries
- `dispose()` -- closes the underlying client

### Test file: `test/services/http_requester_test.dart`

```dart
import 'dart:async';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:klubradio_archivum/services/http_requester.dart';

void main() {
  group('HttpRequester.getJson', () {
    test('returns parsed JSON on 200 response', () async {
      final client = MockClient((_) async => http.Response(
            '{"key": "value"}',
            200,
            headers: {'content-type': 'application/json'},
          ));

      final requester = HttpRequester(
        client: client,
        defaultHeaders: {'X-Test': 'true'},
      );

      final result = await requester.getJson('https://example.com/data');
      expect(result, isA<Map>());
      expect(result['key'], 'value');
    });

    test('merges default and per-call headers', () async {
      late Map<String, String> capturedHeaders;

      final client = MockClient((request) async {
        capturedHeaders = request.headers;
        return http.Response('{}', 200);
      });

      final requester = HttpRequester(
        client: client,
        defaultHeaders: {'Authorization': 'Bearer token'},
      );

      await requester.getJson(
        'https://example.com/data',
        headers: {'X-Custom': 'yes'},
      );

      expect(capturedHeaders['Authorization'], 'Bearer token');
      expect(capturedHeaders['X-Custom'], 'yes');
    });

    test('throws HttpException on 4xx without retry', () async {
      int callCount = 0;
      final client = MockClient((_) async {
        callCount++;
        return http.Response('Not found', 404);
      });

      final requester = HttpRequester(
        client: client,
        defaultHeaders: {},
        maxRetries: 2,
        connectTimeout: const Duration(seconds: 1),
        requestTimeout: const Duration(seconds: 1),
      );

      expect(
        () => requester.getJson('https://example.com/missing'),
        throwsA(isA<HttpException>()),
      );
      // Should NOT retry on 4xx -- only 1 attempt
      // (callCount checked after the future completes)
    });

    test('retries on 5xx up to maxRetries then throws', () async {
      int callCount = 0;
      final client = MockClient((_) async {
        callCount++;
        return http.Response('Server error', 500);
      });

      final requester = HttpRequester(
        client: client,
        defaultHeaders: {},
        maxRetries: 2,
        connectTimeout: const Duration(seconds: 1),
        requestTimeout: const Duration(seconds: 5),
      );

      await expectLater(
        () => requester.getJson('https://example.com/fail'),
        throwsA(isA<HttpException>()),
      );
      // 1 initial + 2 retries = 3 total attempts
      expect(callCount, 3);
    });

    test('retries on SocketException then succeeds', () async {
      int callCount = 0;
      final client = MockClient((_) async {
        callCount++;
        if (callCount < 2) {
          throw const SocketException('Connection refused');
        }
        return http.Response('{"ok": true}', 200);
      });

      final requester = HttpRequester(
        client: client,
        defaultHeaders: {},
        maxRetries: 3,
        connectTimeout: const Duration(seconds: 1),
        requestTimeout: const Duration(seconds: 5),
      );

      final result = await requester.getJson('https://example.com/retry');
      expect(result['ok'], true);
      expect(callCount, 2);
    });

    test('retries on timeout then succeeds', () async {
      int callCount = 0;
      final client = MockClient((_) async {
        callCount++;
        if (callCount < 2) {
          // Simulate timeout by delaying longer than requestTimeout
          await Future.delayed(const Duration(seconds: 10));
        }
        return http.Response('{"done": true}', 200);
      });

      final requester = HttpRequester(
        client: client,
        defaultHeaders: {},
        maxRetries: 3,
        connectTimeout: const Duration(seconds: 1),
        requestTimeout: const Duration(milliseconds: 50), // very short
      );

      final result = await requester.getJson('https://example.com/slow');
      expect(result['done'], true);
    });
  });
}
```

### Dependencies to mock

`http.Client` -- use `MockClient` from `package:http/testing.dart` (already a project dependency).

---

## 7. Profile Provider (`lib/providers/profile_provider.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | 4.1% (2/49 lines) |
| Uncovered lines | 47 |
| Effort | Medium (30 min) |
| Coverage gain | +1.1% (47 lines) |

### Methods to test

- `load()` -- sets `_profile` from repo, toggles `_loading`, notifies listeners
- `setLanguage()` -- updates language, saves, notifies
- `setPlaybackSpeed()` -- updates speed, saves, notifies
- `setAutoDownloadEpisodeCount()` -- updates count, saves, notifies
- `toggleFavouriteEpisode()` -- adds/removes from set, saves, notifies
- `setSubscriptions()` -- replaces subscription set, saves, notifies
- `addRecentlyPlayed()` -- inserts at front, deduplicates, caps at `maxRecentlyPlayed`
- All mutators return early if `_profile` is null (no-op guard)

### Test file: `test/providers/profile_provider_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/providers/profile_provider.dart';
import 'package:klubradio_archivum/repositories/profile_repository.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// Fake ProfileRepository that stores profile in memory (no SharedPreferences).
class FakeProfileRepository extends ProfileRepository {
  UserProfile? _stored;

  FakeProfileRepository([this._stored]);

  @override
  Future<UserProfile> load() async {
    return _stored ?? UserProfile.initial('test-device-id');
  }

  @override
  Future<void> save(UserProfile profile) async {
    _stored = profile;
  }
}

Episode _makeEpisode(String id) => Episode(
      id: id,
      podcastId: 'pod-1',
      title: 'Episode $id',
      description: '',
      audioUrl: 'https://example.com/$id.mp3',
      publishedAt: DateTime(2025, 1, 1),
      showDate: '2025-01-01',
      duration: const Duration(minutes: 30),
    );

void main() {
  late FakeProfileRepository repo;
  late ProfileProvider provider;
  int notifyCount = 0;

  setUp(() {
    repo = FakeProfileRepository();
    provider = ProfileProvider(repo: repo);
    notifyCount = 0;
    provider.addListener(() => notifyCount++);
  });

  group('ProfileProvider', () {
    test('load() sets profile and notifies twice (loading true, loading false)', () async {
      expect(provider.profileOrNull, isNull);
      expect(provider.loading, isFalse);

      await provider.load();

      expect(provider.profileOrNull, isNotNull);
      expect(provider.loading, isFalse);
      expect(notifyCount, 2); // loading=true, loading=false
    });

    test('setLanguage updates language and persists', () async {
      await provider.load();
      notifyCount = 0;

      await provider.setLanguage('hu');

      expect(provider.profileOrNull!.languageCode, 'hu');
      expect(notifyCount, 1);
      expect(repo._stored!.languageCode, 'hu');
    });

    test('setPlaybackSpeed updates speed and persists', () async {
      await provider.load();
      notifyCount = 0;

      await provider.setPlaybackSpeed(1.5);

      expect(provider.profileOrNull!.playbackSpeed, 1.5);
      expect(notifyCount, 1);
      expect(repo._stored!.playbackSpeed, 1.5);
    });

    test('setAutoDownloadEpisodeCount updates count', () async {
      await provider.load();
      await provider.setAutoDownloadEpisodeCount(5);
      expect(provider.profileOrNull!.autoDownloadEpisodeCount, 5);
    });

    test('toggleFavouriteEpisode adds then removes', () async {
      await provider.load();

      await provider.toggleFavouriteEpisode('ep-1');
      expect(provider.profileOrNull!.favouriteEpisodeIds, contains('ep-1'));

      await provider.toggleFavouriteEpisode('ep-1');
      expect(provider.profileOrNull!.favouriteEpisodeIds, isNot(contains('ep-1')));
    });

    test('setSubscriptions replaces subscription set', () async {
      await provider.load();
      await provider.setSubscriptions({'pod-a', 'pod-b'});
      expect(provider.profileOrNull!.subscribedPodcastIds, {'pod-a', 'pod-b'});
    });

    test('addRecentlyPlayed inserts at front and deduplicates', () async {
      await provider.load();

      await provider.addRecentlyPlayed(_makeEpisode('ep-1'));
      await provider.addRecentlyPlayed(_makeEpisode('ep-2'));
      await provider.addRecentlyPlayed(_makeEpisode('ep-1')); // duplicate

      final recent = provider.profileOrNull!.recentlyPlayed;
      expect(recent.length, 2);
      expect(recent.first.id, 'ep-1'); // moved to front
      expect(recent.last.id, 'ep-2');
    });

    test('addRecentlyPlayed caps at maxRecentlyPlayed', () async {
      await provider.load();

      for (int i = 0; i < constants.maxRecentlyPlayed + 5; i++) {
        await provider.addRecentlyPlayed(_makeEpisode('ep-$i'));
      }

      expect(
        provider.profileOrNull!.recentlyPlayed.length,
        constants.maxRecentlyPlayed,
      );
    });

    test('mutators are no-ops when profile is null', () async {
      // Do NOT call load() -- profile stays null
      await provider.setLanguage('en');
      await provider.setPlaybackSpeed(2.0);
      await provider.toggleFavouriteEpisode('ep-1');
      expect(notifyCount, 0); // no notifications because profile is null
    });
  });
}
```

### Dependencies to mock

`ProfileRepository` -- use `FakeProfileRepository` (in-memory fake, shown above). No platform plugins needed.

---

## 8. Download Provider (`lib/providers/download_provider.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | 0% |
| Uncovered lines | 70 |
| Effort | High (45 min) |
| Coverage gain | +1.7% (70 lines) |

### Methods to test

- `enqueue()` -- delegates to `DownloadService.enqueueEpisode()`, notifies
- `pause()` / `resume()` / `cancel()` -- delegate and notify
- `removeLocalFile()` -- delegates and notifies
- `deleteEpisodesForPodcast()` -- delegates and notifies
- `autoEnqueueLatestN()` -- skips completed/queued/running episodes, upserts new ones
- All methods return early when `_isDownloadsSupported` is false (web platform)

### Challenge

`DownloadProvider` constructor creates a real `DownloadService` which depends on `background_downloader` (native plugin). The constructor checks `PlatformUtils.supportsDownloads`.

**Best approach**: Use Mockito `@GenerateMocks` for `DownloadService` and construct `DownloadProvider` via a test-only factory, or test methods by directly setting `_service` via the setter.

### Test file: `test/providers/download_provider_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/services/download_service.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';

import 'download_provider_test.mocks.dart';

@GenerateMocks([DownloadService, EpisodesDao])
void main() {
  // NOTE: DownloadProvider's constructor calls PlatformUtils.supportsDownloads
  // and creates DownloadService internally. For unit testing, we cannot use
  // the normal constructor. Instead, test the autoEnqueueLatestN logic
  // and the web-guard behavior.
  //
  // The approach below uses Fake to bypass constructor dependencies.

  group('DownloadProvider web guard', () {
    test('all methods are no-ops when downloads not supported', () async {
      // On web, _isDownloadsSupported = false, all methods return immediately
      final provider = _WebDownloadProvider();
      final ep = _makeEpisode('ep-1');

      // None of these should throw
      await provider.enqueue(ep);
      await provider.pause('ep-1');
      await provider.resume('ep-1');
      await provider.cancel('ep-1');
      await provider.removeLocalFile('ep-1');
      await provider.deleteEpisodesForPodcast('pod-1');
      final count = await provider.autodownloadPodcast('pod-1');
      expect(count, 0);
    });
  });
}

model.Episode _makeEpisode(String id) => model.Episode(
      id: id,
      podcastId: 'pod-1',
      title: 'Episode $id',
      description: '',
      audioUrl: 'https://example.com/$id.mp3',
      publishedAt: DateTime(2025, 1, 1),
      showDate: '2025-01-01',
      duration: const Duration(minutes: 30),
    );

/// A DownloadProvider subclass that simulates web platform (downloads not supported).
/// Bypasses the constructor's DownloadService initialization.
class _WebDownloadProvider extends DownloadProvider {
  _WebDownloadProvider()
      : super(
          db: AppDatabase.forTesting(NativeDatabase.memory()),
          episodeProvider: _FakeEpisodeProvider(),
          apiService: ApiService(),
        );

  // Override to simulate web (downloads not supported)
  // The actual _isDownloadsSupported is set in constructor based on PlatformUtils
  // Since we run on desktop in tests, we need a different approach.
  // Use Fake instead.
}

class _FakeEpisodeProvider extends Fake implements EpisodeProvider {}
```

**Note**: Full unit testing of `DownloadProvider` is difficult because the constructor eagerly creates `DownloadService` with native plugin dependencies. The best ROI is to:
1. Test the web-guard paths (all methods return early)
2. Test `autoEnqueueLatestN` logic in isolation using a Drift in-memory DB (test the DAO operations it performs)

---

## 9. Podcast Provider (`lib/providers/podcast_provider.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | 11.9% (existing search tests cover ~35 of 297 lines) |
| Uncovered lines | ~262 |
| Effort | Medium-High (45 min for partial coverage) |
| Coverage gain | +2-3% (80-120 additional lines feasible) |

### Methods to test (beyond existing search tests)

- `loadInitialData()` -- calls API in parallel, sets state, handles errors
- `loadUserProfile()` -- fetches profile, stores it, notifies
- `downloadEpisode()` -- delegates to `_downloadProvider.enqueue()`
- `removeDownload()` -- delegates to `_downloadProvider.removeLocalFile()`
- `fetchEpisodesForPodcast()` -- caches results, returns cached on re-call
- `toggleFavourite()` -- toggles episode in `_userProfile.favouriteEpisodeIds`
- `updateAutoDownloadCount()` -- updates profile field
- `fetchPodcastById()` -- delegates to API, returns null on error
- `loadTopShows()` -- fetches top shows, handles errors
- `subscribedPodcasts` getter -- filters `_podcasts` by subscribed IDs

### Test file: `test/providers/podcast_provider_test.dart`

Extend the existing stubs from `podcast_provider_search_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/show_data.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/profile_provider.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/api_cache_service.dart';

// ==================== Stubs ====================

class _StubCacheService extends ApiCacheService {
  @override
  Future<dynamic> get(String key) async => null;
  @override
  Future<void> save(String key, dynamic data, {Duration? expiry}) async {}
}

class _StubApiService extends ApiService {
  _StubApiService() : super(cacheService: _StubCacheService());

  List<Podcast> latestResult = [];
  List<Podcast> trendingResult = [];
  List<Episode> recentResult = [];
  List<ShowData> topShowsResult = [];
  Map<String, List<Episode>> episodesByPodcast = {};
  UserProfile? profileResult;
  Podcast? podcastByIdResult;

  bool fetchLatestCalled = false;
  bool fetchTrendingCalled = false;
  bool fetchRecentCalled = false;

  @override
  bool get hasValidCredentials => true;

  @override
  Future<List<Podcast>> fetchLatestPodcasts({int limit = 10}) async {
    fetchLatestCalled = true;
    return latestResult;
  }

  @override
  Future<List<Podcast>> fetchTrendingPodcasts() async {
    fetchTrendingCalled = true;
    return trendingResult;
  }

  @override
  Future<List<Episode>> fetchRecentEpisodes() async {
    fetchRecentCalled = true;
    return recentResult;
  }

  @override
  Future<List<ShowData>> fetchTopShowsThisYear() async => topShowsResult;

  @override
  Future<List<Episode>> fetchEpisodesForPodcast(String podcastId) async {
    return episodesByPodcast[podcastId] ?? [];
  }

  @override
  Future<UserProfile> fetchUserProfile(String userId) async {
    if (profileResult != null) return profileResult!;
    throw ApiException('No profile');
  }

  @override
  Future<Podcast?> fetchPodcastById(String podcastId) async {
    return podcastByIdResult;
  }
}

class _FakeDownloadProvider extends Fake implements DownloadProvider {
  int enqueueCount = 0;
  int removeCount = 0;

  @override
  Future<void> enqueue(Episode ep) async => enqueueCount++;

  @override
  Future<void> removeLocalFile(String episodeId) async => removeCount++;
}

class _StubProfileProvider extends ProfileProvider {
  _StubProfileProvider() : super();
}

Podcast _pod(String id, {String title = ''}) => Podcast(
      id: id,
      title: title.isEmpty ? 'Podcast $id' : title,
      description: '',
      coverImageUrl: '',
      episodeCount: 0,
      hosts: const [],
    );

Episode _ep(String id, {String podcastId = 'pod-1'}) => Episode(
      id: id,
      podcastId: podcastId,
      title: 'Episode $id',
      description: '',
      audioUrl: 'https://example.com/$id.mp3',
      publishedAt: DateTime(2025, 1, 1),
      showDate: '2025-01-01',
      duration: const Duration(minutes: 30),
    );

// ==================== Tests ====================

void main() {
  late _StubApiService apiService;
  late _FakeDownloadProvider downloadProvider;
  late PodcastProvider provider;

  setUp(() {
    apiService = _StubApiService();
    downloadProvider = _FakeDownloadProvider();
    provider = PodcastProvider(
      apiService: apiService,
      downloadProvider: downloadProvider,
      profileProvider: _StubProfileProvider(),
      apiCacheService: _StubCacheService(),
    );
  });

  group('loadInitialData', () {
    test('fetches all data sources in parallel', () async {
      apiService.latestResult = [_pod('p1')];
      apiService.trendingResult = [_pod('t1')];
      apiService.recentResult = [_ep('e1')];

      await provider.loadInitialData();

      expect(provider.podcasts, hasLength(1));
      expect(provider.trendingPodcasts, hasLength(1));
      expect(provider.recentEpisodes, hasLength(1));
      expect(provider.isLoading, isFalse);
      expect(provider.errorMessage, isNull);
    });

    test('skips when already loading (unless forceRefresh)', () async {
      // loadInitialData sets _isLoading=true at start; a second call
      // should be skipped. We test by checking API was called only once.
      apiService.latestResult = [_pod('p1')];
      apiService.trendingResult = [];
      apiService.recentResult = [];

      // First call
      final f1 = provider.loadInitialData();
      // Second concurrent call -- should be skipped
      final f2 = provider.loadInitialData();
      await Future.wait([f1, f2]);

      expect(apiService.fetchLatestCalled, isTrue);
    });

    test('handles API errors without crashing', () async {
      apiService.latestResult = []; // will succeed
      // Override trending to throw
      final badApi = _ThrowingApiService();
      provider.updateDependencies(
        badApi,
        downloadProvider,
        _StubProfileProvider(),
        _StubCacheService(),
      );

      await provider.loadInitialData();
      // Should not throw; errorMessage may or may not be set
      expect(provider.isLoading, isFalse);
    });
  });

  group('fetchEpisodesForPodcast', () {
    test('fetches and caches episodes', () async {
      apiService.episodesByPodcast = {
        'pod-1': [_ep('e1'), _ep('e2')],
      };

      final first = await provider.fetchEpisodesForPodcast('pod-1');
      expect(first, hasLength(2));

      // Second call should return cached (not hit API again)
      apiService.episodesByPodcast = {}; // clear API data
      final second = await provider.fetchEpisodesForPodcast('pod-1');
      expect(second, hasLength(2)); // still cached
    });
  });

  group('downloadEpisode', () {
    test('delegates to DownloadProvider.enqueue', () async {
      await provider.downloadEpisode(_ep('e1'));
      expect(downloadProvider.enqueueCount, 1);
    });
  });

  group('removeDownload', () {
    test('delegates to DownloadProvider.removeLocalFile', () async {
      await provider.removeDownload('e1');
      expect(downloadProvider.removeCount, 1);
    });
  });

  group('toggleFavourite', () {
    test('toggles episode in favourites set', () async {
      // Need a userProfile first
      provider.loadUserProfile(); // will fail, set profile manually
      // Use reflection-free approach: set profile via loadUserProfile
      apiService.profileResult = UserProfile.initial('test-id');
      await provider.loadUserProfile();

      final ep = _ep('fav-1');
      provider.toggleFavourite(ep);
      expect(provider.userProfile!.favouriteEpisodeIds, contains('fav-1'));

      provider.toggleFavourite(ep);
      expect(provider.userProfile!.favouriteEpisodeIds, isNot(contains('fav-1')));
    });
  });

  group('updateAutoDownloadCount', () {
    test('updates userProfile field', () async {
      apiService.profileResult = UserProfile.initial('test-id');
      await provider.loadUserProfile();

      provider.updateAutoDownloadCount(10);
      expect(provider.userProfile!.autoDownloadEpisodeCount, 10);
    });
  });

  group('subscribedPodcasts', () {
    test('returns empty when no profile', () {
      expect(provider.subscribedPodcasts, isEmpty);
    });

    test('filters podcasts by subscribed IDs', () async {
      apiService.profileResult = UserProfile(
        id: 'test',
        languageCode: 'en',
        playbackSpeed: 1.0,
        autoDownloadEpisodeCount: 2,
        subscribedPodcastIds: {'p2'},
        favouriteEpisodeIds: {},
        recentlyPlayed: [],
      );
      await provider.loadUserProfile();

      apiService.latestResult = [_pod('p1'), _pod('p2'), _pod('p3')];
      await provider.loadInitialData();

      expect(provider.subscribedPodcasts, hasLength(1));
      expect(provider.subscribedPodcasts.first.id, 'p2');
    });
  });
}

class _ThrowingApiService extends _StubApiService {
  @override
  Future<List<Podcast>> fetchLatestPodcasts({int limit = 10}) =>
      throw Exception('Network error');

  @override
  Future<List<Podcast>> fetchTrendingPodcasts() =>
      throw Exception('Network error');

  @override
  Future<List<Episode>> fetchRecentEpisodes() =>
      throw Exception('Network error');

  @override
  Future<List<ShowData>> fetchTopShowsThisYear() =>
      throw Exception('Network error');
}
```

---

## 10. Database DAOs (`lib/db/daos.dart`)

| Metric | Value |
|--------|-------|
| Current coverage | 26.8% (465/1736 lines, but most is generated code) |
| Uncovered lines in `daos.dart` | ~127 (hand-written DAO logic) |
| Effort | Medium-High (45 min) |
| Coverage gain | +3.1% (127 lines) |

### Methods to test

**SubscriptionsDao**:
- `upsert()`, `getById()`, `isSubscribed()`
- `toggleSubscribe()` -- insert new, toggle existing
- `setAutoDownloadN()` -- null normalization
- `setLastHeard()`, `setLastDownloaded()`

**EpisodesDao**:
- `upsert()`, `upsertAll()`, `getById()`
- `latestForPodcast()` -- ordering and limit
- Status lifecycle: `setQueued()`, `setDownloading()`, `setProgress()`, `setCompleted()`, `setFailed()`, `setCanceled()`
- `markPlayed()`, `clearLocalFile()`, `setCachedMeta()`
- `completedWithFileDesc()`, `playedBefore()` -- retention queries
- `enqueueLatestN()` -- only queues eligible statuses

**RetentionDao**:
- `computePlanForPodcast()` -- combines deleteAfterHours + keepLatestN rules

### Test file: `test/db/daos_test.dart`

The project already uses `AppDatabase.forTesting(NativeDatabase.memory())` in `settings_dao_test.dart`. Follow that pattern.

```dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  // ==================== SubscriptionsDao ====================

  group('SubscriptionsDao', () {
    late SubscriptionsDao dao;

    setUp(() => dao = SubscriptionsDao(db));

    test('getById returns null for nonexistent podcast', () async {
      expect(await dao.getById('nonexistent'), isNull);
    });

    test('upsert + getById round-trip', () async {
      await dao.upsert(SubscriptionsCompanion.insert(
        podcastId: 'pod-1',
        active: const Value(true),
      ));
      final sub = await dao.getById('pod-1');
      expect(sub, isNotNull);
      expect(sub!.podcastId, 'pod-1');
      expect(sub.active, isTrue);
    });

    test('isSubscribed returns true for active subscription', () async {
      await dao.upsert(SubscriptionsCompanion.insert(
        podcastId: 'pod-1',
        active: const Value(true),
      ));
      expect(await dao.isSubscribed('pod-1'), isTrue);
    });

    test('isSubscribed returns false for inactive subscription', () async {
      await dao.upsert(SubscriptionsCompanion.insert(
        podcastId: 'pod-1',
        active: const Value(false),
      ));
      expect(await dao.isSubscribed('pod-1'), isFalse);
    });

    test('isSubscribed returns false for missing podcast', () async {
      expect(await dao.isSubscribed('missing'), isFalse);
    });

    test('toggleSubscribe creates new subscription', () async {
      await dao.toggleSubscribe(podcastId: 'pod-new');
      final sub = await dao.getById('pod-new');
      expect(sub, isNotNull);
      expect(sub!.active, isTrue);
    });

    test('toggleSubscribe toggles existing subscription', () async {
      await dao.toggleSubscribe(podcastId: 'pod-1');
      expect((await dao.getById('pod-1'))!.active, isTrue);

      await dao.toggleSubscribe(podcastId: 'pod-1');
      expect((await dao.getById('pod-1'))!.active, isFalse);
    });

    test('toggleSubscribe with explicit active=false', () async {
      await dao.toggleSubscribe(podcastId: 'pod-1', active: false);
      expect((await dao.getById('pod-1'))!.active, isFalse);
    });

    test('toggleSubscribe with autoDownloadN', () async {
      await dao.toggleSubscribe(podcastId: 'pod-1', autoDownloadN: 5);
      final sub = await dao.getById('pod-1');
      expect(sub!.autoDownloadN, 5);
    });

    test('setAutoDownloadN normalizes negative to null', () async {
      await dao.upsert(SubscriptionsCompanion.insert(podcastId: 'pod-1'));
      await dao.setAutoDownloadN('pod-1', -1);
      final sub = await dao.getById('pod-1');
      expect(sub!.autoDownloadN, isNull);
    });

    test('setLastHeard updates field', () async {
      await dao.upsert(SubscriptionsCompanion.insert(podcastId: 'pod-1'));
      await dao.setLastHeard('pod-1', 'ep-5');
      final sub = await dao.getById('pod-1');
      expect(sub!.lastHeardEpisodeId, 'ep-5');
    });

    test('setLastDownloaded updates field', () async {
      await dao.upsert(SubscriptionsCompanion.insert(podcastId: 'pod-1'));
      await dao.setLastDownloaded('pod-1', 'ep-10');
      final sub = await dao.getById('pod-1');
      expect(sub!.lastDownloadedEpisodeId, 'ep-10');
    });
  });

  // ==================== EpisodesDao ====================

  group('EpisodesDao', () {
    late EpisodesDao dao;

    setUp(() => dao = EpisodesDao(db));

    EpisodesCompanion _makeEp(String id, {
      String podcastId = 'pod-1',
      DateTime? publishedAt,
      int status = 0,
    }) => EpisodesCompanion(
          id: Value(id),
          podcastId: Value(podcastId),
          title: Value('Episode $id'),
          audioUrl: Value('https://example.com/$id.mp3'),
          publishedAt: Value(publishedAt ?? DateTime(2025, 1, 1)),
          status: Value(status),
        );

    test('upsert + getById round-trip', () async {
      await dao.upsert(_makeEp('ep-1'));
      final ep = await dao.getById('ep-1');
      expect(ep, isNotNull);
      expect(ep!.id, 'ep-1');
      expect(ep.title, 'Episode ep-1');
    });

    test('upsertAll inserts multiple episodes', () async {
      await dao.upsertAll([_makeEp('ep-1'), _makeEp('ep-2'), _makeEp('ep-3')]);
      expect(await dao.getById('ep-1'), isNotNull);
      expect(await dao.getById('ep-2'), isNotNull);
      expect(await dao.getById('ep-3'), isNotNull);
    });

    test('latestForPodcast returns N newest by publishedAt', () async {
      await dao.upsert(_makeEp('old', publishedAt: DateTime(2024, 1, 1)));
      await dao.upsert(_makeEp('mid', publishedAt: DateTime(2025, 6, 1)));
      await dao.upsert(_makeEp('new', publishedAt: DateTime(2025, 12, 1)));

      final latest = await dao.latestForPodcast('pod-1', 2);
      expect(latest, hasLength(2));
      expect(latest.first.id, 'new');
      expect(latest.last.id, 'mid');
    });

    test('status lifecycle: queued -> downloading -> completed', () async {
      await dao.upsert(_makeEp('ep-1'));

      await dao.setQueued('ep-1');
      expect((await dao.getById('ep-1'))!.status, 1);

      await dao.setDownloading('ep-1', progress: 0.5, bytes: 500, total: 1000);
      var ep = await dao.getById('ep-1');
      expect(ep!.status, 2);
      expect(ep.progress, 0.5);
      expect(ep.bytesDownloaded, 500);

      await dao.setCompleted('ep-1', '/path/to/file.mp3',
          bytes: 1000, total: 1000);
      ep = await dao.getById('ep-1');
      expect(ep!.status, 3);
      expect(ep.progress, 1.0);
      expect(ep.localPath, '/path/to/file.mp3');
      expect(ep.completedAt, isNotNull);
    });

    test('setFailed sets status to 4', () async {
      await dao.upsert(_makeEp('ep-1'));
      await dao.setFailed('ep-1');
      expect((await dao.getById('ep-1'))!.status, 4);
    });

    test('setCanceled sets status to 5', () async {
      await dao.upsert(_makeEp('ep-1'));
      await dao.setCanceled('ep-1');
      expect((await dao.getById('ep-1'))!.status, 5);
    });

    test('markPlayed sets playedAt', () async {
      await dao.upsert(_makeEp('ep-1'));
      await dao.markPlayed('ep-1');
      final ep = await dao.getById('ep-1');
      expect(ep!.playedAt, isNotNull);
    });

    test('clearLocalFile resets path fields and status', () async {
      await dao.upsert(_makeEp('ep-1'));
      await dao.setCompleted('ep-1', '/file.mp3');
      await dao.setCachedMeta('ep-1',
          metaPath: '/meta.json', imagePath: '/cover.jpg');

      await dao.clearLocalFile('ep-1');
      final ep = await dao.getById('ep-1');
      expect(ep!.localPath, isNull);
      expect(ep.cachedMetaPath, isNull);
      expect(ep.cachedImagePath, isNull);
      expect(ep.status, 0);
    });

    test('setCachedMeta updates cached fields', () async {
      await dao.upsert(_makeEp('ep-1'));
      await dao.setCachedMeta('ep-1',
          title: 'Cached Title',
          imagePath: '/img.jpg',
          metaPath: '/meta.json');

      final ep = await dao.getById('ep-1');
      expect(ep!.cachedTitle, 'Cached Title');
      expect(ep.cachedImagePath, '/img.jpg');
      expect(ep.cachedMetaPath, '/meta.json');
    });

    test('setProgress updates progress and bytes', () async {
      await dao.upsert(_makeEp('ep-1'));
      await dao.setProgress('ep-1', 0.75, bytes: 750, total: 1000);
      final ep = await dao.getById('ep-1');
      expect(ep!.progress, 0.75);
      expect(ep.bytesDownloaded, 750);
    });

    test('completedWithFileDesc returns completed episodes with file', () async {
      await dao.upsert(_makeEp('ep-1'));
      await dao.setCompleted('ep-1', '/file1.mp3');
      await dao.upsert(_makeEp('ep-2'));
      await dao.setCompleted('ep-2', '/file2.mp3');
      await dao.upsert(_makeEp('ep-3')); // not completed

      final completed = await dao.completedWithFileDesc('pod-1');
      expect(completed, hasLength(2));
    });

    test('playedBefore returns episodes played before threshold', () async {
      await dao.upsert(_makeEp('ep-old'));
      await dao.setCompleted('ep-old', '/file.mp3');
      await dao.markPlayed('ep-old');
      // playedAt is now(), so set threshold to the future
      final threshold = DateTime.now().add(const Duration(hours: 1));
      final result = await dao.playedBefore(threshold);
      expect(result, hasLength(1));
      expect(result.first.id, 'ep-old');
    });

    test('enqueueLatestN sets eligible episodes to queued', () async {
      await dao.upsert(_makeEp('ep-1', status: 0)); // none -> should queue
      await dao.upsert(_makeEp('ep-2', status: 3)); // completed -> skip
      await dao.upsert(_makeEp('ep-3', status: 4)); // failed -> should queue

      await dao.enqueueLatestN('pod-1', 3);

      expect((await dao.getById('ep-1'))!.status, 1); // queued
      expect((await dao.getById('ep-2'))!.status, 3); // unchanged
      expect((await dao.getById('ep-3'))!.status, 1); // queued
    });

    test('getEpisodesByPodcastId returns all episodes for podcast', () async {
      await dao.upsert(_makeEp('ep-1', podcastId: 'pod-1'));
      await dao.upsert(_makeEp('ep-2', podcastId: 'pod-1'));
      await dao.upsert(_makeEp('ep-3', podcastId: 'pod-2'));

      final results = await dao.getEpisodesByPodcastId('pod-1');
      expect(results, hasLength(2));
    });
  });

  // ==================== RetentionDao ====================

  group('RetentionDao', () {
    late EpisodesDao episodesDao;
    late SubscriptionsDao subscriptionsDao;
    late SettingsDao settingsDao;
    late RetentionDao retentionDao;

    setUp(() {
      episodesDao = EpisodesDao(db);
      subscriptionsDao = SubscriptionsDao(db);
      settingsDao = SettingsDao(db);
      retentionDao = RetentionDao(db, episodesDao, subscriptionsDao, settingsDao);
    });

    test('computePlanForPodcast returns empty plan with no rules', () async {
      await settingsDao.ensureDefaults(); // no retention rules set
      await episodesDao.upsert(EpisodesCompanion(
        id: const Value('ep-1'),
        podcastId: const Value('pod-1'),
        title: const Value('Ep 1'),
        audioUrl: const Value('https://example.com/1.mp3'),
        status: const Value(3),
        localPath: const Value('/file.mp3'),
      ));

      final plan = await retentionDao.computePlanForPodcast('pod-1');
      expect(plan.toDeleteIds, isEmpty);
    });

    test('computePlanForPodcast applies keepLatestN rule', () async {
      await settingsDao.ensureDefaults();
      await settingsDao.setKeepLatestN(1); // keep only 1

      // Insert 3 completed episodes with files
      for (int i = 1; i <= 3; i++) {
        await episodesDao.upsert(EpisodesCompanion(
          id: Value('ep-$i'),
          podcastId: const Value('pod-1'),
          title: Value('Ep $i'),
          audioUrl: Value('https://example.com/$i.mp3'),
          publishedAt: Value(DateTime(2025, 1, i)),
          status: const Value(3),
          localPath: Value('/file$i.mp3'),
          completedAt: Value(DateTime(2025, 1, i)),
        ));
      }

      final plan = await retentionDao.computePlanForPodcast('pod-1');
      // keepLatestN=1 means 2 should be deleted (the 2 oldest)
      expect(plan.toDeleteIds, hasLength(2));
      expect(plan.toDeleteIds, contains('ep-1'));
      expect(plan.toDeleteIds, contains('ep-2'));
      expect(plan.toDeleteIds, isNot(contains('ep-3'))); // newest kept
    });

    test('computePlanForPodcast applies deleteAfterHours rule', () async {
      await settingsDao.ensureDefaults();
      await settingsDao.setDeleteAfterHours(24);

      // Insert episode played 48 hours ago
      final playedAt = DateTime.now().subtract(const Duration(hours: 48));
      await episodesDao.upsert(EpisodesCompanion(
        id: const Value('ep-old'),
        podcastId: const Value('pod-1'),
        title: const Value('Old Episode'),
        audioUrl: const Value('https://example.com/old.mp3'),
        status: const Value(3),
        localPath: const Value('/old.mp3'),
        playedAt: Value(playedAt),
      ));

      final plan = await retentionDao.computePlanForPodcast('pod-1');
      expect(plan.toDeleteIds, contains('ep-old'));
    });

    test('computePlanForPodcast deduplicates IDs', () async {
      await settingsDao.ensureDefaults();
      await settingsDao.setDeleteAfterHours(1);
      await settingsDao.setKeepLatestN(0); // keep none -- everything goes

      final playedAt = DateTime.now().subtract(const Duration(hours: 2));
      await episodesDao.upsert(EpisodesCompanion(
        id: const Value('ep-dup'),
        podcastId: const Value('pod-1'),
        title: const Value('Dup'),
        audioUrl: const Value('https://example.com/dup.mp3'),
        status: const Value(3),
        localPath: const Value('/dup.mp3'),
        playedAt: Value(playedAt),
        completedAt: Value(playedAt),
      ));

      final plan = await retentionDao.computePlanForPodcast('pod-1');
      // Should appear only once even if matched by both rules
      final occurrences = plan.toDeleteIds.where((id) => id == 'ep-dup').length;
      expect(occurrences, 1);
    });
  });
}
```

### Dependencies to mock

None -- uses Drift in-memory database (`NativeDatabase.memory()`), same pattern as the existing `settings_dao_test.dart`.

---

## Summary Table

| # | Target | Current | Lines to cover | Effort | Est. gain |
|---|--------|---------|---------------|--------|-----------|
| 1 | `web_image_proxy.dart` | 0% | 13 | 10 min | +0.3% |
| 2 | `profile_repository.dart` | 0% | 13 | 20 min | +0.3% |
| 3 | `api_cache_service.dart` | ~28% | 21 | 20 min | +0.5% |
| 4 | `device_id.dart` | 0% | 28 | 30 min | +0.7% |
| 5 | `episode_cache_reader.dart` | 0% | 45 | 30 min | +1.1% |
| 6 | `http_requester.dart` | 0% | 28 | 30 min | +0.7% |
| 7 | `profile_provider.dart` | 4.1% | 47 | 30 min | +1.1% |
| 8 | `download_provider.dart` | 0% | 70 | 45 min | +1.7% |
| 9 | `podcast_provider.dart` | 11.9% | ~100 | 45 min | +2.4% |
| 10 | `daos.dart` | 26.8% | 127 | 45 min | +3.1% |
| **Total** | | | **~492** | **~5 hrs** | **+11.9%** |

Implementing all 10 quick-wins would raise overall coverage from **26.9% to approximately 38.8%**.

**Recommended priority order for maximum ROI**:
1. Items 1, 3 (trivially testable, no mocking complexity)
2. Items 5, 6, 7 (moderate effort, good line coverage gain)
3. Item 10 (highest absolute gain, established test pattern exists)
4. Items 9, 2 (good gain, slightly more setup)
5. Items 4, 8 (require refactoring or complex mocking)
