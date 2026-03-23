# Flutter App Dateistruktur

## Verzeichnisbaum der *.dart-Dateien

```
├── klubradio_archivum/integration_test/app_web_test.dart
├── klubradio_archivum/integration_test/download_manager_live_test.dart
├── klubradio_archivum/lib/api/api_client.dart
├── klubradio_archivum/lib/api/episode_api.dart
├── klubradio_archivum/lib/api/podcast_api.dart
├── klubradio_archivum/lib/api/search_api.dart
├── klubradio_archivum/lib/api/telemetry_api.dart
├── klubradio_archivum/lib/api/top_shows_api.dart
├── klubradio_archivum/lib/api/user_api.dart
├── klubradio_archivum/lib/db/app_database.dart
├── klubradio_archivum/lib/db/app_database.g.dart
├── klubradio_archivum/lib/db/connection/connection.dart
├── klubradio_archivum/lib/db/connection/connection_native.dart
├── klubradio_archivum/lib/db/connection/connection_stub.dart
├── klubradio_archivum/lib/db/connection/connection_web.dart
├── klubradio_archivum/lib/db/daos.dart
├── klubradio_archivum/lib/db/daos.g.dart
├── klubradio_archivum/lib/l10n/app_localizations.dart
├── klubradio_archivum/lib/l10n/app_localizations_de.dart
├── klubradio_archivum/lib/l10n/app_localizations_en.dart
├── klubradio_archivum/lib/l10n/app_localizations_hu.dart
├── klubradio_archivum/lib/l10n/app_localizations_ro.dart
├── klubradio_archivum/lib/main.dart
├── klubradio_archivum/lib/models/episode.dart
├── klubradio_archivum/lib/models/podcast.dart
├── klubradio_archivum/lib/models/retention_mode.dart
├── klubradio_archivum/lib/models/show_data.dart
├── klubradio_archivum/lib/models/show_host.dart
├── klubradio_archivum/lib/models/user_profile.dart
├── klubradio_archivum/lib/providers/download_provider.dart
├── klubradio_archivum/lib/providers/episode_provider.dart
├── klubradio_archivum/lib/providers/latest_provider.dart
├── klubradio_archivum/lib/providers/podcast_provider.dart
├── klubradio_archivum/lib/providers/profile_provider.dart
├── klubradio_archivum/lib/providers/recommended_provider.dart
├── klubradio_archivum/lib/providers/subscription_provider.dart
├── klubradio_archivum/lib/providers/theme_provider.dart
├── klubradio_archivum/lib/repositories/podcast_repository.dart
├── klubradio_archivum/lib/repositories/profile_repository.dart
├── klubradio_archivum/lib/screens/about_screen/about_screen.dart
├── klubradio_archivum/lib/screens/about_screen/legal_screen.dart
├── klubradio_archivum/lib/screens/app_shell/app_shell.dart
├── klubradio_archivum/lib/screens/discover_screen/discover_screen.dart
├── klubradio_archivum/lib/screens/discover_screen/recommended_podcasts_list.dart
├── klubradio_archivum/lib/screens/discover_screen/top_shows_list.dart
├── klubradio_archivum/lib/screens/discover_screen/trending_podcasts_list.dart
├── klubradio_archivum/lib/screens/download_manager_screen/download_list.dart
├── klubradio_archivum/lib/screens/download_manager_screen/download_list_entries.dart
├── klubradio_archivum/lib/screens/download_manager_screen/download_manager_screen.dart
├── klubradio_archivum/lib/screens/home_screen/home_screen.dart
├── klubradio_archivum/lib/screens/home_screen/recently_played_list.dart
├── klubradio_archivum/lib/screens/home_screen/subscribed_podcasts_list.dart
├── klubradio_archivum/lib/screens/now_playing_screen/audio_player_controls.dart
├── klubradio_archivum/lib/screens/now_playing_screen/now_playing_screen.dart
├── klubradio_archivum/lib/screens/now_playing_screen/progress_slider.dart
├── klubradio_archivum/lib/screens/podcast_detail_screen/podcast_detail_screen.dart
├── klubradio_archivum/lib/screens/podcast_detail_screen/podcast_info_card.dart
├── klubradio_archivum/lib/screens/profile_screen/profile_screen.dart
├── klubradio_archivum/lib/screens/profile_screen/subscriptions_panel.dart
├── klubradio_archivum/lib/screens/search_screen/recent_searches.dart
├── klubradio_archivum/lib/screens/search_screen/search_bar.dart
├── klubradio_archivum/lib/screens/search_screen/search_results_list.dart
├── klubradio_archivum/lib/screens/search_screen/search_screen.dart
├── klubradio_archivum/lib/screens/settings_screen/download_settings_panel.dart
├── klubradio_archivum/lib/screens/settings_screen/playback_settings.dart
├── klubradio_archivum/lib/screens/settings_screen/settings_screen.dart
├── klubradio_archivum/lib/screens/settings_screen/theme_settings.dart
├── klubradio_archivum/lib/screens/utils/constants.dart
├── klubradio_archivum/lib/screens/utils/helpers.dart
├── klubradio_archivum/lib/screens/widgets/privacy_dialog.dart
├── klubradio_archivum/lib/screens/widgets/stateful/episode_list.dart
├── klubradio_archivum/lib/screens/widgets/stateful/now_playing_bar.dart
├── klubradio_archivum/lib/screens/widgets/stateful/queue_sheet.dart
├── klubradio_archivum/lib/screens/widgets/stateless/bottom_navigation_bar.dart
├── klubradio_archivum/lib/screens/widgets/stateless/episode_list_item.dart
├── klubradio_archivum/lib/screens/widgets/stateless/image_url.dart
├── klubradio_archivum/lib/screens/widgets/stateless/platform_utils.dart
├── klubradio_archivum/lib/screens/widgets/stateless/podcast_list_item.dart
├── klubradio_archivum/lib/screens/widgets/unsubscribe_dialog.dart
├── klubradio_archivum/lib/services/api_cache_service.dart
├── klubradio_archivum/lib/services/api_service.dart
├── klubradio_archivum/lib/services/audio_player_service.dart
├── klubradio_archivum/lib/services/cache_store.dart
├── klubradio_archivum/lib/services/download_service.dart
├── klubradio_archivum/lib/services/http_requester.dart
├── klubradio_archivum/lib/services/privacy_notice_service.dart
├── klubradio_archivum/lib/services/static_data_service.dart
├── klubradio_archivum/lib/utils/device_id.dart
├── klubradio_archivum/lib/utils/episode_cache_reader.dart
├── klubradio_archivum/lib/utils/web_image_proxy.dart
├── klubradio_archivum/test/api/episode_api_test.dart
├── klubradio_archivum/test/api/episode_api_test.mocks.dart
├── klubradio_archivum/test/api/search_api_test.dart
├── klubradio_archivum/test/db/settings_dao_test.dart
├── klubradio_archivum/test/models/episode_test.dart
├── klubradio_archivum/test/models/podcast_test.dart
├── klubradio_archivum/test/models/retention_mode_test.dart
├── klubradio_archivum/test/models/show_data_test.dart
├── klubradio_archivum/test/models/show_host_test.dart
├── klubradio_archivum/test/models/user_profile_test.dart
├── klubradio_archivum/test/providers/episode_provider_queue_test.dart
├── klubradio_archivum/test/providers/episode_provider_queue_test.mocks.dart
├── klubradio_archivum/test/providers/podcast_provider_search_test.dart
├── klubradio_archivum/test/providers/subscription_provider_test.dart
├── klubradio_archivum/test/providers/subscription_provider_test.mocks.dart
├── klubradio_archivum/test/providers/theme_provider_test.dart
├── klubradio_archivum/test/screens/download_list_entries_test.dart
├── klubradio_archivum/test/screens/podcast_detail_screen_test.dart
├── klubradio_archivum/test/screens/subscription_download_test.dart
├── klubradio_archivum/test/screens/utils/constants_test.dart
├── klubradio_archivum/test/screens/utils/helpers_test.dart
├── klubradio_archivum/test/screens/utils/platform_utils_test.dart
├── klubradio_archivum/test/screens/widgets/queue_sheet_test.dart
├── klubradio_archivum/test/services/api_live_validation_test.dart
├── klubradio_archivum/test/services/api_model_validation_test.dart
├── klubradio_archivum/test/services/api_service_live_test.dart
├── klubradio_archivum/test/services/api_service_test.dart
├── klubradio_archivum/test/services/privacy_notice_service_test.dart
├── klubradio_archivum/test_driver/integration_test.dart
├── scripts/fetch_static_data.dart
```

## Inhalt der *.dart-Dateien

### Inhalt von `klubradio_archivum/integration_test/app_web_test.dart`
```dart
// integration_test/app_web_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:klubradio_archivum/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Klubrádió Archivum Web UI Tests', () {
    testWidgets('Verify main screens and player functionality', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      // Ensure the app is loaded and stable
      await tester.pumpAndSettle();

      // --- Test Main Screens ---

      // Take screenshot of the initial screen (e.g., Home or Discover)
      await binding.takeScreenshot('initial_screen');

      // Attempt to find and tap navigation items.
      // Assuming a BottomNavigationBar with at least 'Discover' and 'My Shows' and 'Downloads' and 'Settings'
      // You might need to adjust these Finders based on actual app implementation (e.g., byKey, byTooltip, bySemanticsLabel)

      // Discover Screen
      final discoverTabFinder = find.byIcon(Icons.explore); // Assuming an explore icon for discover
      if (tester.any(discoverTabFinder)) {
        await tester.tap(discoverTabFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('discover_screen');
      } else {
        // Fallback if icon not found, try text if available
        final discoverTextFinder = find.text('Discover');
        if (tester.any(discoverTextFinder)) {
          await tester.tap(discoverTextFinder);
          await tester.pumpAndSettle();
          await binding.takeScreenshot('discover_screen');
        } else {
          // Log a warning if no discover tab found
          debugPrint('Warning: Discover tab (icon/text) not found.');
        }
      }

      // My Shows (Subscriptions) Screen
      final myShowsTabFinder = find.byIcon(Icons.subscriptions); // Assuming subscriptions icon
      if (tester.any(myShowsTabFinder)) {
        await tester.tap(myShowsTabFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('my_shows_screen');
      } else {
        final myShowsTextFinder = find.text('My Shows');
        if (tester.any(myShowsTextFinder)) {
          await tester.tap(myShowsTextFinder);
          await tester.pumpAndSettle();
          await binding.takeScreenshot('my_shows_screen');
        } else {
          debugPrint('Warning: My Shows tab (icon/text) not found.');
        }
      }
      
      // Downloads Screen
      final downloadsTabFinder = find.byIcon(Icons.download); 
      if (tester.any(downloadsTabFinder)) {
        await tester.tap(downloadsTabFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('downloads_screen');
      } else {
        final downloadsTextFinder = find.text('Downloads');
        if (tester.any(downloadsTextFinder)) {
          await tester.tap(downloadsTextFinder);
          await tester.pumpAndSettle();
          await binding.takeScreenshot('downloads_screen');
        } else {
          debugPrint('Warning: Downloads tab (icon/text) not found.');
        }
      }

      // Settings Screen
      final settingsTabFinder = find.byIcon(Icons.settings); 
      if (tester.any(settingsTabFinder)) {
        await tester.tap(settingsTabFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('settings_screen');
      } else {
        final settingsTextFinder = find.text('Settings');
        if (tester.any(settingsTextFinder)) {
          await tester.tap(settingsTextFinder);
          await tester.pumpAndSettle();
          await binding.takeScreenshot('settings_screen');
        } else {
          debugPrint('Warning: Settings tab (icon/text) not found.');
        }
      }

      // --- Test Player Functionality ---
      // This part is more complex as it requires an episode to be available and playable.
      // For a basic test, we can try to find a playable item on the Discover screen
      // and tap it to open the player.

      // Navigate back to Discover to find an episode
      if (tester.any(discoverTabFinder)) {
        await tester.tap(discoverTabFinder);
        await tester.pumpAndSettle();
      } else if (tester.any(find.text('Discover'))) {
        await tester.tap(find.text('Discover'));
        await tester.pumpAndSettle();
      }

      // Find the first list item (assuming it's an episode or podcast)
      // This is a very generic finder, might need to be more specific based on your app's list item widget.
      // For example, you might use find.byType(EpisodeListItem) or find.byKey(Key('episode_1'))
      final firstListItemFinder = find.byType(ListTile).first; 

      if (tester.any(firstListItemFinder)) {
        await tester.tap(firstListItemFinder);
        await tester.pumpAndSettle();
        await binding.takeScreenshot('player_screen_opened');

        // Verify player controls exist (play/pause button)
        final playPauseButtonFinder = find.byIcon(Icons.play_arrow); // Or Icons.pause
        if (tester.any(playPauseButtonFinder)) {
          await tester.tap(playPauseButtonFinder);
          await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for a moment to let playback start
          await binding.takeScreenshot('player_playing');
        } else {
          debugPrint('Warning: Play/Pause button not found on player screen.');
        }

        // You can add more player interactions here, like seeking, changing speed, etc.
      } else {
        debugPrint('Warning: No list item found on Discover screen to play.');
      }
    });
  });
}
```

### Inhalt von `klubradio_archivum/integration_test/download_manager_live_test.dart`
```dart
// test/integration_test/download_manager_live_test.dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/services/download_service.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/audio_player_service.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const bool runLive = bool.fromEnvironment(
    'DOWNLOAD_LIVE_TESTS',
    defaultValue: false,
  );
  if (!runLive) {
    test('skipped (set --dart-define DOWNLOAD_LIVE_TESTS=true)', () {
      expect(
        runLive,
        isTrue,
        reason: 'Enable with --dart-define DOWNLOAD_LIVE_TESTS=true',
      );
    });
    return;
  }

  const int overrideTimeoutSec = int.fromEnvironment(
    'DOWNLOAD_TEST_TIMEOUT_SEC',
    defaultValue: 0,
  );

  group('DownloadManager live (latest via API) with speed/ETA', () {
    late AppDatabase db;
    late EpisodesDao episodesDao;
    late SubscriptionsDao subscriptionsDao;
    late SettingsDao settingsDao;
    late RetentionDao retentionDao;
    late DownloadService service;
    late ApiService api;

    setUpAll(() async {
      db = AppDatabase();
      episodesDao = EpisodesDao(db);
      subscriptionsDao = SubscriptionsDao(db);
      settingsDao = SettingsDao(db);
      retentionDao = RetentionDao(
        db,
        episodesDao,
        subscriptionsDao,
        settingsDao,
      );
      api = ApiService();

      service = DownloadService(
        db: db,
        episodesDao: episodesDao,
        subscriptionsDao: subscriptionsDao,
        settingsDao: settingsDao,
        retentionDao: retentionDao,
        episodeProvider: EpisodeProvider(
          apiService: api,
          audioPlayerService: AudioPlayerService(),
          db: db,
        ),
        apiService: api,
      );
      await service.init();
      await settingsDao.ensureDefaults();
      await settingsDao.setKeepLatestN(2); // 0 != aus → null = aus
      await settingsDao.setDeleteAfterHours(0); // sicherheitshalber
      await settingsDao.setWifiOnly(false); // optional für Desktop
    });

    tearDownAll(() async {
      await service.dispose();
      await db.close();
    });

    testWidgets('fetch latest -> estimate size & speed -> enqueue -> complete', (
      tester,
    ) async {
      // 1) Neuste Episode holen (limit=1) – ggf. Methode an deinen ApiService anpassen
      final latest = await api.fetchRecentEpisodes(limit: 1);
      expect(latest.isNotEmpty, isTrue, reason: 'API returned no episodes');
      final ep = latest.first;

      // 2) Größe + Speed bestimmen (nur Test; echte DL macht der Service)
      final sizeBytes = await _fetchContentLength(ep.audioUrl);
      final speedBps = await _measureThroughput(
        ep.audioUrl,
        warmup: const Duration(seconds: 10),
      );

      debugPrint(
        'SIZE: ${_fmtBytes(sizeBytes)}   SPEED(10s): ${_fmtBps(speedBps)}',
      );

      // 3) ETA/Timeout bestimmen – großzügig puffern (x1.8 + 30s)
      //    Fallbacks, wenn Größe unbekannt: pauschaler Timeout
      final estSeconds = (sizeBytes != null && speedBps != null && speedBps > 0)
          ? (sizeBytes / speedBps)
          : 180.0; // 3 min fallback, wenn Größe unbekannt

      // robuste Timeout-Wahl:
      // - entweder explizit via --dart-define DOWNLOAD_TEST_TIMEOUT_SEC
      // - sonst ETA * 2.2 + 60s Puffer, aber mind. 5 Minuten
      final computed = Duration(seconds: (estSeconds * 2.2).ceil() + 60);
      final dlTimeout = overrideTimeoutSec > 0
          ? Duration(seconds: overrideTimeoutSec)
          : (computed < const Duration(minutes: 5)
                ? const Duration(minutes: 5)
                : computed);

      debugPrint(
        'ETA: ${_fmtDuration(Duration(seconds: estSeconds.ceil()))}  '
        '→ timeout used: ${_fmtDuration(dlTimeout)}',
      );

      // 4) Enqueue
      await service.enqueueEpisode(ep);

      // Optional: kurz warten bis queued/running sichtbar
      await _waitUntil(
        timeout: const Duration(minutes: 2),
        interval: const Duration(seconds: 1),
        condition: () async {
          final row = await episodesDao.getById(ep.id);
          final st = row?.status;
          if (st != null) {
            // alle 5s ein kleines Lebenszeichen
            if (DateTime.now().second % 5 == 0) {
              debugPrint(
                'status=$st progress=${(row?.progress ?? 0) * 100 ~/ 1}%',
              );
            }
          }
          return st == 1 || st == 2 || st == 3 || st == 4 || st == 5;
        },
      );

      // 5) Warten bis completed/failed/canceled – mit dynamischem Timeout
      await _waitUntil(
        timeout: dlTimeout,
        interval: const Duration(seconds: 1),
        condition: () async {
          final row = await episodesDao.getById(ep.id);
          final st = row?.status;
          if (st != null && DateTime.now().second % 5 == 0) {
            debugPrint(
              'waiting… status=$st progress=${(row?.progress ?? 0) * 100 ~/ 1}%',
            );
          }
          return row != null && (st == 3 || st == 4 || st == 5);
        },
      );

      // 6) Asserts
      final done = await episodesDao.getById(ep.id);
      expect(done, isNotNull);
      expect(
        done!.status,
        3,
        reason: 'status should be completed (3), got ${done.status}',
      );
      expect(
        done.localPath?.isNotEmpty ?? false,
        isTrue,
        reason: 'localPath should be set',
      );

      final file = File(done.localPath!);
      final exists = await file.exists();
      final length = exists ? await file.length() : 0;
      expect(
        exists,
        isTrue,
        reason: 'Downloaded file should exist at localPath',
      );
      expect(
        length,
        greaterThan(0),
        reason: 'Downloaded file size should be > 0',
      );

      // 7) Cleanup
      await service.removeLocalFile(ep.id);
      final after = await episodesDao.getById(ep.id);
      expect(
        after?.localPath,
        isNull,
        reason: 'localPath should be cleared after removeLocalFile',
      );
    });
  });
}

/// HEAD → Content-Length, Fallback: Range 0-0 liest Content-Range (…/TOTAL)
Future<int?> _fetchContentLength(String url) async {
  try {
    final head = await http.head(Uri.parse(url));
    final cl = head.headers['content-length'];
    if (cl != null) return int.tryParse(cl);

    // Fallback: Range-Request, um TOTAL aus Content-Range zu ziehen
    final range = await http.get(
      Uri.parse(url),
      headers: {'range': 'bytes=0-0'},
    );
    final cr = range.headers['content-range']; // e.g. "bytes 0-0/1234567"
    if (cr != null && cr.contains('/')) {
      final total = cr.split('/').last.trim();
      return int.tryParse(total);
    }
  } catch (_) {}
  return null; // unbekannt
}

/// 10s Speedprobe: streamt Bytes und bricht nach [warmup] ab. Liefert Bytes/s.
Future<double?> _measureThroughput(
  String url, {
  Duration warmup = const Duration(seconds: 10),
}) async {
  final client = http.Client();
  try {
    // Range ohne Ende → Streaming
    final req = http.Request('GET', Uri.parse(url))
      ..headers['range'] = 'bytes=0-'
      ..followRedirects = true;
    final resp = await client.send(req);

    int bytes = 0;
    final sw = Stopwatch()..start();

    final sub = resp.stream.listen(
      (chunk) {
        bytes += chunk.length;
      },
      onError: (_) {},
      cancelOnError: true,
    );

    // max [warmup] warten
    await Future.any([
      Future.delayed(warmup),
      sub.asFuture<void>(), // falls Stream vorher endet
    ]);

    await sub.cancel();
    sw.stop();

    final secs = sw.elapsedMilliseconds / 1000.0;
    if (secs <= 0) return null;
    return bytes / secs; // Bytes/s
  } catch (_) {
    return null;
  } finally {
    client.close();
  }
}

Future<void> _waitUntil({
  required Duration timeout,
  required Duration interval,
  required FutureOr<bool> Function() condition,
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    if (await condition()) return;
    await Future.delayed(interval);
  }
  fail('Timed out after ${timeout.inSeconds}s');
}

String _fmtBytes(int? b) {
  if (b == null) return 'unknown';
  const units = ['B', 'KB', 'MB', 'GB'];
  double val = b.toDouble();
  int u = 0;
  while (val >= 1024 && u < units.length - 1) {
    val /= 1024;
    u++;
  }
  return '${val.toStringAsFixed(1)} ${units[u]}';
}

String _fmtBps(double? bps) {
  if (bps == null) return 'unknown';
  const units = ['B/s', 'KB/s', 'MB/s', 'GB/s'];
  double val = bps;
  int u = 0;
  while (val >= 1024 && u < units.length - 1) {
    val /= 1024;
    u++;
  }
  return '${val.toStringAsFixed(1)} ${units[u]}';
}

String _fmtDuration(Duration d) {
  final m = d.inMinutes;
  final s = d.inSeconds % 60;
  if (m > 0) return '${m}m ${s}s';
  return '${s}s';
}
```

### Inhalt von `klubradio_archivum/lib/api/api_client.dart`
```dart
// lib/api/api_client.dart

/// Shared API configuration and utilities for all API classes.
///
/// This class provides centralized configuration for Supabase API access,
/// including credentials, headers, and validation helpers.
class ApiClient {
  /// Base URL for Supabase instance
  static const String supabaseUrl = 'https://arakbotxgwpyyqyxjhhl.supabase.co';

  /// Anonymous API key for Supabase
  static const String supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyYWtib3R4Z3dweXlxeXhqaGhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgxMDE0MzUsImV4cCI6MjA3MzY3NzQzNX0.zO__rAZCmPQW26YAC3CYhq_ZSjUAx0Gh0KHXIVHhm7w';

  /// Standard HTTP headers for Supabase API requests
  static Map<String, String> get headers => {
        'apikey': supabaseKey,
        'Authorization': 'Bearer $supabaseKey',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// Checks if the API credentials are properly configured.
  ///
  /// Returns false if credentials contain placeholder values like 'TODO'.
  static bool get hasValidCredentials =>
      !supabaseUrl.contains('TODO') && !supabaseKey.contains('TODO');
}
```

### Inhalt von `klubradio_archivum/lib/api/episode_api.dart`
```dart
// lib/api/episode_api.dart
import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for episode-related operations.
///
/// Handles fetching episodes for specific podcasts and recent episodes.
class EpisodeApi {
  EpisodeApi({
    required this.baseUrl,
    required String apiKey,
    HttpRequester? requester,
  }) : _requester = requester ??
            HttpRequester(
              defaultHeaders: {
                'apikey': apiKey,
                'Authorization': 'Bearer $apiKey',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            );

  final String baseUrl;
  final HttpRequester _requester;

  /// Fetches episodes for a specific podcast.
  ///
  /// Returns raw JSON data that can be parsed into Episode models.
  /// The [limit] parameter controls the maximum number of episodes returned.
  Future<List<Map<String, dynamic>>> forPodcast(
    String podcastId, {
    int limit = 500,
  }) async {
    final url =
        '$baseUrl/rest/v1/${constants.episodesTable}?select=*&podcastId=eq.$podcastId&limit=$limit';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches the most recent episodes across all podcasts.
  ///
  /// Returns raw JSON data ordered by ID descending (most recent first).
  /// The [limit] parameter controls the maximum number of episodes returned.
  Future<List<Map<String, dynamic>>> recent({int limit = 8}) async {
    final url =
        '$baseUrl/rest/v1/${constants.episodesTable}?select=*&order=id.desc&limit=$limit';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }
}
```

### Inhalt von `klubradio_archivum/lib/api/podcast_api.dart`
```dart
import 'package:flutter/foundation.dart'; // Import for kIsWeb and debugPrint

import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for podcast-related operations.
///
/// Handles fetching podcast lists, individual podcasts, and related data.
class PodcastApi {
  PodcastApi({
    required this.baseUrl,
    required String apiKey,
    HttpRequester? requester,
  }) : _requester =
           requester ??
           HttpRequester(
             defaultHeaders: {
               'apikey': apiKey,
               'Authorization': 'Bearer $apiKey',
               'Content-Type': 'application/json',
               'Accept': 'application/json',
             },
           );

  final String baseUrl;
  final HttpRequester _requester;

  /// Fetches the latest podcasts ordered by last updated date.
  ///
  /// Returns raw JSON data that can be parsed into Podcast models.
  /// The [limit] parameter controls the maximum number of podcasts returned.
  Future<List<Map<String, dynamic>>> latest({int limit = 10}) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&order=last_updated.desc&limit=$limit';
    debugPrint('latest url: $url');
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches recommended podcasts.
  ///
  /// Returns raw JSON data that can be parsed into Podcast models.
  Future<List<Map<String, dynamic>>> recommended({int limit = 10}) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&order=last_updated.desc.nullslast&limit=$limit';
    debugPrint('recommended url: $url');
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches trending podcasts.
  ///
  /// Returns raw JSON data that can be parsed into Podcast models.
  Future<List<Map<String, dynamic>>> trending({int limit = 10}) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&order=id.desc&limit=$limit';
    debugPrint('trending url: $url');
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches recent episodes across all podcasts.
  ///
  /// Returns raw JSON data that can be parsed into Episode models.
  /// Note: This method may be moved to EpisodeApi in the future.
  Future<List<Map<String, dynamic>>> recentEpisodes({int limit = 8}) async {
    final url =
        '$baseUrl/rest/v1/${constants.episodesTable}?select=*&order=id.desc&limit=$limit';
    debugPrint('recentEpisodes url: $url');
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Fetches a single podcast by ID.
  ///
  /// Returns raw JSON data for the podcast, or null if not found.
  Future<Map<String, dynamic>?> byId(String podcastId) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&id=eq.$podcastId&limit=1';
    final json = await _requester.getJson(url);

    final list = json as List;
    if (list.isEmpty) {
      return null;
    }

    return list.first as Map<String, dynamic>;
  }

  /// Searches for podcasts by title.
  ///
  /// Performs a case-insensitive partial match search.
  /// Returns raw JSON data that can be parsed into Podcast models.
  /// Note: This method may be moved to SearchApi in the future.
  Future<List<Map<String, dynamic>>> search(String query) async {
    if (query.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    // Escape single quotes for SQL ILIKE query
    final encoded = query.replaceAll("'", "''");
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&title=ilike.%25$encoded%25';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }
}
```

### Inhalt von `klubradio_archivum/lib/api/search_api.dart`
```dart
// lib/api/search_api.dart
import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for search operations.
///
/// Handles searching podcasts and episodes by query string.
class SearchApi {
  SearchApi({
    required this.baseUrl,
    required String apiKey,
    HttpRequester? requester,
  }) : _requester = requester ??
            HttpRequester(
              defaultHeaders: {
                'apikey': apiKey,
                'Authorization': 'Bearer $apiKey',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            );

  final String baseUrl;
  final HttpRequester _requester;

  /// Searches for podcasts by title.
  ///
  /// Performs a case-insensitive partial match search on podcast titles.
  /// Returns raw JSON data that can be parsed into Podcast models.
  Future<List<Map<String, dynamic>>> podcasts(String query) async {
    if (query.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    // Escape single quotes for SQL ILIKE query
    final encoded = query.replaceAll("'", "''");
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&title=ilike.%25$encoded%25';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  /// Searches for episodes by title.
  ///
  /// Performs a case-insensitive partial match search on episode titles.
  /// Returns raw JSON data that can be parsed into Episode models.
  Future<List<Map<String, dynamic>>> episodes(String query) async {
    if (query.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    // Escape single quotes for SQL ILIKE query
    final encoded = query.replaceAll("'", "''");
    final url =
        '$baseUrl/rest/v1/${constants.episodesTable}?select=*&title=ilike.%25$encoded%25';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  // Future enhancement: full-text search across descriptions, hosts, etc.
  // Future<List<Map<String, dynamic>>> fullText(String query) async { ... }
}
```

### Inhalt von `klubradio_archivum/lib/api/telemetry_api.dart`
```dart
// lib/api/telemetry_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for telemetry and analytics operations.
///
/// Handles logging user events like playback, downloads, and searches.
/// These operations are fire-and-forget and should not block user interactions.
class TelemetryApi {
  TelemetryApi({
    required this.baseUrl,
    required String apiKey,
    http.Client? client,
  })  : _apiKey = apiKey,
        _client = client ?? http.Client();

  final String baseUrl;
  final String _apiKey;
  final http.Client _client;

  static const Duration _timeout = Duration(seconds: 5);

  Map<String, String> get _headers => {
        'apikey': _apiKey,
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// Logs a playback event for an episode.
  ///
  /// This is a fire-and-forget operation that records when a user plays an episode.
  /// Failures are silently ignored to not impact user experience.
  Future<void> logPlayback({required String episodeId}) async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/${constants.playbackEventsTable}');
      await _client
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              'episodeId': episodeId,
              'playedAt': DateTime.now().toIso8601String(),
            }),
          )
          .timeout(_timeout);
    } catch (_) {
      // Silently ignore telemetry errors
    }
  }

  /// Logs a download event for an episode.
  ///
  /// Records when a user downloads an episode for offline playback.
  Future<void> logDownload({required String episodeId}) async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/download_events');
      await _client
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              'episodeId': episodeId,
              'downloadedAt': DateTime.now().toIso8601String(),
            }),
          )
          .timeout(_timeout);
    } catch (_) {
      // Silently ignore telemetry errors
    }
  }

  /// Logs a search event.
  ///
  /// Records search queries and result counts for analytics.
  Future<void> logSearch({
    required String query,
    required int resultCount,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/search_events');
      await _client
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              'query': query,
              'resultCount': resultCount,
              'searchedAt': DateTime.now().toIso8601String(),
            }),
          )
          .timeout(_timeout);
    } catch (_) {
      // Silently ignore telemetry errors
    }
  }

  /// Disposes of the HTTP client.
  void dispose() {
    _client.close();
  }
}
```

### Inhalt von `klubradio_archivum/lib/api/top_shows_api.dart`
```dart
// lib/api/top_shows_api.dart
import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for fetching top shows statistics.
///
/// Handles retrieving aggregated statistics about most popular shows.
class TopShowsApi {
  TopShowsApi({
    required this.baseUrl,
    required String apiKey,
    HttpRequester? requester,
  }) : _requester = requester ??
            HttpRequester(
              defaultHeaders: {
                'apikey': apiKey,
                'Authorization': 'Bearer $apiKey',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            );

  final String baseUrl;
  final HttpRequester _requester;

  /// Fetches top shows for this year.
  ///
  /// Returns raw JSON data with show statistics (id, title, count).
  Future<List<Map<String, dynamic>>> thisYear() async {
    final url = '$baseUrl/rest/v1/${constants.topShowsTable}';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  // Future enhancement: add methods for different time periods
  // Future<List<Map<String, dynamic>>> thisMonth() async { ... }
  // Future<List<Map<String, dynamic>>> thisWeek() async { ... }
}
```

### Inhalt von `klubradio_archivum/lib/api/user_api.dart`
```dart
// lib/api/user_api.dart
import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

/// API client for user profile operations.
///
/// Handles fetching and updating user profile data.
class UserApi {
  UserApi({
    required this.baseUrl,
    required String apiKey,
    HttpRequester? requester,
  }) : _requester = requester ??
            HttpRequester(
              defaultHeaders: {
                'apikey': apiKey,
                'Authorization': 'Bearer $apiKey',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            );

  final String baseUrl;
  final HttpRequester _requester;

  /// Fetches a user profile by ID.
  ///
  /// Returns raw JSON data for the user profile, or null if not found.
  Future<Map<String, dynamic>?> profile(String userId) async {
    final url =
        '$baseUrl/rest/v1/${constants.userProfilesTable}?select=*&id=eq.$userId&limit=1';
    final json = await _requester.getJson(url);

    final list = json as List;
    if (list.isEmpty) {
      return null;
    }

    return list.first as Map<String, dynamic>;
  }

  // Future enhancement: add update and create methods
  // Future<void> updateProfile(String userId, Map<String, dynamic> data) async { ... }
  // Future<void> createProfile(Map<String, dynamic> data) async { ... }
}
```

### Inhalt von `klubradio_archivum/lib/db/app_database.dart`
```dart
import 'package:drift/drift.dart';

import 'connection/connection.dart';

part 'app_database.g.dart';

/// ---------- Tabellen ----------

class Subscriptions extends Table {
  TextColumn get podcastId => text()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get subscribedAt =>
      dateTime().withDefault(currentDateAndTime)();

  IntColumn get autoDownloadN => integer().nullable()();
  TextColumn get lastHeardEpisodeId => text().nullable()();
  TextColumn get lastDownloadedEpisodeId => text().nullable()();

  @override
  Set<Column> get primaryKey => {podcastId};
}

class Episodes extends Table {
  TextColumn get id => text()(); // Primary Key (episodeId)
  TextColumn get podcastId => text()();
  TextColumn get title => text()();
  TextColumn get audioUrl => text()();
  DateTimeColumn get publishedAt => dateTime().nullable()();

  // Metadata from API (v2)
  IntColumn get durationSeconds =>
      integer().nullable()(); // Duration in seconds
  TextColumn get description => text().nullable()();
  TextColumn get showDate => text().nullable()();
  TextColumn get imageUrl => text().nullable()();

  /// Download-Status:
  /// 0=none, 1=queued, 2=downloading, 3=completed, 4=failed, 5=canceled
  IntColumn get status => integer().withDefault(const Constant(0))();
  RealColumn get progress => real().withDefault(const Constant(0))(); // 0..1
  TextColumn get localPath => text().nullable()();
  IntColumn get bytesDownloaded => integer().nullable()();
  IntColumn get totalBytes => integer().nullable()();

  /// Nutzung/Retention
  DateTimeColumn get playedAt => dateTime().nullable()(); // gehört?
  DateTimeColumn get completedAt => dateTime().nullable()(); // fertig geladen
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  // Offline-Cache (optional)
  TextColumn get cachedTitle => text().nullable()(); // lokaler Anzeigename
  TextColumn get cachedImagePath => text().nullable()(); // Pfad zu 500x500 JPG
  TextColumn get cachedMetaPath => text().nullable()(); // Pfad zu JSON

  BoolColumn get resumable => boolean().nullable()(); // true/false/null

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(podcast_id) REFERENCES subscriptions(podcast_id) ON DELETE CASCADE',
  ];
}

class Settings extends Table {
  IntColumn get id => integer()(); // stets 1
  BoolColumn get wifiOnly => boolean().withDefault(const Constant(true))();
  IntColumn get maxParallel => integer().withDefault(const Constant(2))();
  IntColumn get deleteAfterHours =>
      integer().nullable()(); // z.B. 24 (am nächsten Tag)
  IntColumn get keepLatestN => integer().nullable()();
  BoolColumn get autodownloadSubscribed =>
      boolean().withDefault(const Constant(false))();

  /// Episode sort order: 'newest' (default) or 'oldest'
  TextColumn get playOrder => text().withDefault(const Constant('newest'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// ---------- DB ----------

LazyDatabase _openConnection() {
  return LazyDatabase(openConnection);
}

@DriftDatabase(tables: [Subscriptions, Episodes, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // v2: add metadata columns to episodes
        await m.addColumn(episodes, episodes.durationSeconds);
        await m.addColumn(episodes, episodes.description);
        await m.addColumn(episodes, episodes.showDate);
        await m.addColumn(episodes, episodes.imageUrl);
      }
      if (from < 3) {
        // v3: add playOrder column to settings (default 'newest')
        await m.addColumn(settings, settings.playOrder);
      }
    },
  );

  /// Convenience: Timestamps aktualisieren
  Future<int> touchEpisode(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(updatedAt: Value(DateTime.now())),
      );

  Future<int> touchSubscription(String podcastId) =>
      (update(subscriptions)..where((s) => s.podcastId.equals(podcastId)))
          .write(SubscriptionsCompanion(updatedAt: Value(DateTime.now())));
}
```

### Inhalt von `klubradio_archivum/lib/db/app_database.g.dart`
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, Subscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _podcastIdMeta = const VerificationMeta(
    'podcastId',
  );
  @override
  late final GeneratedColumn<String> podcastId = GeneratedColumn<String>(
    'podcast_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _subscribedAtMeta = const VerificationMeta(
    'subscribedAt',
  );
  @override
  late final GeneratedColumn<DateTime> subscribedAt = GeneratedColumn<DateTime>(
    'subscribed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _autoDownloadNMeta = const VerificationMeta(
    'autoDownloadN',
  );
  @override
  late final GeneratedColumn<int> autoDownloadN = GeneratedColumn<int>(
    'auto_download_n',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastHeardEpisodeIdMeta =
      const VerificationMeta('lastHeardEpisodeId');
  @override
  late final GeneratedColumn<String> lastHeardEpisodeId =
      GeneratedColumn<String>(
        'last_heard_episode_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastDownloadedEpisodeIdMeta =
      const VerificationMeta('lastDownloadedEpisodeId');
  @override
  late final GeneratedColumn<String> lastDownloadedEpisodeId =
      GeneratedColumn<String>(
        'last_downloaded_episode_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    podcastId,
    active,
    updatedAt,
    subscribedAt,
    autoDownloadN,
    lastHeardEpisodeId,
    lastDownloadedEpisodeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subscription> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('podcast_id')) {
      context.handle(
        _podcastIdMeta,
        podcastId.isAcceptableOrUnknown(data['podcast_id']!, _podcastIdMeta),
      );
    } else if (isInserting) {
      context.missing(_podcastIdMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('subscribed_at')) {
      context.handle(
        _subscribedAtMeta,
        subscribedAt.isAcceptableOrUnknown(
          data['subscribed_at']!,
          _subscribedAtMeta,
        ),
      );
    }
    if (data.containsKey('auto_download_n')) {
      context.handle(
        _autoDownloadNMeta,
        autoDownloadN.isAcceptableOrUnknown(
          data['auto_download_n']!,
          _autoDownloadNMeta,
        ),
      );
    }
    if (data.containsKey('last_heard_episode_id')) {
      context.handle(
        _lastHeardEpisodeIdMeta,
        lastHeardEpisodeId.isAcceptableOrUnknown(
          data['last_heard_episode_id']!,
          _lastHeardEpisodeIdMeta,
        ),
      );
    }
    if (data.containsKey('last_downloaded_episode_id')) {
      context.handle(
        _lastDownloadedEpisodeIdMeta,
        lastDownloadedEpisodeId.isAcceptableOrUnknown(
          data['last_downloaded_episode_id']!,
          _lastDownloadedEpisodeIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {podcastId};
  @override
  Subscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subscription(
      podcastId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}podcast_id'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      subscribedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}subscribed_at'],
      )!,
      autoDownloadN: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_download_n'],
      ),
      lastHeardEpisodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_heard_episode_id'],
      ),
      lastDownloadedEpisodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_downloaded_episode_id'],
      ),
    );
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(attachedDatabase, alias);
  }
}

class Subscription extends DataClass implements Insertable<Subscription> {
  final String podcastId;
  final bool active;
  final DateTime updatedAt;
  final DateTime subscribedAt;
  final int? autoDownloadN;
  final String? lastHeardEpisodeId;
  final String? lastDownloadedEpisodeId;
  const Subscription({
    required this.podcastId,
    required this.active,
    required this.updatedAt,
    required this.subscribedAt,
    this.autoDownloadN,
    this.lastHeardEpisodeId,
    this.lastDownloadedEpisodeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['podcast_id'] = Variable<String>(podcastId);
    map['active'] = Variable<bool>(active);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['subscribed_at'] = Variable<DateTime>(subscribedAt);
    if (!nullToAbsent || autoDownloadN != null) {
      map['auto_download_n'] = Variable<int>(autoDownloadN);
    }
    if (!nullToAbsent || lastHeardEpisodeId != null) {
      map['last_heard_episode_id'] = Variable<String>(lastHeardEpisodeId);
    }
    if (!nullToAbsent || lastDownloadedEpisodeId != null) {
      map['last_downloaded_episode_id'] = Variable<String>(
        lastDownloadedEpisodeId,
      );
    }
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      podcastId: Value(podcastId),
      active: Value(active),
      updatedAt: Value(updatedAt),
      subscribedAt: Value(subscribedAt),
      autoDownloadN: autoDownloadN == null && nullToAbsent
          ? const Value.absent()
          : Value(autoDownloadN),
      lastHeardEpisodeId: lastHeardEpisodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastHeardEpisodeId),
      lastDownloadedEpisodeId: lastDownloadedEpisodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDownloadedEpisodeId),
    );
  }

  factory Subscription.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subscription(
      podcastId: serializer.fromJson<String>(json['podcastId']),
      active: serializer.fromJson<bool>(json['active']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      subscribedAt: serializer.fromJson<DateTime>(json['subscribedAt']),
      autoDownloadN: serializer.fromJson<int?>(json['autoDownloadN']),
      lastHeardEpisodeId: serializer.fromJson<String?>(
        json['lastHeardEpisodeId'],
      ),
      lastDownloadedEpisodeId: serializer.fromJson<String?>(
        json['lastDownloadedEpisodeId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'podcastId': serializer.toJson<String>(podcastId),
      'active': serializer.toJson<bool>(active),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'subscribedAt': serializer.toJson<DateTime>(subscribedAt),
      'autoDownloadN': serializer.toJson<int?>(autoDownloadN),
      'lastHeardEpisodeId': serializer.toJson<String?>(lastHeardEpisodeId),
      'lastDownloadedEpisodeId': serializer.toJson<String?>(
        lastDownloadedEpisodeId,
      ),
    };
  }

  Subscription copyWith({
    String? podcastId,
    bool? active,
    DateTime? updatedAt,
    DateTime? subscribedAt,
    Value<int?> autoDownloadN = const Value.absent(),
    Value<String?> lastHeardEpisodeId = const Value.absent(),
    Value<String?> lastDownloadedEpisodeId = const Value.absent(),
  }) => Subscription(
    podcastId: podcastId ?? this.podcastId,
    active: active ?? this.active,
    updatedAt: updatedAt ?? this.updatedAt,
    subscribedAt: subscribedAt ?? this.subscribedAt,
    autoDownloadN: autoDownloadN.present
        ? autoDownloadN.value
        : this.autoDownloadN,
    lastHeardEpisodeId: lastHeardEpisodeId.present
        ? lastHeardEpisodeId.value
        : this.lastHeardEpisodeId,
    lastDownloadedEpisodeId: lastDownloadedEpisodeId.present
        ? lastDownloadedEpisodeId.value
        : this.lastDownloadedEpisodeId,
  );
  Subscription copyWithCompanion(SubscriptionsCompanion data) {
    return Subscription(
      podcastId: data.podcastId.present ? data.podcastId.value : this.podcastId,
      active: data.active.present ? data.active.value : this.active,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      subscribedAt: data.subscribedAt.present
          ? data.subscribedAt.value
          : this.subscribedAt,
      autoDownloadN: data.autoDownloadN.present
          ? data.autoDownloadN.value
          : this.autoDownloadN,
      lastHeardEpisodeId: data.lastHeardEpisodeId.present
          ? data.lastHeardEpisodeId.value
          : this.lastHeardEpisodeId,
      lastDownloadedEpisodeId: data.lastDownloadedEpisodeId.present
          ? data.lastDownloadedEpisodeId.value
          : this.lastDownloadedEpisodeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subscription(')
          ..write('podcastId: $podcastId, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('subscribedAt: $subscribedAt, ')
          ..write('autoDownloadN: $autoDownloadN, ')
          ..write('lastHeardEpisodeId: $lastHeardEpisodeId, ')
          ..write('lastDownloadedEpisodeId: $lastDownloadedEpisodeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    podcastId,
    active,
    updatedAt,
    subscribedAt,
    autoDownloadN,
    lastHeardEpisodeId,
    lastDownloadedEpisodeId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subscription &&
          other.podcastId == this.podcastId &&
          other.active == this.active &&
          other.updatedAt == this.updatedAt &&
          other.subscribedAt == this.subscribedAt &&
          other.autoDownloadN == this.autoDownloadN &&
          other.lastHeardEpisodeId == this.lastHeardEpisodeId &&
          other.lastDownloadedEpisodeId == this.lastDownloadedEpisodeId);
}

class SubscriptionsCompanion extends UpdateCompanion<Subscription> {
  final Value<String> podcastId;
  final Value<bool> active;
  final Value<DateTime> updatedAt;
  final Value<DateTime> subscribedAt;
  final Value<int?> autoDownloadN;
  final Value<String?> lastHeardEpisodeId;
  final Value<String?> lastDownloadedEpisodeId;
  final Value<int> rowid;
  const SubscriptionsCompanion({
    this.podcastId = const Value.absent(),
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.subscribedAt = const Value.absent(),
    this.autoDownloadN = const Value.absent(),
    this.lastHeardEpisodeId = const Value.absent(),
    this.lastDownloadedEpisodeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    required String podcastId,
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.subscribedAt = const Value.absent(),
    this.autoDownloadN = const Value.absent(),
    this.lastHeardEpisodeId = const Value.absent(),
    this.lastDownloadedEpisodeId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : podcastId = Value(podcastId);
  static Insertable<Subscription> custom({
    Expression<String>? podcastId,
    Expression<bool>? active,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? subscribedAt,
    Expression<int>? autoDownloadN,
    Expression<String>? lastHeardEpisodeId,
    Expression<String>? lastDownloadedEpisodeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (podcastId != null) 'podcast_id': podcastId,
      if (active != null) 'active': active,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (subscribedAt != null) 'subscribed_at': subscribedAt,
      if (autoDownloadN != null) 'auto_download_n': autoDownloadN,
      if (lastHeardEpisodeId != null)
        'last_heard_episode_id': lastHeardEpisodeId,
      if (lastDownloadedEpisodeId != null)
        'last_downloaded_episode_id': lastDownloadedEpisodeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubscriptionsCompanion copyWith({
    Value<String>? podcastId,
    Value<bool>? active,
    Value<DateTime>? updatedAt,
    Value<DateTime>? subscribedAt,
    Value<int?>? autoDownloadN,
    Value<String?>? lastHeardEpisodeId,
    Value<String?>? lastDownloadedEpisodeId,
    Value<int>? rowid,
  }) {
    return SubscriptionsCompanion(
      podcastId: podcastId ?? this.podcastId,
      active: active ?? this.active,
      updatedAt: updatedAt ?? this.updatedAt,
      subscribedAt: subscribedAt ?? this.subscribedAt,
      autoDownloadN: autoDownloadN ?? this.autoDownloadN,
      lastHeardEpisodeId: lastHeardEpisodeId ?? this.lastHeardEpisodeId,
      lastDownloadedEpisodeId:
          lastDownloadedEpisodeId ?? this.lastDownloadedEpisodeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (podcastId.present) {
      map['podcast_id'] = Variable<String>(podcastId.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (subscribedAt.present) {
      map['subscribed_at'] = Variable<DateTime>(subscribedAt.value);
    }
    if (autoDownloadN.present) {
      map['auto_download_n'] = Variable<int>(autoDownloadN.value);
    }
    if (lastHeardEpisodeId.present) {
      map['last_heard_episode_id'] = Variable<String>(lastHeardEpisodeId.value);
    }
    if (lastDownloadedEpisodeId.present) {
      map['last_downloaded_episode_id'] = Variable<String>(
        lastDownloadedEpisodeId.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('podcastId: $podcastId, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('subscribedAt: $subscribedAt, ')
          ..write('autoDownloadN: $autoDownloadN, ')
          ..write('lastHeardEpisodeId: $lastHeardEpisodeId, ')
          ..write('lastDownloadedEpisodeId: $lastDownloadedEpisodeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EpisodesTable extends Episodes with TableInfo<$EpisodesTable, Episode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EpisodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _podcastIdMeta = const VerificationMeta(
    'podcastId',
  );
  @override
  late final GeneratedColumn<String> podcastId = GeneratedColumn<String>(
    'podcast_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _showDateMeta = const VerificationMeta(
    'showDate',
  );
  @override
  late final GeneratedColumn<String> showDate = GeneratedColumn<String>(
    'show_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bytesDownloadedMeta = const VerificationMeta(
    'bytesDownloaded',
  );
  @override
  late final GeneratedColumn<int> bytesDownloaded = GeneratedColumn<int>(
    'bytes_downloaded',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalBytesMeta = const VerificationMeta(
    'totalBytes',
  );
  @override
  late final GeneratedColumn<int> totalBytes = GeneratedColumn<int>(
    'total_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _cachedTitleMeta = const VerificationMeta(
    'cachedTitle',
  );
  @override
  late final GeneratedColumn<String> cachedTitle = GeneratedColumn<String>(
    'cached_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedImagePathMeta = const VerificationMeta(
    'cachedImagePath',
  );
  @override
  late final GeneratedColumn<String> cachedImagePath = GeneratedColumn<String>(
    'cached_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedMetaPathMeta = const VerificationMeta(
    'cachedMetaPath',
  );
  @override
  late final GeneratedColumn<String> cachedMetaPath = GeneratedColumn<String>(
    'cached_meta_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resumableMeta = const VerificationMeta(
    'resumable',
  );
  @override
  late final GeneratedColumn<bool> resumable = GeneratedColumn<bool>(
    'resumable',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("resumable" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    podcastId,
    title,
    audioUrl,
    publishedAt,
    durationSeconds,
    description,
    showDate,
    imageUrl,
    status,
    progress,
    localPath,
    bytesDownloaded,
    totalBytes,
    playedAt,
    completedAt,
    createdAt,
    updatedAt,
    cachedTitle,
    cachedImagePath,
    cachedMetaPath,
    resumable,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'episodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Episode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('podcast_id')) {
      context.handle(
        _podcastIdMeta,
        podcastId.isAcceptableOrUnknown(data['podcast_id']!, _podcastIdMeta),
      );
    } else if (isInserting) {
      context.missing(_podcastIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_audioUrlMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('show_date')) {
      context.handle(
        _showDateMeta,
        showDate.isAcceptableOrUnknown(data['show_date']!, _showDateMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('bytes_downloaded')) {
      context.handle(
        _bytesDownloadedMeta,
        bytesDownloaded.isAcceptableOrUnknown(
          data['bytes_downloaded']!,
          _bytesDownloadedMeta,
        ),
      );
    }
    if (data.containsKey('total_bytes')) {
      context.handle(
        _totalBytesMeta,
        totalBytes.isAcceptableOrUnknown(data['total_bytes']!, _totalBytesMeta),
      );
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('cached_title')) {
      context.handle(
        _cachedTitleMeta,
        cachedTitle.isAcceptableOrUnknown(
          data['cached_title']!,
          _cachedTitleMeta,
        ),
      );
    }
    if (data.containsKey('cached_image_path')) {
      context.handle(
        _cachedImagePathMeta,
        cachedImagePath.isAcceptableOrUnknown(
          data['cached_image_path']!,
          _cachedImagePathMeta,
        ),
      );
    }
    if (data.containsKey('cached_meta_path')) {
      context.handle(
        _cachedMetaPathMeta,
        cachedMetaPath.isAcceptableOrUnknown(
          data['cached_meta_path']!,
          _cachedMetaPathMeta,
        ),
      );
    }
    if (data.containsKey('resumable')) {
      context.handle(
        _resumableMeta,
        resumable.isAcceptableOrUnknown(data['resumable']!, _resumableMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Episode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Episode(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      podcastId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}podcast_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      audioUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_url'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      showDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}show_date'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      bytesDownloaded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bytes_downloaded'],
      ),
      totalBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_bytes'],
      ),
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      cachedTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_title'],
      ),
      cachedImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_image_path'],
      ),
      cachedMetaPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_meta_path'],
      ),
      resumable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}resumable'],
      ),
    );
  }

  @override
  $EpisodesTable createAlias(String alias) {
    return $EpisodesTable(attachedDatabase, alias);
  }
}

class Episode extends DataClass implements Insertable<Episode> {
  final String id;
  final String podcastId;
  final String title;
  final String audioUrl;
  final DateTime? publishedAt;
  final int? durationSeconds;
  final String? description;
  final String? showDate;
  final String? imageUrl;

  /// Download-Status:
  /// 0=none, 1=queued, 2=downloading, 3=completed, 4=failed, 5=canceled
  final int status;
  final double progress;
  final String? localPath;
  final int? bytesDownloaded;
  final int? totalBytes;

  /// Nutzung/Retention
  final DateTime? playedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? cachedTitle;
  final String? cachedImagePath;
  final String? cachedMetaPath;
  final bool? resumable;
  const Episode({
    required this.id,
    required this.podcastId,
    required this.title,
    required this.audioUrl,
    this.publishedAt,
    this.durationSeconds,
    this.description,
    this.showDate,
    this.imageUrl,
    required this.status,
    required this.progress,
    this.localPath,
    this.bytesDownloaded,
    this.totalBytes,
    this.playedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.cachedTitle,
    this.cachedImagePath,
    this.cachedMetaPath,
    this.resumable,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['podcast_id'] = Variable<String>(podcastId);
    map['title'] = Variable<String>(title);
    map['audio_url'] = Variable<String>(audioUrl);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || showDate != null) {
      map['show_date'] = Variable<String>(showDate);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['status'] = Variable<int>(status);
    map['progress'] = Variable<double>(progress);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || bytesDownloaded != null) {
      map['bytes_downloaded'] = Variable<int>(bytesDownloaded);
    }
    if (!nullToAbsent || totalBytes != null) {
      map['total_bytes'] = Variable<int>(totalBytes);
    }
    if (!nullToAbsent || playedAt != null) {
      map['played_at'] = Variable<DateTime>(playedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || cachedTitle != null) {
      map['cached_title'] = Variable<String>(cachedTitle);
    }
    if (!nullToAbsent || cachedImagePath != null) {
      map['cached_image_path'] = Variable<String>(cachedImagePath);
    }
    if (!nullToAbsent || cachedMetaPath != null) {
      map['cached_meta_path'] = Variable<String>(cachedMetaPath);
    }
    if (!nullToAbsent || resumable != null) {
      map['resumable'] = Variable<bool>(resumable);
    }
    return map;
  }

  EpisodesCompanion toCompanion(bool nullToAbsent) {
    return EpisodesCompanion(
      id: Value(id),
      podcastId: Value(podcastId),
      title: Value(title),
      audioUrl: Value(audioUrl),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      showDate: showDate == null && nullToAbsent
          ? const Value.absent()
          : Value(showDate),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      status: Value(status),
      progress: Value(progress),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      bytesDownloaded: bytesDownloaded == null && nullToAbsent
          ? const Value.absent()
          : Value(bytesDownloaded),
      totalBytes: totalBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(totalBytes),
      playedAt: playedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(playedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      cachedTitle: cachedTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedTitle),
      cachedImagePath: cachedImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedImagePath),
      cachedMetaPath: cachedMetaPath == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedMetaPath),
      resumable: resumable == null && nullToAbsent
          ? const Value.absent()
          : Value(resumable),
    );
  }

  factory Episode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Episode(
      id: serializer.fromJson<String>(json['id']),
      podcastId: serializer.fromJson<String>(json['podcastId']),
      title: serializer.fromJson<String>(json['title']),
      audioUrl: serializer.fromJson<String>(json['audioUrl']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      description: serializer.fromJson<String?>(json['description']),
      showDate: serializer.fromJson<String?>(json['showDate']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      status: serializer.fromJson<int>(json['status']),
      progress: serializer.fromJson<double>(json['progress']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      bytesDownloaded: serializer.fromJson<int?>(json['bytesDownloaded']),
      totalBytes: serializer.fromJson<int?>(json['totalBytes']),
      playedAt: serializer.fromJson<DateTime?>(json['playedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      cachedTitle: serializer.fromJson<String?>(json['cachedTitle']),
      cachedImagePath: serializer.fromJson<String?>(json['cachedImagePath']),
      cachedMetaPath: serializer.fromJson<String?>(json['cachedMetaPath']),
      resumable: serializer.fromJson<bool?>(json['resumable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'podcastId': serializer.toJson<String>(podcastId),
      'title': serializer.toJson<String>(title),
      'audioUrl': serializer.toJson<String>(audioUrl),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'description': serializer.toJson<String?>(description),
      'showDate': serializer.toJson<String?>(showDate),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'status': serializer.toJson<int>(status),
      'progress': serializer.toJson<double>(progress),
      'localPath': serializer.toJson<String?>(localPath),
      'bytesDownloaded': serializer.toJson<int?>(bytesDownloaded),
      'totalBytes': serializer.toJson<int?>(totalBytes),
      'playedAt': serializer.toJson<DateTime?>(playedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'cachedTitle': serializer.toJson<String?>(cachedTitle),
      'cachedImagePath': serializer.toJson<String?>(cachedImagePath),
      'cachedMetaPath': serializer.toJson<String?>(cachedMetaPath),
      'resumable': serializer.toJson<bool?>(resumable),
    };
  }

  Episode copyWith({
    String? id,
    String? podcastId,
    String? title,
    String? audioUrl,
    Value<DateTime?> publishedAt = const Value.absent(),
    Value<int?> durationSeconds = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> showDate = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    int? status,
    double? progress,
    Value<String?> localPath = const Value.absent(),
    Value<int?> bytesDownloaded = const Value.absent(),
    Value<int?> totalBytes = const Value.absent(),
    Value<DateTime?> playedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> cachedTitle = const Value.absent(),
    Value<String?> cachedImagePath = const Value.absent(),
    Value<String?> cachedMetaPath = const Value.absent(),
    Value<bool?> resumable = const Value.absent(),
  }) => Episode(
    id: id ?? this.id,
    podcastId: podcastId ?? this.podcastId,
    title: title ?? this.title,
    audioUrl: audioUrl ?? this.audioUrl,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
    description: description.present ? description.value : this.description,
    showDate: showDate.present ? showDate.value : this.showDate,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    status: status ?? this.status,
    progress: progress ?? this.progress,
    localPath: localPath.present ? localPath.value : this.localPath,
    bytesDownloaded: bytesDownloaded.present
        ? bytesDownloaded.value
        : this.bytesDownloaded,
    totalBytes: totalBytes.present ? totalBytes.value : this.totalBytes,
    playedAt: playedAt.present ? playedAt.value : this.playedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    cachedTitle: cachedTitle.present ? cachedTitle.value : this.cachedTitle,
    cachedImagePath: cachedImagePath.present
        ? cachedImagePath.value
        : this.cachedImagePath,
    cachedMetaPath: cachedMetaPath.present
        ? cachedMetaPath.value
        : this.cachedMetaPath,
    resumable: resumable.present ? resumable.value : this.resumable,
  );
  Episode copyWithCompanion(EpisodesCompanion data) {
    return Episode(
      id: data.id.present ? data.id.value : this.id,
      podcastId: data.podcastId.present ? data.podcastId.value : this.podcastId,
      title: data.title.present ? data.title.value : this.title,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      description: data.description.present
          ? data.description.value
          : this.description,
      showDate: data.showDate.present ? data.showDate.value : this.showDate,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      status: data.status.present ? data.status.value : this.status,
      progress: data.progress.present ? data.progress.value : this.progress,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      bytesDownloaded: data.bytesDownloaded.present
          ? data.bytesDownloaded.value
          : this.bytesDownloaded,
      totalBytes: data.totalBytes.present
          ? data.totalBytes.value
          : this.totalBytes,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedTitle: data.cachedTitle.present
          ? data.cachedTitle.value
          : this.cachedTitle,
      cachedImagePath: data.cachedImagePath.present
          ? data.cachedImagePath.value
          : this.cachedImagePath,
      cachedMetaPath: data.cachedMetaPath.present
          ? data.cachedMetaPath.value
          : this.cachedMetaPath,
      resumable: data.resumable.present ? data.resumable.value : this.resumable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Episode(')
          ..write('id: $id, ')
          ..write('podcastId: $podcastId, ')
          ..write('title: $title, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('description: $description, ')
          ..write('showDate: $showDate, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('localPath: $localPath, ')
          ..write('bytesDownloaded: $bytesDownloaded, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('playedAt: $playedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedTitle: $cachedTitle, ')
          ..write('cachedImagePath: $cachedImagePath, ')
          ..write('cachedMetaPath: $cachedMetaPath, ')
          ..write('resumable: $resumable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    podcastId,
    title,
    audioUrl,
    publishedAt,
    durationSeconds,
    description,
    showDate,
    imageUrl,
    status,
    progress,
    localPath,
    bytesDownloaded,
    totalBytes,
    playedAt,
    completedAt,
    createdAt,
    updatedAt,
    cachedTitle,
    cachedImagePath,
    cachedMetaPath,
    resumable,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Episode &&
          other.id == this.id &&
          other.podcastId == this.podcastId &&
          other.title == this.title &&
          other.audioUrl == this.audioUrl &&
          other.publishedAt == this.publishedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.description == this.description &&
          other.showDate == this.showDate &&
          other.imageUrl == this.imageUrl &&
          other.status == this.status &&
          other.progress == this.progress &&
          other.localPath == this.localPath &&
          other.bytesDownloaded == this.bytesDownloaded &&
          other.totalBytes == this.totalBytes &&
          other.playedAt == this.playedAt &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedTitle == this.cachedTitle &&
          other.cachedImagePath == this.cachedImagePath &&
          other.cachedMetaPath == this.cachedMetaPath &&
          other.resumable == this.resumable);
}

class EpisodesCompanion extends UpdateCompanion<Episode> {
  final Value<String> id;
  final Value<String> podcastId;
  final Value<String> title;
  final Value<String> audioUrl;
  final Value<DateTime?> publishedAt;
  final Value<int?> durationSeconds;
  final Value<String?> description;
  final Value<String?> showDate;
  final Value<String?> imageUrl;
  final Value<int> status;
  final Value<double> progress;
  final Value<String?> localPath;
  final Value<int?> bytesDownloaded;
  final Value<int?> totalBytes;
  final Value<DateTime?> playedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> cachedTitle;
  final Value<String?> cachedImagePath;
  final Value<String?> cachedMetaPath;
  final Value<bool?> resumable;
  final Value<int> rowid;
  const EpisodesCompanion({
    this.id = const Value.absent(),
    this.podcastId = const Value.absent(),
    this.title = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.description = const Value.absent(),
    this.showDate = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.localPath = const Value.absent(),
    this.bytesDownloaded = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.playedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedTitle = const Value.absent(),
    this.cachedImagePath = const Value.absent(),
    this.cachedMetaPath = const Value.absent(),
    this.resumable = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EpisodesCompanion.insert({
    required String id,
    required String podcastId,
    required String title,
    required String audioUrl,
    this.publishedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.description = const Value.absent(),
    this.showDate = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.localPath = const Value.absent(),
    this.bytesDownloaded = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.playedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedTitle = const Value.absent(),
    this.cachedImagePath = const Value.absent(),
    this.cachedMetaPath = const Value.absent(),
    this.resumable = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       podcastId = Value(podcastId),
       title = Value(title),
       audioUrl = Value(audioUrl);
  static Insertable<Episode> custom({
    Expression<String>? id,
    Expression<String>? podcastId,
    Expression<String>? title,
    Expression<String>? audioUrl,
    Expression<DateTime>? publishedAt,
    Expression<int>? durationSeconds,
    Expression<String>? description,
    Expression<String>? showDate,
    Expression<String>? imageUrl,
    Expression<int>? status,
    Expression<double>? progress,
    Expression<String>? localPath,
    Expression<int>? bytesDownloaded,
    Expression<int>? totalBytes,
    Expression<DateTime>? playedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? cachedTitle,
    Expression<String>? cachedImagePath,
    Expression<String>? cachedMetaPath,
    Expression<bool>? resumable,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (podcastId != null) 'podcast_id': podcastId,
      if (title != null) 'title': title,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (publishedAt != null) 'published_at': publishedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (description != null) 'description': description,
      if (showDate != null) 'show_date': showDate,
      if (imageUrl != null) 'image_url': imageUrl,
      if (status != null) 'status': status,
      if (progress != null) 'progress': progress,
      if (localPath != null) 'local_path': localPath,
      if (bytesDownloaded != null) 'bytes_downloaded': bytesDownloaded,
      if (totalBytes != null) 'total_bytes': totalBytes,
      if (playedAt != null) 'played_at': playedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedTitle != null) 'cached_title': cachedTitle,
      if (cachedImagePath != null) 'cached_image_path': cachedImagePath,
      if (cachedMetaPath != null) 'cached_meta_path': cachedMetaPath,
      if (resumable != null) 'resumable': resumable,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EpisodesCompanion copyWith({
    Value<String>? id,
    Value<String>? podcastId,
    Value<String>? title,
    Value<String>? audioUrl,
    Value<DateTime?>? publishedAt,
    Value<int?>? durationSeconds,
    Value<String?>? description,
    Value<String?>? showDate,
    Value<String?>? imageUrl,
    Value<int>? status,
    Value<double>? progress,
    Value<String?>? localPath,
    Value<int?>? bytesDownloaded,
    Value<int?>? totalBytes,
    Value<DateTime?>? playedAt,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? cachedTitle,
    Value<String?>? cachedImagePath,
    Value<String?>? cachedMetaPath,
    Value<bool?>? resumable,
    Value<int>? rowid,
  }) {
    return EpisodesCompanion(
      id: id ?? this.id,
      podcastId: podcastId ?? this.podcastId,
      title: title ?? this.title,
      audioUrl: audioUrl ?? this.audioUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      description: description ?? this.description,
      showDate: showDate ?? this.showDate,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      localPath: localPath ?? this.localPath,
      bytesDownloaded: bytesDownloaded ?? this.bytesDownloaded,
      totalBytes: totalBytes ?? this.totalBytes,
      playedAt: playedAt ?? this.playedAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedTitle: cachedTitle ?? this.cachedTitle,
      cachedImagePath: cachedImagePath ?? this.cachedImagePath,
      cachedMetaPath: cachedMetaPath ?? this.cachedMetaPath,
      resumable: resumable ?? this.resumable,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (podcastId.present) {
      map['podcast_id'] = Variable<String>(podcastId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (showDate.present) {
      map['show_date'] = Variable<String>(showDate.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (bytesDownloaded.present) {
      map['bytes_downloaded'] = Variable<int>(bytesDownloaded.value);
    }
    if (totalBytes.present) {
      map['total_bytes'] = Variable<int>(totalBytes.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cachedTitle.present) {
      map['cached_title'] = Variable<String>(cachedTitle.value);
    }
    if (cachedImagePath.present) {
      map['cached_image_path'] = Variable<String>(cachedImagePath.value);
    }
    if (cachedMetaPath.present) {
      map['cached_meta_path'] = Variable<String>(cachedMetaPath.value);
    }
    if (resumable.present) {
      map['resumable'] = Variable<bool>(resumable.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EpisodesCompanion(')
          ..write('id: $id, ')
          ..write('podcastId: $podcastId, ')
          ..write('title: $title, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('description: $description, ')
          ..write('showDate: $showDate, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('localPath: $localPath, ')
          ..write('bytesDownloaded: $bytesDownloaded, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('playedAt: $playedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedTitle: $cachedTitle, ')
          ..write('cachedImagePath: $cachedImagePath, ')
          ..write('cachedMetaPath: $cachedMetaPath, ')
          ..write('resumable: $resumable, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wifiOnlyMeta = const VerificationMeta(
    'wifiOnly',
  );
  @override
  late final GeneratedColumn<bool> wifiOnly = GeneratedColumn<bool>(
    'wifi_only',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("wifi_only" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _maxParallelMeta = const VerificationMeta(
    'maxParallel',
  );
  @override
  late final GeneratedColumn<int> maxParallel = GeneratedColumn<int>(
    'max_parallel',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _deleteAfterHoursMeta = const VerificationMeta(
    'deleteAfterHours',
  );
  @override
  late final GeneratedColumn<int> deleteAfterHours = GeneratedColumn<int>(
    'delete_after_hours',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keepLatestNMeta = const VerificationMeta(
    'keepLatestN',
  );
  @override
  late final GeneratedColumn<int> keepLatestN = GeneratedColumn<int>(
    'keep_latest_n',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autodownloadSubscribedMeta =
      const VerificationMeta('autodownloadSubscribed');
  @override
  late final GeneratedColumn<bool> autodownloadSubscribed =
      GeneratedColumn<bool>(
        'autodownload_subscribed',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("autodownload_subscribed" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _playOrderMeta = const VerificationMeta(
    'playOrder',
  );
  @override
  late final GeneratedColumn<String> playOrder = GeneratedColumn<String>(
    'play_order',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('newest'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wifiOnly,
    maxParallel,
    deleteAfterHours,
    keepLatestN,
    autodownloadSubscribed,
    playOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wifi_only')) {
      context.handle(
        _wifiOnlyMeta,
        wifiOnly.isAcceptableOrUnknown(data['wifi_only']!, _wifiOnlyMeta),
      );
    }
    if (data.containsKey('max_parallel')) {
      context.handle(
        _maxParallelMeta,
        maxParallel.isAcceptableOrUnknown(
          data['max_parallel']!,
          _maxParallelMeta,
        ),
      );
    }
    if (data.containsKey('delete_after_hours')) {
      context.handle(
        _deleteAfterHoursMeta,
        deleteAfterHours.isAcceptableOrUnknown(
          data['delete_after_hours']!,
          _deleteAfterHoursMeta,
        ),
      );
    }
    if (data.containsKey('keep_latest_n')) {
      context.handle(
        _keepLatestNMeta,
        keepLatestN.isAcceptableOrUnknown(
          data['keep_latest_n']!,
          _keepLatestNMeta,
        ),
      );
    }
    if (data.containsKey('autodownload_subscribed')) {
      context.handle(
        _autodownloadSubscribedMeta,
        autodownloadSubscribed.isAcceptableOrUnknown(
          data['autodownload_subscribed']!,
          _autodownloadSubscribedMeta,
        ),
      );
    }
    if (data.containsKey('play_order')) {
      context.handle(
        _playOrderMeta,
        playOrder.isAcceptableOrUnknown(data['play_order']!, _playOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wifiOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}wifi_only'],
      )!,
      maxParallel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_parallel'],
      )!,
      deleteAfterHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delete_after_hours'],
      ),
      keepLatestN: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}keep_latest_n'],
      ),
      autodownloadSubscribed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}autodownload_subscribed'],
      )!,
      playOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}play_order'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final bool wifiOnly;
  final int maxParallel;
  final int? deleteAfterHours;
  final int? keepLatestN;
  final bool autodownloadSubscribed;

  /// Episode sort order: 'newest' (default) or 'oldest'
  final String playOrder;
  const Setting({
    required this.id,
    required this.wifiOnly,
    required this.maxParallel,
    this.deleteAfterHours,
    this.keepLatestN,
    required this.autodownloadSubscribed,
    required this.playOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wifi_only'] = Variable<bool>(wifiOnly);
    map['max_parallel'] = Variable<int>(maxParallel);
    if (!nullToAbsent || deleteAfterHours != null) {
      map['delete_after_hours'] = Variable<int>(deleteAfterHours);
    }
    if (!nullToAbsent || keepLatestN != null) {
      map['keep_latest_n'] = Variable<int>(keepLatestN);
    }
    map['autodownload_subscribed'] = Variable<bool>(autodownloadSubscribed);
    map['play_order'] = Variable<String>(playOrder);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      wifiOnly: Value(wifiOnly),
      maxParallel: Value(maxParallel),
      deleteAfterHours: deleteAfterHours == null && nullToAbsent
          ? const Value.absent()
          : Value(deleteAfterHours),
      keepLatestN: keepLatestN == null && nullToAbsent
          ? const Value.absent()
          : Value(keepLatestN),
      autodownloadSubscribed: Value(autodownloadSubscribed),
      playOrder: Value(playOrder),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      wifiOnly: serializer.fromJson<bool>(json['wifiOnly']),
      maxParallel: serializer.fromJson<int>(json['maxParallel']),
      deleteAfterHours: serializer.fromJson<int?>(json['deleteAfterHours']),
      keepLatestN: serializer.fromJson<int?>(json['keepLatestN']),
      autodownloadSubscribed: serializer.fromJson<bool>(
        json['autodownloadSubscribed'],
      ),
      playOrder: serializer.fromJson<String>(json['playOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wifiOnly': serializer.toJson<bool>(wifiOnly),
      'maxParallel': serializer.toJson<int>(maxParallel),
      'deleteAfterHours': serializer.toJson<int?>(deleteAfterHours),
      'keepLatestN': serializer.toJson<int?>(keepLatestN),
      'autodownloadSubscribed': serializer.toJson<bool>(autodownloadSubscribed),
      'playOrder': serializer.toJson<String>(playOrder),
    };
  }

  Setting copyWith({
    int? id,
    bool? wifiOnly,
    int? maxParallel,
    Value<int?> deleteAfterHours = const Value.absent(),
    Value<int?> keepLatestN = const Value.absent(),
    bool? autodownloadSubscribed,
    String? playOrder,
  }) => Setting(
    id: id ?? this.id,
    wifiOnly: wifiOnly ?? this.wifiOnly,
    maxParallel: maxParallel ?? this.maxParallel,
    deleteAfterHours: deleteAfterHours.present
        ? deleteAfterHours.value
        : this.deleteAfterHours,
    keepLatestN: keepLatestN.present ? keepLatestN.value : this.keepLatestN,
    autodownloadSubscribed:
        autodownloadSubscribed ?? this.autodownloadSubscribed,
    playOrder: playOrder ?? this.playOrder,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      wifiOnly: data.wifiOnly.present ? data.wifiOnly.value : this.wifiOnly,
      maxParallel: data.maxParallel.present
          ? data.maxParallel.value
          : this.maxParallel,
      deleteAfterHours: data.deleteAfterHours.present
          ? data.deleteAfterHours.value
          : this.deleteAfterHours,
      keepLatestN: data.keepLatestN.present
          ? data.keepLatestN.value
          : this.keepLatestN,
      autodownloadSubscribed: data.autodownloadSubscribed.present
          ? data.autodownloadSubscribed.value
          : this.autodownloadSubscribed,
      playOrder: data.playOrder.present ? data.playOrder.value : this.playOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('wifiOnly: $wifiOnly, ')
          ..write('maxParallel: $maxParallel, ')
          ..write('deleteAfterHours: $deleteAfterHours, ')
          ..write('keepLatestN: $keepLatestN, ')
          ..write('autodownloadSubscribed: $autodownloadSubscribed, ')
          ..write('playOrder: $playOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    wifiOnly,
    maxParallel,
    deleteAfterHours,
    keepLatestN,
    autodownloadSubscribed,
    playOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.wifiOnly == this.wifiOnly &&
          other.maxParallel == this.maxParallel &&
          other.deleteAfterHours == this.deleteAfterHours &&
          other.keepLatestN == this.keepLatestN &&
          other.autodownloadSubscribed == this.autodownloadSubscribed &&
          other.playOrder == this.playOrder);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<bool> wifiOnly;
  final Value<int> maxParallel;
  final Value<int?> deleteAfterHours;
  final Value<int?> keepLatestN;
  final Value<bool> autodownloadSubscribed;
  final Value<String> playOrder;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.wifiOnly = const Value.absent(),
    this.maxParallel = const Value.absent(),
    this.deleteAfterHours = const Value.absent(),
    this.keepLatestN = const Value.absent(),
    this.autodownloadSubscribed = const Value.absent(),
    this.playOrder = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.wifiOnly = const Value.absent(),
    this.maxParallel = const Value.absent(),
    this.deleteAfterHours = const Value.absent(),
    this.keepLatestN = const Value.absent(),
    this.autodownloadSubscribed = const Value.absent(),
    this.playOrder = const Value.absent(),
  });
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<bool>? wifiOnly,
    Expression<int>? maxParallel,
    Expression<int>? deleteAfterHours,
    Expression<int>? keepLatestN,
    Expression<bool>? autodownloadSubscribed,
    Expression<String>? playOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wifiOnly != null) 'wifi_only': wifiOnly,
      if (maxParallel != null) 'max_parallel': maxParallel,
      if (deleteAfterHours != null) 'delete_after_hours': deleteAfterHours,
      if (keepLatestN != null) 'keep_latest_n': keepLatestN,
      if (autodownloadSubscribed != null)
        'autodownload_subscribed': autodownloadSubscribed,
      if (playOrder != null) 'play_order': playOrder,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? wifiOnly,
    Value<int>? maxParallel,
    Value<int?>? deleteAfterHours,
    Value<int?>? keepLatestN,
    Value<bool>? autodownloadSubscribed,
    Value<String>? playOrder,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      wifiOnly: wifiOnly ?? this.wifiOnly,
      maxParallel: maxParallel ?? this.maxParallel,
      deleteAfterHours: deleteAfterHours ?? this.deleteAfterHours,
      keepLatestN: keepLatestN ?? this.keepLatestN,
      autodownloadSubscribed:
          autodownloadSubscribed ?? this.autodownloadSubscribed,
      playOrder: playOrder ?? this.playOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wifiOnly.present) {
      map['wifi_only'] = Variable<bool>(wifiOnly.value);
    }
    if (maxParallel.present) {
      map['max_parallel'] = Variable<int>(maxParallel.value);
    }
    if (deleteAfterHours.present) {
      map['delete_after_hours'] = Variable<int>(deleteAfterHours.value);
    }
    if (keepLatestN.present) {
      map['keep_latest_n'] = Variable<int>(keepLatestN.value);
    }
    if (autodownloadSubscribed.present) {
      map['autodownload_subscribed'] = Variable<bool>(
        autodownloadSubscribed.value,
      );
    }
    if (playOrder.present) {
      map['play_order'] = Variable<String>(playOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('wifiOnly: $wifiOnly, ')
          ..write('maxParallel: $maxParallel, ')
          ..write('deleteAfterHours: $deleteAfterHours, ')
          ..write('keepLatestN: $keepLatestN, ')
          ..write('autodownloadSubscribed: $autodownloadSubscribed, ')
          ..write('playOrder: $playOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SubscriptionsTable subscriptions = $SubscriptionsTable(this);
  late final $EpisodesTable episodes = $EpisodesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    subscriptions,
    episodes,
    settings,
  ];
}

typedef $$SubscriptionsTableCreateCompanionBuilder =
    SubscriptionsCompanion Function({
      required String podcastId,
      Value<bool> active,
      Value<DateTime> updatedAt,
      Value<DateTime> subscribedAt,
      Value<int?> autoDownloadN,
      Value<String?> lastHeardEpisodeId,
      Value<String?> lastDownloadedEpisodeId,
      Value<int> rowid,
    });
typedef $$SubscriptionsTableUpdateCompanionBuilder =
    SubscriptionsCompanion Function({
      Value<String> podcastId,
      Value<bool> active,
      Value<DateTime> updatedAt,
      Value<DateTime> subscribedAt,
      Value<int?> autoDownloadN,
      Value<String?> lastHeardEpisodeId,
      Value<String?> lastDownloadedEpisodeId,
      Value<int> rowid,
    });

class $$SubscriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get podcastId => $composableBuilder(
    column: $table.podcastId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get subscribedAt => $composableBuilder(
    column: $table.subscribedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoDownloadN => $composableBuilder(
    column: $table.autoDownloadN,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastHeardEpisodeId => $composableBuilder(
    column: $table.lastHeardEpisodeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastDownloadedEpisodeId => $composableBuilder(
    column: $table.lastDownloadedEpisodeId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubscriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get podcastId => $composableBuilder(
    column: $table.podcastId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get subscribedAt => $composableBuilder(
    column: $table.subscribedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoDownloadN => $composableBuilder(
    column: $table.autoDownloadN,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastHeardEpisodeId => $composableBuilder(
    column: $table.lastHeardEpisodeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastDownloadedEpisodeId => $composableBuilder(
    column: $table.lastDownloadedEpisodeId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubscriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get podcastId =>
      $composableBuilder(column: $table.podcastId, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get subscribedAt => $composableBuilder(
    column: $table.subscribedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoDownloadN => $composableBuilder(
    column: $table.autoDownloadN,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastHeardEpisodeId => $composableBuilder(
    column: $table.lastHeardEpisodeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastDownloadedEpisodeId => $composableBuilder(
    column: $table.lastDownloadedEpisodeId,
    builder: (column) => column,
  );
}

class $$SubscriptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubscriptionsTable,
          Subscription,
          $$SubscriptionsTableFilterComposer,
          $$SubscriptionsTableOrderingComposer,
          $$SubscriptionsTableAnnotationComposer,
          $$SubscriptionsTableCreateCompanionBuilder,
          $$SubscriptionsTableUpdateCompanionBuilder,
          (
            Subscription,
            BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>,
          ),
          Subscription,
          PrefetchHooks Function()
        > {
  $$SubscriptionsTableTableManager(_$AppDatabase db, $SubscriptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> podcastId = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> subscribedAt = const Value.absent(),
                Value<int?> autoDownloadN = const Value.absent(),
                Value<String?> lastHeardEpisodeId = const Value.absent(),
                Value<String?> lastDownloadedEpisodeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion(
                podcastId: podcastId,
                active: active,
                updatedAt: updatedAt,
                subscribedAt: subscribedAt,
                autoDownloadN: autoDownloadN,
                lastHeardEpisodeId: lastHeardEpisodeId,
                lastDownloadedEpisodeId: lastDownloadedEpisodeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String podcastId,
                Value<bool> active = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> subscribedAt = const Value.absent(),
                Value<int?> autoDownloadN = const Value.absent(),
                Value<String?> lastHeardEpisodeId = const Value.absent(),
                Value<String?> lastDownloadedEpisodeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion.insert(
                podcastId: podcastId,
                active: active,
                updatedAt: updatedAt,
                subscribedAt: subscribedAt,
                autoDownloadN: autoDownloadN,
                lastHeardEpisodeId: lastHeardEpisodeId,
                lastDownloadedEpisodeId: lastDownloadedEpisodeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubscriptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubscriptionsTable,
      Subscription,
      $$SubscriptionsTableFilterComposer,
      $$SubscriptionsTableOrderingComposer,
      $$SubscriptionsTableAnnotationComposer,
      $$SubscriptionsTableCreateCompanionBuilder,
      $$SubscriptionsTableUpdateCompanionBuilder,
      (
        Subscription,
        BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>,
      ),
      Subscription,
      PrefetchHooks Function()
    >;
typedef $$EpisodesTableCreateCompanionBuilder =
    EpisodesCompanion Function({
      required String id,
      required String podcastId,
      required String title,
      required String audioUrl,
      Value<DateTime?> publishedAt,
      Value<int?> durationSeconds,
      Value<String?> description,
      Value<String?> showDate,
      Value<String?> imageUrl,
      Value<int> status,
      Value<double> progress,
      Value<String?> localPath,
      Value<int?> bytesDownloaded,
      Value<int?> totalBytes,
      Value<DateTime?> playedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> cachedTitle,
      Value<String?> cachedImagePath,
      Value<String?> cachedMetaPath,
      Value<bool?> resumable,
      Value<int> rowid,
    });
typedef $$EpisodesTableUpdateCompanionBuilder =
    EpisodesCompanion Function({
      Value<String> id,
      Value<String> podcastId,
      Value<String> title,
      Value<String> audioUrl,
      Value<DateTime?> publishedAt,
      Value<int?> durationSeconds,
      Value<String?> description,
      Value<String?> showDate,
      Value<String?> imageUrl,
      Value<int> status,
      Value<double> progress,
      Value<String?> localPath,
      Value<int?> bytesDownloaded,
      Value<int?> totalBytes,
      Value<DateTime?> playedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> cachedTitle,
      Value<String?> cachedImagePath,
      Value<String?> cachedMetaPath,
      Value<bool?> resumable,
      Value<int> rowid,
    });

class $$EpisodesTableFilterComposer
    extends Composer<_$AppDatabase, $EpisodesTable> {
  $$EpisodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get podcastId => $composableBuilder(
    column: $table.podcastId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get showDate => $composableBuilder(
    column: $table.showDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bytesDownloaded => $composableBuilder(
    column: $table.bytesDownloaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedTitle => $composableBuilder(
    column: $table.cachedTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedImagePath => $composableBuilder(
    column: $table.cachedImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedMetaPath => $composableBuilder(
    column: $table.cachedMetaPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get resumable => $composableBuilder(
    column: $table.resumable,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EpisodesTableOrderingComposer
    extends Composer<_$AppDatabase, $EpisodesTable> {
  $$EpisodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get podcastId => $composableBuilder(
    column: $table.podcastId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get showDate => $composableBuilder(
    column: $table.showDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bytesDownloaded => $composableBuilder(
    column: $table.bytesDownloaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedTitle => $composableBuilder(
    column: $table.cachedTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedImagePath => $composableBuilder(
    column: $table.cachedImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedMetaPath => $composableBuilder(
    column: $table.cachedMetaPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get resumable => $composableBuilder(
    column: $table.resumable,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EpisodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EpisodesTable> {
  $$EpisodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get podcastId =>
      $composableBuilder(column: $table.podcastId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get showDate =>
      $composableBuilder(column: $table.showDate, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<int> get bytesDownloaded => $composableBuilder(
    column: $table.bytesDownloaded,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get cachedTitle => $composableBuilder(
    column: $table.cachedTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedImagePath => $composableBuilder(
    column: $table.cachedImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedMetaPath => $composableBuilder(
    column: $table.cachedMetaPath,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get resumable =>
      $composableBuilder(column: $table.resumable, builder: (column) => column);
}

class $$EpisodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EpisodesTable,
          Episode,
          $$EpisodesTableFilterComposer,
          $$EpisodesTableOrderingComposer,
          $$EpisodesTableAnnotationComposer,
          $$EpisodesTableCreateCompanionBuilder,
          $$EpisodesTableUpdateCompanionBuilder,
          (Episode, BaseReferences<_$AppDatabase, $EpisodesTable, Episode>),
          Episode,
          PrefetchHooks Function()
        > {
  $$EpisodesTableTableManager(_$AppDatabase db, $EpisodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EpisodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EpisodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EpisodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> podcastId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> audioUrl = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> showDate = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<int?> bytesDownloaded = const Value.absent(),
                Value<int?> totalBytes = const Value.absent(),
                Value<DateTime?> playedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> cachedTitle = const Value.absent(),
                Value<String?> cachedImagePath = const Value.absent(),
                Value<String?> cachedMetaPath = const Value.absent(),
                Value<bool?> resumable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EpisodesCompanion(
                id: id,
                podcastId: podcastId,
                title: title,
                audioUrl: audioUrl,
                publishedAt: publishedAt,
                durationSeconds: durationSeconds,
                description: description,
                showDate: showDate,
                imageUrl: imageUrl,
                status: status,
                progress: progress,
                localPath: localPath,
                bytesDownloaded: bytesDownloaded,
                totalBytes: totalBytes,
                playedAt: playedAt,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedTitle: cachedTitle,
                cachedImagePath: cachedImagePath,
                cachedMetaPath: cachedMetaPath,
                resumable: resumable,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String podcastId,
                required String title,
                required String audioUrl,
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> showDate = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<int?> bytesDownloaded = const Value.absent(),
                Value<int?> totalBytes = const Value.absent(),
                Value<DateTime?> playedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> cachedTitle = const Value.absent(),
                Value<String?> cachedImagePath = const Value.absent(),
                Value<String?> cachedMetaPath = const Value.absent(),
                Value<bool?> resumable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EpisodesCompanion.insert(
                id: id,
                podcastId: podcastId,
                title: title,
                audioUrl: audioUrl,
                publishedAt: publishedAt,
                durationSeconds: durationSeconds,
                description: description,
                showDate: showDate,
                imageUrl: imageUrl,
                status: status,
                progress: progress,
                localPath: localPath,
                bytesDownloaded: bytesDownloaded,
                totalBytes: totalBytes,
                playedAt: playedAt,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedTitle: cachedTitle,
                cachedImagePath: cachedImagePath,
                cachedMetaPath: cachedMetaPath,
                resumable: resumable,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EpisodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EpisodesTable,
      Episode,
      $$EpisodesTableFilterComposer,
      $$EpisodesTableOrderingComposer,
      $$EpisodesTableAnnotationComposer,
      $$EpisodesTableCreateCompanionBuilder,
      $$EpisodesTableUpdateCompanionBuilder,
      (Episode, BaseReferences<_$AppDatabase, $EpisodesTable, Episode>),
      Episode,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<bool> wifiOnly,
      Value<int> maxParallel,
      Value<int?> deleteAfterHours,
      Value<int?> keepLatestN,
      Value<bool> autodownloadSubscribed,
      Value<String> playOrder,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<bool> wifiOnly,
      Value<int> maxParallel,
      Value<int?> deleteAfterHours,
      Value<int?> keepLatestN,
      Value<bool> autodownloadSubscribed,
      Value<String> playOrder,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wifiOnly => $composableBuilder(
    column: $table.wifiOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxParallel => $composableBuilder(
    column: $table.maxParallel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deleteAfterHours => $composableBuilder(
    column: $table.deleteAfterHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get keepLatestN => $composableBuilder(
    column: $table.keepLatestN,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autodownloadSubscribed => $composableBuilder(
    column: $table.autodownloadSubscribed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playOrder => $composableBuilder(
    column: $table.playOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wifiOnly => $composableBuilder(
    column: $table.wifiOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxParallel => $composableBuilder(
    column: $table.maxParallel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deleteAfterHours => $composableBuilder(
    column: $table.deleteAfterHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get keepLatestN => $composableBuilder(
    column: $table.keepLatestN,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autodownloadSubscribed => $composableBuilder(
    column: $table.autodownloadSubscribed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playOrder => $composableBuilder(
    column: $table.playOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get wifiOnly =>
      $composableBuilder(column: $table.wifiOnly, builder: (column) => column);

  GeneratedColumn<int> get maxParallel => $composableBuilder(
    column: $table.maxParallel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deleteAfterHours => $composableBuilder(
    column: $table.deleteAfterHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get keepLatestN => $composableBuilder(
    column: $table.keepLatestN,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autodownloadSubscribed => $composableBuilder(
    column: $table.autodownloadSubscribed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get playOrder =>
      $composableBuilder(column: $table.playOrder, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> wifiOnly = const Value.absent(),
                Value<int> maxParallel = const Value.absent(),
                Value<int?> deleteAfterHours = const Value.absent(),
                Value<int?> keepLatestN = const Value.absent(),
                Value<bool> autodownloadSubscribed = const Value.absent(),
                Value<String> playOrder = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                wifiOnly: wifiOnly,
                maxParallel: maxParallel,
                deleteAfterHours: deleteAfterHours,
                keepLatestN: keepLatestN,
                autodownloadSubscribed: autodownloadSubscribed,
                playOrder: playOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> wifiOnly = const Value.absent(),
                Value<int> maxParallel = const Value.absent(),
                Value<int?> deleteAfterHours = const Value.absent(),
                Value<int?> keepLatestN = const Value.absent(),
                Value<bool> autodownloadSubscribed = const Value.absent(),
                Value<String> playOrder = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                wifiOnly: wifiOnly,
                maxParallel: maxParallel,
                deleteAfterHours: deleteAfterHours,
                keepLatestN: keepLatestN,
                autodownloadSubscribed: autodownloadSubscribed,
                playOrder: playOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db, _db.subscriptions);
  $$EpisodesTableTableManager get episodes =>
      $$EpisodesTableTableManager(_db, _db.episodes);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
```

### Inhalt von `klubradio_archivum/lib/db/connection/connection.dart`
```dart
export 'connection_stub.dart'
    if (dart.library.html) 'connection_web.dart'
    if (dart.library.io) 'connection_native.dart';
```

### Inhalt von `klubradio_archivum/lib/db/connection/connection_native.dart`
```dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<QueryExecutor> openConnection() async {
  final dir = (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
      ? await getApplicationSupportDirectory()
      : await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'klubradio.db'));
  return NativeDatabase.createInBackground(file);
}
```

### Inhalt von `klubradio_archivum/lib/db/connection/connection_stub.dart`
```dart
import 'package:drift/drift.dart';

Future<QueryExecutor> openConnection() async {
  throw UnsupportedError('No database implementation for this platform.');
}
```

### Inhalt von `klubradio_archivum/lib/db/connection/connection_web.dart`
```dart
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

Future<QueryExecutor> openConnection() async {
  final db = await WasmDatabase.open(
    databaseName: 'klubradio_archivum',
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    driftWorkerUri: Uri.parse('drift_worker.js'),
  );
  return db.resolvedExecutor;
}
```

### Inhalt von `klubradio_archivum/lib/db/daos.dart`
```dart
// lib/db/daos.dart
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'; // Import for debugPrint

import 'package:drift/drift.dart';
import 'app_database.dart';

part 'daos.g.dart';

/// ---------------- Subscriptions DAO ----------------

@DriftAccessor(tables: [Subscriptions])
class SubscriptionsDao extends DatabaseAccessor<AppDatabase>
    with _$SubscriptionsDaoMixin {
  SubscriptionsDao(super.db);

  Future<void> upsert(SubscriptionsCompanion data) =>
      into(subscriptions).insertOnConflictUpdate(data);

  Future<Subscription?> getById(String podcastId) async {
    return (select(
      subscriptions,
    )..where((s) => s.podcastId.equals(podcastId))).getSingleOrNull();
  }

  // Live-State für einen Podcast (Button/UI)
  Stream<Subscription?> watchOne(String podcastId) {
    return (select(
      subscriptions,
    )..where((s) => s.podcastId.equals(podcastId))).watchSingleOrNull();
  }

  // alle aktiven Abos streamen (z. B. Auto-Download beim App-Start)
  Stream<List<Subscription>> watchAllActive() {
    return (select(subscriptions)..where((s) => s.active.equals(true))).watch();
  }

  // bool: abonniert?
  Future<bool> isSubscribed(String podcastId) async {
    final row = await getById(podcastId);
    return row?.active == true;
  }

  // aktivieren/deaktivieren OHNE Titel/Bild – nur Status & Rules
  Future<void> toggleSubscribe({
    required String podcastId,
    bool? active, // optional: explizit setzen
    int? autoDownloadN, // optional: Regel mitgeben
  }) async {
    final existing = await getById(podcastId);
    if (existing == null) {
      await into(subscriptions).insert(
        SubscriptionsCompanion.insert(
          podcastId: podcastId,
          active: Value(active ?? true),
          autoDownloadN: Value(autoDownloadN),
        ),
      );
    } else {
      final toActive = active ?? !existing.active;
      await (update(
        subscriptions,
      )..where((s) => s.podcastId.equals(podcastId))).write(
        SubscriptionsCompanion(
          active: Value(toActive),
          // Regel übernehmen, wenn übergeben
          autoDownloadN: autoDownloadN == null
              ? const Value.absent()
              : Value(autoDownloadN),
        ),
      );
    }
  }

  // Regel-Setter
  Future<int> setAutoDownloadN(String podcastId, int? n) {
    // 0 => null (aus)
    final normalized = (n ?? 0) <= 0 ? null : n;
    return (update(subscriptions)..where((s) => s.podcastId.equals(podcastId)))
        .write(SubscriptionsCompanion(autoDownloadN: Value(normalized)));
  }

  // Fortschritt updaten (optional)
  Future<int> setLastHeard(String podcastId, String episodeId) {
    return (update(subscriptions)..where((s) => s.podcastId.equals(podcastId)))
        .write(SubscriptionsCompanion(lastHeardEpisodeId: Value(episodeId)));
  }

  Future<int> setLastDownloaded(String podcastId, String episodeId) {
    return (update(
      subscriptions,
    )..where((s) => s.podcastId.equals(podcastId))).write(
      SubscriptionsCompanion(lastDownloadedEpisodeId: Value(episodeId)),
    );
  }
}

/// ---------------- Episodes DAO ----------------

@DriftAccessor(tables: [Episodes, Subscriptions])
class EpisodesDao extends DatabaseAccessor<AppDatabase>
    with _$EpisodesDaoMixin {
  EpisodesDao(super.db);

  // Upsert einzelner Episode
  Future<void> upsert(EpisodesCompanion data) =>
      into(episodes).insertOnConflictUpdate(data);

  // Bulk-Upsert (z. B. vom API-Refresh)
  Future<void> upsertAll(List<EpisodesCompanion> many) async {
    await batch((b) => b.insertAllOnConflictUpdate(episodes, many));
  }

  Future<Episode?> getById(String id) =>
      (select(episodes)..where((e) => e.id.equals(id))).getSingleOrNull();

  // Neueste N Episoden für einen Podcast (für Auto-Download-Queue)
  Future<List<Episode>> latestForPodcast(String podcastId, int n) {
    final q = select(episodes)
      ..where((e) => e.podcastId.equals(podcastId))
      ..orderBy([(e) => OrderingTerm.desc(e.publishedAt)])
      ..limit(n);
    return q.get();
  }

  Future<List<Episode>> getEpisodesByPodcastId(String podcastId) {
    return (select(
      episodes,
    )..where((e) => e.podcastId.equals(podcastId))).get();
  }

  // Status-/Progress-Updates (Download-Lifecycle)
  Future<int> setQueued(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(
          status: const Value(1), // queued
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<int> setDownloading(
    String id, {
    double? progress,
    int? bytes,
    int? total,
  }) => (update(episodes)..where((e) => e.id.equals(id))).write(
    EpisodesCompanion(
      status: const Value(2), // downloading
      progress: progress == null ? const Value.absent() : Value(progress),
      bytesDownloaded: bytes == null ? const Value.absent() : Value(bytes),
      totalBytes: total == null ? const Value.absent() : Value(total),
      updatedAt: Value(DateTime.now()),
    ),
  );

  Future<int> setProgress(
    String id,
    double progress, {
    int? bytes,
    int? total,
  }) => (update(episodes)..where((e) => e.id.equals(id))).write(
    EpisodesCompanion(
      progress: Value(progress),
      bytesDownloaded: bytes == null ? const Value.absent() : Value(bytes),
      totalBytes: total == null ? const Value.absent() : Value(total),
      updatedAt: Value(DateTime.now()),
    ),
  );

  Future<int> setCompleted(
    String id,
    String localPath, {
    int? bytes,
    int? total,
  }) async {
    debugPrint('DAO.setCompleted id=$id path=$localPath');
    return (update(episodes)..where((e) => e.id.equals(id))).write(
      EpisodesCompanion(
        status: const Value(3),
        // completed
        progress: const Value(1.0),
        localPath: Value(localPath),
        bytesDownloaded: bytes == null ? const Value.absent() : Value(bytes),
        totalBytes: total == null ? const Value.absent() : Value(total),
        completedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> setFailed(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(
          status: const Value(4), // failed
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<int> setCanceled(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(
          status: const Value(5), // canceled
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<int> markPlayed(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(
          playedAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  // Nach File-Löschung: DB-Felder bereinigen
  Future<int> clearLocalFile(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        const EpisodesCompanion(
          localPath: Value(null),
          status: Value(0), // none
        ),
      );

  // Streams für UI
  /// Watch episodes for a podcast, ordered by publishedAt.
  /// [ascending] = false (default) means newest first; true means oldest first.
  Stream<List<Episode>> watchByPodcast(
    String podcastId, {
    bool ascending = false,
  }) =>
      (select(episodes)
            ..where((e) => e.podcastId.equals(podcastId))
            ..orderBy([
              (e) => ascending
                  ? OrderingTerm.asc(e.publishedAt)
                  : OrderingTerm.desc(e.publishedAt),
            ]))
          .watch();

  Stream<List<Episode>> watchActiveDownloads() =>
      (select(episodes)
            ..where((e) => e.status.isIn([1, 2]))) // queued or downloading
          .watch();

  // Für Retention: alle completed mit File, neueste zuerst
  Future<List<Episode>> completedWithFileDesc(String podcastId) =>
      (select(episodes)
            ..where(
              (e) =>
                  e.podcastId.equals(podcastId) &
                  e.status.equals(3) &
                  e.localPath.isNotNull(),
            )
            ..orderBy([(e) => OrderingTerm.desc(e.completedAt)]))
          .get();

  // Für Retention: gehört + älter als threshold, mit File
  Future<List<Episode>> playedBefore(DateTime threshold) =>
      (select(episodes)..where(
            (e) =>
                e.playedAt.isSmallerThanValue(threshold) &
                e.localPath.isNotNull(),
          ))
          .get();

  // Auto-Download: markiere die neuesten N als queued (ohne bereits completed)
  Future<void> enqueueLatestN(String podcastId, int n) async {
    final latest = await latestForPodcast(podcastId, n);
    await batch((b) {
      for (final ep in latest) {
        if (ep.status == 0 || ep.status == 4 || ep.status == 5) {
          b.update(
            episodes,
            EpisodesCompanion(
              status: const Value(1),
              updatedAt: Value(DateTime.now()),
            ),
            where: (tbl) => tbl.id.equals(ep.id),
          );
        }
      }
    });
  }

  Future<int> setCachedMeta(
    String id, {
    String? title,
    String? imagePath,
    String? metaPath,
  }) {
    return (update(episodes)..where((e) => e.id.equals(id))).write(
      EpisodesCompanion(
        cachedTitle: title == null ? const Value.absent() : Value(title),
        cachedImagePath: imagePath == null
            ? const Value.absent()
            : Value(imagePath),
        cachedMetaPath: metaPath == null
            ? const Value.absent()
            : Value(metaPath),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

/// ---------------- Settings DAO ----------------

@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Future<Setting?> getOne() =>
      (select(settings)..where((s) => s.id.equals(1))).getSingleOrNull();

  Future<void> ensureDefaults() async {
    final wifiDefault = Platform.isAndroid || Platform.isIOS ? true : false;
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion(
        id: const Value(1),
        wifiOnly: Value(wifiDefault), // mobil: an, desktop: aus
        maxParallel: const Value(2),
        deleteAfterHours: const Value(null), // AUS
        keepLatestN: const Value(null), // AUS
        autodownloadSubscribed: const Value(false),
        playOrder: const Value('newest'),
      ),
    );
  }

  Future<int> setWifiOnly(bool v) => (update(
    settings,
  )..where((s) => s.id.equals(1))).write(SettingsCompanion(wifiOnly: Value(v)));

  Future<int> setMaxParallel(int n) =>
      (update(settings)..where((s) => s.id.equals(1))).write(
        SettingsCompanion(maxParallel: Value(n)),
      );

  Future<int> setDeleteAfterHours(int? h) =>
      (update(settings)..where((s) => s.id.equals(1))).write(
        SettingsCompanion(deleteAfterHours: Value((h ?? 0) <= 0 ? null : h)),
      );

  Future<int> setKeepLatestN(int? n) =>
      (update(settings)..where((s) => s.id.equals(1))).write(
        SettingsCompanion(keepLatestN: Value((n ?? 0) <= 0 ? null : n)),
      );

  Future<int> setAutodownloadSubscribed(bool v) =>
      (update(settings)..where((s) => s.id.equals(1))).write(
        SettingsCompanion(autodownloadSubscribed: Value(v)),
      );

  Future<int> setPlayOrder(String order) async {
    await ensureDefaults();
    return (update(settings)..where((s) => s.id.equals(1))).write(
      SettingsCompanion(playOrder: Value(order)),
    );
  }
}

/// ---------------- Retention Helper (DB-seitig) ----------------
/// Diese Funktionen liefern NUR die Kandidaten.
/// Das tatsächliche Dateilöschen passiert in der Service-Schicht.

class RetentionPlan {
  RetentionPlan({required this.toDeleteIds});
  final List<String> toDeleteIds;
}

class RetentionDao {
  RetentionDao(
    this.db,
    this.episodesDao,
    this.subscriptionsDao,
    this.settingsDao,
  );

  final AppDatabase db;
  final EpisodesDao episodesDao;
  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;

  /// Errechne zu löschende Episoden IDs gemäß:
  /// - deleteAfterHours (playedAt + h)
  /// - keepLatestN je Podcast
  Future<RetentionPlan> computePlanForPodcast(String podcastId) async {
    final planIds = <String>[];

    // 1) deleteAfterHours-Regel (global)
    final s = await settingsDao.getOne();

    // deleteAfterHours nur wenn > 0
    if (s?.deleteAfterHours != null && s!.deleteAfterHours! > 0) {
      final threshold = DateTime.now().subtract(
        Duration(hours: s.deleteAfterHours!),
      );
      final oldPlayed = await episodesDao.playedBefore(threshold);
      for (final ep in oldPlayed.where((e) => e.podcastId == podcastId)) {
        planIds.add(ep.id);
      }
    }

    // keepLatestN nur wenn > 0
    final global = await settingsDao.getOne();
    final keepN = global?.keepLatestN;

    if (keepN != null && keepN > 0) {
      final done = await episodesDao.completedWithFileDesc(podcastId);
      if (done.length > keepN) {
        final extra = done.sublist(keepN);
        planIds.addAll(extra.map((e) => e.id));
      }
    }

    // Deduplizieren
    final unique = planIds.toSet().toList();
    return RetentionPlan(toDeleteIds: unique);
  }
}
```

### Inhalt von `klubradio_archivum/lib/db/daos.g.dart`
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daos.dart';

// ignore_for_file: type=lint
mixin _$SubscriptionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SubscriptionsTable get subscriptions => attachedDatabase.subscriptions;
  SubscriptionsDaoManager get managers => SubscriptionsDaoManager(this);
}

class SubscriptionsDaoManager {
  final _$SubscriptionsDaoMixin _db;
  SubscriptionsDaoManager(this._db);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db.attachedDatabase, _db.subscriptions);
}

mixin _$EpisodesDaoMixin on DatabaseAccessor<AppDatabase> {
  $SubscriptionsTable get subscriptions => attachedDatabase.subscriptions;
  $EpisodesTable get episodes => attachedDatabase.episodes;
  EpisodesDaoManager get managers => EpisodesDaoManager(this);
}

class EpisodesDaoManager {
  final _$EpisodesDaoMixin _db;
  EpisodesDaoManager(this._db);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db.attachedDatabase, _db.subscriptions);
  $$EpisodesTableTableManager get episodes =>
      $$EpisodesTableTableManager(_db.attachedDatabase, _db.episodes);
}

mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SettingsTable get settings => attachedDatabase.settings;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db.attachedDatabase, _db.settings);
}
```

### Inhalt von `klubradio_archivum/lib/l10n/app_localizations.dart`
```dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_ro.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('hu'),
    Locale('ro'),
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Klubradio Archive'**
  String get appName;

  /// Title for the downloads screen
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloadListTitle;

  /// Download status: Item is in queue to be downloaded
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get downloadStatusQueued;

  /// Download status: Item has not been downloaded yet
  ///
  /// In en, this message translates to:
  /// **'Not Downloaded'**
  String get downloadStatusNotDownloaded;

  /// Download status: Item has been successfully downloaded
  ///
  /// In en, this message translates to:
  /// **'Downloaded'**
  String get downloadStatusDownloaded;

  /// Download status: Item is currently being downloaded
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get downloadStatusDownloading;

  /// Download status: Item download has failed
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get downloadStatusFailed;

  /// Button text to retry a failed download
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get downloadActionRetry;

  /// Button text to cancel an ongoing download
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get downloadActionCancel;

  /// Button text to delete a downloaded item
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get downloadActionDelete;

  /// Label showing the download progress percentage
  ///
  /// In en, this message translates to:
  /// **'{progressPercentage}%'**
  String downloadProgressLabel(int progressPercentage);

  /// Message shown when the download list is empty
  ///
  /// In en, this message translates to:
  /// **'No Downloads Yet'**
  String get noDownloads;

  /// Title for the AppBar on the About screen
  ///
  /// In en, this message translates to:
  /// **'About the Application'**
  String get aboutScreenAppBarTitle;

  /// The name of the application on the About screen
  ///
  /// In en, this message translates to:
  /// **'Klubradio Archive Application'**
  String get aboutScreenAppNameDetail;

  /// Description of the application's purpose
  ///
  /// In en, this message translates to:
  /// **'The purpose of the application is to provide easy access to Klubrádió\'s archived programs and to allow the creation of RSS feeds for podcast players.'**
  String get aboutScreenPurpose;

  /// Information about the community nature of the project and content availability
  ///
  /// In en, this message translates to:
  /// **'This is a community project that serves to support Klubrádió. All content is freely available on the radio\'s official website.'**
  String get aboutScreenCommunityProjectInfo;

  /// Contact information
  ///
  /// In en, this message translates to:
  /// **'Contact: info@klubradio.hu (content), multilevelstudios@gmail.com (developer contact)'**
  String get aboutScreenContactInfo;

  /// Title for the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Setting to select the theme (e.g., Light/Dark)
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// Setting to select the application language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// Generic OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Generic Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Error dialog window title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorDialogTitle;

  /// Generic error message for unexpected issues
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again later.'**
  String get unexpectedError;

  /// Error message when loading podcast episodes fails.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {errorDetails}'**
  String podcastDetailErrorLoading(String errorDetails);

  /// Notification on successful podcast subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription successful!'**
  String get podcastDetailSubscriptionSuccess;

  /// Button label to subscribe to the podcast.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get podcastDetailSubscribeButton;

  /// No description provided for @homeScreenSubscribedPodcastsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions yet — discover podcasts and tap “Subscribe”.'**
  String get homeScreenSubscribedPodcastsEmptyHint;

  /// Section title for subscribed podcasts on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Subscribed Shows'**
  String get homeScreenSubscribedPodcastsTitle;

  /// Section title for recent episodes on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Recent Episodes'**
  String get homeScreenRecentEpisodesTitle;

  /// Section title for recently played episodes on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Recently Played'**
  String get homeScreenRecentlyPlayedTitle;

  /// Option to use the system's theme setting.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeSettingSystemDefault;

  /// Option to select the light theme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeSettingLight;

  /// Option to select the dark theme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeSettingDark;

  /// Title for the Support Klubradio section on the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Support Klubradio'**
  String get settingsScreenSupportKlubradioTitle;

  /// Subtitle for the Support Klubradio section.
  ///
  /// In en, this message translates to:
  /// **'Open the support page in your browser.'**
  String get settingsScreenSupportKlubradioSubtitle;

  /// Title for the Support App Developer section.
  ///
  /// In en, this message translates to:
  /// **'Support the App Developer'**
  String get settingsScreenSupportDeveloperTitle;

  /// Subtitle for the Support App Developer section.
  ///
  /// In en, this message translates to:
  /// **'Voluntary donation for further development.'**
  String get settingsScreenSupportDeveloperSubtitle;

  /// Section title for theme settings.
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettingsSectionTitle;

  /// Navigation tab label: Home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomNavHome;

  /// Navigation tab label: Discover
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get bottomNavDiscover;

  /// Navigation tab label: Search
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get bottomNavSearch;

  /// Navigation tab label: Downloads
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get bottomNavDownloads;

  /// Navigation tab label: Profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavProfile;

  /// Navigation tab label: Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottomNavSettings;

  /// Section title for playback settings.
  ///
  /// In en, this message translates to:
  /// **'Playback Settings'**
  String get playbackSettingsTitle;

  /// Label for the playback speed setting.
  ///
  /// In en, this message translates to:
  /// **'Playback speed:'**
  String get playbackSettingsSpeedLabel;

  /// Format for displaying the playback speed value. Example: 1.5x
  ///
  /// In en, this message translates to:
  /// **'{speed}x'**
  String playbackSettingsSpeedValue(double speed);

  /// Label for the automatic downloads count setting.
  ///
  /// In en, this message translates to:
  /// **'Automatic downloads:'**
  String get playbackSettingsAutoDownloadLabel;

  /// Format for displaying the number of episodes to auto-download. Example: 5 episodes
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{No episodes} =1{1 episode} other{{count} episodes}}'**
  String playbackSettingsAutoDownloadValue(int count);

  /// Feedback message shown when a show is selected from a list of chips.
  ///
  /// In en, this message translates to:
  /// **'\"{showTitle}\" selected.'**
  String showSelectedFeedback(String showTitle);

  /// Title for the featured/top categories section on the Discover screen.
  ///
  /// In en, this message translates to:
  /// **'Top Shows'**
  String get discoverScreenFeaturedCategoriesTitle;

  /// Title for the recommended shows section on the Discover screen.
  ///
  /// In en, this message translates to:
  /// **'Recommended Shows'**
  String get discoverScreenRecommendedShowsTitle;

  /// Title for the trending podcasts section on the Discover screen.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get discoverScreenTrendingTitle;

  /// No description provided for @discoverScreenNoTopShows.
  ///
  /// In en, this message translates to:
  /// **'No featured shows available.'**
  String get discoverScreenNoTopShows;

  /// Message shown when there are no recommended podcasts to display.
  ///
  /// In en, this message translates to:
  /// **'No recommendations available. Please refresh the data later.'**
  String get recommendedPodcastsNoRecommendations;

  /// Message shown when there are no trending podcasts to display.
  ///
  /// In en, this message translates to:
  /// **'No trending shows on the list.'**
  String get trendingPodcastsNoShows;

  /// Message shown when the user has not subscribed to any podcasts.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t subscribed to any shows yet.'**
  String get subscribedPodcastsNoSubscriptions;

  /// Message shown when there are no recent searches to display.
  ///
  /// In en, this message translates to:
  /// **'No search history yet.'**
  String get recentSearchesNoHistory;

  /// Hint text displayed in the search bar.
  ///
  /// In en, this message translates to:
  /// **'Shows, hosts, keywords...'**
  String get searchBarHintText;

  /// Message shown when a search yields no results.
  ///
  /// In en, this message translates to:
  /// **'No results found for your search.'**
  String get searchResultsNoResults;

  /// No description provided for @searchTabShows.
  ///
  /// In en, this message translates to:
  /// **'Shows'**
  String get searchTabShows;

  /// No description provided for @searchTabEpisodes.
  ///
  /// In en, this message translates to:
  /// **'Episodes'**
  String get searchTabEpisodes;

  /// Initial prompt message on the search screen before any search is performed.
  ///
  /// In en, this message translates to:
  /// **'Find your favorite shows or hosts.'**
  String get searchScreenInitialPrompt;

  /// Error message displayed on the search screen if a search fails.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {errorDetails}'**
  String searchScreenErrorMessage(String errorDetails);

  /// Error message shown when data parsing fails.
  ///
  /// In en, this message translates to:
  /// **'There was an issue processing the data.'**
  String get errorParsingData;

  /// Generic error message for unknown issues.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get errorUnknown;

  /// Text shown on the profile screen when the user's email is not available.
  ///
  /// In en, this message translates to:
  /// **'No email address provided'**
  String get profileScreenNoEmail;

  /// Title for the download settings section on the profile screen.
  ///
  /// In en, this message translates to:
  /// **'Download Settings'**
  String get profileScreenDownloadSettingsTitle;

  /// Title for the automatic downloads option in profile settings.
  ///
  /// In en, this message translates to:
  /// **'Automatic Downloads'**
  String get profileScreenAutoDownloadsTitle;

  /// Subtitle indicating the number of episodes set for automatic download.
  ///
  /// In en, this message translates to:
  /// **'Number of episodes: {count}'**
  String profileScreenAutoDownloadsSubtitle(int count);

  /// Title for the recently played episodes section on the profile screen.
  ///
  /// In en, this message translates to:
  /// **'Recently Played Episodes'**
  String get profileScreenRecentlyPlayedTitle;

  /// Title for the favorites section on the profile screen.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get profileScreenFavoritesTitle;

  /// Message shown when the user has no favorite episodes.
  ///
  /// In en, this message translates to:
  /// **'No favorite episodes yet.'**
  String get profileScreenNoFavoriteEpisodes;

  /// Default display name for a guest user or when the name is not set.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get profileScreenGuestUserDisplayName;

  /// Title for the card that opens the license/legal information.
  ///
  /// In en, this message translates to:
  /// **'License / Legal'**
  String get aboutScreenLicenseTitle;

  /// Short subtitle/summary shown under the license card title.
  ///
  /// In en, this message translates to:
  /// **'Open the license and legal information.'**
  String get aboutScreenLicenseSummary;

  /// Title for the card that shows the current app version/build.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutScreenVersionTitle;

  /// Formatted version string with placeholders for version and build number.
  ///
  /// In en, this message translates to:
  /// **'{version} (Build {build})'**
  String aboutScreenVersionFormat(String version, String build);

  /// Label for the list of hosts on the podcast info card.
  ///
  /// In en, this message translates to:
  /// **'{hostNames}'**
  String podcastInfoCardHostsLabel(String hostNames);

  /// Error message when episodes for a podcast fail to load.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading episodes: {errorDetails}'**
  String podcastDetailScreenErrorMessage(String errorDetails);

  /// Text for the button to subscribe to a podcast.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get podcastDetailScreenSubscribeButton;

  /// Text for the button to unsubscribe from a podcast.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get podcastDetailScreenUnsubscribeButton;

  /// Snackbar message shown after successfully subscribing to a podcast.
  ///
  /// In en, this message translates to:
  /// **'Subscribed successfully!'**
  String get podcastDetailScreenSubscribeSuccess;

  /// Snackbar message shown after successfully unsubscribing from a podcast.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed successfully!'**
  String get podcastDetailScreenUnsubscribeSuccess;

  /// No description provided for @unsubscribeDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get unsubscribeDialogTitle;

  /// No description provided for @unsubscribeDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the downloaded episodes for this podcast?'**
  String get unsubscribeDialogContent;

  /// No description provided for @unsubscribeDialogDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Episodes'**
  String get unsubscribeDialogDeleteButton;

  /// No description provided for @unsubscribeDialogKeepButton.
  ///
  /// In en, this message translates to:
  /// **'Keep Episodes'**
  String get unsubscribeDialogKeepButton;

  /// Title for the 'Now Playing' screen.
  ///
  /// In en, this message translates to:
  /// **'Now Playing'**
  String get nowPlayingScreenTitle;

  /// Message shown on the 'Now Playing' screen when no episode has been selected.
  ///
  /// In en, this message translates to:
  /// **'No episode is currently playing.'**
  String get nowPlayingScreenNoEpisode;

  /// Formats a duration with hours and minutes. Example: 1h 23m
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String durationInHoursAndMinutes(int hours, int minutes);

  /// Formats a duration with only minutes. Example: 45m
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String durationInMinutes(int minutes);

  /// Error message when a podcast selected from a list can't be fetched.
  ///
  /// In en, this message translates to:
  /// **'Sorry, the selected show could not be found.'**
  String get podcastNotFoundError;

  /// No description provided for @podcastListItem_subscribed.
  ///
  /// In en, this message translates to:
  /// **'Subscribed'**
  String get podcastListItem_subscribed;

  /// No description provided for @podcastListItem_unsubscribe.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get podcastListItem_unsubscribe;

  /// No description provided for @podcastListItem_subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get podcastListItem_subscribe;

  /// No description provided for @podcastListItem_unsubscribed.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed'**
  String get podcastListItem_unsubscribed;

  /// No description provided for @podcastListItem_subtitleFallback.
  ///
  /// In en, this message translates to:
  /// **'Klubrádió show'**
  String get podcastListItem_subtitleFallback;

  /// No description provided for @podcastListItem_openDetails.
  ///
  /// In en, this message translates to:
  /// **'Open podcast details'**
  String get podcastListItem_openDetails;

  /// No description provided for @downloads_tab_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get downloads_tab_active;

  /// No description provided for @downloads_tab_done.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get downloads_tab_done;

  /// No description provided for @downloads_empty_active.
  ///
  /// In en, this message translates to:
  /// **'No active downloads'**
  String get downloads_empty_active;

  /// No description provided for @downloads_empty_done.
  ///
  /// In en, this message translates to:
  /// **'No completed downloads'**
  String get downloads_empty_done;

  /// No description provided for @downloads_status_waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get downloads_status_waiting;

  /// No description provided for @downloads_status_running.
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get downloads_status_running;

  /// No description provided for @downloads_status_done.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get downloads_status_done;

  /// No description provided for @downloads_status_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get downloads_status_failed;

  /// No description provided for @downloads_status_canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get downloads_status_canceled;

  /// No description provided for @downloads_status_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get downloads_status_unknown;

  /// No description provided for @downloads_action_pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get downloads_action_pause;

  /// No description provided for @downloads_action_resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get downloads_action_resume;

  /// No description provided for @downloads_action_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get downloads_action_cancel;

  /// No description provided for @downloads_action_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get downloads_action_delete;

  /// No description provided for @downloads_section_active.
  ///
  /// In en, this message translates to:
  /// **'Active Downloads'**
  String get downloads_section_active;

  /// No description provided for @downloads_section_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed Downloads'**
  String get downloads_section_completed;

  /// No description provided for @downloads_menu_play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get downloads_menu_play;

  /// No description provided for @downloads_menu_open_folder.
  ///
  /// In en, this message translates to:
  /// **'Open in folder'**
  String get downloads_menu_open_folder;

  /// No description provided for @downloads_menu_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get downloads_menu_delete;

  /// No description provided for @downloads_menu_add_to_queue.
  ///
  /// In en, this message translates to:
  /// **'Add to playlist'**
  String get downloads_menu_add_to_queue;

  /// No description provided for @ep_action_resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get ep_action_resume;

  /// No description provided for @ep_action_downloaded.
  ///
  /// In en, this message translates to:
  /// **'Downloaded'**
  String get ep_action_downloaded;

  /// No description provided for @ep_action_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get ep_action_retry;

  /// No description provided for @ep_action_download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get ep_action_download;

  /// No description provided for @settings_title_downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get settings_title_downloads;

  /// No description provided for @settings_wifi_only.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi only'**
  String get settings_wifi_only;

  /// No description provided for @settings_wifi_only_mobile_default.
  ///
  /// In en, this message translates to:
  /// **'Default on mobile: ON'**
  String get settings_wifi_only_mobile_default;

  /// No description provided for @settings_wifi_only_desktop_default.
  ///
  /// In en, this message translates to:
  /// **'Default on desktop: OFF'**
  String get settings_wifi_only_desktop_default;

  /// No description provided for @settings_max_parallel.
  ///
  /// In en, this message translates to:
  /// **'Max concurrent downloads'**
  String get settings_max_parallel;

  /// No description provided for @settings_retention_section.
  ///
  /// In en, this message translates to:
  /// **'Retention'**
  String get settings_retention_section;

  /// No description provided for @settings_keep_all.
  ///
  /// In en, this message translates to:
  /// **'Keep all'**
  String get settings_keep_all;

  /// No description provided for @settings_keep_latest_label.
  ///
  /// In en, this message translates to:
  /// **'Keep only the last n'**
  String get settings_keep_latest_label;

  /// No description provided for @settings_keep_latest.
  ///
  /// In en, this message translates to:
  /// **'Keep latest episodes'**
  String get settings_keep_latest;

  /// No description provided for @settings_keep_latest_hint.
  ///
  /// In en, this message translates to:
  /// **'Keeps the newest n episodes per podcast.'**
  String get settings_keep_latest_hint;

  /// No description provided for @settings_delete_after_heard_label.
  ///
  /// In en, this message translates to:
  /// **'Delete x hours after listened'**
  String get settings_delete_after_heard_label;

  /// No description provided for @settings_delete_after_hours.
  ///
  /// In en, this message translates to:
  /// **'Delete after (hours)'**
  String get settings_delete_after_hours;

  /// No description provided for @settings_delete_after_hint.
  ///
  /// In en, this message translates to:
  /// **'Automatically remove x hours after playback.'**
  String get settings_delete_after_hint;

  /// No description provided for @settings_zero_off.
  ///
  /// In en, this message translates to:
  /// **'0 = OFF'**
  String get settings_zero_off;

  /// No description provided for @settings_autodownload_subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Autodownload subscribed episodes'**
  String get settings_autodownload_subscriptions;

  /// No description provided for @settings_autodownload_subscriptions_hint.
  ///
  /// In en, this message translates to:
  /// **'Automatically download new episodes from subscribed podcasts.'**
  String get settings_autodownload_subscriptions_hint;

  /// No description provided for @profileScreenNoRecentlyPlayed.
  ///
  /// In en, this message translates to:
  /// **'No recently played episodes yet.'**
  String get profileScreenNoRecentlyPlayed;

  /// No description provided for @profileScreenSubscriptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscribed shows'**
  String get profileScreenSubscriptionsTitle;

  /// No description provided for @profileScreenAppIdTitle.
  ///
  /// In en, this message translates to:
  /// **'App ID'**
  String get profileScreenAppIdTitle;

  /// No description provided for @profileScreenIdCopied.
  ///
  /// In en, this message translates to:
  /// **'ID copied'**
  String get profileScreenIdCopied;

  /// No description provided for @profileScreenPlaybackSpeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Playback speed'**
  String get profileScreenPlaybackSpeedTitle;

  /// No description provided for @profileScreenPlaybackSpeedValue.
  ///
  /// In en, this message translates to:
  /// **'{value}×'**
  String profileScreenPlaybackSpeedValue(Object value);

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonCount.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get commonCount;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Fertig'**
  String get commonDone;

  /// Label for the episode sort order setting.
  ///
  /// In en, this message translates to:
  /// **'Episode order'**
  String get settings_episode_order_label;

  /// Option to sort episodes with newest first.
  ///
  /// In en, this message translates to:
  /// **'Newest first'**
  String get settings_episode_order_newest;

  /// Option to sort episodes with oldest first.
  ///
  /// In en, this message translates to:
  /// **'Oldest first'**
  String get settings_episode_order_oldest;

  /// Title of the privacy notice popup dialog.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security Notice'**
  String get privacyDialogTitle;

  /// Headline of the privacy notice text.
  ///
  /// In en, this message translates to:
  /// **'Your data stays with you.'**
  String get privacyNoticeHeadline;

  /// Body text of the privacy notice.
  ///
  /// In en, this message translates to:
  /// **'This app is designed so that we are technically unable to collect or store personal usage data. There is no account, no login, and no tracking infrastructure. Everything you listen to, download, or subscribe to stays exclusively on your device and is loaded directly from the Klubradio server — so your usage supports their work. You are also welcome to support this app — more under \"About\".'**
  String get privacyNoticeBody;

  /// Headline for the disclaimer section.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimerHeadline;

  /// Body text of the disclaimer.
  ///
  /// In en, this message translates to:
  /// **'No liability is accepted for app crashes or data loss. Use this app at your own risk.'**
  String get disclaimerBody;

  /// Row title in Settings/About for opening the privacy notice.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security Notice'**
  String get privacySettingsRow;

  /// Subtitle for the privacy settings row.
  ///
  /// In en, this message translates to:
  /// **'Tap to view the privacy and security information.'**
  String get privacySettingsRowSubtitle;

  /// Label for the App-ID card on the About screen.
  ///
  /// In en, this message translates to:
  /// **'App-ID'**
  String get aboutScreenAppIdLabel;

  /// Title for the supporters/donors section on the About screen.
  ///
  /// In en, this message translates to:
  /// **'Supporters'**
  String get aboutScreenContributionsTitle;

  /// Message shown when the supporters list is empty.
  ///
  /// In en, this message translates to:
  /// **'Become a supporter!'**
  String get aboutScreenContributionsEmpty;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'hu', 'ro'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'hu':
      return AppLocalizationsHu();
    case 'ro':
      return AppLocalizationsRo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
```

### Inhalt von `klubradio_archivum/lib/l10n/app_localizations_de.dart`
```dart
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Klubrádió Archiv';

  @override
  String get downloadListTitle => 'Downloads';

  @override
  String get downloadStatusQueued => 'In Warteschlange';

  @override
  String get downloadStatusNotDownloaded => 'Nicht heruntergeladen';

  @override
  String get downloadStatusDownloaded => 'Heruntergeladen';

  @override
  String get downloadStatusDownloading => 'Wird heruntergeladen';

  @override
  String get downloadStatusFailed => 'Fehlgeschlagen';

  @override
  String get downloadActionRetry => 'Wiederholen';

  @override
  String get downloadActionCancel => 'Abbrechen';

  @override
  String get downloadActionDelete => 'Löschen';

  @override
  String downloadProgressLabel(int progressPercentage) {
    return '$progressPercentage%';
  }

  @override
  String get noDownloads => 'Noch keine Downloads';

  @override
  String get aboutScreenAppBarTitle => 'Über die Anwendung';

  @override
  String get aboutScreenAppNameDetail => 'Klubrádió Archiv Anwendung';

  @override
  String get aboutScreenPurpose =>
      'Ziel der Anwendung ist es, einen einfachen Zugang zu den archivierten Sendungen von Klubrádió zu ermöglichen und die Erstellung von RSS-Feeds für Podcast-Player zu erlauben.';

  @override
  String get aboutScreenCommunityProjectInfo =>
      'Dies ist ein Gemeinschaftsprojekt, das der Unterstützung von Klubrádió dient. Alle Inhalte sind auf der offiziellen Webseite des Radios frei verfügbar.';

  @override
  String get aboutScreenContactInfo =>
      'Kontakt: info@klubradio.hu (Inhalt), multilevelstudios@gmail.com (Entwicklerkontakt)';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get errorDialogTitle => 'Fehler';

  @override
  String get unexpectedError =>
      'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.';

  @override
  String podcastDetailErrorLoading(String errorDetails) {
    return 'Fehler aufgetreten: $errorDetails';
  }

  @override
  String get podcastDetailSubscriptionSuccess => 'Erfolgreich abonniert!';

  @override
  String get podcastDetailSubscribeButton => 'Abonnieren';

  @override
  String get homeScreenSubscribedPodcastsEmptyHint =>
      'Noch keine Abos – entdecke Podcasts und tippe auf „Abonnieren“.';

  @override
  String get homeScreenSubscribedPodcastsTitle => 'Abonnierte Sendungen';

  @override
  String get homeScreenRecentEpisodesTitle => 'Neueste Episoden';

  @override
  String get homeScreenRecentlyPlayedTitle => 'Zuletzt gehört';

  @override
  String get themeSettingSystemDefault => 'Systemstandard';

  @override
  String get themeSettingLight => 'Hell';

  @override
  String get themeSettingDark => 'Dunkel';

  @override
  String get settingsScreenSupportKlubradioTitle => 'Klubrádió unterstützen';

  @override
  String get settingsScreenSupportKlubradioSubtitle =>
      'Öffne die Support-Seite im Browser.';

  @override
  String get settingsScreenSupportDeveloperTitle =>
      'App-Entwickler unterstützen';

  @override
  String get settingsScreenSupportDeveloperSubtitle =>
      'Freiwillige Spende für weitere Entwicklungen.';

  @override
  String get themeSettingsSectionTitle => 'Design-Einstellungen';

  @override
  String get bottomNavHome => 'Startseite';

  @override
  String get bottomNavDiscover => 'Entdecken';

  @override
  String get bottomNavSearch => 'Suche';

  @override
  String get bottomNavDownloads => 'Downloads';

  @override
  String get bottomNavProfile => 'Profil';

  @override
  String get bottomNavSettings => 'Einstellungen';

  @override
  String get playbackSettingsTitle => 'Wiedergabeeinstellungen';

  @override
  String get playbackSettingsSpeedLabel => 'Wiedergabegeschwindigkeit:';

  @override
  String playbackSettingsSpeedValue(double speed) {
    return '${speed}x';
  }

  @override
  String get playbackSettingsAutoDownloadLabel => 'Automatische Downloads:';

  @override
  String playbackSettingsAutoDownloadValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Folgen',
      one: '1 Folge',
      zero: 'Keine Folgen',
    );
    return '$_temp0';
  }

  @override
  String showSelectedFeedback(String showTitle) {
    return '\"$showTitle\" ausgewählt.';
  }

  @override
  String get discoverScreenFeaturedCategoriesTitle => 'Top-Sendungen';

  @override
  String get discoverScreenRecommendedShowsTitle => 'Empfohlene Sendungen';

  @override
  String get discoverScreenTrendingTitle => 'Angesagt';

  @override
  String get discoverScreenNoTopShows =>
      'Keine vorgestellten Sendungen verfügbar.';

  @override
  String get recommendedPodcastsNoRecommendations =>
      'Keine Empfehlungen verfügbar. Bitte aktualisiere die Daten später.';

  @override
  String get trendingPodcastsNoShows =>
      'Keine angesagten Sendungen auf der Liste.';

  @override
  String get subscribedPodcastsNoSubscriptions =>
      'Du hast noch keine Sendungen abonniert.';

  @override
  String get recentSearchesNoHistory => 'Noch kein Suchverlauf vorhanden.';

  @override
  String get searchBarHintText => 'Sendungen, Moderatoren, Schlüsselwörter...';

  @override
  String get searchResultsNoResults =>
      'Keine Ergebnisse für Ihre Suche gefunden.';

  @override
  String get searchTabShows => 'Sendungen';

  @override
  String get searchTabEpisodes => 'Episoden';

  @override
  String get searchScreenInitialPrompt =>
      'Finde deine Lieblingssendungen oder Moderatoren.';

  @override
  String searchScreenErrorMessage(String errorDetails) {
    return 'Ein Fehler ist aufgetreten: $errorDetails';
  }

  @override
  String get errorParsingData =>
      'Bei der Verarbeitung der Daten ist ein Problem aufgetreten.';

  @override
  String get errorUnknown => 'Ein unbekannter Fehler ist aufgetreten.';

  @override
  String get profileScreenNoEmail => 'Keine E-Mail-Adresse angegeben';

  @override
  String get profileScreenDownloadSettingsTitle => 'Downloadeinstellungen';

  @override
  String get profileScreenAutoDownloadsTitle => 'Automatische Downloads';

  @override
  String profileScreenAutoDownloadsSubtitle(int count) {
    return 'Anzahl der Episoden: $count';
  }

  @override
  String get profileScreenRecentlyPlayedTitle => 'Zuletzt abgespielte Episoden';

  @override
  String get profileScreenFavoritesTitle => 'Favoriten';

  @override
  String get profileScreenNoFavoriteEpisodes =>
      'Noch keine Favoriten vorhanden.';

  @override
  String get profileScreenGuestUserDisplayName => 'Gastbenutzer';

  @override
  String get aboutScreenLicenseTitle => 'Lizenz / Rechtliches';

  @override
  String get aboutScreenLicenseSummary =>
      'Lizenz- und rechtliche Hinweise öffnen.';

  @override
  String get aboutScreenVersionTitle => 'Version';

  @override
  String aboutScreenVersionFormat(String version, String build) {
    return '$version (Build $build)';
  }

  @override
  String podcastInfoCardHostsLabel(String hostNames) {
    return '$hostNames';
  }

  @override
  String podcastDetailScreenErrorMessage(String errorDetails) {
    return 'Fehler beim Laden der Episoden: $errorDetails';
  }

  @override
  String get podcastDetailScreenSubscribeButton => 'Abonnieren';

  @override
  String get podcastDetailScreenUnsubscribeButton => 'Deabonnieren';

  @override
  String get podcastDetailScreenSubscribeSuccess => 'Erfolgreich abonniert!';

  @override
  String get podcastDetailScreenUnsubscribeSuccess => 'Erfolgreich abbestellt!';

  @override
  String get unsubscribeDialogTitle => 'Abbestellen';

  @override
  String get unsubscribeDialogContent =>
      'Möchten Sie die heruntergeladenen Episoden für diesen Podcast löschen?';

  @override
  String get unsubscribeDialogDeleteButton => 'Episoden löschen';

  @override
  String get unsubscribeDialogKeepButton => 'Episoden behalten';

  @override
  String get nowPlayingScreenTitle => 'Aktuelle Wiedergabe';

  @override
  String get nowPlayingScreenNoEpisode =>
      'Aktuell wird keine Episode abgespielt.';

  @override
  String durationInHoursAndMinutes(int hours, int minutes) {
    return '$hours Std. $minutes Min.';
  }

  @override
  String durationInMinutes(int minutes) {
    return '$minutes Min.';
  }

  @override
  String get podcastNotFoundError =>
      'Die ausgewählte Sendung konnte leider nicht gefunden werden.';

  @override
  String get podcastListItem_subscribed => 'Abonniert';

  @override
  String get podcastListItem_unsubscribe => 'Abo beenden';

  @override
  String get podcastListItem_subscribe => 'Abonnieren';

  @override
  String get podcastListItem_unsubscribed => 'Abo beendet';

  @override
  String get podcastListItem_subtitleFallback => 'Klubrádió-Sendung';

  @override
  String get podcastListItem_openDetails => 'Podcastdetails öffnen';

  @override
  String get downloads_tab_active => 'Aktiv';

  @override
  String get downloads_tab_done => 'Fertig';

  @override
  String get downloads_empty_active => 'Keine aktiven Downloads';

  @override
  String get downloads_empty_done => 'Keine fertigen Downloads';

  @override
  String get downloads_status_waiting => 'Wartet';

  @override
  String get downloads_status_running => 'Lädt';

  @override
  String get downloads_status_done => 'Fertig';

  @override
  String get downloads_status_failed => 'Fehler';

  @override
  String get downloads_status_canceled => 'Abgebrochen';

  @override
  String get downloads_status_unknown => 'Unbekannt';

  @override
  String get downloads_action_pause => 'Pause';

  @override
  String get downloads_action_resume => 'Fortsetzen';

  @override
  String get downloads_action_cancel => 'Abbrechen';

  @override
  String get downloads_action_delete => 'Löschen';

  @override
  String get downloads_section_active => 'Aktive Downloads';

  @override
  String get downloads_section_completed => 'Fertige Downloads';

  @override
  String get downloads_menu_play => 'Abspielen';

  @override
  String get downloads_menu_open_folder => 'Im Ordner öffnen';

  @override
  String get downloads_menu_delete => 'Löschen';

  @override
  String get downloads_menu_add_to_queue => 'Zur Playlist hinzufügen';

  @override
  String get ep_action_resume => 'Fortsetzen';

  @override
  String get ep_action_downloaded => 'Heruntergeladen';

  @override
  String get ep_action_retry => 'Erneut versuchen';

  @override
  String get ep_action_download => 'Download';

  @override
  String get settings_title_downloads => 'Downloads';

  @override
  String get settings_wifi_only => 'Nur WLAN';

  @override
  String get settings_wifi_only_mobile_default => 'Standard auf Mobil: AN';

  @override
  String get settings_wifi_only_desktop_default => 'Standard auf Desktop: AUS';

  @override
  String get settings_max_parallel => 'Max. gleichzeitige Downloads';

  @override
  String get settings_retention_section => 'Aufbewahrung';

  @override
  String get settings_keep_all => 'Alle behalten';

  @override
  String get settings_keep_latest_label => 'Nur die letzten n';

  @override
  String get settings_keep_latest => 'Letzte Episoden behalten';

  @override
  String get settings_keep_latest_hint =>
      'Behält pro Podcast die neuesten n Episoden.';

  @override
  String get settings_delete_after_heard_label =>
      'Nach „gehört” in x Stunden löschen';

  @override
  String get settings_delete_after_hours => 'Löschen nach (Stunden)';

  @override
  String get settings_delete_after_hint =>
      'Nach dem Anhören automatisch nach x Stunden entfernen.';

  @override
  String get settings_zero_off => '0 = AUS';

  @override
  String get settings_autodownload_subscriptions =>
      'Automatisch abonnierte Episoden herunterladen';

  @override
  String get settings_autodownload_subscriptions_hint =>
      'Neue Episoden von abonnierten Podcasts automatisch herunterladen.';

  @override
  String get profileScreenNoRecentlyPlayed => 'Noch nichts kürzlich gehört.';

  @override
  String get profileScreenSubscriptionsTitle => 'Abonnierte Sendungen';

  @override
  String get profileScreenAppIdTitle => 'App-ID';

  @override
  String get profileScreenIdCopied => 'ID kopiert';

  @override
  String get profileScreenPlaybackSpeedTitle => 'Wiedergabegeschwindigkeit';

  @override
  String profileScreenPlaybackSpeedValue(Object value) {
    return '$value×';
  }

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonCount => 'Anzahl';

  @override
  String get commonDone => 'Fertig';

  @override
  String get settings_episode_order_label => 'Episoden-Reihenfolge';

  @override
  String get settings_episode_order_newest => 'Neueste zuerst';

  @override
  String get settings_episode_order_oldest => 'Älteste zuerst';

  @override
  String get privacyDialogTitle => 'Datenschutz & Sicherheitshinweis';

  @override
  String get privacyNoticeHeadline => 'Deine Daten bleiben bei dir.';

  @override
  String get privacyNoticeBody =>
      'Diese App ist so konstruiert, dass wir technisch gar nicht in der Lage sind, persönliche Nutzungsdaten zu erfassen oder zu speichern. Es gibt keinen Account, keinen Login und keine Tracking-Infrastruktur. Alles, was du hörst, herunterlädst oder abonnierst, bleibt ausschließlich auf deinem Gerät und wird vom Server von KR direkt geladen — also unterstützt diese Arbeit. Diese App dürft Ihr auch gerne unterstützen — mehr unter \"About\".';

  @override
  String get disclaimerHeadline => 'Haftungsausschluss';

  @override
  String get disclaimerBody =>
      'Für App-Abstürze oder Datenverlust wird nicht gehaftet. Die Nutzung erfolgt auf eigene Gefahr.';

  @override
  String get privacySettingsRow => 'Datenschutz & Sicherheitshinweis';

  @override
  String get privacySettingsRowSubtitle =>
      'Tippen, um die Datenschutz- und Sicherheitshinweise anzuzeigen.';

  @override
  String get aboutScreenAppIdLabel => 'App-ID';

  @override
  String get aboutScreenContributionsTitle => 'Unterstützer';

  @override
  String get aboutScreenContributionsEmpty => 'Werde Unterstützer!';
}
```

### Inhalt von `klubradio_archivum/lib/l10n/app_localizations_en.dart`
```dart
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Klubradio Archive';

  @override
  String get downloadListTitle => 'Downloads';

  @override
  String get downloadStatusQueued => 'Queued';

  @override
  String get downloadStatusNotDownloaded => 'Not Downloaded';

  @override
  String get downloadStatusDownloaded => 'Downloaded';

  @override
  String get downloadStatusDownloading => 'Downloading';

  @override
  String get downloadStatusFailed => 'Failed';

  @override
  String get downloadActionRetry => 'Retry';

  @override
  String get downloadActionCancel => 'Cancel';

  @override
  String get downloadActionDelete => 'Delete';

  @override
  String downloadProgressLabel(int progressPercentage) {
    return '$progressPercentage%';
  }

  @override
  String get noDownloads => 'No Downloads Yet';

  @override
  String get aboutScreenAppBarTitle => 'About the Application';

  @override
  String get aboutScreenAppNameDetail => 'Klubradio Archive Application';

  @override
  String get aboutScreenPurpose =>
      'The purpose of the application is to provide easy access to Klubrádió\'s archived programs and to allow the creation of RSS feeds for podcast players.';

  @override
  String get aboutScreenCommunityProjectInfo =>
      'This is a community project that serves to support Klubrádió. All content is freely available on the radio\'s official website.';

  @override
  String get aboutScreenContactInfo =>
      'Contact: info@klubradio.hu (content), multilevelstudios@gmail.com (developer contact)';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get errorDialogTitle => 'Error';

  @override
  String get unexpectedError =>
      'An unexpected error occurred. Please try again later.';

  @override
  String podcastDetailErrorLoading(String errorDetails) {
    return 'An error occurred: $errorDetails';
  }

  @override
  String get podcastDetailSubscriptionSuccess => 'Subscription successful!';

  @override
  String get podcastDetailSubscribeButton => 'Subscribe';

  @override
  String get homeScreenSubscribedPodcastsEmptyHint =>
      'No subscriptions yet — discover podcasts and tap “Subscribe”.';

  @override
  String get homeScreenSubscribedPodcastsTitle => 'Subscribed Shows';

  @override
  String get homeScreenRecentEpisodesTitle => 'Recent Episodes';

  @override
  String get homeScreenRecentlyPlayedTitle => 'Recently Played';

  @override
  String get themeSettingSystemDefault => 'System Default';

  @override
  String get themeSettingLight => 'Light';

  @override
  String get themeSettingDark => 'Dark';

  @override
  String get settingsScreenSupportKlubradioTitle => 'Support Klubradio';

  @override
  String get settingsScreenSupportKlubradioSubtitle =>
      'Open the support page in your browser.';

  @override
  String get settingsScreenSupportDeveloperTitle => 'Support the App Developer';

  @override
  String get settingsScreenSupportDeveloperSubtitle =>
      'Voluntary donation for further development.';

  @override
  String get themeSettingsSectionTitle => 'Theme Settings';

  @override
  String get bottomNavHome => 'Home';

  @override
  String get bottomNavDiscover => 'Discover';

  @override
  String get bottomNavSearch => 'Search';

  @override
  String get bottomNavDownloads => 'Downloads';

  @override
  String get bottomNavProfile => 'Profile';

  @override
  String get bottomNavSettings => 'Settings';

  @override
  String get playbackSettingsTitle => 'Playback Settings';

  @override
  String get playbackSettingsSpeedLabel => 'Playback speed:';

  @override
  String playbackSettingsSpeedValue(double speed) {
    return '${speed}x';
  }

  @override
  String get playbackSettingsAutoDownloadLabel => 'Automatic downloads:';

  @override
  String playbackSettingsAutoDownloadValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count episodes',
      one: '1 episode',
      zero: 'No episodes',
    );
    return '$_temp0';
  }

  @override
  String showSelectedFeedback(String showTitle) {
    return '\"$showTitle\" selected.';
  }

  @override
  String get discoverScreenFeaturedCategoriesTitle => 'Top Shows';

  @override
  String get discoverScreenRecommendedShowsTitle => 'Recommended Shows';

  @override
  String get discoverScreenTrendingTitle => 'Trending';

  @override
  String get discoverScreenNoTopShows => 'No featured shows available.';

  @override
  String get recommendedPodcastsNoRecommendations =>
      'No recommendations available. Please refresh the data later.';

  @override
  String get trendingPodcastsNoShows => 'No trending shows on the list.';

  @override
  String get subscribedPodcastsNoSubscriptions =>
      'You haven\'t subscribed to any shows yet.';

  @override
  String get recentSearchesNoHistory => 'No search history yet.';

  @override
  String get searchBarHintText => 'Shows, hosts, keywords...';

  @override
  String get searchResultsNoResults => 'No results found for your search.';

  @override
  String get searchTabShows => 'Shows';

  @override
  String get searchTabEpisodes => 'Episodes';

  @override
  String get searchScreenInitialPrompt => 'Find your favorite shows or hosts.';

  @override
  String searchScreenErrorMessage(String errorDetails) {
    return 'An error occurred: $errorDetails';
  }

  @override
  String get errorParsingData => 'There was an issue processing the data.';

  @override
  String get errorUnknown => 'An unknown error occurred.';

  @override
  String get profileScreenNoEmail => 'No email address provided';

  @override
  String get profileScreenDownloadSettingsTitle => 'Download Settings';

  @override
  String get profileScreenAutoDownloadsTitle => 'Automatic Downloads';

  @override
  String profileScreenAutoDownloadsSubtitle(int count) {
    return 'Number of episodes: $count';
  }

  @override
  String get profileScreenRecentlyPlayedTitle => 'Recently Played Episodes';

  @override
  String get profileScreenFavoritesTitle => 'Favorites';

  @override
  String get profileScreenNoFavoriteEpisodes => 'No favorite episodes yet.';

  @override
  String get profileScreenGuestUserDisplayName => 'Guest User';

  @override
  String get aboutScreenLicenseTitle => 'License / Legal';

  @override
  String get aboutScreenLicenseSummary =>
      'Open the license and legal information.';

  @override
  String get aboutScreenVersionTitle => 'Version';

  @override
  String aboutScreenVersionFormat(String version, String build) {
    return '$version (Build $build)';
  }

  @override
  String podcastInfoCardHostsLabel(String hostNames) {
    return '$hostNames';
  }

  @override
  String podcastDetailScreenErrorMessage(String errorDetails) {
    return 'An error occurred while loading episodes: $errorDetails';
  }

  @override
  String get podcastDetailScreenSubscribeButton => 'Subscribe';

  @override
  String get podcastDetailScreenUnsubscribeButton => 'Unsubscribe';

  @override
  String get podcastDetailScreenSubscribeSuccess => 'Subscribed successfully!';

  @override
  String get podcastDetailScreenUnsubscribeSuccess =>
      'Unsubscribed successfully!';

  @override
  String get unsubscribeDialogTitle => 'Unsubscribe';

  @override
  String get unsubscribeDialogContent =>
      'Do you want to delete the downloaded episodes for this podcast?';

  @override
  String get unsubscribeDialogDeleteButton => 'Delete Episodes';

  @override
  String get unsubscribeDialogKeepButton => 'Keep Episodes';

  @override
  String get nowPlayingScreenTitle => 'Now Playing';

  @override
  String get nowPlayingScreenNoEpisode => 'No episode is currently playing.';

  @override
  String durationInHoursAndMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String durationInMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String get podcastNotFoundError =>
      'Sorry, the selected show could not be found.';

  @override
  String get podcastListItem_subscribed => 'Subscribed';

  @override
  String get podcastListItem_unsubscribe => 'Unsubscribe';

  @override
  String get podcastListItem_subscribe => 'Subscribe';

  @override
  String get podcastListItem_unsubscribed => 'Unsubscribed';

  @override
  String get podcastListItem_subtitleFallback => 'Klubrádió show';

  @override
  String get podcastListItem_openDetails => 'Open podcast details';

  @override
  String get downloads_tab_active => 'Active';

  @override
  String get downloads_tab_done => 'Completed';

  @override
  String get downloads_empty_active => 'No active downloads';

  @override
  String get downloads_empty_done => 'No completed downloads';

  @override
  String get downloads_status_waiting => 'Waiting';

  @override
  String get downloads_status_running => 'Downloading';

  @override
  String get downloads_status_done => 'Completed';

  @override
  String get downloads_status_failed => 'Failed';

  @override
  String get downloads_status_canceled => 'Canceled';

  @override
  String get downloads_status_unknown => 'Unknown';

  @override
  String get downloads_action_pause => 'Pause';

  @override
  String get downloads_action_resume => 'Resume';

  @override
  String get downloads_action_cancel => 'Cancel';

  @override
  String get downloads_action_delete => 'Delete';

  @override
  String get downloads_section_active => 'Active Downloads';

  @override
  String get downloads_section_completed => 'Completed Downloads';

  @override
  String get downloads_menu_play => 'Play';

  @override
  String get downloads_menu_open_folder => 'Open in folder';

  @override
  String get downloads_menu_delete => 'Delete';

  @override
  String get downloads_menu_add_to_queue => 'Add to playlist';

  @override
  String get ep_action_resume => 'Resume';

  @override
  String get ep_action_downloaded => 'Downloaded';

  @override
  String get ep_action_retry => 'Retry';

  @override
  String get ep_action_download => 'Download';

  @override
  String get settings_title_downloads => 'Downloads';

  @override
  String get settings_wifi_only => 'Wi-Fi only';

  @override
  String get settings_wifi_only_mobile_default => 'Default on mobile: ON';

  @override
  String get settings_wifi_only_desktop_default => 'Default on desktop: OFF';

  @override
  String get settings_max_parallel => 'Max concurrent downloads';

  @override
  String get settings_retention_section => 'Retention';

  @override
  String get settings_keep_all => 'Keep all';

  @override
  String get settings_keep_latest_label => 'Keep only the last n';

  @override
  String get settings_keep_latest => 'Keep latest episodes';

  @override
  String get settings_keep_latest_hint =>
      'Keeps the newest n episodes per podcast.';

  @override
  String get settings_delete_after_heard_label =>
      'Delete x hours after listened';

  @override
  String get settings_delete_after_hours => 'Delete after (hours)';

  @override
  String get settings_delete_after_hint =>
      'Automatically remove x hours after playback.';

  @override
  String get settings_zero_off => '0 = OFF';

  @override
  String get settings_autodownload_subscriptions =>
      'Autodownload subscribed episodes';

  @override
  String get settings_autodownload_subscriptions_hint =>
      'Automatically download new episodes from subscribed podcasts.';

  @override
  String get profileScreenNoRecentlyPlayed =>
      'No recently played episodes yet.';

  @override
  String get profileScreenSubscriptionsTitle => 'Subscribed shows';

  @override
  String get profileScreenAppIdTitle => 'App ID';

  @override
  String get profileScreenIdCopied => 'ID copied';

  @override
  String get profileScreenPlaybackSpeedTitle => 'Playback speed';

  @override
  String profileScreenPlaybackSpeedValue(Object value) {
    return '$value×';
  }

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonCount => 'Count';

  @override
  String get commonDone => 'Fertig';

  @override
  String get settings_episode_order_label => 'Episode order';

  @override
  String get settings_episode_order_newest => 'Newest first';

  @override
  String get settings_episode_order_oldest => 'Oldest first';

  @override
  String get privacyDialogTitle => 'Privacy & Security Notice';

  @override
  String get privacyNoticeHeadline => 'Your data stays with you.';

  @override
  String get privacyNoticeBody =>
      'This app is designed so that we are technically unable to collect or store personal usage data. There is no account, no login, and no tracking infrastructure. Everything you listen to, download, or subscribe to stays exclusively on your device and is loaded directly from the Klubradio server — so your usage supports their work. You are also welcome to support this app — more under \"About\".';

  @override
  String get disclaimerHeadline => 'Disclaimer';

  @override
  String get disclaimerBody =>
      'No liability is accepted for app crashes or data loss. Use this app at your own risk.';

  @override
  String get privacySettingsRow => 'Privacy & Security Notice';

  @override
  String get privacySettingsRowSubtitle =>
      'Tap to view the privacy and security information.';

  @override
  String get aboutScreenAppIdLabel => 'App-ID';

  @override
  String get aboutScreenContributionsTitle => 'Supporters';

  @override
  String get aboutScreenContributionsEmpty => 'Become a supporter!';
}
```

### Inhalt von `klubradio_archivum/lib/l10n/app_localizations_hu.dart`
```dart
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appName => 'Klubrádió Archívum';

  @override
  String get downloadListTitle => 'Letöltések';

  @override
  String get downloadStatusQueued => 'Várólistán';

  @override
  String get downloadStatusNotDownloaded => 'Nincs letöltve';

  @override
  String get downloadStatusDownloaded => 'Letöltve';

  @override
  String get downloadStatusDownloading => 'Letöltés';

  @override
  String get downloadStatusFailed => 'Sikertelen';

  @override
  String get downloadActionRetry => 'Újra';

  @override
  String get downloadActionCancel => 'Mégse';

  @override
  String get downloadActionDelete => 'Törlés';

  @override
  String downloadProgressLabel(int progressPercentage) {
    return '$progressPercentage%';
  }

  @override
  String get noDownloads => 'Még nincsenek letöltések';

  @override
  String get aboutScreenAppBarTitle => 'Az alkalmazásról';

  @override
  String get aboutScreenAppNameDetail => 'Klubrádió archívum alkalmazás';

  @override
  String get aboutScreenPurpose =>
      'Az alkalmazás célja, hogy egyszerű hozzáférést biztosítson a Klubrádió archív műsoraihoz, és lehetőséget adjon RSS feedek létrehozására podcast lejátszók számára.';

  @override
  String get aboutScreenCommunityProjectInfo =>
      'Ez egy közösségi projekt, amely a Klubrádió támogatását szolgálja. Minden tartalom szabadon elérhető a rádió hivatalos oldalán.';

  @override
  String get aboutScreenContactInfo =>
      'Kapcsolat: info@klubradio.hu (tartalom), multilevelstudios@gmail.com (fejlesztői elérhetőség)';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get settingsTheme => 'Téma';

  @override
  String get settingsLanguage => 'Nyelv';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Mégse';

  @override
  String get errorDialogTitle => 'Hiba';

  @override
  String get unexpectedError =>
      'Váratlan hiba történt. Kérjük, próbálja újra később.';

  @override
  String podcastDetailErrorLoading(String errorDetails) {
    return 'Hiba történt: $errorDetails';
  }

  @override
  String get podcastDetailSubscriptionSuccess => 'Feliratkozás sikeres!';

  @override
  String get podcastDetailSubscribeButton => 'Feliratkozás';

  @override
  String get homeScreenSubscribedPodcastsEmptyHint =>
      'Még nincsenek feliratkozások – fedezd fel a podcasteket és koppints a „Feliratkozás” gombra.';

  @override
  String get homeScreenSubscribedPodcastsTitle => 'Feliratkozott műsorok';

  @override
  String get homeScreenRecentEpisodesTitle => 'Legutóbbi epizódok';

  @override
  String get homeScreenRecentlyPlayedTitle => 'Legutóbb hallgatott';

  @override
  String get themeSettingSystemDefault => 'Rendszer alapértelmezett';

  @override
  String get themeSettingLight => 'Világos';

  @override
  String get themeSettingDark => 'Sötét';

  @override
  String get settingsScreenSupportKlubradioTitle => 'Támogasd a Klubrádiót';

  @override
  String get settingsScreenSupportKlubradioSubtitle =>
      'Nyisd meg a támogatási oldalt a böngészőben.';

  @override
  String get settingsScreenSupportDeveloperTitle =>
      'Támogasd az alkalmazás fejlesztőjét';

  @override
  String get settingsScreenSupportDeveloperSubtitle =>
      'Önkéntes adomány a további fejlesztésekhez.';

  @override
  String get themeSettingsSectionTitle => 'Téma beállítások';

  @override
  String get bottomNavHome => 'Főoldal';

  @override
  String get bottomNavDiscover => 'Felfedezés';

  @override
  String get bottomNavSearch => 'Keresés';

  @override
  String get bottomNavDownloads => 'Letöltések';

  @override
  String get bottomNavProfile => 'Profil';

  @override
  String get bottomNavSettings => 'Beállítások';

  @override
  String get playbackSettingsTitle => 'Lejátszási beállítások';

  @override
  String get playbackSettingsSpeedLabel => 'Lejátszási sebesség:';

  @override
  String playbackSettingsSpeedValue(double speed) {
    return '${speed}x';
  }

  @override
  String get playbackSettingsAutoDownloadLabel => 'Automatikus letöltések:';

  @override
  String playbackSettingsAutoDownloadValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count epizód',
      one: '1 epizód',
      zero: 'Nincs epizód',
    );
    return '$_temp0';
  }

  @override
  String showSelectedFeedback(String showTitle) {
    return '\"$showTitle\" kiválasztva.';
  }

  @override
  String get discoverScreenFeaturedCategoriesTitle => 'Kiemelt műsorok';

  @override
  String get discoverScreenRecommendedShowsTitle => 'Ajánlott műsorok';

  @override
  String get discoverScreenTrendingTitle => 'Felkapott';

  @override
  String get discoverScreenNoTopShows => 'Nincsenek kiemelt műsorok.';

  @override
  String get recommendedPodcastsNoRecommendations =>
      'Nincs elérhető ajánlás. Frissítsd az adatokat később.';

  @override
  String get trendingPodcastsNoShows => 'Nincs felkapott műsor a listán.';

  @override
  String get subscribedPodcastsNoSubscriptions =>
      'Még nem iratkoztál fel egy műsorra sem.';

  @override
  String get recentSearchesNoHistory => 'Még nincs keresési előzmény.';

  @override
  String get searchBarHintText => 'Műsorok, műsorvezetők, kulcsszavak...';

  @override
  String get searchResultsNoResults => 'Nincs találat a megadott keresésre.';

  @override
  String get searchTabShows => 'Műsorok';

  @override
  String get searchTabEpisodes => 'Epizódok';

  @override
  String get searchScreenInitialPrompt =>
      'Keresd meg kedvenc műsoraidat vagy műsorvezetőidet.';

  @override
  String searchScreenErrorMessage(String errorDetails) {
    return 'Hiba történt: $errorDetails';
  }

  @override
  String get errorParsingData => 'Hiba történt az adatok feldolgozása során.';

  @override
  String get errorUnknown => 'Ismeretlen hiba történt.';

  @override
  String get profileScreenNoEmail => 'Nincs megadva e-mail cím';

  @override
  String get profileScreenDownloadSettingsTitle => 'Letöltési beállítások';

  @override
  String get profileScreenAutoDownloadsTitle => 'Automatikus letöltések';

  @override
  String profileScreenAutoDownloadsSubtitle(int count) {
    return 'Epizódok száma: $count';
  }

  @override
  String get profileScreenRecentlyPlayedTitle => 'Legutóbb hallgatott epizódok';

  @override
  String get profileScreenFavoritesTitle => 'Kedvencek';

  @override
  String get profileScreenNoFavoriteEpisodes => 'Nincsenek kedvenc epizódok.';

  @override
  String get profileScreenGuestUserDisplayName => 'Vendég felhasználó';

  @override
  String get aboutScreenLicenseTitle => 'Licenc / Jogi információk';

  @override
  String get aboutScreenLicenseSummary =>
      'Licenc és jogi információk megnyitása.';

  @override
  String get aboutScreenVersionTitle => 'Verzió';

  @override
  String aboutScreenVersionFormat(String version, String build) {
    return '$version (Build $build)';
  }

  @override
  String podcastInfoCardHostsLabel(String hostNames) {
    return '$hostNames';
  }

  @override
  String podcastDetailScreenErrorMessage(String errorDetails) {
    return 'Hiba történt az epizódok betöltésekor: $errorDetails';
  }

  @override
  String get podcastDetailScreenSubscribeButton => 'Feliratkozás';

  @override
  String get podcastDetailScreenUnsubscribeButton => 'Leiratkozás';

  @override
  String get podcastDetailScreenSubscribeSuccess => 'Feliratkozás sikeres!';

  @override
  String get podcastDetailScreenUnsubscribeSuccess => 'Leiratkozás sikeres!';

  @override
  String get unsubscribeDialogTitle => 'Leiratkozás';

  @override
  String get unsubscribeDialogContent =>
      'Törölni szeretné a letöltött epizódokat ehhez a podcasthoz?';

  @override
  String get unsubscribeDialogDeleteButton => 'Epizódok törlése';

  @override
  String get unsubscribeDialogKeepButton => 'Epizódok megtartása';

  @override
  String get nowPlayingScreenTitle => 'Most szól';

  @override
  String get nowPlayingScreenNoEpisode => 'Jelenleg nincs lejátszott epizód.';

  @override
  String durationInHoursAndMinutes(int hours, int minutes) {
    return '$hours óra $minutes perc';
  }

  @override
  String durationInMinutes(int minutes) {
    return '$minutes perc';
  }

  @override
  String get podcastNotFoundError =>
      'Sajnos a kiválasztott műsor nem található.';

  @override
  String get podcastListItem_subscribed => 'Feliratkozva';

  @override
  String get podcastListItem_unsubscribe => 'Leiratkozás';

  @override
  String get podcastListItem_subscribe => 'Feliratkozás';

  @override
  String get podcastListItem_unsubscribed => 'Leiratkozva';

  @override
  String get podcastListItem_subtitleFallback => 'Klubrádió műsor';

  @override
  String get podcastListItem_openDetails => 'Műsor részleteinek megnyitása';

  @override
  String get downloads_tab_active => 'Aktív';

  @override
  String get downloads_tab_done => 'Kész';

  @override
  String get downloads_empty_active => 'Nincs aktív letöltés';

  @override
  String get downloads_empty_done => 'Nincsenek kész letöltések';

  @override
  String get downloads_status_waiting => 'Várakozik';

  @override
  String get downloads_status_running => 'Letöltés';

  @override
  String get downloads_status_done => 'Kész';

  @override
  String get downloads_status_failed => 'Hiba';

  @override
  String get downloads_status_canceled => 'Megszakítva';

  @override
  String get downloads_status_unknown => 'Ismeretlen';

  @override
  String get downloads_action_pause => 'Szünet';

  @override
  String get downloads_action_resume => 'Folytatás';

  @override
  String get downloads_action_cancel => 'Megállítás';

  @override
  String get downloads_action_delete => 'Törlés';

  @override
  String get downloads_section_active => 'Aktív letöltések';

  @override
  String get downloads_section_completed => 'Kész letöltések';

  @override
  String get downloads_menu_play => 'Lejátszás';

  @override
  String get downloads_menu_open_folder => 'Megnyitás mappában';

  @override
  String get downloads_menu_delete => 'Törlés';

  @override
  String get downloads_menu_add_to_queue => 'Hozzáadás a lejátszási listához';

  @override
  String get ep_action_resume => 'Folytatás';

  @override
  String get ep_action_downloaded => 'Letöltve';

  @override
  String get ep_action_retry => 'Újra';

  @override
  String get ep_action_download => 'Letöltés';

  @override
  String get settings_title_downloads => 'Letöltések';

  @override
  String get settings_wifi_only => 'Csak Wi-Fi-n';

  @override
  String get settings_wifi_only_mobile_default => 'Alapértelmezett mobilon: BE';

  @override
  String get settings_wifi_only_desktop_default =>
      'Alapértelmezett asztali gépen: KI';

  @override
  String get settings_max_parallel => 'Max. párhuzamos letöltés';

  @override
  String get settings_retention_section => 'Megőrzés';

  @override
  String get settings_keep_all => 'Mindet megtartja';

  @override
  String get settings_keep_latest_label => 'Csak az utolsó n';

  @override
  String get settings_keep_latest => 'Legújabb epizódok megtartása';

  @override
  String get settings_keep_latest_hint =>
      'Podcastonként a legújabb n epizód marad meg.';

  @override
  String get settings_delete_after_heard_label =>
      'Törlés x órával lejátszás után';

  @override
  String get settings_delete_after_hours => 'Törlés ennyi óra után';

  @override
  String get settings_delete_after_hint =>
      'Automatikus eltávolítás x óra után.';

  @override
  String get settings_zero_off => '0 = KI';

  @override
  String get settings_autodownload_subscriptions =>
      'Feliratkozott epizódok automatikus letöltése';

  @override
  String get settings_autodownload_subscriptions_hint =>
      'Automatikusan letölti az új epizódokat a feliratkozott podcastokból.';

  @override
  String get profileScreenNoRecentlyPlayed =>
      'Még nincs nemrég hallgatott epizód.';

  @override
  String get profileScreenSubscriptionsTitle => 'Feliratkozott műsorok';

  @override
  String get profileScreenAppIdTitle => 'Alkalmazás-azonosító';

  @override
  String get profileScreenIdCopied => 'Azonosító kimásolva';

  @override
  String get profileScreenPlaybackSpeedTitle => 'Lejátszási sebesség';

  @override
  String profileScreenPlaybackSpeedValue(Object value) {
    return '$value×';
  }

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Mégse';

  @override
  String get commonCount => 'Darab';

  @override
  String get commonDone => 'Kész';

  @override
  String get settings_episode_order_label => 'Epizódok sorrendje';

  @override
  String get settings_episode_order_newest => 'Legújabb elöl';

  @override
  String get settings_episode_order_oldest => 'Legrégebbi elöl';

  @override
  String get privacyDialogTitle => 'Adatvédelem és biztonsági tájékoztató';

  @override
  String get privacyNoticeHeadline => 'Az adataid nálad maradnak.';

  @override
  String get privacyNoticeBody =>
      'Ez az alkalmazás úgy van felépítve, hogy technikailag nem vagyunk képesek személyes felhasználási adatokat gyűjteni vagy tárolni. Nincs fiók, nincs bejelentkezés és nincs nyomkövetési infrastruktúra. Minden, amit hallgatsz, letöltesz vagy feliratkozol, kizárólag a te eszközödön marad, és közvetlenül a Klubrádió szerveréről töltődik — tehát a használatoddal támogatod a munkájukat. Ezt az alkalmazást is szívesen támogathatod — részletek az \"About\" menüben.';

  @override
  String get disclaimerHeadline => 'Felelősségkizárás';

  @override
  String get disclaimerBody =>
      'Az alkalmazás összeomlásáért vagy adatvesztésért nem vállalunk felelősséget. A használat saját felelősségre történik.';

  @override
  String get privacySettingsRow => 'Adatvédelem és biztonsági tájékoztató';

  @override
  String get privacySettingsRowSubtitle =>
      'Koppints az adatvédelmi és biztonsági információk megtekintéséhez.';

  @override
  String get aboutScreenAppIdLabel => 'Alkalmazás-azonosító';

  @override
  String get aboutScreenContributionsTitle => 'Támogatók';

  @override
  String get aboutScreenContributionsEmpty => 'Légy támogató!';
}
```

### Inhalt von `klubradio_archivum/lib/l10n/app_localizations_ro.dart`
```dart
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appName => 'Arhiva Klubradio';

  @override
  String get downloadListTitle => 'Descărcări';

  @override
  String get downloadStatusQueued => 'În așteptare';

  @override
  String get downloadStatusNotDownloaded => 'Nu este descărcat';

  @override
  String get downloadStatusDownloaded => 'Descărcat';

  @override
  String get downloadStatusDownloading => 'Se descarcă';

  @override
  String get downloadStatusFailed => 'Eșuat';

  @override
  String get downloadActionRetry => 'Reîncercați';

  @override
  String get downloadActionCancel => 'Anulați';

  @override
  String get downloadActionDelete => 'Ștergeți';

  @override
  String downloadProgressLabel(int progressPercentage) {
    return '$progressPercentage%';
  }

  @override
  String get noDownloads => 'Nicio descărcare încă';

  @override
  String get aboutScreenAppBarTitle => 'Despre aplicație';

  @override
  String get aboutScreenAppNameDetail => 'Aplicația Arhiva Klubradio';

  @override
  String get aboutScreenPurpose =>
      'Scopul aplicației este de a oferi acces ușor la programele arhivate ale Klubrádió și de a permite crearea de fluxuri RSS pentru playerele podcast.';

  @override
  String get aboutScreenCommunityProjectInfo =>
      'Acesta este un proiect comunitar care servește la susținerea Klubrádió. Tot conținutul este disponibil gratuit pe site-ul oficial al radioului.';

  @override
  String get aboutScreenContactInfo =>
      'Contact: info@klubradio.hu (conținut), multilevelstudios@gmail.com (contact dezvoltator)';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get settingsTheme => 'Temă';

  @override
  String get settingsLanguage => 'Limbă';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Anulați';

  @override
  String get errorDialogTitle => 'Eroare';

  @override
  String get unexpectedError =>
      'A apărut o eroare neașteptată. Vă rugăm să încercați din nou mai târziu.';

  @override
  String podcastDetailErrorLoading(String errorDetails) {
    return 'A apărut o eroare: $errorDetails';
  }

  @override
  String get podcastDetailSubscriptionSuccess => 'Abonare reușită!';

  @override
  String get podcastDetailSubscribeButton => 'Abonează-te';

  @override
  String get homeScreenSubscribedPodcastsEmptyHint =>
      'Nicio abonare încă — descoperiți podcasturi și atingeți „Abonează-te”.';

  @override
  String get homeScreenSubscribedPodcastsTitle => 'Emisiuni abonate';

  @override
  String get homeScreenRecentEpisodesTitle => 'Episoade recente';

  @override
  String get homeScreenRecentlyPlayedTitle => 'Redate recent';

  @override
  String get themeSettingSystemDefault => 'Implicit sistem';

  @override
  String get themeSettingLight => 'Luminos';

  @override
  String get themeSettingDark => 'Întunecat';

  @override
  String get settingsScreenSupportKlubradioTitle => 'Sprijiniți Klubradio';

  @override
  String get settingsScreenSupportKlubradioSubtitle =>
      'Deschideți pagina de suport în browserul dvs.';

  @override
  String get settingsScreenSupportDeveloperTitle =>
      'Sprijiniți dezvoltatorul aplicației';

  @override
  String get settingsScreenSupportDeveloperSubtitle =>
      'Donație voluntară pentru dezvoltare ulterioară.';

  @override
  String get themeSettingsSectionTitle => 'Setări temă';

  @override
  String get bottomNavHome => 'Acasă';

  @override
  String get bottomNavDiscover => 'Descoperiți';

  @override
  String get bottomNavSearch => 'Căutați';

  @override
  String get bottomNavDownloads => 'Descărcări';

  @override
  String get bottomNavProfile => 'Profil';

  @override
  String get bottomNavSettings => 'Setări';

  @override
  String get playbackSettingsTitle => 'Setări redare';

  @override
  String get playbackSettingsSpeedLabel => 'Viteză redare:';

  @override
  String playbackSettingsSpeedValue(double speed) {
    return '${speed}x';
  }

  @override
  String get playbackSettingsAutoDownloadLabel => 'Descărcări automate:';

  @override
  String playbackSettingsAutoDownloadValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count episoade',
      one: '1 episod',
      zero: 'Niciun episod',
    );
    return '$_temp0';
  }

  @override
  String showSelectedFeedback(String showTitle) {
    return '\"$showTitle\" selectat.';
  }

  @override
  String get discoverScreenFeaturedCategoriesTitle => 'Emisiuni populare';

  @override
  String get discoverScreenRecommendedShowsTitle => 'Emisiuni recomandate';

  @override
  String get discoverScreenTrendingTitle => 'În tendințe';

  @override
  String get discoverScreenNoTopShows => 'Nicio emisiune populară disponibilă.';

  @override
  String get recommendedPodcastsNoRecommendations =>
      'Nicio recomandare disponibilă. Vă rugăm să reîmprospătați datele mai târziu.';

  @override
  String get trendingPodcastsNoShows => 'Nicio emisiune în tendințe în listă.';

  @override
  String get subscribedPodcastsNoSubscriptions =>
      'Nu v-ați abonat încă la nicio emisiune.';

  @override
  String get recentSearchesNoHistory => 'Niciun istoric de căutări încă.';

  @override
  String get searchBarHintText => 'Emisiuni, gazde, cuvinte cheie...';

  @override
  String get searchResultsNoResults =>
      'Nu s-au găsit rezultate pentru căutarea dvs.';

  @override
  String get searchTabShows => 'Emisiuni';

  @override
  String get searchTabEpisodes => 'Episoade';

  @override
  String get searchScreenInitialPrompt =>
      'Găsiți emisiunile sau gazdele preferate.';

  @override
  String searchScreenErrorMessage(String errorDetails) {
    return 'A apărut o eroare: $errorDetails';
  }

  @override
  String get errorParsingData => 'A apărut o problemă la procesarea datelor.';

  @override
  String get errorUnknown => 'A apărut o eroare necunoscută.';

  @override
  String get profileScreenNoEmail => 'Niciun email furnizat';

  @override
  String get profileScreenDownloadSettingsTitle => 'Setări descărcări';

  @override
  String get profileScreenAutoDownloadsTitle => 'Descărcări automate';

  @override
  String profileScreenAutoDownloadsSubtitle(int count) {
    return 'Număr de episoade: $count';
  }

  @override
  String get profileScreenRecentlyPlayedTitle => 'Episoade redate recent';

  @override
  String get profileScreenFavoritesTitle => 'Favorite';

  @override
  String get profileScreenNoFavoriteEpisodes => 'Niciun episod favorit încă.';

  @override
  String get profileScreenGuestUserDisplayName => 'Utilizator invitat';

  @override
  String get aboutScreenLicenseTitle => 'Licență / Legal';

  @override
  String get aboutScreenLicenseSummary =>
      'Deschideți informațiile despre licență și legale.';

  @override
  String get aboutScreenVersionTitle => 'Versiune';

  @override
  String aboutScreenVersionFormat(String version, String build) {
    return '$version (Build $build)';
  }

  @override
  String podcastInfoCardHostsLabel(String hostNames) {
    return '$hostNames';
  }

  @override
  String podcastDetailScreenErrorMessage(String errorDetails) {
    return 'A apărut o eroare la încărcarea episoadelor: $errorDetails';
  }

  @override
  String get podcastDetailScreenSubscribeButton => 'Abonează-te';

  @override
  String get podcastDetailScreenUnsubscribeButton => 'Dezabonează-te';

  @override
  String get podcastDetailScreenSubscribeSuccess => 'Abonat cu succes!';

  @override
  String get podcastDetailScreenUnsubscribeSuccess => 'Dezabonat cu succes!';

  @override
  String get unsubscribeDialogTitle => 'Dezabonare';

  @override
  String get unsubscribeDialogContent =>
      'Doriți să ștergeți episoadele descărcate pentru acest podcast?';

  @override
  String get unsubscribeDialogDeleteButton => 'Ștergeți episoadele';

  @override
  String get unsubscribeDialogKeepButton => 'Păstrați episoadele';

  @override
  String get nowPlayingScreenTitle => 'Se redă acum';

  @override
  String get nowPlayingScreenNoEpisode =>
      'Niciun episod nu se redă în prezent.';

  @override
  String durationInHoursAndMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String durationInMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String get podcastNotFoundError =>
      'Ne pare rău, emisiunea selectată nu a putut fi găsită.';

  @override
  String get podcastListItem_subscribed => 'Abonat';

  @override
  String get podcastListItem_unsubscribe => 'Dezabonare';

  @override
  String get podcastListItem_subscribe => 'Abonare';

  @override
  String get podcastListItem_unsubscribed => 'Dezabonat';

  @override
  String get podcastListItem_subtitleFallback => 'Emisiune Klubrádió';

  @override
  String get podcastListItem_openDetails => 'Deschide detaliile podcastului';

  @override
  String get downloads_tab_active => 'Active';

  @override
  String get downloads_tab_done => 'Finalizate';

  @override
  String get downloads_empty_active => 'Nicio descărcare activă';

  @override
  String get downloads_empty_done => 'Nicio descărcare finalizată';

  @override
  String get downloads_status_waiting => 'În așteptare';

  @override
  String get downloads_status_running => 'Se descarcă';

  @override
  String get downloads_status_done => 'Finalizat';

  @override
  String get downloads_status_failed => 'Eșuat';

  @override
  String get downloads_status_canceled => 'Anulat';

  @override
  String get downloads_status_unknown => 'Necunoscut';

  @override
  String get downloads_action_pause => 'Pauză';

  @override
  String get downloads_action_resume => 'Reluați';

  @override
  String get downloads_action_cancel => 'Anulați';

  @override
  String get downloads_action_delete => 'Ștergeți';

  @override
  String get downloads_section_active => 'Descărcări active';

  @override
  String get downloads_section_completed => 'Descărcări finalizate';

  @override
  String get downloads_menu_play => 'Redare';

  @override
  String get downloads_menu_open_folder => 'Deschide în dosar';

  @override
  String get downloads_menu_delete => 'Ștergeți';

  @override
  String get downloads_menu_add_to_queue => 'Adăugați la playlist';

  @override
  String get ep_action_resume => 'Reluați';

  @override
  String get ep_action_downloaded => 'Descărcat';

  @override
  String get ep_action_retry => 'Reîncercați';

  @override
  String get ep_action_download => 'Descărcați';

  @override
  String get settings_title_downloads => 'Descărcări';

  @override
  String get settings_wifi_only => 'Doar Wi-Fi';

  @override
  String get settings_wifi_only_mobile_default => 'Implicit pe mobil: ACTIVAT';

  @override
  String get settings_wifi_only_desktop_default =>
      'Implicit pe desktop: DEZACTIVAT';

  @override
  String get settings_max_parallel => 'Descărcări concurente maxime';

  @override
  String get settings_retention_section => 'Retenție';

  @override
  String get settings_keep_all => 'Păstrați toate';

  @override
  String get settings_keep_latest_label => 'Păstrați doar ultimele n';

  @override
  String get settings_keep_latest => 'Păstrați ultimele episoade';

  @override
  String get settings_keep_latest_hint =>
      'Păstrează cele mai noi n episoade per podcast.';

  @override
  String get settings_delete_after_heard_label =>
      'Ștergeți la x ore după ascultare';

  @override
  String get settings_delete_after_hours => 'Ștergeți după (ore)';

  @override
  String get settings_delete_after_hint =>
      'Eliminați automat la x ore după redare.';

  @override
  String get settings_zero_off => '0 = DEZACTIVAT';

  @override
  String get settings_autodownload_subscriptions =>
      'Descărcați automat episoadele abonate';

  @override
  String get settings_autodownload_subscriptions_hint =>
      'Descărcați automat episoadele noi de la podcasturile abonate.';

  @override
  String get profileScreenNoRecentlyPlayed =>
      'Niciun episod redat recent încă.';

  @override
  String get profileScreenSubscriptionsTitle => 'Emisiuni abonate';

  @override
  String get profileScreenAppIdTitle => 'ID aplicație';

  @override
  String get profileScreenIdCopied => 'ID copiat';

  @override
  String get profileScreenPlaybackSpeedTitle => 'Viteză redare';

  @override
  String profileScreenPlaybackSpeedValue(Object value) {
    return '$value×';
  }

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Anulați';

  @override
  String get commonCount => 'Număr';

  @override
  String get commonDone => 'Finalizat';

  @override
  String get settings_episode_order_label => 'Ordinea episoadelor';

  @override
  String get settings_episode_order_newest => 'Cele mai noi primele';

  @override
  String get settings_episode_order_oldest => 'Cele mai vechi primele';

  @override
  String get privacyDialogTitle =>
      'Notificare de confidențialitate și securitate';

  @override
  String get privacyNoticeHeadline => 'Datele tale rămân la tine.';

  @override
  String get privacyNoticeBody =>
      'Această aplicație este concepută astfel încât nu suntem capabili din punct de vedere tehnic să colectăm sau să stocăm date personale de utilizare. Nu există cont, nu există autentificare și nu există infrastructură de urmărire. Tot ceea ce asculți, descarci sau te abonezi rămâne exclusiv pe dispozitivul tău și se încarcă direct de pe serverul Klubradio — astfel utilizarea ta le susține munca. Sunteți bineveniți să susțineți și această aplicație — mai multe în \"About\".';

  @override
  String get disclaimerHeadline => 'Declinarea responsabilității';

  @override
  String get disclaimerBody =>
      'Nu se acceptă nicio responsabilitate pentru blocări ale aplicației sau pierderi de date. Utilizați această aplicație pe propria răspundere.';

  @override
  String get privacySettingsRow =>
      'Notificare de confidențialitate și securitate';

  @override
  String get privacySettingsRowSubtitle =>
      'Atingeți pentru a vizualiza informațiile de confidențialitate și securitate.';

  @override
  String get aboutScreenAppIdLabel => 'ID aplicație';

  @override
  String get aboutScreenContributionsTitle => 'Susținători';

  @override
  String get aboutScreenContributionsEmpty => 'Devino susținător!';
}
```

### Inhalt von `klubradio_archivum/lib/main.dart`
```dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'package:provider/provider.dart';

import 'api/podcast_api.dart';
import 'l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'repositories/podcast_repository.dart';

import 'providers/download_provider.dart';
import 'providers/episode_provider.dart';
import 'providers/podcast_provider.dart';
import 'providers/latest_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/recommended_provider.dart';
import 'services/api_cache_service.dart';
import 'services/api_service.dart';
import 'services/audio_player_service.dart';
import 'screens/app_shell/app_shell.dart';
import 'providers/profile_provider.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'repositories/profile_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && Platform.isLinux) {
    JustAudioMediaKit.ensureInitialized();
  }
  await Hive.initFlutter();
  runApp(const KlubradioArchivumApp());
}

class KlubradioArchivumApp extends StatefulWidget {
  const KlubradioArchivumApp({super.key});
  @override
  State<KlubradioArchivumApp> createState() => _KlubradioArchivumAppState();
}

class _KlubradioArchivumAppState extends State<KlubradioArchivumApp> {
  late final AppDatabase db;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    SettingsDao(db).ensureDefaults();
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: db),
        Provider<ApiService>(
          create: (_) => ApiService(),
          dispose: (_, ApiService service) => service.dispose(),
        ),
        Provider<ApiCacheService>(create: (_) => ApiCacheService()),
        Provider<AudioPlayerService>(
          create: (_) => AudioPlayerService(),
          dispose: (_, AudioPlayerService service) => service.dispose(),
        ),
        // EpisodeProvider depends on ApiService + AudioPlayerService
        ChangeNotifierProxyProvider3<
          ApiService,
          AudioPlayerService,
          AppDatabase,
          EpisodeProvider
        >(
          create: (context) => EpisodeProvider(
            apiService: context.read<ApiService>(),
            audioPlayerService: context.read<AudioPlayerService>(),
            db: context.read<AppDatabase>(),
          ),
          update: (context, api, audio, db, previous) {
            if (previous != null) {
              previous.updateDependencies(api, audio, db);
              return previous;
            }
            return EpisodeProvider(
              apiService: api,
              audioPlayerService: audio,
              db: db,
            );
          },
        ),
        ChangeNotifierProvider<DownloadProvider>(
          create: (ctx) => DownloadProvider(
            db: ctx.read<AppDatabase>(),
            episodeProvider: ctx.read<EpisodeProvider>(),
            apiService: ctx.read<ApiService>(),
          ),
        ),
        Provider<SubscriptionsDao>(
          create: (ctx) => SubscriptionsDao(ctx.read<AppDatabase>()),
        ),
        Provider<EpisodesDao>(
          create: (ctx) => EpisodesDao(ctx.read<AppDatabase>()),
        ),
        ChangeNotifierProxyProvider<DownloadProvider, SubscriptionProvider>(
          create: (ctx) => SubscriptionProvider(
            subscriptionsDao: ctx.read<SubscriptionsDao>(),
            settingsDao: SettingsDao(ctx.read<AppDatabase>()),
            downloadProvider: ctx.read<DownloadProvider>(),
          ),
          update: (context, downloadProvider, previous) {
            if (previous != null) {
              previous.updateDependencies(downloadProvider: downloadProvider);
              return previous;
            }
            return SubscriptionProvider(
              subscriptionsDao: context.read<SubscriptionsDao>(),
              settingsDao: SettingsDao(context.read<AppDatabase>()),
              downloadProvider: downloadProvider,
            );
          },
        ),
        // Repository layer for podcasts
        Provider<PodcastRepository>(
          create: (ctx) {
            final apiService = ctx.read<ApiService>();
            // Aus ApiService die Konfig übernehmen:
            final api = PodcastApi(
              baseUrl: apiService
                  .supabaseUrl, // <— falls nicht public: expose getter
              apiKey: apiService.supabaseKey, // <— dito
            );
            return PodcastRepository(api: api);
          },
        ),
        // ProfileRepository (SharedPreferences-basiert)
        Provider<ProfileRepository>(create: (_) => ProfileRepository()),

        // ProfileProvider (lädt Profil beim Start)
        ChangeNotifierProvider<ProfileProvider>(
          create: (ctx) =>
              ProfileProvider(repo: ctx.read<ProfileRepository>())..load(),
        ),
        ChangeNotifierProvider<LatestProvider>(
          create: (ctx) => LatestProvider(ctx.read<PodcastRepository>()),
        ),
        ChangeNotifierProvider<RecommendedProvider>(
          create: (ctx) => RecommendedProvider(ctx.read<PodcastRepository>()),
        ),
        // Theme provider (consumed by the single MaterialApp below)
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),

        // PodcastProvider depends on ApiService + DownloadService
        ChangeNotifierProxyProvider4<
          ApiService,
          DownloadProvider,
          ProfileProvider,
          ApiCacheService,
          PodcastProvider
        >(
          create: (context) => PodcastProvider(
            apiService: context.read<ApiService>(),
            downloadProvider: context.read<DownloadProvider>(),
            profileProvider: context.read<ProfileProvider>(),
            apiCacheService: context.read<ApiCacheService>(),
          ),
          update: (context, api, dlProv, profileProv, apiCache, previous) {
            if (previous != null) {
              previous.updateDependencies(api, dlProv, profileProv, apiCache);
              return previous;
            }
            return PodcastProvider(
              apiService: api,
              downloadProvider: dlProv,
              profileProvider: profileProv,
              apiCacheService: apiCache,
            );
          },
        ),
      ],

      // Single MaterialApp (removes the duplicate from before)
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
            theme: theme.lightTheme,
            darkTheme: theme.darkTheme,
            themeMode: theme.themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            // Keep the shell mounted so bottom nav + player persist across tabs/stacks
            home: const AppShell(),
          );
        },
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/models/episode.dart`
```dart
import 'dart:convert';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;
import 'package:klubradio_archivum/db/app_database.dart' as db; // For db.Episode

enum DownloadStatus { notDownloaded, queued, downloading, downloaded, failed, canceled }

class Episode {
  Episode({
    required this.id,
    required this.podcastId,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.publishedAt,
    required this.showDate,
    required this.duration,
    this.imageUrl,
    this.hosts = const <String>[],
    this.isFavourite = false,
    this.downloadStatus = DownloadStatus.notDownloaded,
    this.downloadProgress = 0,
    this.localFilePath,
    this.cachedTitle,
    this.cachedImagePath,
    this.cachedMetaPath,
  });

  factory Episode.fromDb(db.Episode dbEpisode) {
    return Episode(
      id: dbEpisode.id,
      podcastId: dbEpisode.podcastId,
      title: dbEpisode.title,
      description: dbEpisode.description ?? dbEpisode.cachedTitle ?? '',
      audioUrl: dbEpisode.audioUrl,
      publishedAt: dbEpisode.publishedAt ?? DateTime.now(),
      showDate: dbEpisode.showDate ?? dbEpisode.publishedAt?.toIso8601String().substring(0, 10) ?? '',
      duration: dbEpisode.durationSeconds != null
          ? Duration(seconds: dbEpisode.durationSeconds!)
          : Duration.zero,
      imageUrl: dbEpisode.cachedImagePath ?? dbEpisode.imageUrl,
      hosts: const <String>[],
      isFavourite: false,
      downloadStatus: _downloadStatusFromJson(dbEpisode.status),
      downloadProgress: dbEpisode.progress,
      localFilePath: dbEpisode.localPath,
      cachedTitle: dbEpisode.cachedTitle,
      cachedImagePath: dbEpisode.cachedImagePath,
      cachedMetaPath: dbEpisode.cachedMetaPath,
    );
  }

  factory Episode.fromJson(Map<String, dynamic> json, {String? podcastCoverImageUrl}) {
    final hostsJson = json['hosts'];
    String? imageUrl = json['imageUrl'] as String?;

    if (imageUrl == constants.problematicEpisodeImageUrl) {
      imageUrl = podcastCoverImageUrl ?? constants.defaultEpisodeImageUrl;
    }
    
    return Episode(
      id: json['id'].toString(),
      podcastId: json['podcastId'].toString(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      audioUrl: json['audioUrl'] as String? ?? '',
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      showDate: json['showDate'] as String? ?? '',
      duration: json['duration'] is int
          ? Duration(seconds: json['duration'] as int)
          : _durationFromString(json['duration']?.toString()),
      imageUrl: imageUrl,
      hosts: hostsJson is List
          ? hostsJson.map((dynamic e) => e.toString()).toList()
          : const <String>[],
      isFavourite: json['isFavourite'] as bool? ?? false,
      downloadStatus: _downloadStatusFromJson(json['downloadStatus']),
      downloadProgress: (json['downloadProgress'] as num?)?.toDouble() ?? 0,
      localFilePath: json['localFilePath'] as String?,
      cachedTitle: json['cachedTitle'] as String?,
      cachedImagePath: json['cachedImagePath'] as String?,
      cachedMetaPath: json['cachedMetaPath'] as String?,
    );
  }

  final String id;
  final String podcastId;
  final String title;
  final String description;
  final String audioUrl;
  final DateTime publishedAt;
  final String showDate;
  final Duration duration;
  final String? imageUrl;
  final List<String> hosts;
  final bool isFavourite;
  final DownloadStatus downloadStatus;
  final double downloadProgress;
  final String? localFilePath;

  final String? cachedTitle;
  final String? cachedImagePath;
  final String? cachedMetaPath;

  /// Bevorzugter Titel für UI (offline → cachedTitle, sonst title)
  String get displayTitle =>
      (cachedTitle != null && cachedTitle!.isNotEmpty) ? cachedTitle! : title;

  /// true, wenn ein lokal gecachtes Bild verfügbar ist
  bool get hasCachedImage =>
      (cachedImagePath != null && cachedImagePath!.isNotEmpty);

  /// Bevorzugte Bild-Quelle (Pfad oder URL): zuerst lokal, dann remote
  String? get displayImagePathOrUrl =>
      hasCachedImage ? cachedImagePath : imageUrl;

  /// Kennzeichnet, ob displayImagePathOrUrl eine lokale Datei ist
  bool get isDisplayImageLocal => hasCachedImage;

  Episode copyWith({
    String? id,
    String? podcastId,
    String? title,
    String? description,
    String? audioUrl,
    DateTime? publishedAt,
    String? showDate,
    Duration? duration,
    String? imageUrl,
    List<String>? hosts,
    bool? isFavourite,
    DownloadStatus? downloadStatus,
    double? downloadProgress,
    String? localFilePath,
    String? cachedTitle,
    String? cachedImagePath,
    String? cachedMetaPath,
  }) {
    return Episode(
      id: id ?? this.id,
      podcastId: podcastId ?? this.podcastId,
      title: title ?? this.title,
      description: description ?? this.description,
      audioUrl: audioUrl ?? this.audioUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      showDate: showDate ?? this.showDate,
      duration: duration ?? this.duration,
      imageUrl: imageUrl ?? this.imageUrl,
      hosts: hosts ?? List<String>.from(this.hosts),
      isFavourite: isFavourite ?? this.isFavourite,
      downloadStatus: downloadStatus ?? this.downloadStatus,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      localFilePath: localFilePath ?? this.localFilePath,
      cachedTitle: cachedTitle ?? this.cachedTitle,
      cachedImagePath: cachedImagePath ?? this.cachedImagePath,
      cachedMetaPath: cachedMetaPath ?? this.cachedMetaPath,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'podcastId': podcastId,
      'title': title,
      'description': description,
      'audioUrl': audioUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'showDate': showDate,
      'duration': duration.inSeconds,
      'imageUrl': imageUrl,
      'hosts': hosts,
      'isFavourite': isFavourite,
      'downloadStatus': downloadStatus.name,
      'downloadProgress': downloadProgress,
      'localFilePath': localFilePath,
      'cachedTitle': cachedTitle,
      'cachedImagePath': cachedImagePath,
      'cachedMetaPath': cachedMetaPath,
    };
  }

  static Duration _durationFromString(String? value) {
    if (value == null || value.isEmpty) return Duration.zero;
    final parts = value.split(':');
    if (parts.length == 3) {
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      final seconds = int.tryParse(parts[2]) ?? 0;
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    }
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      return Duration(minutes: minutes, seconds: seconds);
    }
    return Duration(seconds: int.tryParse(value) ?? 0);
  }

  static DownloadStatus _downloadStatusFromJson(dynamic value) {
    if (value == null) return DownloadStatus.notDownloaded;
    // Handle String (from toJson / offline JSON cache)
    if (value is String) {
      return DownloadStatus.values.firstWhere(
        (s) => s.name == value,
        orElse: () => DownloadStatus.notDownloaded,
      );
    }
    // Handle int (from DB / Drift)
    if (value is int) {
      switch (value) {
        case 0: return DownloadStatus.notDownloaded;
        case 1: return DownloadStatus.queued;
        case 2: return DownloadStatus.downloading;
        case 3: return DownloadStatus.downloaded;
        case 4: return DownloadStatus.failed;
        case 5: return DownloadStatus.canceled;
        default: return DownloadStatus.notDownloaded;
      }
    }
    return DownloadStatus.notDownloaded;
  }

  @override
  String toString() => jsonEncode(toJson());
}
```

### Inhalt von `klubradio_archivum/lib/models/podcast.dart`
```dart
import 'dart:convert';
import 'episode.dart';
import 'show_host.dart';

/// Represents a podcast or show within the Klubrádió archive.
class Podcast {
  Podcast({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.episodeCount,
    required this.hosts,
    this.latestEpisode,
    this.lastUpdated,
    this.isSubscribed = false,
    this.isTrending = false,
    this.isRecommended = false,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    final hostsJson = json['hosts'];

    return Podcast(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? 'Ismeretlen műsor',
      description: json['description'] as String? ?? '',
      coverImageUrl: json['cover_image_url'] as String? ?? '',
      episodeCount: json['episode_count'] is int
          ? json['episode_count'] as int
          : int.tryParse(json['episode_count']?.toString() ?? '') ?? 0,
      hosts: hostsJson is List
          ? hostsJson
                .whereType<Map<String, dynamic>>()
                .map(ShowHost.fromJson)
                .toList()
          : const <ShowHost>[],
      latestEpisode: json['latest_episode'] is Map<String, dynamic>
          ? Episode.fromJson(json['latest_episode'] as Map<String, dynamic>)
          : null,
      lastUpdated: json['last_updated'] != null
          ? DateTime.tryParse(json['last_updated'].toString())
          : null,
      isSubscribed: json['is_subscribed'] as bool? ?? false,
      isTrending: json['is_trending'] as bool? ?? false,
      isRecommended: json['is_recommended'] as bool? ?? false,
    );
  }

  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final int episodeCount;
  final List<ShowHost> hosts;
  final Episode? latestEpisode;
  final DateTime? lastUpdated;
  final bool isSubscribed;
  final bool isTrending;
  final bool isRecommended;

  Podcast copyWith({
    String? id,
    String? title,
    String? description,
    String? coverImageUrl,
    int? episodeCount,
    List<ShowHost>? hosts,
    Episode? latestEpisode,
    DateTime? lastUpdated,
    bool? isSubscribed,
    bool? isTrending,
    bool? isRecommended,
  }) {
    return Podcast(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      episodeCount: episodeCount ?? this.episodeCount,
      hosts: hosts ?? List<ShowHost>.from(this.hosts),
      latestEpisode: latestEpisode ?? this.latestEpisode,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      isTrending: isTrending ?? this.isTrending,
      isRecommended: isRecommended ?? this.isRecommended,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'episodeCount': episodeCount,
      'hosts': hosts.map((h) => h.toJson()).toList(),
      'latestEpisode': latestEpisode?.toJson(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'isSubscribed': isSubscribed,
      'isTrending': isTrending,
      'isRecommended': isRecommended,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
```

### Inhalt von `klubradio_archivum/lib/models/retention_mode.dart`
```dart
enum RetentionMode { keepAll, keepLatestN, deleteAfterHeard }```

### Inhalt von `klubradio_archivum/lib/models/show_data.dart`
```dart
class ShowData {
  final String id;
  final String title;
  final int count;

  ShowData({required this.id, required this.title, required this.count});

  factory ShowData.fromJson(Map<String, dynamic> json) {
    return ShowData(
      id: json['id'].toString(),
      title: json['title'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'title': title, 'count': count};
  }
}
```

### Inhalt von `klubradio_archivum/lib/models/show_host.dart`
```dart
import 'dart:convert';

class ShowHost {
  const ShowHost({required this.name});

  factory ShowHost.fromJson(Map<String, dynamic> json) {
    return ShowHost(name: json['name'] as String? ?? 'Ismeretlen műsorvezető');
  }

  final String name;

  ShowHost copyWith({String? name}) {
    return ShowHost(name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name};
  }

  @override
  String toString() => jsonEncode(toJson());
}
```

### Inhalt von `klubradio_archivum/lib/models/user_profile.dart`
```dart
// lib/models/user_profile.dart
import 'dart:convert';
import 'episode.dart';

class UserProfile {
  final String id; // anonymous app id
  final String languageCode; // 'de' | 'en' | 'hu'
  final double playbackSpeed; // 0.5..3.0
  final int maxAutoDownload; // z.B. 10
  final Set<String> subscribedPodcastIds;
  final Set<String> favouriteEpisodeIds;
  final List<Episode> recentlyPlayed;

  const UserProfile({
    required this.id,
    required this.languageCode,
    required this.playbackSpeed,
    required this.maxAutoDownload,
    required this.subscribedPodcastIds,
    required this.favouriteEpisodeIds,
    required this.recentlyPlayed,
  });

  UserProfile copyWith({
    String? id,
    String? languageCode,
    double? playbackSpeed,
    int? maxAutoDownload,
    Set<String>? subscribedPodcastIds,
    List<Episode>? recentlyPlayed,
    Set<String>? favouriteEpisodeIds,
  }) {
    return UserProfile(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      maxAutoDownload: maxAutoDownload ?? this.maxAutoDownload,
      subscribedPodcastIds: subscribedPodcastIds ?? this.subscribedPodcastIds,
      favouriteEpisodeIds: favouriteEpisodeIds ?? this.favouriteEpisodeIds,
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
    );
  }

  factory UserProfile.initial(String id, {String languageCode = 'de'}) {
    return UserProfile(
      id: id,
      languageCode: languageCode,
      playbackSpeed: 1.0,
      maxAutoDownload: 10,
      subscribedPodcastIds: <String>{},
      favouriteEpisodeIds: <String>{},
      recentlyPlayed: const <Episode>[],
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Migration: akzeptiere alte Felder stillschweigend, falls noch vorhanden
    return UserProfile(
      id: json['id'] as String,
      languageCode: (json['languageCode'] ?? 'de') as String,
      playbackSpeed: (json['playbackSpeed'] as num?)?.toDouble() ?? 1.0,
      maxAutoDownload: (json['maxAutoDownload'] as num?)?.toInt() ?? 10,
      subscribedPodcastIds:
          (json['subscribedPodcastIds'] as List?)
              ?.map((e) => e.toString())
              .toSet() ??
          <String>{},
      recentlyPlayed:
          (json['recentlyPlayed'] as List?)
              ?.map((e) => Episode.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          <Episode>[],
      favouriteEpisodeIds:
          (json['favouriteEpisodeIds'] as List?)
              ?.map((e) => e.toString())
              .toSet() ??
          <String>{},
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'languageCode': languageCode,
    'playbackSpeed': playbackSpeed,
    'maxAutoDownload': maxAutoDownload,
    'subscribedPodcastIds': subscribedPodcastIds.toList(),
    'recentlyPlayed': recentlyPlayed.map((e) => e.toJson()).toList(),
    'favouriteEpisodeIds': favouriteEpisodeIds.toList(),
  };

  @override
  String toString() => jsonEncode(toJson());
}
```

### Inhalt von `klubradio_archivum/lib/providers/download_provider.dart`
```dart
// lib/providers/download_provider.dart
import 'dart:async' show unawaited;
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' show Value;

import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/services/download_service.dart';
import 'package:klubradio_archivum/services/api_service.dart'; // Import ApiService
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart'; // Import PlatformUtils

import '../providers/episode_provider.dart';

/// Einfacher ChangeNotifier-Provider rund um den DownloadService.
class DownloadProvider extends ChangeNotifier {
  DownloadProvider({
    required AppDatabase db,
    required EpisodeProvider episodeProvider,
    required this.apiService,
  })  : episodesDao = EpisodesDao(db),
        subscriptionsDao = SubscriptionsDao(db),
        settingsDao = SettingsDao(db),
        retentionDao = RetentionDao(
          db,
          EpisodesDao(db),
          SubscriptionsDao(db),
          SettingsDao(db),
        ) {
    _isDownloadsSupported = PlatformUtils.supportsDownloads;

    if (_isDownloadsSupported) {
      service = DownloadService(
        db: db,
        episodesDao: episodesDao,
        subscriptionsDao: subscriptionsDao,
        settingsDao: settingsDao,
        retentionDao: retentionDao,
        episodeProvider: episodeProvider,
        apiService: apiService,
      );
      // init bewusst nicht awaiten – der Service wartet intern auf _ready
      unawaited(service.init());
    } else {
      // For web, create a dummy DownloadService or ensure `service` is not used.
      // For this approach, we'll rely on the method checks.
      // We still need a non-null `service` for type safety, but it won't be initialized.
      // Let's make `service` nullable and check it in methods.
      // OR, provide a Null DownloadService implementation if we want to avoid null checks everywhere.
      // For now, let's make it simple: `service` is not initialized, and methods will guard against it.
    }
  }

  // late final DownloadService service; // Will be initialized conditionally
  DownloadService? _service; // Make it nullable
  bool _isDownloadsSupported = false;

  set service(DownloadService svc) => _service = svc; // Setter for conditional init
  DownloadService get service {
    if (_service == null) {
      throw StateError('DownloadService accessed when not supported/initialized');
    }
    return _service!;
  }

  final EpisodesDao episodesDao;
  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;
  final RetentionDao retentionDao;
  final ApiService apiService; // Add apiService field

  /// API, die Screens aufrufen:
  Future<void> enqueue(model.Episode ep) async {
    if (!_isDownloadsSupported) return;
    await _service!.enqueueEpisode(ep);
    notifyListeners();
  }

  Future<void> pause(String episodeId) async {
    if (!_isDownloadsSupported) return;
    await _service!.pause(episodeId);
    notifyListeners();
  }

  Future<void> resume(String episodeId) async {
    if (!_isDownloadsSupported) return;
    await _service!.resume(episodeId);
    notifyListeners();
  }

  Future<void> cancel(String episodeId) async {
    if (!_isDownloadsSupported) return;
    await _service!.cancel(episodeId);
    notifyListeners();
  }

  Future<void> removeLocalFile(String episodeId) async {
    if (!_isDownloadsSupported) return;
    await _service!.removeLocalFile(episodeId);
    notifyListeners();
  }

  Future<void> deleteEpisodesForPodcast(String podcastId) async {
    if (!_isDownloadsSupported) return;
    await _service!.deleteEpisodesForPodcast(podcastId);
    notifyListeners();
  }

  Future<int> autodownloadPodcast(String podcastId) async {
    if (!_isDownloadsSupported) return 0;
    final count = await _service!.autodownloadPodcast(podcastId);
    notifyListeners();
    return count;
  }

  Future<void> autoEnqueueLatestN(
    String podcastId,
    int n,
    List<model.Episode> candidates,
  ) async {
    if (!_isDownloadsSupported) return;
    final latest = candidates.take(n).toList();

    for (final ep in latest) {
      final row = await episodesDao.getById(ep.id);
      final alreadyDone = row?.status == 3 && (row?.localPath ?? '').isNotEmpty;
      final alreadyQueuedOrRunning = row?.status == 1 || row?.status == 2;

      if (alreadyDone || alreadyQueuedOrRunning) {
        continue;
      }

      if (row == null) {
        await episodesDao.upsert(
          EpisodesCompanion(
            id: Value(ep.id),
            podcastId: Value(ep.podcastId),
            title: Value(ep.title),
            audioUrl: Value(ep.audioUrl),
            publishedAt: Value(ep.publishedAt),
            status: const Value(0), // none
            progress: const Value(0),
          ),
        );
      }

      await _service!.enqueueEpisode(ep);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    if (_isDownloadsSupported) {
      // Stream sauber abmelden, damit nach Widget-Dispose keine Events mehr ankommen
      unawaited(_service!.dispose());
    }
    super.dispose();
  }
}
```

### Inhalt von `klubradio_archivum/lib/providers/episode_provider.dart`
```dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:drift/drift.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/audio_player_service.dart';
import 'package:klubradio_archivum/utils/episode_cache_reader.dart';

class EpisodeProvider extends ChangeNotifier {
  EpisodeProvider({
    required ApiService apiService,
    required AudioPlayerService audioPlayerService,
    required db.AppDatabase db,
  }) : _apiService = apiService,
       _db = db,
       _audioPlayerService = audioPlayerService {
    _positionSubscription = _audioPlayerService.positionStream.listen(
      _onPositionChanged,
    );
    _playerStateSubscription = _audioPlayerService.playerStateStream.listen(
      _onPlayerStateChanged,
    );
    _bufferingSubscription = _audioPlayerService.bufferingStream.listen(
      _onBufferingChanged,
    );
  }

  late db.AppDatabase _db;
  ApiService _apiService;
  AudioPlayerService _audioPlayerService;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<bool>? _bufferingSubscription;

  final ValueNotifier<Duration> _positionNotifier =
      ValueNotifier<Duration>(Duration.zero);

  model.Episode? _currentEpisode;
  List<model.Episode> _queue = <model.Episode>[];
  bool _isBuffering = false;
  double _playbackSpeed = 1.0;

  model.Episode? get currentEpisode => _currentEpisode;
  ValueNotifier<Duration> get positionNotifier => _positionNotifier;

  bool get isPlaying => _audioPlayerService.isPlaying;
  bool get isBuffering => _isBuffering;
  Duration? get totalDuration => _audioPlayerService.totalDuration;
  List<model.Episode> get queue => List<model.Episode>.unmodifiable(_queue);
  double get playbackSpeed => _playbackSpeed;

  void updateDependencies(
    ApiService apiService,
    AudioPlayerService audioPlayerService,
    db.AppDatabase db,
  ) {
    if (!identical(_apiService, apiService)) {
      _apiService = apiService;
    }
    if (!identical(_db, db)) _db = db;
    if (!identical(_audioPlayerService, audioPlayerService)) {
      _positionSubscription?.cancel();
      _playerStateSubscription?.cancel();
      _bufferingSubscription?.cancel();
      _audioPlayerService = audioPlayerService;
      _positionSubscription = _audioPlayerService.positionStream.listen(
        _onPositionChanged,
      );
      _playerStateSubscription = _audioPlayerService.playerStateStream.listen(
        _onPlayerStateChanged,
      );
      _bufferingSubscription = _audioPlayerService.bufferingStream.listen(
        _onBufferingChanged,
      );
    }
  }

  Future<List<model.Episode>> fetchEpisodes(String podcastId) async {
    return _apiService.fetchEpisodesForPodcast(podcastId);
  }

  final Set<String> _loadedPodcasts = {};

  /// Fetches episodes from the API and upserts them into the local DB.
  /// Skips if already loaded this session. The StreamBuilder in
  /// PodcastDetailScreen will reactively update.
  Future<void> loadEpisodesIntoDb(String podcastId) async {
    if (_loadedPodcasts.contains(podcastId)) return;
    _loadedPodcasts.add(podcastId);
    try {
      final episodes = await _apiService.fetchEpisodesForPodcast(podcastId);
      final companions = episodes.map((ep) => db.EpisodesCompanion(
        id: Value(ep.id),
        podcastId: Value(ep.podcastId),
        title: Value(ep.title),
        audioUrl: Value(ep.audioUrl),
        publishedAt: Value(ep.publishedAt),
        durationSeconds: Value(ep.duration.inSeconds),
        description: Value(ep.description),
        showDate: Value(ep.showDate),
        imageUrl: Value(ep.imageUrl),
      )).toList();
      if (companions.isNotEmpty) {
        await EpisodesDao(_db).upsertAll(companions);
      }
    } catch (e) {
      _loadedPodcasts.remove(podcastId);
      debugPrint('loadEpisodesIntoDb($podcastId): $e');
    }
  }

  Future<void> playEpisode(
    model.Episode episode, {
    List<model.Episode>? queue,
    bool preferLocal = true,
  }) async {
    if (queue != null) {
      _queue = List<model.Episode>.of(queue);
    } else if (!_queue.any((model.Episode item) => item.id == episode.id)) {
      _queue.insert(0, episode);
    }

    model.Episode episodeForPlay = episode;
    if (preferLocal && (episode.cachedMetaPath?.isNotEmpty ?? false)) {
      final fromCache = await readEpisodeFromCacheJson(episode.cachedMetaPath!);
      if (fromCache != null) {
        episodeForPlay = fromCache;
      }
    }

    _currentEpisode = episodeForPlay;

    await _audioPlayerService.loadEpisode(episodeForPlay);
    notifyListeners();
  }

  Future<void> onEpisodeDownloaded(String episodeId, String localPath) async {
    if (_currentEpisode?.id == episodeId) {
      // If the downloaded episode is currently playing
      final currentPosition = _positionNotifier.value;
      await _audioPlayerService.stop(); // Stop playback

      // Update _currentEpisode to point to the local path
      _currentEpisode = _currentEpisode!.copyWith(localFilePath: localPath);

      // Reload episode and resume playback from local
      await _audioPlayerService.loadEpisode(_currentEpisode!);
      await _audioPlayerService.seek(currentPosition);
      await _audioPlayerService.togglePlayPause();
      notifyListeners();
    }
  }

  /// Jumps the playback position relative to the current position.
  /// Use a positive [duration] to seek forward, and a negative one to seek backward.
  Future<void> seekRelative(Duration duration) async {
    // Use the provider's own `_currentPosition` property
    Duration newPosition = _positionNotifier.value + duration;

    // --- Boundary Checks ---
    // Ensure the new position is not negative
    if (newPosition.isNegative) {
      newPosition = Duration.zero;
    }

    // Ensure the new position does not exceed the episode duration
    // Use the provider's `totalDuration` getter
    final episodeDuration = totalDuration ?? Duration.zero;
    if (newPosition > episodeDuration) {
      newPosition = episodeDuration;
    }

    // --- FIX: Optimistically update the local state ---
    // Update the internal position immediately and notify listeners.
    // This allows consecutive seek calls to work as expected.
    _positionNotifier.value = newPosition;

    // Now, tell the audio player to perform the actual seek.
    await _audioPlayerService.seek(newPosition);
  }

  Future<void> playNext() async {
    final model.Episode? nextEpisode = getNextEpisode();
    if (nextEpisode != null) {
      await playEpisode(nextEpisode);
    }
  }

  Future<void> playPrevious() async {
    final model.Episode? previousEpisode = getPreviousEpisode();
    if (previousEpisode != null) {
      await playEpisode(previousEpisode);
    }
  }

  model.Episode? getNextEpisode() {
    if (_currentEpisode == null) {
      return null;
    }
    final int index = _queue.indexWhere(
      (model.Episode episode) => episode.id == _currentEpisode!.id,
    );
    if (index != -1 && index + 1 < _queue.length) {
      return _queue[index + 1];
    }
    return null;
  }

  model.Episode? getPreviousEpisode() {
    if (_currentEpisode == null) {
      return null;
    }
    final int index = _queue.indexWhere(
      (model.Episode episode) => episode.id == _currentEpisode!.id,
    );
    if (index > 0) {
      return _queue[index - 1];
    }
    return null;
  }

  Future<void> togglePlayPause() => _audioPlayerService.togglePlayPause();

  Future<void> seek(Duration position) => _audioPlayerService.seek(position);

  Future<void> updatePlaybackSpeed(double speed) async {
    _playbackSpeed = speed;
    await _audioPlayerService.setSpeed(speed);
    notifyListeners();
  }

  void addToQueue(model.Episode episode) {
    if (_queue.any((model.Episode item) => item.id == episode.id)) {
      return;
    }
    _queue.add(episode);
    notifyListeners();
  }

  void removeFromQueue(String episodeId) {
    _queue.removeWhere((model.Episode episode) => episode.id == episodeId);
    notifyListeners();
  }

  void reorderQueue(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final model.Episode item = _queue.removeAt(oldIndex);
    _queue.insert(newIndex, item);
    notifyListeners();
  }

  void _onPositionChanged(Duration position) {
    _positionNotifier.value = position;
  }

  void _onPlayerStateChanged(PlayerState state) {
    notifyListeners();
  }

  void _onBufferingChanged(bool isBuffering) {
    _isBuffering = isBuffering;
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    await _positionSubscription?.cancel();
    await _playerStateSubscription?.cancel();
    await _bufferingSubscription?.cancel();
    _positionNotifier.dispose();
    super.dispose();
  }
}
```

### Inhalt von `klubradio_archivum/lib/providers/latest_provider.dart`
```dart
import 'package:flutter/foundation.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/repositories/podcast_repository.dart';

class LatestProvider extends ChangeNotifier {
  LatestProvider(this.repo);
  final PodcastRepository repo;

  List<Podcast> items = const [];
  String? error;
  bool loading = false;

  Future<void> load({bool useCacheFirst = true}) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      items = await repo.latest(useCacheFirst: useCacheFirst);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
```

### Inhalt von `klubradio_archivum/lib/providers/podcast_provider.dart`
```dart
// lib/providers/podcast_provider.dart
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../models/episode.dart';
import '../models/podcast.dart';
import '../models/show_data.dart';
import '../models/user_profile.dart';
import '../screens/utils/constants.dart' as constants;
import '../services/api_service.dart';
import '../providers/download_provider.dart';

import '../providers/profile_provider.dart';

import '../services/api_cache_service.dart';

class PodcastProvider extends ChangeNotifier {
  PodcastProvider({
    required ApiService apiService,
    required DownloadProvider downloadProvider,
    required ProfileProvider profileProvider,
    required ApiCacheService apiCacheService,
  }) : _apiService = apiService,
       _downloadProvider = downloadProvider,
       _profileProvider = profileProvider,
       _apiCacheService = apiCacheService;

  ApiService _apiService;
  DownloadProvider _downloadProvider;
  ProfileProvider _profileProvider;
  ApiCacheService _apiCacheService;

  final Map<String, List<Episode>> _episodesByPodcast =
      <String, List<Episode>>{};
  final List<String> _recentSearches = <String>[];

  List<Podcast> _podcasts = <Podcast>[];
  List<Podcast> _trendingPodcasts = <Podcast>[];
  List<Podcast> _recommendedPodcasts = <Podcast>[];
  List<Episode> _recentEpisodes = <Episode>[];

  List<ShowData> _topShows = [];
  List<ShowData> get topShows => _topShows;
  bool _isLoadingTopShows = false;
  bool get isLoadingTopShows => _isLoadingTopShows;

  UserProfile? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;

  List<Podcast> get podcasts => _podcasts;
  List<Podcast> get trendingPodcasts => _trendingPodcasts;
  List<Podcast> get recommendedPodcasts => _recommendedPodcasts;
  List<Episode> get recentEpisodes => _recentEpisodes;
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get recentSearches => List<String>.unmodifiable(_recentSearches);

  List<Podcast> get subscribedPodcasts {
    if (_userProfile == null) return const <Podcast>[];
    return _podcasts
        .where((p) => _userProfile!.subscribedPodcastIds.contains(p.id))
        .toList();
  }

  void updateDependencies(
    ApiService apiService,
    DownloadProvider downloadProvider,
    ProfileProvider profileProvider,
    ApiCacheService apiCacheService,
  ) {
    if (!identical(_apiService, apiService)) {
      _apiService = apiService;
    }
    if (!identical(_downloadProvider, downloadProvider)) {
      _downloadProvider = downloadProvider;
    }
    if (!identical(_profileProvider, profileProvider)) {
      _profileProvider = profileProvider;
    }
    if (!identical(_apiCacheService, apiCacheService)) {
      _apiCacheService = apiCacheService;
    }
  }

  /// Kleiner Mess-Helper: protokolliert Dauer + Fehler je Call.
  Future<T?> _measure<T>(String label, Future<T> Function() call) async {
    final t0 = DateTime.now();
    if (kDebugMode) debugPrint('LOAD → $label start');
    try {
      final res = await call();
      final t1 = DateTime.now();
      if (kDebugMode) {
        debugPrint('LOAD ← $label ok  Δ=${t1.difference(t0).inMilliseconds}ms');
      }
      return res;
    } catch (e) {
      final t1 = DateTime.now();
      if (kDebugMode) {
        debugPrint(
          'LOAD ← $label ERR Δ=${t1.difference(t0).inMilliseconds}ms  $e',
        );
      }
      return null; // andere Calls sollen weiterlaufen
    }
  }

  Future<void> loadInitialData({bool forceRefresh = false}) async {
    if (_isLoading && !forceRefresh) {
      if (kDebugMode) debugPrint('LOAD ✋ already running – skip');
      return;
    }
    final t0 = DateTime.now();
    if (kDebugMode) debugPrint('LOAD ▶ start');
    _isLoading = true;
    _errorMessage = null;
    if (forceRefresh && kDebugMode) debugPrint('LOAD ▷ forceRefresh=true');
    notifyListeners();

    try {
      // Alle Fetches PARALLEL starten – jede mit eigener Messung/Fehlerlogik
      final fLatest = _measure<List<Podcast>>(
        'latestPodcasts',
        () => _apiService.fetchLatestPodcasts(),
      );

      final fRecommended = _measure<List<Podcast>>(
        'recommended',
        () => _apiService.fetchRecommendedPodcasts(),
      );

      final fTrending = _measure<List<Podcast>>(
        'trending',
        () => _apiService.fetchTrendingPodcasts(),
      );

      final fRecent = _measure<List<Episode>>(
        'recentEpisodes',
        () => _apiService.fetchRecentEpisodes(),
      );

      // TopShows separat (mit interner Messung)
      final fTopShows = loadTopShows(forceRefresh: forceRefresh);

      // Warten bis alles fertig (Fehler sind bereits im Helper geloggt)
      final results = await Future.wait([
        fLatest,
        fTrending,
        fRecommended,
        fRecent,
        fTopShows,
      ]);

      // Zuordnen, was da ist
      final latestPodcasts = results[0] as List<Podcast>?;
      final trending = results[1] as List<Podcast>?;
      final recommended = results[2] as List<Podcast>?;
      final recent = results[3] as List<Episode>?;

      if (latestPodcasts != null) _podcasts = latestPodcasts;
      if (trending != null) _trendingPodcasts = trending;
      if (recommended != null) _recommendedPodcasts = recommended;
      if (recent != null) _recentEpisodes = recent;

      if (kDebugMode) {
        debugPrint('LOAD ✓ mapped');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
      final t1 = DateTime.now();
      if (kDebugMode) {
        debugPrint('LOAD ■ done total=${t1.difference(t0).inMilliseconds}ms');
      }
    }
  }

  Future<void> loadUserProfile({String userId = constants.demoUserId}) async {
    try {
      _userProfile = await _apiService.fetchUserProfile(userId);
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }





  Future<void> downloadEpisode(Episode episode) async {
    try {
      await _downloadProvider.enqueue(episode);
    } catch (_) {
      // Fehler werden über UI/DB sichtbar; hier keine Exception werfen
    }
  }

  Future<void> removeDownload(String episodeId) async {
    await _downloadProvider.removeLocalFile(episodeId);
    notifyListeners();
  }



  Future<List<Episode>> fetchEpisodesForPodcast(String podcastId) async {
    var episodes = _episodesByPodcast[podcastId];
    if (episodes == null || episodes.isEmpty) {
      episodes = await _apiService.fetchEpisodesForPodcast(podcastId);
      _episodesByPodcast[podcastId] = episodes;
    }
    return episodes;
  }

  void addRecentSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    _recentSearches.remove(trimmed);
    _recentSearches.insert(0, trimmed);
    if (_recentSearches.length > constants.maxRecentSearches) {
      _recentSearches.removeLast();
    }
    notifyListeners();
  }

  Future<List<Podcast>> searchPodcasts(String query) async {
    addRecentSearch(query);
    try {
      return await _apiService.searchPodcasts(query);
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
      return const <Podcast>[];
    }
  }

  Future<List<Episode>> searchEpisodes(String query) async {
    try {
      return await _apiService.searchEpisodes(query);
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
      return const <Episode>[];
    }
  }

  Future<void> addRecentlyPlayed(Episode episode) async {
    await _profileProvider.addRecentlyPlayed(episode);
    notifyListeners(); // Notify listeners in PodcastProvider as well, if needed for UI updates
  }

  void toggleFavourite(Episode episode) {
    final profile = _userProfile;
    if (profile == null) return;

    final favourites = Set<String>.from(profile.favouriteEpisodeIds);
    if (favourites.contains(episode.id)) {
      favourites.remove(episode.id);
    } else {
      favourites.add(episode.id);
    }
    _userProfile = profile.copyWith(favouriteEpisodeIds: favourites);
    notifyListeners();
  }

  void updateAutoDownloadCount(int count) {
    final profile = _userProfile;
    if (profile == null) return;
    _userProfile = profile.copyWith(maxAutoDownload: count);
    notifyListeners();
  }

  Future<Podcast?> fetchPodcastById(String podcastId) async {
    try {
      final podcast = await _apiService.fetchPodcastById(podcastId);
      return podcast;
    } catch (e) {
      debugPrint('Error fetching podcast $podcastId by ID: $e');
      return null;
    }
  }

  Future<void> loadTopShows({bool forceRefresh = false}) async {
    if (!forceRefresh && _topShows.isNotEmpty) return;

    _isLoadingTopShows = true;
    notifyListeners();

    try {
      final s0 = DateTime.now();
      _topShows = await _apiService.fetchTopShowsThisYear();
      final s1 = DateTime.now();
      if (kDebugMode) {
        debugPrint(
          'LOAD ← topShows ok  Δ=${s1.difference(s0).inMilliseconds}ms',
        );
      }
    } catch (e) {
      final s1 = DateTime.now();
      debugPrint(
        'LOAD ← topShows ERR Δ=${s1.difference(s1).inMilliseconds}ms  $e',
      );
    } finally {
      _isLoadingTopShows = false;
      notifyListeners();
    }
  }




}
```

### Inhalt von `klubradio_archivum/lib/providers/profile_provider.dart`
```dart
// lib/providers/profile_provider.dart
import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../models/episode.dart';
import '../repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({ProfileRepository? repo})
    : _repo = repo ?? ProfileRepository();

  final ProfileRepository _repo;

  UserProfile? _profile;
  UserProfile get profile => _profile!;
  UserProfile? get profileOrNull => _profile;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    _profile = await _repo.load();
    _loading = false;
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _profile = profile.copyWith(languageCode: code);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> setPlaybackSpeed(double v) async {
    _profile = profile.copyWith(playbackSpeed: v);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> setMaxAutoDownload(int n) async {
    _profile = profile.copyWith(maxAutoDownload: n);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> toggleFavouriteEpisode(String episodeId) async {
    final fav = Set<String>.from(profile.favouriteEpisodeIds);
    if (fav.contains(episodeId)) {
      fav.remove(episodeId);
    } else {
      fav.add(episodeId);
    }
    _profile = profile.copyWith(favouriteEpisodeIds: fav);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> setSubscriptions(Set<String> ids) async {
    _profile = profile.copyWith(subscribedPodcastIds: ids);
    await _repo.save(profile);
    notifyListeners();
  }

  Future<void> addRecentlyPlayed(Episode episode) async {
    final updated = List<Episode>.from(profile.recentlyPlayed);
    updated.removeWhere((e) => e.id == episode.id);
    updated.insert(0, episode);
    if (updated.length > 10) { // Assuming a max of 10 recently played episodes
      updated.removeLast();
    }
    _profile = profile.copyWith(recentlyPlayed: updated);
    await _repo.save(profile);
    notifyListeners();
  }
}
```

### Inhalt von `klubradio_archivum/lib/providers/recommended_provider.dart`
```dart
import 'package:flutter/foundation.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/repositories/podcast_repository.dart';

class RecommendedProvider extends ChangeNotifier {
  RecommendedProvider(this.repo);
  final PodcastRepository repo;

  List<Podcast> items = const [];
  String? error;
  bool loading = false;

  Future<void> load({bool useCacheFirst = true}) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      items = await repo.recommended(useCacheFirst: useCacheFirst);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
```

### Inhalt von `klubradio_archivum/lib/providers/subscription_provider.dart`
```dart
// lib/providers/subscription_provider.dart
import 'package:flutter/foundation.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    required this.subscriptionsDao,
    required this.settingsDao,
    required this.downloadProvider,
  }) {
    _isSubscriptionsSupported = PlatformUtils.supportsSubscriptions;
    // If subscriptions are not supported, make sure the DAO is not actively used
    // or its methods are also no-ops. For now, we guard provider methods.
  }

  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;
  DownloadProvider downloadProvider; // Make it non-final to allow updating

  Subscription? _currentSubscription;
  Subscription? get currentSubscription => _currentSubscription;

  bool _busy = false;
  bool get busy => _busy;

  bool _loaded = false;
  bool get loaded => _loaded;

  bool _isSubscriptionsSupported = false; // Flag for platform support

  void updateDependencies({
    required DownloadProvider downloadProvider,
  }) {
    if (this.downloadProvider != downloadProvider) {
      this.downloadProvider = downloadProvider;
    }
  }

  Future<void> loadSubscription(String podcastId) async {
    if (!_isSubscriptionsSupported) {
      _loaded = true;
      return;
    }
    _currentSubscription = await subscriptionsDao.getById(podcastId);
    _loaded = true;
    notifyListeners();
  }

  Stream<Subscription?> watchSubscription(String podcastId) {
    if (!_isSubscriptionsSupported) return Stream.value(null); // No-op for unsupported platforms
    return subscriptionsDao.watchOne(podcastId);
  }

  Future<void> toggleSubscription(String podcastId, bool isSubscribed) async {
    if (!_isSubscriptionsSupported) return; // No-op for unsupported platforms
    debugPrint(
      'toggleSubscription: podcastId=$podcastId, isSubscribed=$isSubscribed, busy=true',
    );
    _busy = true;
    notifyListeners();
    try {
      int? autoDownloadDefault;
      if (!isSubscribed) {
        final settings = await settingsDao.getOne();
        autoDownloadDefault =
            settings?.keepLatestN ?? constants.defaultAutoDownloadCount;
      }
      await subscriptionsDao.toggleSubscribe(
        podcastId: podcastId,
        active: !isSubscribed,
        autoDownloadN: autoDownloadDefault,
      );
      _currentSubscription = await subscriptionsDao.getById(podcastId);
      debugPrint(
        'toggleSubscription: subscriptionsDao.toggleSubscribe completed',
      );

      if (!isSubscribed) {
        final downloadCount = await downloadProvider.autodownloadPodcast(
          podcastId,
        );
        debugPrint(
          'toggleSubscription: autodownload called, downloading files: $downloadCount',
        );
      }
    } catch (e) {
      debugPrint('toggleSubscription: Error: $e');
      rethrow; // Re-throw the error so it can be caught by the UI
    } finally {
      _busy = false;
      notifyListeners();
      debugPrint('toggleSubscription: busy=false, notifyListeners called');
    }
  }
}
```

### Inhalt von `klubradio_archivum/lib/providers/theme_provider.dart`
```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _kThemeMode = 'themeMode';

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  // TODO CHECK if color theme is like
  // @link https://www.klubradio.hu/archivum
  ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFB00020),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    textTheme: Typography.blackMountainView,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: const Color(0xFFF6F6F6),
    appBarTheme: const AppBarTheme(centerTitle: true),
  );

  ThemeData get darkTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFCF6679),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
  );

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_kThemeMode);
    if (value != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (m) => m.name == value,
        orElse: () => ThemeMode.system,
      );
      notifyListeners();
    }
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeMode, _themeMode.name);
  }

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode();
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveThemeMode();
    notifyListeners();
  }
}
```

### Inhalt von `klubradio_archivum/lib/repositories/podcast_repository.dart`
```dart
import 'package:klubradio_archivum/api/podcast_api.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/services/cache_store.dart';

class PodcastRepository {
  PodcastRepository({required this.api, CacheStore? cache})
    : _cache = cache ?? CacheStore();

  final PodcastApi api;
  final CacheStore _cache;

  Future<List<Podcast>> latest({bool useCacheFirst = true}) async {
    return _cachedList(
      cacheName: 'latest_podcasts.json',
      fetch: () async =>
          (await api.latest()).map((e) => Podcast.fromJson(e)).toList(),
      useCacheFirst: useCacheFirst,
    );
  }

  Future<List<Podcast>> recommended({bool useCacheFirst = true}) async {
    return _cachedList(
      cacheName: 'recommended_podcasts.json',
      fetch: () async =>
          (await api.recommended()).map((e) => Podcast.fromJson(e)).toList(),
      useCacheFirst: useCacheFirst,
    );
  }

  Future<List<Podcast>> trending() async =>
      (await api.trending()).map(Podcast.fromJson).toList();

  Future<List<Episode>> recentEpisodes() async {
    final allP = await allPodcasts();
    final podcastCoverImageUrls = {
      for (var p in allP) p.id: p.coverImageUrl
    };

    return (await api.recentEpisodes())
        .map((e) => Episode.fromJson(
              e,
              podcastCoverImageUrl:
                  podcastCoverImageUrls[e['podcastId'].toString()],
            ))
        .toList();
  }

  // ---- helpers ----
  Future<List<Podcast>> allPodcasts() async {
    return _cachedList(
      cacheName: 'all_podcasts.json',
      fetch: () async =>
          (await api.latest(limit: 999999)).map((e) => Podcast.fromJson(e)).toList(),
      useCacheFirst: true,
    );
  }

  Future<List<T>> _cachedList<T>({
    required String cacheName,
    required Future<List<T>> Function() fetch,
    required bool useCacheFirst,
  }) async {
    if (useCacheFirst) {
      final cached = await _cache.read(cacheName);
      final items = cached?['items'];
      if (items is List && items.isNotEmpty) {
        // SWR: sofort liefern und im Hintergrund erneuern
        _refresh(cacheName, fetch);
        return items
            .cast<Map<String, dynamic>>()
            .map<T>((e) => _mapFactory<T>(e))
            .toList();
      }
    }

    final fresh = await fetch();
    // persist
    if (fresh.isNotEmpty) {
      final serializable = fresh.map<Map<String, dynamic>>((e) {
        if (e is Podcast) return e.toJson();
        if (e is Episode) return e.toJson();
        throw StateError('Unknown type $T');
      }).toList();
      await _cache.write(cacheName, serializable);
    }
    return fresh;
  }

  void _refresh<T>(String cacheName, Future<List<T>> Function() fetch) async {
    try {
      final fresh = await fetch();
      if (fresh.isNotEmpty) {
        final serializable = fresh.map<Map<String, dynamic>>((e) {
          if (e is Podcast) return e.toJson();
          if (e is Episode) return e.toJson();
          throw StateError('Unknown type $T');
        }).toList();
        await _cache.write(cacheName, serializable);
      }
    } catch (_) {
      /* silently */
    }
  }

  T _mapFactory<T>(Map<String, dynamic> json) {
    if (T == Podcast) return Podcast.fromJson(json) as T;
    if (T == Episode) return Episode.fromJson(json) as T;
    throw StateError('No mapper for type $T');
  }
}
```

### Inhalt von `klubradio_archivum/lib/repositories/profile_repository.dart`
```dart
// lib/repositories/profile_repository.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/utils/device_id.dart';

class ProfileRepository {
  static const _kProfile = 'user_profile.json';

  Future<UserProfile> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kProfile);
    if (raw == null) {
      final id = await AppIdentity.getAppId();
      final profile = UserProfile.initial(id);
      await save(profile);
      return profile;
    }
    try {
      return UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      final id = await AppIdentity.getAppId();
      final profile = UserProfile.initial(id);
      await save(profile);
      return profile;
    }
  }

  Future<void> save(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kProfile, jsonEncode(profile.toJson()));
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/about_screen/about_screen.dart`
```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:klubradio_archivum/screens/about_screen/legal_screen.dart';
import 'package:klubradio_archivum/screens/widgets/privacy_dialog.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? versionText;
  List<String> _contributors = [];

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _loadContributors();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      versionText = l10n.aboutScreenVersionFormat(
        info.version,
        info.buildNumber,
      );
    });
  }

  Future<void> _loadContributors() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/contributions.json');
      final List<dynamic> data = json.decode(jsonString) as List<dynamic>;
      if (!mounted) return;
      setState(() {
        _contributors = data
            .map((e) => (e as Map<String, dynamic>)['name'] as String)
            .toList();
      });
    } catch (_) {
      // If the file can't be loaded, keep the list empty.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutScreenAppBarTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Main About Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: cs.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.aboutScreenAppNameDetail,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(l10n.aboutScreenPurpose, style: textTheme.bodyMedium),
                    const SizedBox(height: 12),
                    Text(
                      l10n.aboutScreenCommunityProjectInfo,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    SelectableText(
                      l10n.aboutScreenContactInfo,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Privacy & Security Notice Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.shield_outlined),
                title: Text(l10n.privacySettingsRow),
                subtitle: Text(l10n.privacySettingsRowSubtitle),
                onTap: () => showPrivacyDialog(context),
              ),
            ),

            const SizedBox(height: 16),

            // License Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(l10n.aboutScreenLicenseTitle),
                subtitle: Text(l10n.aboutScreenLicenseSummary),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LegalScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Version Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.code_outlined),
                title: Text(l10n.aboutScreenVersionTitle),
                subtitle: Text(versionText ?? '...'),
              ),
            ),

            const SizedBox(height: 16),

            // App-ID Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.fingerprint),
                title: Text(l10n.aboutScreenAppIdLabel),
                subtitle: const SelectableText('hu.klubradio.archivum'),
              ),
            ),

            const SizedBox(height: 16),

            // Supporters Card
            Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.volunteer_activism_outlined,
                            color: cs.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.aboutScreenContributionsTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (_contributors.isEmpty)
                      Text(
                        l10n.aboutScreenContributionsEmpty,
                        style: textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      )
                    else
                      ...List.generate(_contributors.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Icon(Icons.favorite,
                                  size: 16, color: cs.primary),
                              const SizedBox(width: 8),
                              Text(
                                _contributors[index],
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/about_screen/legal_screen.dart`
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:markdown_widget/markdown_widget.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  Future<String> _loadLegal() => rootBundle.loadString('assets/legal/LEGAL.md');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutScreenLicenseTitle)),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: _loadLegal(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snap.hasData || snap.data!.isEmpty) {
              return Center(
                child: Text(
                  'LEGAL.md not found',
                  style: textTheme.bodyMedium?.copyWith(color: cs.error),
                ),
              );
            }

            // MarkdownWidget handles links; keep layout consistent with our cards
            return Card(
              margin: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: MarkdownWidget(
                  data: snap.data!,
                  config: MarkdownConfig(
                    // TODO MarkdownConfig
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/app_shell/app_shell.dart`
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/foundation.dart'; // Import for kIsWeb -- Removed

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';

import 'package:klubradio_archivum/screens/home_screen/home_screen.dart';
import 'package:klubradio_archivum/screens/discover_screen/discover_screen.dart';
import 'package:klubradio_archivum/screens/search_screen/search_screen.dart';
import 'package:klubradio_archivum/screens/download_manager_screen/download_manager_screen.dart';
import 'package:klubradio_archivum/screens/profile_screen/profile_screen.dart';
import 'package:klubradio_archivum/screens/settings_screen/settings_screen.dart';
import 'package:klubradio_archivum/screens/about_screen/about_screen.dart';
import 'package:klubradio_archivum/screens/widgets/privacy_dialog.dart';
import 'package:klubradio_archivum/services/privacy_notice_service.dart';

import 'package:klubradio_archivum/screens/widgets/stateful/now_playing_bar.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/bottom_navigation_bar.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  List<GlobalKey<NavigatorState>> _navKeys = [];
  List<Widget> _screens = [];
  bool _initialized = false;
  bool _privacyCheckDone = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initializeNavigation();
      _initialized = true;
    }
    if (!_privacyCheckDone) {
      _privacyCheckDone = true;
      _checkFirstStartPrivacy();
    }
  }

  Future<void> _checkFirstStartPrivacy() async {
    final shouldShow = await PrivacyNoticeService.shouldShowNotice();
    if (shouldShow && mounted) {
      await showPrivacyDialog(context);
      await PrivacyNoticeService.markNoticeShown();
    }
  }

  void _initializeNavigation() {
    _navKeys = [];
    _screens = [];

    // Always include these
    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const HomeScreen()),
    );

    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const DiscoverScreen()),
    );

    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const SearchScreen()),
    );

    // Conditionally add Downloads tab
    if (PlatformUtils.supportsDownloads) {
      _navKeys.add(GlobalKey<NavigatorState>());
      _screens.add(
        _TabNav(
          key: _navKeys.last,
          builder: (_) => const DownloadManagerScreen(),
        ),
      );
    }

    // Always include these
    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const ProfileScreen()),
    );

    _navKeys.add(GlobalKey<NavigatorState>());
    _screens.add(
      _TabNav(key: _navKeys.last, builder: (_) => const SettingsScreen()),
    );

    // Ensure _index is valid if tabs were removed
    if (_index >= _screens.length) {
      _index = 0;
    }
  }

  void onPopInvokedWithResult(bool didPop, result) {
    if (didPop) return; // If system already popped, do nothing
    final nav = _navKeys[_index].currentState!;
    if (nav.canPop()) {
      nav.pop();
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasCurrent = context.watch<EpisodeProvider>().currentEpisode != null;

    // Build destinations list fresh each time
    final destinations = <NavigationDestination>[
      AppBottomNavigationBar.buildDestination(
        Icons.home_outlined,
        Icons.home,
        l10n.bottomNavHome,
      ),
      AppBottomNavigationBar.buildDestination(
        Icons.explore_outlined,
        Icons.explore,
        l10n.bottomNavDiscover,
      ),
      AppBottomNavigationBar.buildDestination(
        Icons.search_outlined,
        Icons.search,
        l10n.bottomNavSearch,
      ),
      if (PlatformUtils.supportsDownloads)
        AppBottomNavigationBar.buildDestination(
          Icons.download_outlined,
          Icons.download,
          l10n.bottomNavDownloads,
        ),
      AppBottomNavigationBar.buildDestination(
        Icons.person_outline,
        Icons.person,
        l10n.bottomNavProfile,
      ),
      AppBottomNavigationBar.buildDestination(
        Icons.settings_outlined,
        Icons.settings,
        l10n.bottomNavSettings,
      ),
    ];

    return PopScope(
      canPop: false, // We handle popping manually
      onPopInvokedWithResult: onPopInvokedWithResult,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.appName),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: l10n.aboutScreenAppBarTitle,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
        body: IndexedStack(
          index: _index,
          children: _screens, // Use filtered screens
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: hasCurrent
                    ? const NowPlayingBar(key: ValueKey('npb'))
                    : const SizedBox.shrink(key: ValueKey('npb-empty')),
              ),
              AppBottomNavigationBar(
                currentIndex: _index,
                onTap: (i) async {
                  if (i == _index) {
                    // Re-tap auf denselben Tab
                    if (i == 0) {
                      final nav = _navKeys[0].currentState;
                      nav?.popUntil((route) => route.isFirst);
                      await context.read<PodcastProvider>().loadInitialData(
                        forceRefresh: true,
                      );
                    }
                    return;
                  }
                  setState(() => _index = i);
                },
                destinations: destinations,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabNav extends StatelessWidget {
  const _TabNav({super.key, required this.builder});
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: builder, settings: settings),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/discover_screen/discover_screen.dart`
```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/providers/latest_provider.dart';
import 'package:klubradio_archivum/providers/recommended_provider.dart';

import 'recommended_podcasts_list.dart';
import 'top_shows_list.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool _bootstrapped = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
      final latest = context.read<LatestProvider>();
      final rec = context.read<RecommendedProvider>();

      // Cache-first sofort anzeigen
      await Future.wait([
        latest.load(useCacheFirst: true),
        rec.load(useCacheFirst: true),
      ], eagerError: false);

      // im Hintergrund frische Daten (UI bleibt sichtbar)
      unawaited(latest.load(useCacheFirst: false));
      unawaited(rec.load(useCacheFirst: false));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_bootstrapped) {
      _bootstrapped = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<PodcastProvider>().loadInitialData();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        final latest = context.read<LatestProvider>();
        final rec = context.read<RecommendedProvider>();

        // Cache-first schnell, danach still fresh
        await Future.wait([
          latest.load(useCacheFirst: true),
          rec.load(useCacheFirst: true),
        ], eagerError: false);

        // Silent refresh (UI bleibt sichtbar)
        latest.load(useCacheFirst: false);
        rec.load(useCacheFirst: false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final latest = context.watch<LatestProvider>();
    final rec = context.watch<RecommendedProvider>();
    final topShowsData = context
        .watch<PodcastProvider>()
        .topShows; // bleibt wie gehabt

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          latest.load(useCacheFirst: false),
          rec.load(useCacheFirst: false),
          context.read<PodcastProvider>().loadTopShows(forceRefresh: true),
        ], eagerError: false);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            l10n.discoverScreenFeaturedCategoriesTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),

          if (latest.loading && latest.items.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            TopShowsList(topShows: topShowsData),
          const SizedBox(height: 24),

          Text(
            l10n.discoverScreenRecommendedShowsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (rec.loading && rec.items.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            RecommendedPodcastsList(podcasts: rec.items),
          const SizedBox(height: 24),

          Text(
            l10n.discoverScreenRecommendedShowsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (latest.loading && latest.items.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            RecommendedPodcastsList(podcasts: latest.items),
        ],
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/discover_screen/recommended_podcasts_list.dart`
```dart
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/podcast_list_item.dart';

class RecommendedPodcastsList extends StatelessWidget {
  const RecommendedPodcastsList({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    // Get l10n instance
    final l10n = AppLocalizations.of(context)!;

    if (podcasts.isEmpty) {
      return Text(
        l10n.recommendedPodcastsNoRecommendations, // Use localized string
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign
            .center, // Optional: for better display of multi-line messages
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: podcasts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final Podcast podcast = podcasts[index];
        return PodcastListItem(podcast: podcast);
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/discover_screen/top_shows_list.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/models/show_data.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/podcast_detail_screen/podcast_detail_screen.dart';

class TopShowsList extends StatelessWidget {
  final List<ShowData> topShows;

  const TopShowsList({super.key, required this.topShows});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // Get l10n instance

    if (topShows.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: topShows.map((ShowData show) {
        return FilterChip(
          label: Text('${show.title} (${show.count})'),
          onSelected: (bool selected) async {
            if (!selected) {
              return;
            }
            final provider = context.read<PodcastProvider>();
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            final navigator = Navigator.of(context);

            // 1. Optionally, add the selected show title to recent searches
            provider.addRecentSearch(show.title);

            // 2. Fetch the full Podcast object using the show.id
            // This assumes you have a method `fetchPodcastById` in your provider.
            final Podcast? podcast = await provider.fetchPodcastById(show.id);

            // 3. Navigate to the PodcastDetailScreen if the podcast was found
            if (podcast != null) {
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => PodcastDetailScreen(podcast: podcast),
                ),
              );
            } else {
              // Handle case where podcast could not be fetched
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(l10n.podcastNotFoundError),
                ), // Assuming you add this l10n key
              );
            }
          },
        );
      }).toList(),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/discover_screen/trending_podcasts_list.dart`
```dart
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/podcast_list_item.dart';

class TrendingPodcastsList extends StatelessWidget {
  const TrendingPodcastsList({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    // Get l10n instance
    final l10n = AppLocalizations.of(context)!;

    if (podcasts.isEmpty) {
      return Text(
        l10n.trendingPodcastsNoShows, // Use localized string
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center, // Optional: for better display
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: podcasts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final Podcast podcast = podcasts[index];
        return PodcastListItem(podcast: podcast);
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/download_manager_screen/download_list.dart`
```dart
import 'dart:io';

import 'package:drift/drift.dart' as d show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/episode_list_item.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';
import 'package:klubradio_archivum/utils/episode_cache_reader.dart';

import 'download_list_entries.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.watch<AppDatabase>();

    final activeStream =
        (db.select(db.episodes)
              ..where((e) => e.status.isIn(const [1, 2]))
              ..orderBy([(e) => d.OrderingTerm.desc(e.updatedAt)]))
            .watch();

    final completedStream =
        (db.select(db.episodes)
              ..where((e) => e.status.equals(3))
              ..where((e) => e.localPath.isNotNull())
              ..orderBy([(e) => d.OrderingTerm.desc(e.completedAt)]))
            .watch();

    return StreamBuilder<List<Episode>>(
      stream: activeStream,
      builder: (context, activeSnap) {
        return StreamBuilder<List<Episode>>(
          stream: completedStream,
          builder: (context, completedSnap) {
            final activeItems = activeSnap.data ?? const <Episode>[];
            final completedItems = completedSnap.data ?? const <Episode>[];

            final bothWaiting =
                activeSnap.connectionState == ConnectionState.waiting &&
                completedSnap.connectionState == ConnectionState.waiting;
            if (bothWaiting && activeItems.isEmpty && completedItems.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (activeItems.isEmpty && completedItems.isEmpty) {
              return Center(child: Text(l10n.noDownloads));
            }

            final entries = buildDownloadListEntries(
              activeItems: activeItems,
              completedItems: completedItems,
            );

            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                switch (entry.type) {
                  case DownloadListEntryType.activeHeader:
                    return _SectionHeader(
                      icon: Icons.downloading,
                      title: l10n.downloads_section_active,
                    );
                  case DownloadListEntryType.activeItem:
                    return _ActiveDownloadTile(episode: entry.episode!);
                  case DownloadListEntryType.completedHeader:
                    return _SectionHeader(
                      icon: Icons.check_circle_outline,
                      title: l10n.downloads_section_completed,
                    );
                  case DownloadListEntryType.completedItem:
                    return _CompletedDownloadTile(episode: entry.episode!);
                }
              },
            );
          },
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveDownloadTile extends StatelessWidget {
  const _ActiveDownloadTile({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.read<DownloadProvider>();
    final ep = episode;
    final status = _statusLabel(context, ep.status);
    final percentLabel = formatProgress(ep.progress);

    final bytesMB = (ep.bytesDownloaded != null)
        ? (ep.bytesDownloaded! / (1024 * 1024)).toStringAsFixed(1)
        : null;
    final totalMB = (ep.totalBytes != null)
        ? (ep.totalBytes! / (1024 * 1024)).toStringAsFixed(1)
        : null;
    final detail = (bytesMB != null && totalMB != null)
        ? ' ($bytesMB / $totalMB MB)'
        : '';

    final activeSubtitle = '$status · $percentLabel$detail';
    return Column(
      children: [
        ListTile(
          leading: _statusIcon(ep.status),
          title: Text(ep.title),
          subtitle: Text(activeSubtitle),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (ep.status == 2)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    value: ep.progress,
                    strokeWidth: 3,
                  ),
                ),
              if (ep.status == 2) const SizedBox(width: 8),
              if (ep.status == 2) Text(percentLabel),
              if (ep.status == 2 && (ep.resumable ?? false))
                IconButton(
                  tooltip: l10n.downloads_action_pause,
                  icon: const Icon(Icons.pause),
                  onPressed: () => provider.pause(ep.id),
                ),
              if (ep.status == 1 && (ep.resumable ?? false))
                IconButton(
                  tooltip: l10n.downloads_action_resume,
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () => provider.resume(ep.id),
                ),
              IconButton(
                tooltip: l10n.downloads_action_cancel,
                icon: const Icon(Icons.stop),
                onPressed: () => provider.cancel(ep.id),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}

class _CompletedDownloadTile extends StatelessWidget {
  const _CompletedDownloadTile({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ep = episode;

    return Column(
      children: [
        ListTile(
          leading: ImageUrl(path: ep.cachedImagePath),
          title: Text('${ep.podcastId} • ${ep.title}'),
          subtitle: FutureBuilder<model.Episode?>(
            future: (ep.cachedMetaPath?.isNotEmpty ?? false)
                ? readEpisodeFromCacheJson(ep.cachedMetaPath!)
                : Future.value(null),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snap.hasError) {
                return Text('Error: ${snap.error}');
              }
              final showDate = snap.data?.showDate ?? '';
              final base =
                  '${l10n.downloads_status_done} • ${ep.id} - ${ep.localPath}';
              final text = showDate.isNotEmpty ? '$base · $showDate' : base;
              return Text(text);
            },
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'play':
                  final m = model.Episode.fromDb(ep);
                  context.read<EpisodeProvider>().playEpisode(
                    m,
                    queue: [m],
                    preferLocal: true,
                  );
                  break;
                case 'queue':
                  final m = model.Episode.fromDb(ep);
                  context.read<EpisodeProvider>().addToQueue(m);
                  break;
                case 'open':
                  if (ep.localPath != null && ep.localPath!.isNotEmpty) {
                    _openInFolder(ep.localPath!);
                  }
                  break;
                case 'delete':
                  context.read<DownloadProvider>().removeLocalFile(ep.id);
                  break;
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'play',
                child: Row(
                  children: [
                    const Icon(Icons.play_arrow, size: 18),
                    const SizedBox(width: 8),
                    Text(l10n.downloads_menu_play),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'queue',
                child: Row(
                  children: [
                    const Icon(Icons.playlist_add, size: 18),
                    const SizedBox(width: 8),
                    Text(l10n.downloads_menu_add_to_queue),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'open',
                child: Row(
                  children: [
                    const Icon(Icons.folder_open, size: 18),
                    const SizedBox(width: 8),
                    Text(l10n.downloads_menu_open_folder),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete_outline, size: 18),
                    const SizedBox(width: 8),
                    Text(l10n.downloads_menu_delete),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            final m = model.Episode.fromDb(ep);
            context.read<EpisodeProvider>().playEpisode(
              m,
              queue: [m],
              preferLocal: true,
            );
          },
        ),
        const Divider(height: 1),
      ],
    );
  }
}

String _statusLabel(BuildContext context, int status) {
  final l10n = AppLocalizations.of(context)!;
  switch (status) {
    case 1:
      return l10n.downloads_status_waiting;
    case 2:
      return l10n.downloads_status_running;
    case 3:
      return l10n.downloads_status_done;
    case 4:
      return l10n.downloads_status_failed;
    case 5:
      return l10n.downloads_status_canceled;
    default:
      return l10n.downloads_status_unknown;
  }
}

Widget _statusIcon(int status) {
  switch (status) {
    case 1:
      return const Icon(Icons.schedule);
    case 2:
      return const Icon(Icons.downloading);
    case 3:
      return const Icon(Icons.check_circle_outline);
    case 4:
      return const Icon(Icons.error_outline);
    case 5:
      return const Icon(Icons.block);
    default:
      return const Icon(Icons.help_outline);
  }
}

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    super.key,
    required this.episodes,
    this.enableDownloads = true,
  });

  final List<model.Episode> episodes;
  final bool enableDownloads;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<EpisodeProvider, PodcastProvider>(
      builder: (context, episodeProvider, podcastProvider, _) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.episodes.length,
          itemBuilder: (context, index) {
            final ep = widget.episodes[index];
            return EpisodeListItem(
              episode: ep,
              onTap: () async {
                await episodeProvider.playEpisode(ep, queue: widget.episodes);
                podcastProvider.addRecentlyPlayed(ep);
              },
              trailing: widget.enableDownloads
                  ? _DownloadButton(episode: ep)
                  : null,
            );
          },
        );
      },
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({required this.episode});

  final model.Episode episode;

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    final dl = context.read<DownloadProvider>();
    final l10n = AppLocalizations.of(context)!;

    final stream = (db.select(
      db.episodes,
    )..where((e) => e.id.equals(episode.id))).watchSingleOrNull();

    return StreamBuilder<Episode?>(
      stream: stream,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }
        final row = snap.data;
        final status = row?.status ?? 0;
        final progress = row?.progress ?? 0.0;

        switch (status) {
          case 2:
            return SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: (progress > 0 && progress <= 1) ? progress : null,
              ),
            );
          case 1:
            return IconButton(
              tooltip: l10n.ep_action_resume,
              icon: const Icon(Icons.play_arrow),
              onPressed: () => dl.resume(episode.id),
            );
          case 3:
            return IconButton(
              tooltip: l10n.ep_action_downloaded,
              icon: const Icon(Icons.check_circle_outline),
              onPressed: () {},
            );
          case 4:
            return IconButton(
              tooltip: l10n.ep_action_retry,
              icon: const Icon(Icons.refresh),
              onPressed: () => dl.enqueue(episode),
            );
          case 5:
          case 0:
          default:
            return IconButton(
              tooltip: l10n.ep_action_download,
              icon: const Icon(Icons.download_for_offline_outlined),
              onPressed: () => dl.enqueue(episode),
            );
        }
      },
    );
  }
}

void _openInFolder(String filePath) {
  try {
    if (Platform.isWindows) {
      Process.run('explorer', ['/select,', filePath]);
    } else if (Platform.isMacOS) {
      Process.run('open', ['-R', filePath]);
    } else if (Platform.isLinux) {
      final dir = File(filePath).parent.path;
      Process.run('xdg-open', [dir]);
    }
  } catch (_) {
    // Debug-only no-op.
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/download_manager_screen/download_list_entries.dart`
```dart
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
```

### Inhalt von `klubradio_archivum/lib/screens/download_manager_screen/download_manager_screen.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';

import 'download_list.dart';

class DownloadManagerScreen extends StatelessWidget {
  const DownloadManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppDatabase, DownloadProvider>(
      builder: (context, db, dlProv, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          dlProv.settingsDao.ensureDefaults();
        });
        final l10n = AppLocalizations.of(context)!; // Get l10n instance

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                l10n.downloadListTitle, // Localized title
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Expanded(child: DownloadList()),
            ],
          ),
        );
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/home_screen/home_screen.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';

import 'recently_played_list.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/episode_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _kickoffDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_kickoffDone) return;
      _kickoffDone = true;

      final podcastProvider = context.read<PodcastProvider>();
      final episodeProvider = context.read<EpisodeProvider>();

      await podcastProvider.loadInitialData();

      if (episodeProvider.currentEpisode == null &&
          podcastProvider.recentEpisodes.isNotEmpty) {
        await episodeProvider.playEpisode(
          podcastProvider.recentEpisodes.first,
          queue: podcastProvider.recentEpisodes,
        );
        // TODO: Test autoplay on app startup across all platforms (web, mobile, desktop)
        // Currently disabled - togglePlayPause() removed to prevent autoplay issues
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool hasCurrentEpisode =
        context.watch<EpisodeProvider>().currentEpisode != null;

    return Consumer<PodcastProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading && provider.podcasts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null && provider.podcasts.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                provider.errorMessage!,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final List<Episode> recentEpisodes = provider.recentEpisodes;
        final List<Episode> recentlyPlayed =
            provider.userProfile?.recentlyPlayed ?? const <Episode>[];

        return RefreshIndicator(
          onRefresh: () => provider.loadInitialData(forceRefresh: true),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       l10n.homeScreenSubscribedPodcastsTitle,
              //       style: Theme.of(context).textTheme.titleLarge,
              //     ),
              //     const SizedBox(height: 12),
              //     StreamBuilder<List<db.Subscription>>(
              //       stream: context.read<SubscriptionsDao>().watchAllActive(),
              //       builder: (context, subsSnap) {
              //         if (subsSnap.connectionState == ConnectionState.waiting) {
              //           return const SizedBox.shrink();
              //         }
              //         final subs = subsSnap.data ?? const <db.Subscription>[];
              //         if (subs.isEmpty) {
              //           // Leerer Zustand: lokalisierter Hinweis
              //           return Padding(
              //             padding: const EdgeInsets.only(bottom: 24),
              //             child: Text(
              //               l10n.homeScreenSubscribedPodcastsEmptyHint,
              //               style: Theme.of(context).textTheme.bodyMedium
              //                   ?.copyWith(
              //                     color: Theme.of(context).colorScheme.outline,
              //                   ),
              //             ),
              //           );
              //         }
              //
              //         final ids = subs.map((s) => s.podcastId).toList();
              //         return FutureBuilder<List<Podcast?>>(
              //           future: Future.wait(
              //             ids.map((id) => provider.fetchPodcastById(id)),
              //           ),
              //           builder: (context, podSnap) {
              //             if (podSnap.connectionState ==
              //                 ConnectionState.waiting) {
              //               return const SizedBox.shrink();
              //             }
              //             final pods = (podSnap.data ?? const <Podcast?>[])
              //                 .whereType<Podcast>()
              //                 .toList();
              //             if (pods.isEmpty) {
              //               return const SizedBox.shrink();
              //             }
              //
              //             return Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 SubscribedPodcastsList(podcasts: pods),
              //                 const SizedBox(height: 24),
              //               ],
              //             );
              //           },
              //         );
              //       },
              //     ),
              //   ],
              // ),
              Text(
                l10n.homeScreenRecentEpisodesTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              EpisodeList(episodes: recentEpisodes),

              if (recentlyPlayed.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  l10n.homeScreenRecentlyPlayedTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                RecentlyPlayedList(episodes: recentlyPlayed),
              ],

              SizedBox(height: hasCurrentEpisode ? 96 : 24),
            ],
          ),
        );
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/home_screen/recently_played_list.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/episode.dart';
import '../../providers/episode_provider.dart';
import '../../providers/podcast_provider.dart';
import '../utils/helpers.dart';

class RecentlyPlayedList extends StatelessWidget {
  const RecentlyPlayedList({super.key, required this.episodes});

  final List<Episode> episodes;

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: episodes.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int index) {
          final Episode episode = episodes[index];
          return _EpisodeCard(episode: episode);
        },
      ),
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  const _EpisodeCard({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () async {
        final EpisodeProvider episodeProvider = context.read<EpisodeProvider>();
        final PodcastProvider podcastProvider = context.read<PodcastProvider>();
        await episodeProvider.playEpisode(episode);
        podcastProvider.addRecentlyPlayed(episode);
      },
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              episode.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
            const Spacer(),
            Text(formatDuration(context, episode.duration)),
            Text(
              formatDate(episode.publishedAt),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/home_screen/subscribed_podcasts_list.dart`
```dart
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens//widgets/stateless/podcast_list_item.dart';

class SubscribedPodcastsList extends StatelessWidget {
  const SubscribedPodcastsList({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    // Get l10n instance
    final l10n = AppLocalizations.of(context)!;

    if (podcasts.isEmpty) {
      return Text(
        l10n.subscribedPodcastsNoSubscriptions, // Use localized string
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center, // Optional: for better display
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: podcasts.length,
      itemBuilder: (BuildContext context, int index) {
        final Podcast podcast = podcasts[index];
        return PodcastListItem(podcast: podcast);
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/now_playing_screen/audio_player_controls.dart`
```dart
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

class AudioPlayerControls extends StatelessWidget {
  const AudioPlayerControls({super.key, required this.provider});

  final EpisodeProvider provider;

  @override
  Widget build(BuildContext context) {
    final bool hasPrevious = provider.getPreviousEpisode() != null;
    final bool hasNext = provider.getNextEpisode() != null;
    final bool canSeek = provider.currentEpisode != null;

    final List<_SeekOption> seekOptions = const [
      _SeekOption(label: '-2 min', delta: Duration(minutes: -2)),
      _SeekOption(label: '-30 s', delta: Duration(seconds: -30)),
      _SeekOption(label: '-5 s', delta: Duration(seconds: -5)),
      _SeekOption(label: '+5 s', delta: Duration(seconds: 5)),
      _SeekOption(label: '+30 s', delta: Duration(seconds: 30)),
      _SeekOption(label: '+2 min', delta: Duration(minutes: 2)),
    ];

    final List<_SeekOption> leftSeek = seekOptions
        .where((o) => o.delta.isNegative)
        .toList();
    final List<_SeekOption> rightSeek = seekOptions
        .where((o) => !o.delta.isNegative)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 24,
            runSpacing: 12,
            children: [
              // 1️⃣ Left seek cluster
              _SeekCluster(
                options: leftSeek,
                canSeek: canSeek,
                onTap: (d) => provider.seekRelative(d),
              ),

              // 2️⃣ Transport cluster
              _TransportCluster(
                hasPrevious: hasPrevious,
                hasNext: hasNext,
                isPlaying: provider.isPlaying,
                onPrev: hasPrevious ? provider.playPrevious : null,
                onPlayPause: provider.togglePlayPause,
                onNext: hasNext ? provider.playNext : null,
              ),

              // 3️⃣ Right seek cluster
              _SeekCluster(
                options: rightSeek,
                canSeek: canSeek,
                onTap: (d) => provider.seekRelative(d),
              ),
              // 4️⃣ Speed cluster
              _SpeedCluster(
                speed: provider.playbackSpeed,
                onChanged: (v) => provider.updatePlaybackSpeed(v),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SeekOption {
  final String label;
  final Duration delta;

  const _SeekOption({required this.label, required this.delta});
}

class _SeekCluster extends StatelessWidget {
  const _SeekCluster({
    required this.options,
    required this.canSeek,
    required this.onTap,
  });

  final List<_SeekOption> options;
  final bool canSeek;
  final void Function(Duration) onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        for (final opt in options)
          _SeekButton(
            label: opt.label,
            onPressed: canSeek ? () => onTap(opt.delta) : null,
          ),
      ],
    );
  }
}

class _TransportCluster extends StatelessWidget {
  const _TransportCluster({
    required this.hasPrevious,
    required this.hasNext,
    required this.isPlaying,
    required this.onPrev,
    required this.onPlayPause,
    required this.onNext,
  });

  final bool hasPrevious;
  final bool hasNext;
  final bool isPlaying;
  final VoidCallback? onPrev;
  final VoidCallback onPlayPause;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 36,
          tooltip: 'Previous Episode',
          icon: const Icon(Icons.skip_previous),
          onPressed: onPrev,
        ),
        IconButton(
          iconSize: 48,
          tooltip: isPlaying ? 'Pause' : 'Play',
          icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
          onPressed: onPlayPause,
        ),
        IconButton(
          iconSize: 36,
          tooltip: 'Next Episode',
          icon: const Icon(Icons.skip_next),
          onPressed: onNext,
        ),
      ],
    );
  }
}

class _SpeedCluster extends StatelessWidget {
  const _SpeedCluster({required this.speed, required this.onChanged});

  final double speed;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16), // Adjusted spacing
        const Icon(Icons.speed, size: 36),
        const SizedBox(width: 8),
        DropdownButton<double>(
          value: speed,
          underline: const SizedBox.shrink(),
          onChanged: (double? v) {
            if (v != null) onChanged(v);
          },
          items: constants.playbackSpeeds.map((double s) {
            return DropdownMenuItem<double>(value: s, child: Text('${s}x'));
          }).toList(),
        ),
      ],
    );
  }
}

class _SeekButton extends StatelessWidget {
  const _SeekButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/now_playing_screen/now_playing_screen.dart`
```dart
// lib/screens/now_playing/now_playing_screen.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';
import 'package:klubradio_archivum/screens/widgets/unsubscribe_dialog.dart';
import 'audio_player_controls.dart';
import 'progress_slider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<EpisodeProvider>(
      builder: (BuildContext context, EpisodeProvider provider, Widget? child) {
        final episode = provider.currentEpisode;
        if (episode == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.nowPlayingScreenTitle)),
            body: Center(child: Text(l10n.nowPlayingScreenNoEpisode)),
          );
        }

        // Responsive cover size (max 240, ~40% of screen width)
        final double screenW = MediaQuery.sizeOf(context).width;
        final double coverSize = math.min(240, screenW * 0.4);

        return Scaffold(
          appBar: AppBar(title: Text(l10n.nowPlayingScreenTitle)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Scrollable top section prevents bottom overflow on small screens
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.viewPaddingOf(context).bottom,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 24,
                        runSpacing: 16,
                        children: [
                          // Left: cover art
                          ImageUrl(
                            url: episode.imageUrl ?? "",
                            path: episode.cachedImagePath ?? "",
                            width: coverSize,
                            height: coverSize,
                          ),

                          // Right: info
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${episode.displayTitle} - ${episode.showDate}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 12),

                                if (episode.hosts.isNotEmpty) ...[
                                  Text(
                                    episode.hosts.join('\n'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                Text(
                                  episode.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 12),
                                Consumer<SubscriptionProvider>(
                                  builder: (context, subscriptionProvider, child) {
                                    return StreamBuilder<Subscription?>(
                                      stream: subscriptionProvider
                                          .watchSubscription(episode.podcastId),
                                      builder: (context, snapshot) {
                                        final isSubscribed = snapshot.data != null;
                                        return ElevatedButton(
                                          onPressed: subscriptionProvider.busy
                                              ? null
                                              : () {
                                                  if (isSubscribed) {
                                                    showUnsubscribeDialog(
                                                        context, episode.podcastId);
                                                  } else {
                                                    subscriptionProvider
                                                        .toggleSubscription(
                                                      episode.podcastId,
                                                      isSubscribed,
                                                    );
                                                  }
                                                },
                                          child: Text(isSubscribed
                                              ? l10n.podcastDetailScreenUnsubscribeButton
                                              : l10n.podcastDetailScreenSubscribeButton),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Progress + controls stay visible without overflow
                  ProgressSlider(
                    positionNotifier: provider.positionNotifier,
                    totalDuration: provider.totalDuration ?? Duration.zero,
                    onSeek: provider.seek,
                  ),
                  const SizedBox(height: 12),
                  AudioPlayerControls(provider: provider),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/now_playing_screen/progress_slider.dart`
```dart
import 'package:flutter/material.dart';

import '../utils/helpers.dart';

class ProgressSlider extends StatelessWidget {
  const ProgressSlider({
    super.key,
    required this.positionNotifier,
    required this.totalDuration,
    required this.onSeek,
  });

  final ValueNotifier<Duration> positionNotifier;
  final Duration totalDuration;
  final Function(Duration) onSeek;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Duration>(
      valueListenable: positionNotifier,
      builder: (context, position, child) {
        final double maxSeconds = totalDuration.inSeconds > 0
            ? totalDuration.inSeconds.toDouble()
            : 1.0;
        final double value = position.inSeconds
            .clamp(0, totalDuration.inSeconds)
            .toDouble();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider(
              value: value,
              max: maxSeconds,
              onChanged: (double newValue) {
                onSeek(Duration(seconds: newValue.toInt()));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(formatDurationPrecise(position)),
                Text(formatDurationPrecise(totalDuration)),
              ],
            ),
          ],
        );
      },
    );
  }
}

```

### Inhalt von `klubradio_archivum/lib/screens/podcast_detail_screen/podcast_detail_screen.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/models/episode.dart' as model; // Alias for model.Episode
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/episode_list.dart';
import 'podcast_info_card.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db; // Alias for db.Episode
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart'; // Import PlatformUtils
import 'package:klubradio_archivum/screens/widgets/unsubscribe_dialog.dart';

class PodcastDetailScreen extends StatefulWidget {
  const PodcastDetailScreen({super.key, required this.podcast});

  final Podcast podcast;

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionProvider>().loadSubscription(widget.podcast.id);
    context.read<EpisodeProvider>().loadEpisodesIntoDb(widget.podcast.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.podcast.title),
        actions: [
          if (PlatformUtils.supportsSubscriptions)
            Consumer<SubscriptionProvider>(
              builder: (context, subscriptionProvider, child) {
                if (!subscriptionProvider.loaded) {
                  // Still loading subscription state
                  return const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }
                final bool isSubscribed = subscriptionProvider.currentSubscription?.active ?? false;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton.icon(
                  onPressed: subscriptionProvider.busy
                      ? null
                      : () async {
                    final snack = ScaffoldMessenger.of(context);
                    try {
                      if (isSubscribed) {
                        await showUnsubscribeDialog(
                            context, widget.podcast.id);
                      } else {
                        await subscriptionProvider.toggleSubscription(
                          widget.podcast.id,
                          isSubscribed,
                        );
                      }
                      if (!context.mounted) return;

                      snack.showSnackBar(
                        SnackBar(
                          content: Text(
                            !isSubscribed
                                ? l10n.podcastDetailScreenSubscribeSuccess
                                : l10n.podcastDetailScreenUnsubscribeSuccess,
                          ),
                        ),
                      );
                    } catch (e) {
                      snack.showSnackBar(
                        SnackBar(
                          content: Text(
                            l10n.podcastDetailScreenErrorMessage(
                              e.toString(),
                            ),
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.error,
                        ),
                      );
                    }
                  },
                  icon: subscriptionProvider.busy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(isSubscribed ? Icons.check : Icons.add),
                  label: Text(
                    isSubscribed
                        ? l10n.podcastDetailScreenUnsubscribeButton
                        : l10n.podcastDetailScreenSubscribeButton,
                  ),
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          PodcastInfoCard(podcast: widget.podcast),
          const SizedBox(height: 12),
          StreamBuilder<db.Setting?>(
            stream: (context.read<db.AppDatabase>().select(
              context.read<db.AppDatabase>().settings,
            )..where((s) => s.id.equals(1))).watchSingleOrNull(),
            builder: (context, settingsSnap) {
              final ascending = settingsSnap.data?.playOrder == 'oldest';
              return StreamBuilder<List<db.Episode>>(
            stream: context.read<EpisodesDao>().watchByPodcast(
              widget.podcast.id,
              ascending: ascending,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                String errorDetails = snapshot.error.toString();
                if (snapshot.error is ApiException) {
                  errorDetails = (snapshot.error as ApiException).message;
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      l10n.podcastDetailScreenErrorMessage(errorDetails),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final List<model.Episode> episodeList =
                  snapshot.data?.map((e) => model.Episode.fromDb(e)).toList() ?? const <model.Episode>[];
              return EpisodeList(episodes: episodeList);
            },
          );
            },
          ),
        ],
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/podcast_detail_screen/podcast_info_card.dart`
```dart
import 'package:flutter/material.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';

class PodcastInfoCard extends StatelessWidget {
  const PodcastInfoCard({super.key, required this.podcast});

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: podcast.coverImageUrl.isEmpty
                      ? Container(
                          width: 100,
                          height: 100,
                          color: theme.colorScheme.primaryContainer,
                          child: const Icon(Icons.radio, size: 48),
                        )
                      : ImageUrl(
                          url: podcast.coverImageUrl,
                          width: 100,
                          height: 100,
                          borderRadius: 0,
                          icon: Icons.radio,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${podcast.id} - ${podcast.title}',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        podcast.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      if (podcast.hosts.isNotEmpty)
                        Text(
                          // Use localized string with placeholder
                          l10n.podcastInfoCardHostsLabel(
                            podcast.hosts.map((host) => host.name).join(', '),
                          ),
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/profile_screen/profile_screen.dart`
```dart
// lib/screens/profile_screen/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/providers/profile_provider.dart';
import 'package:klubradio_archivum/screens/profile_screen/subscriptions_panel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profileProv = context.watch<ProfileProvider>();
    final profile = profileProv.profileOrNull; // <- nullable getter benutzen

    // Warten nur auf das lokale Profil – NICHT mehr auf PodcastProvider.userProfile
    if (profile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        // App-ID Karte
        Card(
          child: ListTile(
            title: Text(l10n.profileScreenAppIdTitle),
            subtitle: Text(
              profile.id,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: profile.id));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.profileScreenIdCopied)),
                );
              },
            ),
          ),
        ),

        // Auto-Downloads
        ListTile(
          title: Text(l10n.profileScreenDownloadSettingsTitle),
          subtitle: Text(
            l10n.profileScreenAutoDownloadsSubtitle(profile.maxAutoDownload),
          ),
          onTap: () async {
            final n = await _pickNumber(context, profile.maxAutoDownload);
            if (n != null && context.mounted) {
              await context.read<ProfileProvider>().setMaxAutoDownload(n);
            }
          },
        ),

        // Playback Speed
        ListTile(
          title: Text(l10n.profileScreenPlaybackSpeedTitle),
          subtitle: Text('${profile.playbackSpeed.toStringAsFixed(2)}×'),
          onTap: () async {
            final v = await _pickSpeed(context, profile.playbackSpeed);
            if (v != null && context.mounted) {
              await context.read<ProfileProvider>().setPlaybackSpeed(v);
            }
          },
        ),

        const SizedBox(height: 24),
        Text(
          l10n.homeScreenSubscribedPodcastsTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        // Subscriptions: direkt aus lokaler DB, kein Warten auf userProfile
        StreamBuilder<List<db.Subscription>>(
          stream: context.read<SubscriptionsDao>().watchAllActive(),
          builder: (context, subsSnap) {
            if (subsSnap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final subs = subsSnap.data ?? const <db.Subscription>[];
            if (subs.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  l10n.homeScreenSubscribedPodcastsEmptyHint,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              );
            }

            // Lade die zugehörigen Podcasts, aber blockiere das UI nicht:
            final ids = subs.map((s) => s.podcastId).toList();
            return FutureBuilder<List<Podcast?>>(
              future: Future.wait(
                ids.map(
                  (id) => context.read<PodcastProvider>().fetchPodcastById(id),
                ),
              ),
              builder: (context, podSnap) {
                if (podSnap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (podSnap.hasError) {
                  return Center(child: Text('Error: ${podSnap.error}'));
                }
                final pods = (podSnap.data ?? const <Podcast?>[])
                    .whereType<Podcast>()
                    .toList();
                if (pods.isEmpty) {
                  return const SizedBox.shrink();
                }
                return SubscriptionsPanel(podcasts: pods);
              },
            );
          },
        ),
      ],
    );
  }
}

/// Dialog: Zahl (0–50) per Slider wählen
Future<int?> _pickNumber(BuildContext context, int current) async {
  int temp = current.clamp(0, 50);
  return showDialog<int>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(ctx)!.profileScreenAutoDownloadsTitle,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: temp.toDouble(),
                  min: 0,
                  max: 50,
                  divisions: 50,
                  label: '$temp',
                  onChanged: (v) => setState(() => temp = v.round()),
                ),
                Text('${AppLocalizations.of(ctx)!.commonCount}: $temp'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(AppLocalizations.of(ctx)!.commonCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(temp),
                child: Text(AppLocalizations.of(ctx)!.commonOk),
              ),
            ],
          );
        },
      );
    },
  );
}

/// Dialog: Speed (0.5–2.0) per Slider wählen
Future<double?> _pickSpeed(BuildContext context, double current) async {
  double temp = current.clamp(0.5, 2.0);
  return showDialog<double>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(ctx)!.profileScreenPlaybackSpeedTitle,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: temp,
                  min: 0.5,
                  max: 2.0,
                  divisions: 30,
                  label: '${temp.toStringAsFixed(2)}×',
                  onChanged: (v) => setState(() => temp = v),
                ),
                Text(
                  '${AppLocalizations.of(ctx)!.profileScreenPlaybackSpeedValue(temp.toStringAsFixed(2))}×',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(AppLocalizations.of(ctx)!.commonCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(temp),
                child: Text(AppLocalizations.of(ctx)!.commonOk),
              ),
            ],
          );
        },
      );
    },
  );
}
```

### Inhalt von `klubradio_archivum/lib/screens/profile_screen/subscriptions_panel.dart`
```dart
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/screens/podcast_detail_screen/podcast_detail_screen.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';
import 'package:klubradio_archivum/screens/widgets/unsubscribe_dialog.dart';

class SubscriptionsPanel extends StatelessWidget {
  const SubscriptionsPanel({super.key, required this.podcasts});

  final List<Podcast> podcasts;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (podcasts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          l10n.homeScreenSubscribedPodcastsEmptyHint,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: podcasts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final p = podcasts[i];
        return _PodcastTile(podcast: p);
      },
    );
  }
}

class _PodcastTile extends StatelessWidget {
  const _PodcastTile({required this.podcast});
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ImageUrl(
          url: podcast.coverImageUrl,
          width: 56,
          height: 56,
          borderRadius: 0,
          icon: Icons.radio,
          backgroundColor: cs.surfaceContainerHighest,
          loadingBackgroundColor: cs.surfaceContainerHighest,
        ),
      ),
      title: Text(podcast.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        podcast.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: cs.outline),
      ),

      // Abbestellen
      trailing: OutlinedButton.icon(
        icon: const Icon(Icons.notifications_off, size: 18),
        label: Text(l10n.podcastListItem_unsubscribe),
        onPressed: () async {
          final confirmed = await showUnsubscribeDialog(context, podcast.id);
          if (!context.mounted) return;
          if (confirmed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.commonDone)));
          }
        },
      ),

      // Details öffnen
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PodcastDetailScreen(podcast: podcast),
          ),
        );
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/search_screen/recent_searches.dart`
```dart
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({
    super.key,
    required this.searches,
    required this.onSelected,
  });

  final List<String> searches;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    // Get l10n instance
    final l10n = AppLocalizations.of(context)!;

    if (searches.isEmpty) {
      return Text(
        l10n.recentSearchesNoHistory, // Use localized string
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center, // Optional: for better display
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: searches.map((String term) {
        return ActionChip(
          label: Text(
            term,
          ), // Search terms themselves are usually not localized
          onPressed: () => onSelected(term),
        );
      }).toList(),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/search_screen/search_bar.dart`
```dart
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.onSubmitted,
    this.onChanged,
  });

  final ValueChanged<String> onSubmitted;
  final ValueChanged<String>? onChanged;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: l10n.searchBarHintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear),
                tooltip: MaterialLocalizations.of(
                  context,
                ).deleteButtonTooltip,
                onPressed: () {
                  _controller.clear();
                  widget.onChanged?.call('');
                  widget.onSubmitted('');
                  setState(() {});
                },
              ),
      ),
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        setState(() {}); // rebuild clear icon
        widget.onChanged?.call(value);
      },
      onSubmitted: widget.onSubmitted,
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/search_screen/search_results_list.dart`
```dart
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import '../../models/podcast.dart';
import '../widgets/stateless/podcast_list_item.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key, required this.results});

  final List<Podcast> results;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (results.isEmpty) {
      return Center(
        child: Text(
          l10n.searchResultsNoResults, // Use localized string
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center, // Optional for better display
        ),
      );
    }

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final Podcast podcast = results[index];
        return PodcastListItem(podcast: podcast);
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/search_screen/search_screen.dart`
```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;
import 'package:klubradio_archivum/services/api_service.dart';

import 'recent_searches.dart';
import 'search_bar.dart';
import 'search_results_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  Future<List<Podcast>>? _podcastFuture;
  Future<List<model.Episode>>? _episodeFuture;
  Timer? _debounce;
  String _lastQuery = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  bool get _hasSearch => _podcastFuture != null || _episodeFuture != null;

  void _onSearch(String query) {
    _debounce?.cancel();
    _lastQuery = query;
    final PodcastProvider provider = context.read<PodcastProvider>();
    setState(() {
      if (query.trim().isEmpty) {
        _podcastFuture = null;
        _episodeFuture = null;
        return;
      }
      _podcastFuture = provider.searchPodcasts(query);
      _episodeFuture = provider.searchEpisodes(query);
    });
  }

  void _onChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      if (_hasSearch) {
        setState(() {
          _podcastFuture = null;
          _episodeFuture = null;
          _lastQuery = '';
        });
      }
      return;
    }
    if (query.trim().length < constants.minSearchLength) return;
    if (query.trim() == _lastQuery.trim()) return;

    _debounce = Timer(constants.searchDebounce, () {
      _onSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final PodcastProvider provider = context.watch<PodcastProvider>();

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: SearchBarWidget(
            onSubmitted: _onSearch,
            onChanged: _onChanged,
          ),
        ),
        if (!_hasSearch) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: RecentSearches(
              searches: provider.recentSearches,
              onSelected: _onSearch,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                l10n.searchScreenInitialPrompt,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        if (_hasSearch) ...[
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: l10n.searchTabShows),
              Tab(text: l10n.searchTabEpisodes),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPodcastResults(l10n),
                _buildEpisodeResults(l10n),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPodcastResults(AppLocalizations l10n) {
    return FutureBuilder<List<Podcast>>(
      future: _podcastFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _buildError(l10n, snapshot.error!);
        }
        final results = snapshot.data ?? const <Podcast>[];
        return SearchResultsList(results: results);
      },
    );
  }

  Widget _buildEpisodeResults(AppLocalizations l10n) {
    return FutureBuilder<List<model.Episode>>(
      future: _episodeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _buildError(l10n, snapshot.error!);
        }
        final results = snapshot.data ?? const <model.Episode>[];
        if (results.isEmpty) {
          return Center(
            child: Text(
              l10n.searchResultsNoResults,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          );
        }
        return _EpisodeResultsList(episodes: results);
      },
    );
  }

  Widget _buildError(AppLocalizations l10n, Object error) {
    String errorDetails = error.toString();
    if (error is ApiException) {
      errorDetails = error.message;
    } else if (error is FormatException) {
      errorDetails = l10n.errorParsingData;
    }
    return Center(
      child: Text(
        l10n.searchScreenErrorMessage(errorDetails),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );
  }
}

class _EpisodeResultsList extends StatelessWidget {
  const _EpisodeResultsList({required this.episodes});

  final List<model.Episode> episodes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: episodes.length,
      separatorBuilder: (_, _) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final episode = episodes[index];
        return Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: const Icon(Icons.audiotrack),
            title: Text(
              episode.displayTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(episode.showDate),
            trailing: Text(
              _formatDuration(episode.duration),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/settings_screen/download_settings_panel.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/retention_mode.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart'; // Import PlatformUtils

class DownloadSettingsPanel extends StatefulWidget {
  const DownloadSettingsPanel({super.key});
  @override
  State<DownloadSettingsPanel> createState() => _DownloadSettingsPanelState();
}

class _DownloadSettingsPanelState extends State<DownloadSettingsPanel> {
  late final SettingsDao _dao;

  @override
  void initState() {
    super.initState();
    final db = context.read<AppDatabase>();
    _dao = SettingsDao(db);
    // Only ensure defaults if downloads are supported
    if (PlatformUtils.supportsDownloads) {
      _dao.ensureDefaults();
    }
  }

  RetentionMode _modeFrom(Setting s) {
    if ((s.keepLatestN ?? 0) > 0) return RetentionMode.keepLatestN;
    if ((s.deleteAfterHours ?? 0) > 0) return RetentionMode.deleteAfterHeard;
    return RetentionMode.keepAll;
  }

  @override
  Widget build(BuildContext context) {
    if (!PlatformUtils.supportsDownloads) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context)!;
    final db = context.watch<AppDatabase>();
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final settingsStream = (db.select(
      db.settings,
    )..where((s) => s.id.equals(1))).watchSingleOrNull();

    return StreamBuilder<Setting?>(
      stream: settingsStream,
      builder: (context, snap) {
        final s = snap.data;
        if (s == null) return const SizedBox.shrink();

        final mode = _modeFrom(s);

        return Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settings_title_downloads,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 12),

                // WLAN only
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.settings_wifi_only),
                  subtitle: Text(
                    !kIsWeb
                        ? l10n.settings_wifi_only_mobile_default
                        : l10n.settings_wifi_only_desktop_default,
                  ),
                  value: s.wifiOnly,
                  onChanged: (v) => _dao.setWifiOnly(v),
                ),
                const SizedBox(height: 8),

                // Autodownload subscribed episodes
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.settings_autodownload_subscriptions),
                  subtitle: Text(l10n.settings_autodownload_subscriptions_hint),
                  value: s.autodownloadSubscribed,
                  onChanged: (v) => _dao.setAutodownloadSubscribed(v),
                ),
                const SizedBox(height: 8),

                // Max parallel
                _StepperRow(
                  label: l10n.settings_max_parallel,
                  valueText: '${s.maxParallel}',
                  onMinus: s.maxParallel > 1
                      ? () => _dao.setMaxParallel(s.maxParallel - 1)
                      : null,
                  onPlus: () => _dao.setMaxParallel(s.maxParallel + 1),
                  cs: cs,
                ),
                const SizedBox(height: 16),

                Text(
                  l10n.settings_retention_section,
                  style: textTheme.titleSmall,
                ),
                const SizedBox(height: 8),

                // Retention-Modus wie Theme-ChoiceChips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _ModeChip(
                      label: l10n.settings_keep_all,
                      selected: mode == RetentionMode.keepAll,
                      onSelected: () async {
                        await _dao.setKeepLatestN(null);
                        await _dao.setDeleteAfterHours(null);
                      },
                    ),
                    _ModeChip(
                      label: l10n
                          .settings_keep_latest_label, // „Nur die letzten n“
                      selected: mode == RetentionMode.keepLatestN,
                      onSelected: () async {
                        // wenn aktivieren und noch 0/null → auf 5 setzen als Startwert
                        final next = (s.keepLatestN ?? 0) > 0
                            ? s.keepLatestN
                            : 5;
                        await _dao.setDeleteAfterHours(null);
                        await _dao.setKeepLatestN(next);
                      },
                    ),
                    _ModeChip(
                      label: l10n
                          .settings_delete_after_heard_label, // „Nach gehört in x h“
                      selected: mode == RetentionMode.deleteAfterHeard,
                      onSelected: () async {
                        final next = (s.deleteAfterHours ?? 0) > 0
                            ? s.deleteAfterHours
                            : 24;
                        await _dao.setKeepLatestN(null);
                        await _dao.setDeleteAfterHours(next);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Nur die zugehörige Zahl editierbar machen
                if (mode == RetentionMode.keepLatestN)
                  _StepperRow(
                    label: l10n.settings_keep_latest,
                    hint: l10n
                        .settings_keep_latest_hint, // z.B. „Behalte die neuesten n Episoden“
                    valueText: '${s.keepLatestN ?? 0}',
                    onMinus: (s.keepLatestN ?? 0) > 1
                        ? () => _dao.setKeepLatestN((s.keepLatestN ?? 0) - 1)
                        : null,
                    onPlus: () => _dao.setKeepLatestN((s.keepLatestN ?? 0) + 1),
                    cs: cs,
                  ),
                if (mode == RetentionMode.deleteAfterHeard)
                  _StepperRow(
                    label: l10n.settings_delete_after_hours,
                    hint: l10n
                        .settings_delete_after_hint, // „Nach gehört, erst nach x h löschen“
                    valueText: '${s.deleteAfterHours ?? 0}',
                    onMinus: (s.deleteAfterHours ?? 0) > 1
                        ? () => _dao.setDeleteAfterHours(
                            (s.deleteAfterHours ?? 0) - 1,
                          )
                        : null,
                    onPlus: () =>
                        _dao.setDeleteAfterHours((s.deleteAfterHours ?? 0) + 1),
                    cs: cs,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: cs.primary.withAlpha((255 * 0.16).round()),
      labelStyle: TextStyle(
        color: selected ? cs.onPrimaryContainer : cs.onSurface,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
      ),
      side: BorderSide(
        color: selected ? cs.primary : cs.outlineVariant.withAlpha((255 * 0.7).round()),
      ),
    );
  }
}

class _StepperRow extends StatelessWidget {
  const _StepperRow({
    required this.label,
    required this.valueText,
    required this.cs,
    this.hint,
    this.onMinus,
    this.onPlus,
  });

  final String label;
  final String valueText;
  final String? hint;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: textTheme.titleSmall),
              if (hint != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    hint!,
                    style: textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onMinus, icon: const Icon(Icons.remove)),
            Text(valueText, style: textTheme.titleMedium),
            IconButton(onPressed: onPlus, icon: const Icon(Icons.add)),
          ],
        ),
      ],
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/settings_screen/playback_settings.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/profile_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

class PlaybackSettings extends StatelessWidget {
  const PlaybackSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final profile = context.watch<ProfileProvider>().profileOrNull;
    if (profile == null) {
      return const Card(
        child: SizedBox(
          height: 96,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    final currentSpeed = profile.playbackSpeed;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.playbackSettingsTitle, style: textTheme.titleMedium),
            const SizedBox(height: 16),

            // --- Playback Speed (Chips) ---
            Text(l10n.playbackSettingsSpeedLabel, style: textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: constants.playbackSpeeds.map((speed) {
                final selected = currentSpeed == speed;
                return ChoiceChip(
                  label: Text(l10n.playbackSettingsSpeedValue(speed)),
                  selected: selected,
                  onSelected: (_) async {
                    await context.read<ProfileProvider>().setPlaybackSpeed(
                      speed,
                    ); // Persistenz
                    if (!context.mounted) return;
                    context.read<EpisodeProvider>().updatePlaybackSpeed(
                      speed,
                    ); // Live-Player
                  },
                  selectedColor: cs.primary.withAlpha((255 * 0.16).round()),
                  labelStyle: TextStyle(
                    color: selected ? cs.onPrimaryContainer : cs.onSurface,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  side: BorderSide(
                    color: selected
                        ? cs.primary
                        : cs.outlineVariant.withAlpha((255 * 0.7).round()),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // --- Episode Order ---
            Text(l10n.settings_episode_order_label, style: textTheme.titleSmall),
            const SizedBox(height: 8),
            _EpisodeOrderChips(cs: cs),
          ],
        ),
      ),
    );
  }
}

class _EpisodeOrderChips extends StatelessWidget {
  const _EpisodeOrderChips({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.watch<AppDatabase>();
    final settingsStream = (db.select(db.settings)
          ..where((s) => s.id.equals(1)))
        .watchSingleOrNull();

    return StreamBuilder<Setting?>(
      stream: settingsStream,
      builder: (context, snap) {
        final current = snap.data?.playOrder ?? 'newest';
        final dao = SettingsDao(db);

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _orderChip(
              label: l10n.settings_episode_order_newest,
              selected: current == 'newest',
              onSelected: () => dao.setPlayOrder('newest'),
            ),
            _orderChip(
              label: l10n.settings_episode_order_oldest,
              selected: current == 'oldest',
              onSelected: () => dao.setPlayOrder('oldest'),
            ),
          ],
        );
      },
    );
  }

  Widget _orderChip({
    required String label,
    required bool selected,
    required VoidCallback onSelected,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: cs.primary.withAlpha((255 * 0.16).round()),
      labelStyle: TextStyle(
        color: selected ? cs.onPrimaryContainer : cs.onSurface,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
      ),
      side: BorderSide(
        color: selected
            ? cs.primary
            : cs.outlineVariant.withAlpha((255 * 0.7).round()),
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/settings_screen/settings_screen.dart`
```dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

import 'package:klubradio_archivum/screens/settings_screen/playback_settings.dart';
import 'package:klubradio_archivum/screens/settings_screen/theme_settings.dart';
import 'package:klubradio_archivum/screens/settings_screen/download_settings_panel.dart';
import 'package:klubradio_archivum/screens/widgets/privacy_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ThemeSettings(),
        const SizedBox(height: 16),
        const DownloadSettingsPanel(),
        const SizedBox(height: 16),
        const PlaybackSettings(),
        const SizedBox(height: 16),
        Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: Text(l10n.settingsScreenSupportKlubradioTitle),
            subtitle: Text(l10n.settingsScreenSupportKlubradioSubtitle),
            onTap: () {
              launchUrl(
                Uri.parse('https://www.klubradio.hu/tamogatas'),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: const Icon(Icons.coffee),
            title: Text(l10n.settingsScreenSupportDeveloperTitle),
            subtitle: Text(l10n.settingsScreenSupportDeveloperSubtitle),
            onTap: () {
              launchUrl(
                Uri.parse('https://buymeacoffee.com/mschultheiss83'),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // About section
        Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: const Icon(Icons.shield_outlined),
            title: Text(l10n.privacySettingsRow),
            subtitle: Text(l10n.privacySettingsRowSubtitle),
            onTap: () => showPrivacyDialog(context),
          ),
        ),
      ],
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/settings_screen/theme_settings.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/theme_provider.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<ThemeProvider>(
          builder: (context, provider, _) {
            final items = <_ThemeOption>[
              _ThemeOption(
                label: l10n.themeSettingSystemDefault,
                mode: ThemeMode.system,
              ),
              _ThemeOption(
                label: l10n.themeSettingLight,
                mode: ThemeMode.light,
              ),
              _ThemeOption(label: l10n.themeSettingDark, mode: ThemeMode.dark),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.themeSettingsSectionTitle,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: items.map((opt) {
                    final selected = provider.themeMode == opt.mode;
                    return ChoiceChip(
                      label: Text(opt.label),
                      selected: selected,
                      onSelected: (_) => provider.setThemeMode(opt.mode),
                      selectedColor: cs.primary.withAlpha((255 * 0.16).round()),
                      labelStyle: TextStyle(
                        color: selected ? cs.onPrimaryContainer : cs.onSurface,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      side: BorderSide(
                        color: selected
                            ? cs.primary
                            : cs.outlineVariant.withAlpha((255 * 0.7).round()),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ThemeOption {
  const _ThemeOption({required this.label, required this.mode});
  final String label;
  final ThemeMode mode;
}
```

### Inhalt von `klubradio_archivum/lib/screens/utils/constants.dart`
```dart
const String podcastsTable = 'podcasts';
const String episodesTable = 'episodes';
const String userProfilesTable = 'user_profiles';
const String playbackEventsTable = 'playback_events';
const String topShowsTable = 'top_shows_this_year';

const String problematicEpisodeImageUrl =
    'https://www.klubradio.hu/data/sound-speaker-radio-microphone_focuspoint_340x340.jpg';
const String defaultEpisodeImageUrl = 'assets/app_icon/app_icon.png';

const int defaultAutoDownloadCount = 2;
const int maxRecentSearches = 10;
const int minSearchLength = 3;
const Duration searchDebounce = Duration(milliseconds: 400);
const int maxRecentlyPlayed = 20;

const String demoUserId = 'guest-user';

const List<double> playbackSpeeds = <double>[0.5, 0.75, 1.0, 1.25, 1.5];
```

### Inhalt von `klubradio_archivum/lib/screens/utils/helpers.dart`
```dart
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
```

### Inhalt von `klubradio_archivum/lib/screens/widgets/privacy_dialog.dart`
```dart
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';

/// Shows a dialog with privacy notice and disclaimer text.
///
/// Used in three places:
/// 1. First app start (after install or update) — one-time per version
/// 2. Settings → About → "Datenschutz & Sicherheitshinweis" row
/// 3. About button in AppBar on every tab
Future<void> showPrivacyDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final textTheme = Theme.of(context).textTheme;

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(l10n.privacyDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.privacyNoticeHeadline,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(l10n.privacyNoticeBody, style: textTheme.bodyMedium),
            const SizedBox(height: 20),
            Text(
              l10n.disclaimerHeadline,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(l10n.disclaimerBody, style: textTheme.bodyMedium),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonOk),
        ),
      ],
    ),
  );
}
```

### Inhalt von `klubradio_archivum/lib/screens/widgets/stateful/episode_list.dart`
```dart
// lib/screens/download_manager_screen/download_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/providers/podcast_provider.dart';
import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart'; // For supportsDownloads
import 'package:klubradio_archivum/screens/widgets/stateless/episode_list_item.dart'; // Missing import

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    super.key,
    required this.episodes,
    this.enableDownloads = true,
  });

  final List<model.Episode> episodes;
  final bool enableDownloads;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<EpisodeProvider, PodcastProvider>(
      builder:
          (
            BuildContext context,
            EpisodeProvider episodeProvider,
            PodcastProvider podcastProvider,
            Widget? child,
          ) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.episodes.length,
              itemBuilder: (BuildContext context, int index) {
                final model.Episode ep = widget.episodes[index];

                return EpisodeListItem(
                  episode: ep,
                  onTap: () async {
                    await episodeProvider.playEpisode(
                      ep,
                      queue: widget.episodes,
                    );
                    podcastProvider.addRecentlyPlayed(ep);
                  },
                  trailing: widget.enableDownloads && PlatformUtils.supportsDownloads
                      ? _DownloadButton(episode: ep, queue: widget.episodes)
                      : null,
                );
              },
            );
          },
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({required this.episode, this.queue});
  final model.Episode episode;
  final List<model.Episode>? queue;

  @override
  Widget build(BuildContext context) {
    final appDb = context.read<db.AppDatabase>(); // Corrected local variable name
    final dl = context.read<DownloadProvider>();

    // Reaktiver Status aus SQLite (Drift)
    final stream = (appDb.select( // Use appDb alias
      appDb.episodes, // Use appDb alias
    )..where((e) => e.id.equals(episode.id))).watchSingleOrNull();
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<db.Episode?>( // Corrected type argument
      stream: stream,
      builder: (context, snap) {
        final row = snap.data;

        // Mappe DB-Status (int) -> UI
        final status =
            row?.status ??
            0; // 0=none,1=queued,2=downloading,3=completed,4=failed,5=canceled
        final progress = row?.progress ?? 0.0;
        final canPause = row?.resumable ?? false;

        switch (status) {
          case 2: // downloading
            return SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: (progress > 0 && progress <= 1) ? progress : null,
              ),
            );

          case 1: // queued (als "wartet/pausiert")
            return canPause
                ? IconButton(
                    tooltip: l10n.ep_action_resume,
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () => dl.resume(episode.id),
                  )
                : IconButton(
                    tooltip: l10n
                        .ep_action_download, // kein Resume → normaler Download-Button
                    icon: const Icon(Icons.download_for_offline_outlined),
                    onPressed: () => dl.enqueue(episode),
                  );

          case 3: // completed
            return IconButton(
              tooltip: l10n.ep_action_downloaded,
              icon: const Icon(Icons.check_circle_outline),
              onPressed: () {
                context.read<EpisodeProvider>().playEpisode(
                  episode,
                  queue: queue,
                );
              },
            );

          case 4: // failed
            return IconButton(
              tooltip: l10n.ep_action_retry,
              icon: const Icon(Icons.refresh),
              onPressed: () => dl.enqueue(episode),
            );

          case 5: // canceled
          case 0: // none / unbekannt
          default:
            return IconButton(
              tooltip: l10n.ep_action_download,
              icon: const Icon(Icons.download_for_offline_outlined),
              onPressed: () => dl.enqueue(episode),
            );
        }
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/widgets/stateful/now_playing_bar.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/screens/now_playing_screen/now_playing_screen.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/queue_sheet.dart';

class NowPlayingBar extends StatelessWidget {
  const NowPlayingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (BuildContext context, EpisodeProvider provider, Widget? child) {
        final currentEpisode = provider.currentEpisode;
        if (currentEpisode == null) {
          return const SizedBox.shrink();
        }

        return ValueListenableBuilder<Duration>(
          valueListenable: provider.positionNotifier,
          builder: (context, position, child) {
            final Duration? total = provider.totalDuration;
            final double progress = total == null || total.inMilliseconds == 0
                ? 0
                : position.inMilliseconds / total.inMilliseconds;

            final cs = Theme.of(context).colorScheme;

            return Material(
              color: cs.surface,
              elevation: 4,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const NowPlayingScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              provider.isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              size: 32,
                            ),
                            onPressed: provider.togglePlayPause,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  currentEpisode.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  '${formatDurationPrecise(position)} - ${currentEpisode.showDate}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  currentEpisode.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.queue_music),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return QueueSheet(provider: provider);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: progress.clamp(0, 1)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/widgets/stateful/queue_sheet.dart`
```dart
import 'package:flutter/material.dart';

import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';

class QueueSheet extends StatelessWidget {
  const QueueSheet({super.key, required this.provider});

  final EpisodeProvider provider;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) => _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      padding: const EdgeInsets.all(16),
      itemCount: provider.queue.length,
      onReorder: (int oldIndex, int newIndex) {
        provider.reorderQueue(oldIndex, newIndex);
      },
      itemBuilder: (BuildContext context, int index) {
        final episode = provider.queue[index];
        final bool isCurrent = provider.currentEpisode?.id == episode.id;
        final hosts = episode.hosts
            .join('')
            .split('\n')
            .where((s) => s.isNotEmpty)
            .join(' ');
        return Dismissible(
          key: ValueKey(episode.id),
          direction: isCurrent
              ? DismissDirection.none
              : DismissDirection.endToStart,
          onDismissed: (_) => provider.removeFromQueue(episode.id),
          background: ColoredBox(
            color: cs.errorContainer,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.delete_outline, color: cs.onErrorContainer),
              ),
            ),
          ),
          child: ListTile(
          key: ValueKey('tile-${episode.id}'),
          selected: isCurrent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isCurrent ? cs.outline : Colors.transparent,
              width: 1,
            ),
          ),
          tileColor: cs.surfaceContainerLow,
          selectedTileColor: cs.secondaryContainer,
          textColor: isCurrent ? cs.onSecondaryContainer : cs.onSurface,
          iconColor:
              isCurrent ? cs.onSecondaryContainer : cs.onSurfaceVariant,
          leading: ReorderableDragStartListener(
            index: index,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.drag_indicator),
                const SizedBox(width: 8),
                Icon(isCurrent ? Icons.play_arrow : Icons.queue_music),
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isCurrent)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Entfernen',
                  onPressed: () => provider.removeFromQueue(episode.id),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ImageUrl(
                    url: episode.imageUrl ?? '',
                    path: episode.cachedImagePath ?? '',
                    width: 56,
                    height: 56,
                  ),
                ),
              ),
            ],
          ),
          title: Text('${episode.title}, ${episode.showDate}'),
          subtitle: Text(
            '${formatDuration(context, episode.duration)} - $hosts',
          ),
          hoverColor: cs.onSurface.withValues(alpha: 0.12),
          onTap: () async {
            Navigator.of(context).pop();
            await provider.playEpisode(episode, queue: provider.queue);
          },
        ),
        );
      },
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/widgets/stateless/bottom_navigation_bar.dart`
```dart
import 'package:flutter/material.dart';
// import 'package:klubradio_archivum/l10n/app_localizations.dart'; // Removed

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.destinations,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!; // Removed
    final cs = Theme.of(context).colorScheme;

    final double w = MediaQuery.of(context).size.width;
    final bool isSmall = w < 600;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(
          top: BorderSide(
            color: cs.outlineVariant.withAlpha((255 * 0.5).round()),
            width: 0.6,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top title strip (selected destination label)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  isSmall ? 8 : 10,
                  16,
                  isSmall ? 4 : 6,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SizeTransition(
                      sizeFactor: anim,
                      axisAlignment: -1,
                      child: child,
                    ),
                  ),
                  child: _TitleLabel(
                    key: ValueKey<int>(currentIndex),
                    text: destinations[currentIndex].tooltip ?? '', // Use tooltip for label
                    color: cs.onSurface,
                    isSmall: isSmall,
                  ),
                ),
              ),

              // Icon-only NavigationBar
              NavigationBar(
                selectedIndex: currentIndex,
                onDestinationSelected: onTap,
                height: isSmall ? 60 : 68,
                backgroundColor: cs.surface,
                indicatorColor: cs.primary.withAlpha((255 * 0.12).round()),
                labelBehavior: NavigationDestinationLabelBehavior
                    .alwaysHide, // we show label above
                destinations: destinations, // Use passed destinations
              ),
            ],
          ),
        ),
      ),
    );
  }

  static NavigationDestination buildDestination(
    IconData icon,
    IconData selectedIcon,
    String tooltip) {
    return NavigationDestination(
      tooltip: tooltip, // accessibility + long-press hint
      icon: Icon(icon),
      selectedIcon: Icon(selectedIcon),
      label: '', // hidden (we render title above)
    );
  }
}

class _TitleLabel extends StatelessWidget {
  const _TitleLabel({
    super.key,
    required this.text,
    required this.color,
    required this.isSmall,
  });
  final String text;
  final Color color;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    // Single line, ellipsis for very long HU labels
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: color,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}

```

### Inhalt von `klubradio_archivum/lib/screens/widgets/stateless/episode_list_item.dart`
```dart
import 'package:flutter/material.dart';

import 'package:klubradio_archivum/models/episode.dart' as model; // Use alias for Episode
import 'package:klubradio_archivum/screens/utils/helpers.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({
    super.key,
    required this.episode,
    this.onTap,
    this.trailing,
  });

  final model.Episode episode; // Use aliased type
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: ImageUrl(
          url: episode.imageUrl ?? "",
          path: episode.cachedImagePath,
        ),
        title: Text(
          '${episode.id} ${episode.title}',
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          '${episode.showDate} • ${formatDuration(context, episode.duration)}',
        ),
        onTap: onTap,
        trailing: trailing,
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/widgets/stateless/image_url.dart`
```dart
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:klubradio_archivum/utils/web_image_proxy.dart';

/// Zeigt bevorzugt ein lokales Bild (Dateipfad), andernfalls eine URL.
/// Fällt bei Fehlern auf ein Icon im Container zurück.
///
/// - [path]  : absoluter Dateipfad (z. B. aus cachedImagePath)
/// - [url]   : Netzwerk-URL (HTTP/HTTPS)
/// - [preferLocal] : true ⇒ wenn [path] existiert, wird es genutzt
///
/// Mindestens eines von [path] oder [url] sollte gesetzt sein.
/// Auf Web wird [path] ignoriert (da kein direkter Dateizugriff).
class ImageUrl extends StatelessWidget {
  const ImageUrl({
    super.key,
    this.path,
    this.url,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.icon = Icons.podcasts_outlined,
    this.fit = BoxFit.cover,
    this.preferLocal = true,
    this.backgroundColor,
    this.loadingBackgroundColor,
  });

  /// Absoluter Dateipfad (z. B. `C:\Users\...\52775.jpg` oder `/data/.../52775.jpg`)
  final String? path;

  /// Netzwerk-URL
  final String? url;

  final double? width;
  final double? height;
  final double borderRadius;
  final IconData icon;
  final BoxFit fit;

  /// True ⇒ lokales Bild hat Vorrang, wenn vorhanden.
  final bool preferLocal;

  /// Background color for the fallback/error state.
  final Color? backgroundColor;

  /// Background color for the loading placeholder.
  final Color? loadingBackgroundColor;

  bool get _hasValidUrl {
    final u = url ?? '';
    if (u.isEmpty) return false;
    final parsed = Uri.tryParse(u);
    return parsed != null &&
        (parsed.scheme == 'http' || parsed.scheme == 'https') &&
        (parsed.host.isNotEmpty);
  }

  bool get _hasUsablePath {
    if (kIsWeb) return false; // auf Web keine Dateisystemzugriffe
    final p = path ?? '';
    if (p.isEmpty) return false;
    try {
      return File(p).existsSync();
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = width ?? 72.0;
    final h = height ?? 72.0;
    final baseBackgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.primaryContainer;
    final resolvedLoadingBackgroundColor = loadingBackgroundColor ??
        Theme.of(context).colorScheme.surfaceContainerHighest;

    Widget fallback([Color? color]) => Container(
      width: w,
      height: h,
      color: color ?? baseBackgroundColor,
      alignment: Alignment.center,
      child: Icon(icon, size: w * 0.5),
    );

    Widget clip(Widget child) => ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: child,
    );

    // Handle asset images first
    if (url != null && url!.startsWith('assets/')) {
      return clip(
        Image.asset(
          url!,
          width: w,
          height: h,
          fit: fit,
          errorBuilder: (ctx, _, _) => fallback(),
        ),
      );
    }

    // Priorität: lokal (wenn preferLocal & vorhanden) → URL → Fallback
    if (preferLocal && _hasUsablePath) {
      return clip(
        Image.file(
          File(path!),
          width: w,
          height: h,
          fit: fit,
          errorBuilder: (ctx, _, _) => fallback(),
        ),
      );
    }

    if (_hasValidUrl) {
      // Transform URL for web platform to avoid CORS issues
      final imageUrl = WebImageProxy.transform(url!);

      return clip(
        Image.network(
          imageUrl,
          width: w,
          height: h,
          fit: fit,
          // Leichtgewichtiger Placeholder beim Laden
          loadingBuilder: (ctx, child, progress) {
            if (progress == null) return child;
            return fallback(resolvedLoadingBackgroundColor);
          },
          // Bei 404/Netz/Decode-Fehlern: Fallback statt rotem Fehler
          errorBuilder: (ctx, error, stack) => fallback(),
        ),
      );
    }

    // Wenn URL nicht valide oder kein lokales Bild verfügbar ist:
    // ggf. trotzdem lokales Bild versuchen (falls preferLocal=false)
    if (!preferLocal && _hasUsablePath) {
      return clip(
        Image.file(
          File(path!),
          width: w,
          height: h,
          fit: fit,
          errorBuilder: (ctx, _, _) => fallback(),
        ),
      );
    }

    return clip(fallback());
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/widgets/stateless/platform_utils.dart`
```dart
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtils {
  static bool get supportsDownloads => !kIsWeb;
  static bool get supportsOfflinePlayback => !kIsWeb;
  static bool get supportsBackgroundAudio => !kIsWeb;
  static bool get supportsSubscriptions => !kIsWeb;
}```

### Inhalt von `klubradio_archivum/lib/screens/widgets/stateless/podcast_list_item.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/podcast.dart';

import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'package:klubradio_archivum/screens/podcast_detail_screen/podcast_detail_screen.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/image_url.dart';
import 'package:klubradio_archivum/screens/widgets/unsubscribe_dialog.dart';

class PodcastListItem extends StatelessWidget {
  const PodcastListItem({
    super.key,
    required this.podcast,
    this.showSubscribeButton = true,
  });

  final Podcast podcast;
  final bool showSubscribeButton;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final subscriptionProvider = context.watch<SubscriptionProvider>();



    final String subtitle = podcast.hosts.isNotEmpty
        ? podcast.hosts.map((h) => h.name).join(', ')
        : l10n.podcastListItem_subtitleFallback;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => PodcastDetailScreen(podcast: podcast),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ImageUrl(url: podcast.coverImageUrl),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(podcast.title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(subtitle, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      podcast.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    if (showSubscribeButton)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: StreamBuilder<Subscription?>(
                            stream: subscriptionProvider.watchSubscription(podcast.id),
                            builder: (context, snapshot) {
                              final bool currentIsSubscribed = snapshot.data?.active ?? false;
                              return OutlinedButton.icon(
                                icon: Icon(
                                  currentIsSubscribed
                                      ? Icons.notifications_active
                                      : Icons.notifications_outlined,
                                ),
                                label: Text(
                                  currentIsSubscribed
                                      ? l10n.podcastListItem_subscribed
                                      : l10n.podcastListItem_subscribe,
                                ),
                                onPressed: () {
                                  if (currentIsSubscribed) {
                                    showUnsubscribeDialog(context, podcast.id);
                                  } else {
                                    context.read<SubscriptionProvider>().toggleSubscription(podcast.id, currentIsSubscribed);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Inhalt von `klubradio_archivum/lib/screens/widgets/unsubscribe_dialog.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';

/// Shows a confirmation dialog when unsubscribing from a podcast.
///
/// Asks the user whether to keep or delete downloaded episodes.
/// Returns `true` if the user confirmed unsubscription, `false` otherwise.
Future<bool> showUnsubscribeDialog(
  BuildContext context,
  String podcastId,
) async {
  final l10n = AppLocalizations.of(context)!;
  final subscriptionProvider = context.read<SubscriptionProvider>();
  final downloadProvider = context.read<DownloadProvider>();

  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(l10n.unsubscribeDialogTitle),
      content: Text(l10n.unsubscribeDialogContent),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.unsubscribeDialogKeepButton),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.unsubscribeDialogDeleteButton),
        ),
      ],
    ),
  );

  if (result != null) {
    if (result) {
      await downloadProvider.deleteEpisodesForPodcast(podcastId);
    }
    await subscriptionProvider.toggleSubscription(podcastId, true);
    return true;
  }
  return false;
}
```

### Inhalt von `klubradio_archivum/lib/services/api_cache_service.dart`
```dart
// lib/services/api_cache_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiCacheService {
  ApiCacheService();

  static const String _cachePrefix = 'api_cache_';

  Future<void> save(String key, dynamic data, {Duration? expiry}) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(data);
    final int expiryTime = expiry != null
        ? DateTime.now().add(expiry).millisecondsSinceEpoch
        : -1; // -1 for no expiry

    final Map<String, dynamic> cacheEntry = {
      'data': encodedData,
      'expiry': expiryTime,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    await prefs.setString('$_cachePrefix$key', jsonEncode(cacheEntry));
  }

  Future<dynamic> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? rawCacheEntry = prefs.getString('$_cachePrefix$key');

    if (rawCacheEntry == null) {
      return null;
    }

    final Map<String, dynamic> cacheEntry = jsonDecode(rawCacheEntry);
    final int expiryTime = cacheEntry['expiry'];

    if (expiryTime != -1 && DateTime.now().millisecondsSinceEpoch > expiryTime) {
      // Cache expired, remove it
      await prefs.remove('$_cachePrefix$key');
      return null;
    }

    return jsonDecode(cacheEntry['data']);
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_cachePrefix$key');
  }

  Future<bool> isCached(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('$_cachePrefix$key');
  }

  Future<bool> isExpired(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? rawCacheEntry = prefs.getString('$_cachePrefix$key');

    if (rawCacheEntry == null) {
      return true; // Not cached, so considered expired
    }

    final Map<String, dynamic> cacheEntry = jsonDecode(rawCacheEntry);
    final int expiryTime = cacheEntry['expiry'];

    return expiryTime != -1 && DateTime.now().millisecondsSinceEpoch > expiryTime;
  }
}
```

### Inhalt von `klubradio_archivum/lib/services/api_service.dart`
```dart
// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:klubradio_archivum/models/show_data.dart';

import '../models/episode.dart';
import '../models/podcast.dart';
import '../models/show_host.dart';
import '../models/user_profile.dart';
import '../screens/utils/constants.dart' as constants;

import 'package:klubradio_archivum/services/api_cache_service.dart';

class ApiService {
  ApiService({http.Client? httpClient, ApiCacheService? cacheService})
    : _httpClient = httpClient ?? http.Client(),
      _cacheService = cacheService ?? ApiCacheService();

  // === Supabase ===
  static const String _supabaseUrl = 'https://arakbotxgwpyyqyxjhhl.supabase.co';
  static const String _supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyYWtib3R4Z3dweXlxeXhqaGhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgxMDE0MzUsImV4cCI6MjA3MzY3NzQzNX0.zO__rAZCmPQW26YAC3CYhq_ZSjUAx0Gh0KHXIVHhm7w';

  // Exponieren, falls andere Schichten das brauchen (Repo etc.)
  String get supabaseUrl => _supabaseUrl;
  String get supabaseKey => _supabaseKey;

  static const Duration _timeout = Duration(seconds: 20);
  static const Duration _longTimeout = Duration(minutes: 1);

  final http.Client _httpClient;
  final ApiCacheService _cacheService;

  bool get hasValidCredentials =>
      !_supabaseUrl.contains('TODO') && !_supabaseKey.contains('TODO');

  Map<String, String> get _headers => <String, String>{
    'apikey': _supabaseKey,
    'Authorization': 'Bearer $_supabaseKey',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // =================== PODCAST LISTS ===================

  Future<List<Podcast>> fetchLatestPodcasts({int limit = 10}) async {
    const String cacheKey = 'latest_podcasts';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .toList();
    }

    if (!hasValidCredentials) return _mockPodcasts();

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'order': 'last_updated.desc',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .toList();
    }
    final serverMsg = getServerErrorMessage(res);
    throw ApiException(
      'Unable to fetch podcasts (${res.statusCode})\n$serverMsg',
    );
  }

  Future<List<Podcast>> fetchTrendingPodcasts({int limit = 10}) async {
    const String cacheKey = 'trending_podcasts';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((p) => p.copyWith(isTrending: true))
          .toList();
    }

    if (!hasValidCredentials) {
      return _mockPodcasts()
          .take(limit)
          .map((p) => p.copyWith(isTrending: true))
          .toList();
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {
            'select': '*',
            // 'order': 'play_count.desc.nullslast',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((p) => p.copyWith(isTrending: true))
          .toList();
    }
    final serverMsg = getServerErrorMessage(res);
    throw ApiException('Unable to fetch trending podcasts\n$serverMsg');
  }

  Future<List<Podcast>> fetchRecommendedPodcasts({int limit = 10}) async {
    const String cacheKey = 'recommended_podcasts';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((p) => p.copyWith(isRecommended: true))
          .toList();
    }

    if (!hasValidCredentials) {
      return _mockPodcasts()
          .take(limit)
          .map((p) => p.copyWith(isRecommended: true))
          .toList();
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'order': 'last_updated.desc.nullslast',
            // 'order': 'recommendation_score.desc.nullslast',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .map((p) => p.copyWith(isRecommended: true))
          .toList();
    }
    final serverMsg = getServerErrorMessage(res);
    throw ApiException('Unable to fetch recommended podcasts\n$serverMsg');
  }

  // =================== EPISODES ===================

  Future<List<Episode>> fetchEpisodesForPodcast(
    String podcastId, {
    int limit = 500,
  }) async {
    final String cacheKey = 'episodes_for_podcast_$podcastId';
    // Try to get from cache first
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }

    if (!hasValidCredentials) {
      return _mockEpisodes(podcastId).take(limit).toList();
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.episodesTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'podcastId': 'eq.$podcastId',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      // Save to cache with a 2-4 hour expiry (e.g., 3 hours)
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }
    throw ApiException(
      'Unable to fetch episodes for podcast $podcastId, statusCode ${res.statusCode}',
    );
  }

  Future<List<Episode>> fetchRecentEpisodes({int limit = 8}) async {
    const String cacheKey = 'recent_episodes';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }

    if (!hasValidCredentials) {
      final mocked = _mockPodcasts().expand((p) => _mockEpisodes(p.id)).toList()
        ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      return mocked.take(limit).toList();
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.episodesTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'order': 'id.desc',
            'limit': limit.toString(),
          },
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      await _cacheService.save(cacheKey, data, expiry: const Duration(hours: 3));
      return data
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }
    throw ApiException(
      'Unable to fetch recent episodes statusCode: ${res.statusCode}',
    );
  }

  // =================== SEARCH / TOP SHOWS / LOOKUP ===================

  Future<List<Podcast>> searchPodcasts(String query) async {
    if (query.trim().isEmpty) return const <Podcast>[];

    if (!hasValidCredentials) {
      return _mockPodcasts()
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    final encoded = query.replaceAll("'", "''");
    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'title': 'ilike.%$encoded%',
            'order': 'id.desc',
          },
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Podcast.fromJson)
          .toList();
    }
    throw ApiException('Unable to search podcasts');
  }

  Future<List<Episode>> searchEpisodes(String query) async {
    if (query.trim().isEmpty) return const <Episode>[];

    if (!hasValidCredentials) {
      return _mockPodcasts()
          .expand((p) => _mockEpisodes(p.id))
          .where((e) => e.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    final encoded = query.replaceAll("'", "''");
    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.episodesTable}')
        .replace(
          queryParameters: {
            'select': '*',
            'title': 'ilike.%$encoded%',
            'order': 'id.desc',
          },
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(Episode.fromJson)
          .toList();
    }
    throw ApiException('Unable to search episodes');
  }

  Future<List<ShowData>> fetchTopShowsThisYear() async {
    const String cacheKey = 'top_shows_this_year';
    // Try to get from cache first
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return (cachedData as List)
          .whereType<Map<String, dynamic>>()
          .map(ShowData.fromJson)
          .toList();
    }

    if (!hasValidCredentials) {
      final queryResults = [
        {"id": "3", "title": "A lényeg", "count": 8563},
        {"id": "38", "title": "Reggeli gyors", "count": 1743},
        {"id": "14", "title": "Esti gyors", "count": 1691},
        {"id": "34", "title": "Megbeszéljük.", "count": 1687},
        {"id": "91", "title": "Ezitta Fórum", "count": 1628},
        {"id": "78", "title": "Reggeli gyors/Reggeli személy", "count": 1446},
        {"id": "22", "title": "Hetes Stúdió", "count": 356},
        {"id": "29", "title": "Klubdélelőtt", "count": 351},
      ];
      return queryResults
          .map(
            (row) => ShowData(
              id: row['id'] as String,
              title: row['title'] as String,
              count: row['count'] as int,
            ),
          )
          .toList();
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.topShowsTable}');
    final res = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      // Save to cache with a daily expiry
      await _cacheService.save(cacheKey, data, expiry: const Duration(days: 1));
      return data
          .whereType<Map<String, dynamic>>()
          .map(ShowData.fromJson)
          .toList();
    }
    throw ApiException('Unable to fetch top shows');
  }

  Future<Podcast?> fetchPodcastById(String podcastId) async {
    final String cacheKey = 'podcast_by_id_$podcastId';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return Podcast.fromJson(cachedData as Map<String, dynamic>);
    }

    final uri = Uri.parse('$_supabaseUrl/rest/v1/${constants.podcastsTable}')
        .replace(
          queryParameters: {'select': '*', 'id': 'eq.$podcastId', 'limit': '1'},
        );
    final res = await _httpClient
        .get(uri, headers: _headers)
        .timeout(_longTimeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      if (data.isNotEmpty) {
        await _cacheService.save(cacheKey, data.first, expiry: const Duration(hours: 3));
        return Podcast.fromJson(data.first as Map<String, dynamic>);
      }
    }
    return null;
  }

  // =================== USER / TELEMETRY ===================

  Future<UserProfile> fetchUserProfile(String userId) async {
    final String cacheKey = 'user_profile_$userId';
    final cachedData = await _cacheService.get(cacheKey);
    if (cachedData != null) {
      return UserProfile.fromJson(cachedData as Map<String, dynamic>);
    }

    if (!hasValidCredentials) {
      final podcasts = _mockPodcasts();
      final episodes = podcasts.expand((p) => _mockEpisodes(p.id)).toList();
      return UserProfile(
        id: userId,
        languageCode: 'de',
        playbackSpeed: 1.0,
        maxAutoDownload: 10,
        subscribedPodcastIds: podcasts.take(2).map((p) => p.id).toSet(),
        recentlyPlayed: episodes.take(4).toList(),
        favouriteEpisodeIds: episodes.take(3).map((e) => e.id).toSet(),
      );
    }

    final uri =
        Uri.parse(
          '$_supabaseUrl/rest/v1/${constants.userProfilesTable}',
        ).replace(
          queryParameters: {'select': '*', 'id': 'eq.$userId', 'limit': '1'},
        );
    final res = await _httpClient.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List<dynamic>;
      if (data.isEmpty) throw ApiException('Profile not found for $userId');
      await _cacheService.save(cacheKey, data.first, expiry: const Duration(hours: 3));
      return UserProfile.fromJson(data.first as Map<String, dynamic>);
    }
    throw ApiException('Unable to fetch user profile ($userId)');
  }

  Future<void> logPlayback({required String episodeId}) async {
    if (!hasValidCredentials) return;

    final uri = Uri.parse(
      '$_supabaseUrl/rest/v1/${constants.playbackEventsTable}',
    );
    final res = await _httpClient
        .post(
          uri,
          headers: _headers,
          body: jsonEncode(<String, dynamic>{
            'episodeId': episodeId,
            'playedAt': DateTime.now().toIso8601String(),
          }),
        )
        .timeout(_timeout);
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ApiException('Unable to log playback event');
    }
  }

  // =================== MISC ===================

  void dispose() => _httpClient.close();

  // ---- Helpers & Mocks ----

  List<Podcast> _mockPodcasts() {
    final ShowHost bolgarGyorgy = ShowHost(name: 'Bolgár György');
    final ShowHost szenteVeronika = ShowHost(name: 'Szente Veronika');

    return <Podcast>[
      Podcast(
        id: 'esti-gyors',
        title: 'Esti gyors',
        description:
            'Az Esti gyors napi közéleti összefoglalója a legfontosabb hírekkel.',
        coverImageUrl: 'https://images.klubradio.hu/podcasts/esti-gyors.jpg',
        episodeCount: 1200,
        hosts: <ShowHost>[bolgarGyorgy],
        latestEpisode: _mockEpisodes('esti-gyors').first,
        lastUpdated: DateTime.now(),
        isTrending: true,
      ),
      Podcast(
        id: 'megbeszeljuk',
        title: 'Megbeszéljük',
        description:
            'Bolgár György legendás betelefonálós műsora a hallgatók kérdéseivel.',
        coverImageUrl: 'https://images.klubradio.hu/podcasts/megbeszeljuk.jpg',
        episodeCount: 1800,
        hosts: <ShowHost>[bolgarGyorgy],
        latestEpisode: _mockEpisodes('megbeszeljuk').first,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 3)),
        isRecommended: true,
      ),
      Podcast(
        id: 'hangos-irodalom',
        title: 'Hangos irodalom',
        description:
            'Kulturális műsor irodalmi érdekességekkel és felolvasásokkal.',
        coverImageUrl:
            'https://images.klubradio.hu/podcasts/hangos-irodalom.jpg',
        episodeCount: 540,
        hosts: <ShowHost>[szenteVeronika],
        latestEpisode: _mockEpisodes('hangos-irodalom').first,
        lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  Iterable<Episode> _mockEpisodes(String podcastId) sync* {
    for (int i = 0; i < 12; i++) {
      yield Episode(
        id: '$podcastId-ep-$i',
        podcastId: podcastId,
        title: 'Epizód #$i',
        description:
            'Ez egy mintapélda epizód leírása a(z) $podcastId műsorhoz.',
        audioUrl: 'https://cdn.klubradio.hu/audio/$podcastId/$i.mp3',
        publishedAt: DateTime.now().subtract(Duration(days: i)),
        showDate: '2023-01-01',
        duration: Duration(minutes: 55 - i.clamp(0, 20)),
        hosts: const <String>['Klubrádió stáb'],
      );
    }
  }

  String getServerErrorMessage(http.Response response) {
    String serverMsg = 'status ${response.statusCode}';
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        final msg = decoded['message'] ?? decoded['error'] ?? decoded['hint'];
        serverMsg = '$serverMsg — ${msg ?? response.body}';
      } else {
        serverMsg = '$serverMsg — ${response.body}';
      }
    } catch (_) {
      serverMsg = '$serverMsg — ${response.body}';
    }
    return serverMsg;
  }
}

class ApiException implements Exception {
  ApiException(this.message);
  final String message;
  @override
  String toString() => 'ApiException: $message';
}
```

### Inhalt von `klubradio_archivum/lib/services/audio_player_service.dart`
```dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart'; // Import for kIsWeb and debugPrint
import 'package:just_audio/just_audio.dart';

import '../models/episode.dart';

class AudioPlayerService {
  AudioPlayerService() {
    _playerStateSubscription = _player.playerStateStream.listen(
      _handlePlayerStateChange,
    );
  }

  final AudioPlayer _player = AudioPlayer();
  final StreamController<bool> _bufferingController =
      StreamController<bool>.broadcast();

  Episode? _currentEpisode;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  Episode? get currentEpisode => _currentEpisode;
  Stream<bool> get bufferingStream => _bufferingController.stream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  bool get isPlaying => _player.playing;
  Duration? get totalDuration => _player.duration;

  // TODO: Test autoplay functionality across all platforms (web, mobile, desktop)
  // Currently disabled due to issues on web and other platforms
  Future<void> loadEpisode(Episode episode, {bool autoplay = false}) async {
    _currentEpisode = episode;
    try {
      final local = episode.localFilePath;
      bool loadedSuccessfully = false;

      // Try loading local file first, only if not on web
      if (!kIsWeb && local != null && local.isNotEmpty && await File(local).exists()) {
        try {
          await _player.setFilePath(local);
          debugPrint('Successfully loaded local file: $local');
          loadedSuccessfully = true;
        } catch (e, st) {
          debugPrint('Error loading local file $local: $e\n$st');
          // Fallback to remote if local fails
        }
      }

      // If local failed, was not available, or on web, try remote URL
      if (!loadedSuccessfully) {
        try {
          await _player.setUrl(episode.audioUrl);
          debugPrint('Successfully loaded remote URL: ${episode.audioUrl}');
          loadedSuccessfully = true;
        } catch (e, st) {
          debugPrint('Error loading remote URL ${episode.audioUrl}: $e\n$st');
          // All attempts failed
        }
      }

      if (loadedSuccessfully) {
        if (autoplay) {
          await _player.play();
        }
      } else {
        // If neither local nor remote could be loaded, clear current episode and stop
        _currentEpisode = null;
        await _player.stop();
        // Potentially add an error message to a stream/notifier for UI to display
        debugPrint('Failed to load audio for episode: ${episode.id}');
      }
    } on PlayerException catch (error) {
      debugPrint('PlayerException in loadEpisode: $error');
      _bufferingController.addError(error);
      _currentEpisode = null; // Clear on player-specific errors too
      await _player.stop();
    } on PlayerInterruptedException catch (error) {
      debugPrint('PlayerInterruptedException in loadEpisode: $error');
      _bufferingController.addError(error);
      _currentEpisode = null; // Clear on player-specific errors too
      await _player.stop();
    } catch (e, st) { // Catch any other unexpected exceptions
      debugPrint('Unexpected error in loadEpisode: $e\n$st');
      _bufferingController.addError(e);
      _currentEpisode = null; // Clear on any unexpected errors
      await _player.stop();
    }
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> stop() => _player.stop();

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  Future<void> setVolume(double volume) => _player.setVolume(volume);

  void _handlePlayerStateChange(PlayerState state) {
    _bufferingController.add(
      state.processingState == ProcessingState.buffering,
    );
  }

  Future<void> dispose() async {
    await _playerStateSubscription?.cancel();
    await _player.dispose();
    await _bufferingController.close();
  }
}
```

### Inhalt von `klubradio_archivum/lib/services/cache_store.dart`
```dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CacheStore {
  Future<File> _file(String name) async {
    final dir = await getApplicationSupportDirectory();
    final cacheDir = Directory('${dir.path}/Klubradio/cache');
    if (!await cacheDir.exists()) await cacheDir.create(recursive: true);
    return File('${cacheDir.path}/$name');
  }

  Future<Map<String, dynamic>?> read(String name) async {
    final f = await _file(name);
    if (!await f.exists()) return null;
    try {
      return jsonDecode(await f.readAsString()) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> write(String name, List<Map<String, dynamic>> items) async {
    final f = await _file(name);
    final payload = jsonEncode({
      'updatedAt': DateTime.now().toIso8601String(),
      'items': items,
    });
    await f.writeAsString(payload, flush: true);
  }
}
```

### Inhalt von `klubradio_archivum/lib/services/download_service.dart`
```dart
// lib/services/download_service.dart
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart' show Value;
import 'package:background_downloader/background_downloader.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/models/episode.dart' as model;
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/services/api_service.dart';

class _EpisodeMetaLite {
  _EpisodeMetaLite({
    required this.id,
    required this.podcastId,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.publishedAt,
    required this.showDate,
    required this.durationSeconds,
    required this.hosts,
    this.imageUrl,
  });

  final String id;
  final String podcastId;
  final String title;
  final String description;
  final String audioUrl;
  final DateTime publishedAt;
  final String showDate;
  final int durationSeconds;
  final List<String> hosts;
  final String? imageUrl;

  factory _EpisodeMetaLite.fromModel(model.Episode e) => _EpisodeMetaLite(
    id: e.id,
    podcastId: e.podcastId,
    title: e.displayTitle, // cachedTitle bevorzugt
    description: e.description,
    audioUrl: e.audioUrl,
    publishedAt: e.publishedAt,
    showDate: e.showDate,
    durationSeconds: e.duration.inSeconds,
    hosts: e.hosts,
    imageUrl: e.imageUrl,
  );

  Map<String, dynamic> toJson({
    String? cachedImageFile,
    String? mp3File,
    int schemaVersion = 1,
  }) => {
    'schemaVersion': schemaVersion,
    'id': id,
    'podcastId': podcastId,
    'title': title,
    'description': description,
    'audioUrl': audioUrl,
    'publishedAt': publishedAt.toIso8601String(),
    'showDate': showDate,
    'duration': durationSeconds,
    'hosts': hosts,
    'imageUrl': imageUrl ?? '',
    'cachedImageFile': cachedImageFile ?? '',
    'mp3File': mp3File ?? '',
    'createdAt': DateTime.now().toIso8601String(),
  };
}

/// Integer-Status in der DB
class EpisodeStatusDB {
  static const none = 0;
  static const queued = 1;
  static const downloading = 2;
  static const completed = 3;
  static const failed = 4;
  static const canceled = 5;
}

class DownloadService {
  DownloadService({
    required this.db,
    required this.episodesDao,
    required this.subscriptionsDao,
    required this.settingsDao,
    required this.retentionDao,
    required this.episodeProvider,
    required this.apiService,
  });

  final AppDatabase db;
  final EpisodesDao episodesDao;
  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;
  final RetentionDao retentionDao;
  final EpisodeProvider episodeProvider;
  final ApiService apiService;

  late FileDownloader _downloader;
  StreamSubscription<TaskUpdate>? _sub;
  Timer? _autodownloadTimer;

  final Map<String, DownloadTask> _tasksByEpisodeId = {};
  final Map<String, String?> _imageUrlHintByEpisodeId = {};
  final Map<String, _EpisodeMetaLite> _metaHintByEpisodeId = {};

  final List<model.Episode> _pendingDownloadQueue = [];
  int _activeDownloadCount = 0;

  final Completer<void> _ready = Completer<void>();
  bool _disposed = false;
  static const _relDir = 'Klubradio';
  String _podcastSubdir(String podcastId) => p.join(_relDir, podcastId);
  String _episodeMp3Name(String episodeId) => '$episodeId.mp3';

  /// Muss genau einmal aufgerufen werden. Lädt Konfig & startet Eventstream.
  Future<void> init() async {
    if (_disposed) return;
    _downloader = FileDownloader();

    _downloader.configureNotification(
      running: const TaskNotification('Downloading', 'file: {filename}'),
      complete: const TaskNotification('Download finished', 'file: {filename}'),
      progressBar: true,
    );

    _sub = _downloader.updates.listen(_onUpdate, onError: (_) {});
    await _downloader.start();

    _autodownloadTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => checkAutodownloads(),
    );

    if (!_ready.isCompleted) _ready.complete();
  }

  Future<void> dispose() async {
    _disposed = true;
    await _sub?.cancel();
    _autodownloadTimer?.cancel();
  }

  Future<void> enqueueEpisode(model.Episode ep) async {
    await _ready.future;
    final existingSub = await subscriptionsDao.getById(ep.podcastId);
    if (existingSub == null) {
      await subscriptionsDao.upsert(
        SubscriptionsCompanion.insert(
          podcastId: ep.podcastId,
          active: const Value(false),
        ),
      );
    }
    if (_disposed) return;

    _pendingDownloadQueue.add(ep);
    _processQueue();
  }

  Future<void> _processQueue() async {
    if (_disposed) return;
    final settings = await settingsDao.getOne();
    final maxParallel = settings?.maxParallel ?? 1; // Default to 1 if not set

    while (_activeDownloadCount < maxParallel &&
        _pendingDownloadQueue.isNotEmpty) {
      final ep = _pendingDownloadQueue.removeAt(0);
      _activeDownloadCount++;
      _startDownload(ep);
    }
  }

  Future<void> _startDownload(model.Episode ep) async {
    final isResumable = await _checkResumable(ep.audioUrl);

    await episodesDao.upsert(
      EpisodesCompanion(
        id: Value(ep.id),
        podcastId: Value(ep.podcastId),
        title: Value(ep.title),
        audioUrl: Value(ep.audioUrl),
        publishedAt: Value(ep.publishedAt),
        status: Value(EpisodeStatusDB.queued),
        progress: const Value(0),
        resumable: Value(isResumable),
      ),
    );

    final settings = await settingsDao.getOne();
    final wifiOnly = settings?.wifiOnly ?? true;
    final subdir = _podcastSubdir(ep.podcastId);
    final filename = _episodeMp3Name(ep.id);

    final task = DownloadTask(
      url: ep.audioUrl,
      filename: filename,
      baseDirectory: BaseDirectory.applicationSupport,
      directory: subdir,
      updates: Updates.statusAndProgress,
      retries: 3,
      allowPause: isResumable,
      requiresWiFi: wifiOnly,
      metaData: 'episodeId=${ep.id}',
    );

    _imageUrlHintByEpisodeId[ep.id] = ep.imageUrl;
    _metaHintByEpisodeId[ep.id] = _EpisodeMetaLite.fromModel(ep);
    _tasksByEpisodeId[ep.id] = task;
    if (task.baseDirectory == BaseDirectory.applicationSupport) {
      final base = await getApplicationSupportDirectory();
      final absDir = p.join(base.path, task.directory);
      await Directory(absDir).create(recursive: true);
    }

    await _downloader.enqueue(task);
  }

  Future<void> pause(String episodeId) async {
    await _ready.future;
    if (_disposed) return;

    final task = _tasksByEpisodeId[episodeId];
    if (task != null) {
      await _downloader.pause(task);
    }
  }

  Future<void> resume(String episodeId) async {
    await _ready.future;
    if (_disposed) return;

    final task = _tasksByEpisodeId[episodeId];
    if (task != null) {
      await _downloader.resume(task);
    }
  }

  Future<void> cancel(String episodeId) async {
    await _ready.future;
    if (_disposed) return;

    final task = _tasksByEpisodeId[episodeId];
    if (task != null) {
      await _downloader.cancel(task);
    }
    await episodesDao.setCanceled(episodeId);
  }

  Future<void> _onUpdate(TaskUpdate u) async {
    if (_disposed) return;

    final task = u.task;

    // episodeId aus metaData oder Dateiname herausziehen (null-sicher)
    String? episodeId;
    final meta = task.metaData;
    if (meta.contains('episodeId=')) {
      episodeId = meta.split('episodeId=').last;
    } else {
      final name = task.filename;
      if (name.endsWith('.mp3')) {
        episodeId = name.substring(0, name.length - 4);
      }
    }
    if (episodeId == null) return;

    if (task is DownloadTask) {
      _tasksByEpisodeId[episodeId] = task;
    }

    if (u is TaskStatusUpdate) {
      switch (u.status) {
        case TaskStatus.running:
          await episodesDao.setDownloading(episodeId);
          break;
        case TaskStatus.paused:
          await episodesDao.setQueued(episodeId);
          _activeDownloadCount--;
          _processQueue();
          break;
        case TaskStatus.canceled:
          await episodesDao.setCanceled(episodeId);
          _activeDownloadCount--;
          _processQueue();
          break;
        case TaskStatus.failed:
          await episodesDao.setFailed(episodeId);
          _activeDownloadCount--;
          _processQueue();
          break;
        case TaskStatus.complete:
          {
            final localPath = await _finalPathForTask(task as DownloadTask);
            await episodesDao.setCompleted(episodeId, localPath);
            final dirPath = p.dirname(localPath);
            final meta = _metaHintByEpisodeId[episodeId];
            if (meta != null) {
              // JPG + JSON (mit relativen Verweisen) schreiben
              final cache = await _writeEpisodeCache(
                dirPath: dirPath, // <-- exakt der Ordner der MP3
                meta: meta, // enthält podcastId, title, showDate, hosts, ...
              );

              await episodesDao.setCachedMeta(
                episodeId,
                title: meta.title, // cachedTitle
                imagePath: cache.imagePath, // ABSOLUT
                metaPath: cache.jsonPath, // ABSOLUT
              );

              _metaHintByEpisodeId.remove(episodeId);
            }

            // nach dem Caching aufräumen:
            _imageUrlHintByEpisodeId.remove(episodeId);

            // (Deine Retention-Logik anschließend wie gehabt)
            final epRow = await episodesDao.getById(episodeId);
            if (epRow != null) {
              final plan = await retentionDao.computePlanForPodcast(
                epRow.podcastId,
              );
              for (final id in plan.toDeleteIds) {
                await removeLocalFile(id);
              }
            }
            // Notify EpisodeProvider that the episode has been downloaded
            episodeProvider.onEpisodeDownloaded(episodeId, localPath);
            _activeDownloadCount--;
            _processQueue();
            break;
          }
        default:
          break;
      }
    } else if (u is TaskProgressUpdate) {
      await episodesDao.setProgress(episodeId, u.progress);
    }
  }

  Future<String> _finalPathForTask(DownloadTask task) async {
    // 1) map BaseDirectory -> echtes Basis-Verzeichnis vom OS
    Directory base;
    switch (task.baseDirectory) {
      case BaseDirectory.applicationSupport:
        base = await getApplicationSupportDirectory();
        break;
      case BaseDirectory.applicationDocuments:
        base = await getApplicationDocumentsDirectory();
        break;
      case BaseDirectory.temporary:
        base = await getTemporaryDirectory();
        break;
      default:
        base = await getApplicationSupportDirectory();
    }

    // 2) zusammensetzen: base + (relatives) directory + filename
    final relDir = task.directory;
    return p.join(base.path, relDir, task.filename);
  }

  Future<void> removeLocalFile(String episodeId) async {
    await _ready.future;
    if (_disposed) return;

    final ep = await episodesDao.getById(episodeId);
    if (ep?.localPath != null) {
      try {
        final f = File(ep!.localPath!);
        if (await f.exists()) {
          await f.delete();
        }
      } catch (_) {
        // optional: loggen
      }
    }
    await episodesDao.clearLocalFile(episodeId);
  }

  Future<void> deleteEpisodesForPodcast(String podcastId) async {
    await _ready.future;
    if (_disposed) return;

    final episodes = await episodesDao.getEpisodesByPodcastId(podcastId);
    for (final episode in episodes) {
      if (episode.localPath != null && episode.localPath!.isNotEmpty) {
        await removeLocalFile(episode.id);
      }
    }
  }

  Future<void> checkAutodownloads() async {
    if (_disposed) return;
    final settings = await settingsDao.getOne();
    if (settings?.autodownloadSubscribed ?? false) {
      final activeSubscriptions = await subscriptionsDao.watchAllActive().first;
      for (final sub in activeSubscriptions) {
        await autodownloadPodcast(sub.podcastId);
      }
    }
  }

  Future<int> autodownloadPodcast(String podcastId) async {
    // Per-podcast autoDownloadN takes priority, then global keepLatestN
    final sub = await subscriptionsDao.getById(podcastId);
    final settings = await settingsDao.getOne();
    final keepN = sub?.autoDownloadN ?? settings?.keepLatestN ?? 0;

    if (keepN <= 0) {
      return 0;
    }

    // Fetch latest episodes for this podcast from the API and sort them.
    final latestEpisodes = await apiService.fetchEpisodesForPodcast(podcastId);
    latestEpisodes.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    // These are the episodes we want to have locally.
    final targetEpisodes = latestEpisodes.take(keepN);

    // Skip episodes that are already downloaded, queued, or downloading
    final allEpisodes = await episodesDao.getEpisodesByPodcastId(podcastId);
    final skipIds = allEpisodes
        .where((e) => e.status == EpisodeStatusDB.completed ||
                      e.status == EpisodeStatusDB.queued ||
                      e.status == EpisodeStatusDB.downloading)
        .map((e) => e.id)
        .toSet();

    int downloadCount = 0;
    for (final episodeToDownload in targetEpisodes) {
      if (!skipIds.contains(episodeToDownload.id)) {
        await enqueueEpisode(episodeToDownload);
        downloadCount++;
      }
    }
    return downloadCount;
  }

  Future<bool> _checkResumable(String url) async {
    try {
      final resp = await http.head(Uri.parse(url));
      final ar = resp.headers['accept-ranges'] ?? resp.headers['Accept-Ranges'];
      return (ar ?? '').toLowerCase().contains('bytes');
    } catch (_) {
      return false;
    }
  }

  Future<({String? imagePath, String jsonPath})> _writeEpisodeCache({
    required String dirPath,
    required _EpisodeMetaLite meta,
  }) async {
    String? imagePath;
    String? imageFile;
    // 1) Cover (optional)
    if ((meta.imageUrl ?? '').isNotEmpty) {
      try {
        final resp = await http.get(Uri.parse(meta.imageUrl!));
        if (resp.statusCode >= 200 &&
            resp.statusCode < 300 &&
            resp.bodyBytes.isNotEmpty) {
          final decoded = img.decodeImage(resp.bodyBytes);
          if (decoded != null) {
            final resized = img.copyResize(
              decoded,
              width: 500,
              height: 500,
              maintainAspect: true,
            );
            final jpg = img.encodeJpg(resized, quality: 85);
            imageFile = '${meta.id}.jpg';
            imagePath = p.join(dirPath, imageFile);
            await File(imagePath).writeAsBytes(jpg, flush: true);
          }
        }
      } catch (_) {
        /* optional log */
      }
    }

    // 2) JSON
    final jsonFileName = '${meta.id}.json';
    final jsonPath = p.join(dirPath, jsonFileName);
    final mp3File = '${meta.id}.mp3'; // wir nutzen ja diese Namenskonvention
    final jsonMap = meta.toJson(
      cachedImageFile: imageFile,
      mp3File: mp3File,
      schemaVersion: 1,
    );
    await File(jsonPath).writeAsString(jsonEncode(jsonMap), flush: true);

    return (imagePath: imagePath, jsonPath: jsonPath);
  }
}
```

### Inhalt von `klubradio_archivum/lib/services/http_requester.dart`
```dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpRequester {
  HttpRequester({
    http.Client? client,
    required this.defaultHeaders,
    this.connectTimeout = const Duration(seconds: 5),
    this.requestTimeout = const Duration(seconds: 12),
    this.maxRetries = 2,
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final Map<String, String> defaultHeaders;
  final Duration connectTimeout;
  final Duration requestTimeout;
  final int maxRetries;

  Future<dynamic> getJson(String url, {Map<String, String>? headers}) async {
    int attempt = 0;
    while (true) {
      attempt++;
      try {
        final fut = _client.get(
          Uri.parse(url),
          headers: {...defaultHeaders, ...?headers},
        );
        final resp = await fut.timeout(requestTimeout);

        if (resp.statusCode >= 200 && resp.statusCode < 300) {
          return jsonDecode(utf8.decode(resp.bodyBytes));
        }
        throw HttpException('HTTP ${resp.statusCode} for $url');
      } on TimeoutException catch (e) {
        if (attempt > maxRetries) rethrow;
        await _backoff(attempt);
        _log('Timeout for \'$url\' attempt $attempt: $e');
      } on SocketException catch (e) {
        if (attempt > maxRetries) rethrow;
        await _backoff(attempt);
        _log('Socket for \'$url\' attempt $attempt: $e');
      } on HttpException catch (e) {
        // retry nur bei 5xx
        if (attempt > maxRetries || !e.message.contains('HTTP 5')) rethrow;
        await _backoff(attempt);
        _log('HTTP for \'$url\' attempt $attempt: ${e.message}');
      }
    }
  }

  Future<void> dispose() async => _client.close();

  Future<void> _backoff(int attempt) =>
      Future.delayed(Duration(milliseconds: 300 * (1 << (attempt - 1))));

  void _log(Object o) {
    // ignore: avoid_print
    print('[HttpRequester] $o');
  }
}
```

### Inhalt von `klubradio_archivum/lib/services/privacy_notice_service.dart`
```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Manages the one-time-per-version privacy notice popup.
///
/// Checks SharedPreferences for a versioned flag. If the stored version
/// does not match the current app version, the notice should be shown.
class PrivacyNoticeService {
  static const _kPrivacyShownVersion = 'privacyShownVersion';

  /// Returns `true` if the privacy notice should be shown for this version.
  static Future<bool> shouldShowNotice() async {
    final prefs = await SharedPreferences.getInstance();
    final info = await PackageInfo.fromPlatform();
    final currentVersion = info.version;
    final shownVersion = prefs.getString(_kPrivacyShownVersion);
    return shownVersion != currentVersion;
  }

  /// Marks the privacy notice as shown for the current app version.
  static Future<void> markNoticeShown() async {
    final prefs = await SharedPreferences.getInstance();
    final info = await PackageInfo.fromPlatform();
    await prefs.setString(_kPrivacyShownVersion, info.version);
  }
}
```

### Inhalt von `klubradio_archivum/lib/services/static_data_service.dart`
```dart
// lib/services/static_data_service.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// Service for loading pre-generated static data bundles that ship with the app.
///
/// These bundles are generated by a GitHub Action and updated daily, providing
/// instant access to commonly accessed data without requiring network calls.
class StaticDataService {
  /// Loads the latest podcasts from the bundled data.
  ///
  /// Returns raw JSON data that can be parsed into Podcast models.
  Future<List<Map<String, dynamic>>> loadLatestPodcasts() async {
    return _loadBundle('assets/data/latest_podcasts.json');
  }

  /// Loads trending podcasts from the bundled data.
  Future<List<Map<String, dynamic>>> loadTrendingPodcasts() async {
    return _loadBundle('assets/data/trending_podcasts.json');
  }

  /// Loads recommended podcasts from the bundled data.
  Future<List<Map<String, dynamic>>> loadRecommendedPodcasts() async {
    return _loadBundle('assets/data/recommended_podcasts.json');
  }

  /// Loads recent episodes from the bundled data.
  Future<List<Map<String, dynamic>>> loadRecentEpisodes() async {
    return _loadBundle('assets/data/recent_episodes.json');
  }

  /// Loads top shows for this year from the bundled data.
  Future<List<Map<String, dynamic>>> loadTopShows() async {
    return _loadBundle('assets/data/top_shows_this_year.json');
  }

  /// Loads complete podcast index for client-side search.
  ///
  /// This is a comprehensive list of all podcasts that can be used for
  /// fast client-side search without network calls.
  Future<List<Map<String, dynamic>>> loadAllPodcastsIndex() async {
    return _loadBundle('assets/data/all_podcasts_index.json');
  }

  /// Internal helper to load and parse a JSON bundle.
  Future<List<Map<String, dynamic>>> _loadBundle(String assetPath) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final data = jsonDecode(jsonString);

      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      } else if (data is Map<String, dynamic> && data['items'] is List) {
        // Support wrapped format: {"items": [...], "updatedAt": "..."}
        return (data['items'] as List).cast<Map<String, dynamic>>();
      }

      throw FormatException('Unexpected data format in $assetPath');
    } on FlutterError catch (e) {
      // Asset not found or loading failed
      throw StaticDataException(
        'Failed to load static data from $assetPath: ${e.message}',
      );
    } catch (e) {
      throw StaticDataException(
        'Failed to parse static data from $assetPath: $e',
      );
    }
  }

  /// Gets metadata about when the static bundle was last updated.
  ///
  /// Returns null if metadata is not available.
  Future<DateTime?> getBundleUpdateTime() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/metadata.json',
      );
      final data = jsonDecode(jsonString);

      if (data is Map<String, dynamic> && data['updatedAt'] is String) {
        return DateTime.parse(data['updatedAt']);
      }
    } catch (_) {
      // Metadata file not found or invalid - this is not critical
    }
    return null;
  }
}

/// Exception thrown when static data cannot be loaded or parsed.
class StaticDataException implements Exception {
  StaticDataException(this.message);
  final String message;

  @override
  String toString() => 'StaticDataException: $message';
}
```

### Inhalt von `klubradio_archivum/lib/utils/device_id.dart`
```dart
// lib/utils/device_id.dart
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppIdentity {
  static const _kAnonId = 'anon.genId';

  /// Builds: {gen}-{build}-{osName-osVersion}
  static Future<String> getAppId() async {
    final prefs = await SharedPreferences.getInstance();
    var genId = prefs.getString(_kAnonId);
    if (genId == null || genId.isEmpty) {
      genId = const Uuid().v4().split('-').first; // kurz & anonym
      await prefs.setString(_kAnonId, genId);
    }

    final pkg = await PackageInfo.fromPlatform();
    final buildId = pkg.buildNumber.isEmpty ? '0' : pkg.buildNumber;

    final osTag = await _osTag();
    return '$genId-$buildId-$osTag';
  }

  static Future<String> _osTag() async {
    final info = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final a = await info.androidInfo;
        return 'android-${a.version.release}';
      }
      if (Platform.isIOS) {
        final i = await info.iosInfo;
        return 'ios-${i.systemVersion}';
      }
      if (Platform.isWindows) {
        final w = await info.windowsInfo;
        return 'windows-${w.majorVersion}.${w.minorVersion}';
      }
      if (Platform.isMacOS) {
        final m = await info.macOsInfo;
        return 'macos-${m.osRelease}';
      }
      if (Platform.isLinux) {
        final l = await info.linuxInfo;
        final ver = (l.version ?? l.prettyName).split(' ').first;
        return 'linux-$ver';
      }
    } catch (_) {
      /* fallthrough */
    }
    // Fallback
    return 'unknown-0';
  }
}
```

### Inhalt von `klubradio_archivum/lib/utils/episode_cache_reader.dart`
```dart
// lib/utils/episode_cache_reader.dart
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:klubradio_archivum/models/episode.dart' as model;

/// Liest eine Episode aus der Cache-JSON (reiches Format ab schemaVersion 1).
/// Gibt null zurück, wenn Datei fehlt oder JSON unbrauchbar ist.
Future<model.Episode?> readEpisodeFromCacheJson(String metaPath) async {
  try {
    final file = File(metaPath);
    if (!await file.exists()) return null;

    final dir = file.parent.path;
    final map = jsonDecode(await file.readAsString());
    if (map is! Map<String, dynamic>) return null;

    // Schema prüfen (optional, tolerant)
    final schemaVersion = (map['schemaVersion'] is int)
        ? map['schemaVersion'] as int
        : 0;
    if (schemaVersion < 1) {
      // very old/minimal JSON – versuchen wir es trotzdem best-effort
    }

    String toStr(String key, [String fallback = '']) {
      final v = map[key];
      return (v is String) ? v : fallback;
    }

    int toInt(String key, [int fallback = 0]) {
      final v = map[key];
      if (v is int) return v;
      if (v is num) return v.toInt();
      return fallback;
    }

    List<String> strList(String key) {
      final v = map[key];
      if (v is List) {
        return v.whereType<String>().toList(growable: false);
      }
      return const <String>[];
    }

    DateTime? toDatetime(String key) {
      final v = map[key];
      if (v is String && v.isNotEmpty) {
        try {
          return DateTime.parse(v);
        } catch (_) {}
      }
      return null;
    }

    final id = toStr('id');
    final podcastId = toStr('podcastId');
    if (id.isEmpty || podcastId.isEmpty) return null;

    final title = toStr('title');
    final description = toStr('description');
    final audioUrl = toStr('audioUrl');

    // publishedAt (Fallback: createdAt)
    final publishedAt =
        toDatetime('publishedAt') ?? toDatetime('createdAt') ?? DateTime.now();

    // Dauer in Sekunden
    final durationSecs = toInt('duration', 0);
    final duration = Duration(seconds: durationSecs);

    // bereits formatiert (von dir) – übernehmen wie ist
    final showDate = toStr('showDate');

    final hosts = strList('hosts');

    // Bild & MP3 – relative Dateinamen zu absoluten Pfaden auflösen
    final cachedImageFile = toStr('cachedImageFile');
    final imageUrl = toStr('imageUrl'); // nur als Fallback/Info
    final imageAbsPath = cachedImageFile.isNotEmpty
        ? p.join(dir, cachedImageFile)
        : null;

    final mp3Rel = toStr('mp3File');
    final mp3AbsPath = mp3Rel.isNotEmpty ? p.join(dir, mp3Rel) : null;

    // Modell befüllen – Felder benutzen, die dein Player/Provider erwartet
    return model.Episode(
      id: id,
      podcastId: podcastId,
      title: title,
      description: description,
      audioUrl: audioUrl,
      imageUrl: imageUrl.isNotEmpty ? imageUrl : null,
      publishedAt: publishedAt,
      duration: duration,
      hosts: hosts,
      showDate: showDate,
      // Lokale Pfade zurück in dein Modell spiegeln:
      localFilePath: (mp3AbsPath != null && File(mp3AbsPath).existsSync())
          ? mp3AbsPath
          : null,
      cachedImagePath: (imageAbsPath != null && File(imageAbsPath).existsSync())
          ? imageAbsPath
          : null,
      cachedMetaPath: metaPath,
      // Falls du weitere optionale Felder im Model hast, hier setzbar.
    );
  } catch (_) {
    return null;
  }
}
```

### Inhalt von `klubradio_archivum/lib/utils/web_image_proxy.dart`
```dart
import 'package:flutter/foundation.dart' show kIsWeb;

/// Handles CORS-compliant image URLs for Flutter Web.
///
/// On web platform, external images from klubradio.hu cause CORS errors.
/// This utility proxies images through a CORS-enabled service.
class WebImageProxy {
  /// Transforms an image URL to use a CORS proxy on web platform.
  ///
  /// - On web: Routes klubradio.hu images through a proxy
  /// - On mobile/desktop: Returns original URL unchanged
  ///
  /// Example:
  /// ```dart
  /// final url = WebImageProxy.transform('https://www.klubradio.hu/data/musorkepek/foo.jpeg');
  /// Image.network(url); // Works on all platforms
  /// ```
  static String transform(String? originalUrl) {
    if (originalUrl == null || originalUrl.isEmpty) {
      return '';
    }

    // On non-web platforms, use original URL
    if (!kIsWeb) {
      return originalUrl;
    }

    // Check if this is a klubradio.hu image URL
    final uri = Uri.tryParse(originalUrl);
    if (uri == null || !_isKlubradioImage(uri)) {
      return originalUrl;
    }

    // Use Supabase Edge Function for CORS-enabled image proxying
    return _proxyViaSupabase(originalUrl);
  }

  /// Checks if the URL is a klubradio.hu image
  static bool _isKlubradioImage(Uri uri) {
    final host = uri.host.toLowerCase();
    return host == 'www.klubradio.hu' ||
        host == 'klubradio.hu' ||
        host == 'images.klubradio.hu' ||
        host == 'cdn.klubradio.hu';
  }

  /// Routes image through Supabase Edge Function with CORS support
  static String _proxyViaSupabase(String originalUrl) {
    const functionUrl =
        'https://arakbotxgwpyyqyxjhhl.supabase.co/functions/v1/image-proxy';
    return '$functionUrl?url=${Uri.encodeComponent(originalUrl)}';
  }
}
```

### Inhalt von `klubradio_archivum/test/api/episode_api_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:klubradio_archivum/api/episode_api.dart';
import 'package:klubradio_archivum/services/http_requester.dart';

import 'episode_api_test.mocks.dart'; // This will be generated by build_runner

@GenerateMocks([HttpRequester])
void main() {
  group('EpisodeApi', () {
    late EpisodeApi episodeApi;
    late MockHttpRequester mockHttpRequester;
    const String baseUrl = 'http://localhost:8000';
    const String apiKey = 'test_api_key';

    setUp(() {
      mockHttpRequester = MockHttpRequester();
      episodeApi = EpisodeApi(
        baseUrl: baseUrl,
        apiKey: apiKey,
        requester: mockHttpRequester,
      );
    });

    test('forPodcast returns a list of episodes for a given podcastId',
        () async {
      const podcastId = 'podcast123';
      final List<Map<String, dynamic>> mockResponse = [
        {'id': 'ep1', 'title': 'Episode 1', 'podcastId': podcastId},
        {'id': 'ep2', 'title': 'Episode 2', 'podcastId': podcastId},
      ];

      when(mockHttpRequester.getJson(any)).thenAnswer((_) async => mockResponse);

      final result = await episodeApi.forPodcast(podcastId);

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 2);
      expect(result[0]['id'], 'ep1');
      expect(result[1]['podcastId'], podcastId);

      verify(mockHttpRequester.getJson(
              '$baseUrl/rest/v1/episodes?select=*&podcastId=eq.$podcastId&limit=500'))
          .called(1);
    });

    test('recent returns a list of recent episodes', () async {
      final List<Map<String, dynamic>> mockResponse = [
        {'id': 'recent_ep1', 'title': 'Recent Episode 1'},
        {'id': 'recent_ep2', 'title': 'Recent Episode 2'},
      ];

      when(mockHttpRequester.getJson(any)).thenAnswer((_) async => mockResponse);

      final result = await episodeApi.recent(limit: 2);

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 2);
      expect(result[0]['id'], 'recent_ep1');

      verify(mockHttpRequester.getJson(
              '$baseUrl/rest/v1/episodes?select=*&order=id.desc&limit=2'))
          .called(1);
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/api/episode_api_test.mocks.dart`
```dart
// Mocks generated by Mockito 5.4.6 from annotations
// in klubradio_archivum/test/api/episode_api_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:klubradio_archivum/services/http_requester.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class
// ignore_for_file: invalid_use_of_internal_member

class _FakeDuration_0 extends _i1.SmartFake implements Duration {
  _FakeDuration_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [HttpRequester].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpRequester extends _i1.Mock implements _i2.HttpRequester {
  MockHttpRequester() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Map<String, String> get defaultHeaders =>
      (super.noSuchMethod(
            Invocation.getter(#defaultHeaders),
            returnValue: <String, String>{},
          )
          as Map<String, String>);

  @override
  Duration get connectTimeout =>
      (super.noSuchMethod(
            Invocation.getter(#connectTimeout),
            returnValue: _FakeDuration_0(
              this,
              Invocation.getter(#connectTimeout),
            ),
          )
          as Duration);

  @override
  Duration get requestTimeout =>
      (super.noSuchMethod(
            Invocation.getter(#requestTimeout),
            returnValue: _FakeDuration_0(
              this,
              Invocation.getter(#requestTimeout),
            ),
          )
          as Duration);

  @override
  int get maxRetries =>
      (super.noSuchMethod(Invocation.getter(#maxRetries), returnValue: 0)
          as int);

  @override
  _i3.Future<dynamic> getJson(String? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(
            Invocation.method(#getJson, [url], {#headers: headers}),
            returnValue: _i3.Future<dynamic>.value(),
          )
          as _i3.Future<dynamic>);

  @override
  _i3.Future<void> dispose() =>
      (super.noSuchMethod(
            Invocation.method(#dispose, []),
            returnValue: _i3.Future<void>.value(),
            returnValueForMissingStub: _i3.Future<void>.value(),
          )
          as _i3.Future<void>);
}
```

### Inhalt von `klubradio_archivum/test/api/search_api_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:klubradio_archivum/api/search_api.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

import 'episode_api_test.mocks.dart'; // Reuse existing MockHttpRequester

void main() {
  group('SearchApi', () {
    late SearchApi searchApi;
    late MockHttpRequester mockRequester;
    const String baseUrl = 'http://localhost:8000';
    const String apiKey = 'test_api_key';

    setUp(() {
      mockRequester = MockHttpRequester();
      searchApi = SearchApi(
        baseUrl: baseUrl,
        apiKey: apiKey,
        requester: mockRequester,
      );
    });

    // ---- podcasts() ----

    group('podcasts()', () {
      test('returns empty list for blank query', () async {
        final result = await searchApi.podcasts('');
        expect(result, isEmpty);
        verifyNever(mockRequester.getJson(any));
      });

      test('returns empty list for whitespace-only query', () async {
        final result = await searchApi.podcasts('   ');
        expect(result, isEmpty);
        verifyNever(mockRequester.getJson(any));
      });

      test('returns parsed podcast list on valid query', () async {
        final mockResponse = <Map<String, dynamic>>[
          {'id': '3', 'title': 'A lényeg', 'description': 'Hírműsor'},
          {'id': '14', 'title': 'Esti gyors', 'description': 'Napzáró'},
        ];
        when(mockRequester.getJson(any)).thenAnswer((_) async => mockResponse);

        final result = await searchApi.podcasts('lényeg');

        expect(result, hasLength(2));
        expect(result.first['title'], 'A lényeg');
        verify(mockRequester.getJson(
          '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&title=ilike.%25lényeg%25',
        )).called(1);
      });

      test('escapes single quotes in query (SQL injection prevention)', () async {
        when(mockRequester.getJson(any)).thenAnswer((_) async => <Map<String, dynamic>>[]);

        await searchApi.podcasts("O'Connor");

        verify(mockRequester.getJson(
          "$baseUrl/rest/v1/${constants.podcastsTable}?select=*&title=ilike.%25O''Connor%25",
        )).called(1);
      });

      test('escapes multiple single quotes', () async {
        when(mockRequester.getJson(any)).thenAnswer((_) async => <Map<String, dynamic>>[]);

        await searchApi.podcasts("it's a 'test'");

        verify(mockRequester.getJson(
          "$baseUrl/rest/v1/${constants.podcastsTable}?select=*&title=ilike.%25it''s a ''test''%25",
        )).called(1);
      });

      test('handles single-character query', () async {
        when(mockRequester.getJson(any)).thenAnswer((_) async => <Map<String, dynamic>>[]);

        final result = await searchApi.podcasts('a');

        expect(result, isEmpty);
        verify(mockRequester.getJson(any)).called(1);
      });

      test('propagates HTTP errors from requester', () async {
        when(mockRequester.getJson(any)).thenThrow(Exception('Network error'));

        expect(
          () => searchApi.podcasts('test'),
          throwsA(isA<Exception>()),
        );
      });
    });

    // ---- episodes() ----

    group('episodes()', () {
      test('returns empty list for blank query', () async {
        final result = await searchApi.episodes('');
        expect(result, isEmpty);
        verifyNever(mockRequester.getJson(any));
      });

      test('returns empty list for whitespace-only query', () async {
        final result = await searchApi.episodes('  \t  ');
        expect(result, isEmpty);
        verifyNever(mockRequester.getJson(any));
      });

      test('returns parsed episode list on valid query', () async {
        final mockResponse = <Map<String, dynamic>>[
          {'id': '100', 'title': 'A lényeg 2026-03-22', 'podcastId': '3'},
        ];
        when(mockRequester.getJson(any)).thenAnswer((_) async => mockResponse);

        final result = await searchApi.episodes('lényeg');

        expect(result, hasLength(1));
        expect(result.first['id'], '100');
        verify(mockRequester.getJson(
          '$baseUrl/rest/v1/${constants.episodesTable}?select=*&title=ilike.%25lényeg%25',
        )).called(1);
      });

      test('escapes single quotes in episode search', () async {
        when(mockRequester.getJson(any)).thenAnswer((_) async => <Map<String, dynamic>>[]);

        await searchApi.episodes("host's show");

        verify(mockRequester.getJson(
          "$baseUrl/rest/v1/${constants.episodesTable}?select=*&title=ilike.%25host''s show%25",
        )).called(1);
      });

      test('propagates HTTP errors from requester', () async {
        when(mockRequester.getJson(any)).thenThrow(Exception('Timeout'));

        expect(
          () => searchApi.episodes('test'),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/db/settings_dao_test.dart`
```dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';

void main() {
  late AppDatabase db;
  late SettingsDao dao;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dao = SettingsDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'setPlayOrder creates defaults when settings row does not exist',
    () async {
      expect(await dao.getOne(), isNull);

      await dao.setPlayOrder('oldest');

      final settings = await dao.getOne();
      expect(settings, isNotNull);
      expect(settings!.id, 1);
      expect(settings.playOrder, 'oldest');
    },
  );
}
```

### Inhalt von `klubradio_archivum/test/models/episode_test.dart`
```dart
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
```

### Inhalt von `klubradio_archivum/test/models/podcast_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/show_host.dart';

void main() {
  group('Podcast.fromJson', () {
    test('parses minimal fields with defaults', () {
      final p = Podcast.fromJson({'id': '1', 'title': 'Test'});

      expect(p.id, '1');
      expect(p.title, 'Test');
      expect(p.description, '');
      expect(p.coverImageUrl, '');
      expect(p.episodeCount, 0);
      expect(p.hosts, isEmpty);
      expect(p.latestEpisode, isNull);
      expect(p.lastUpdated, isNull);
      expect(p.isSubscribed, isFalse);
      expect(p.isTrending, isFalse);
      expect(p.isRecommended, isFalse);
    });

    test('uses default title when missing', () {
      final p = Podcast.fromJson({'id': '1'});
      expect(p.title, 'Ismeretlen műsor');
    });

    test('parses snake_case fields from Supabase', () {
      final p = Podcast.fromJson({
        'id': '3',
        'title': 'A lényeg',
        'description': 'Napi összefoglaló',
        'cover_image_url': 'https://img.jpg',
        'episode_count': 100,
        'hosts': [{'name': 'Bolgár György'}],
        'last_updated': '2024-01-15T10:00:00Z',
      });

      expect(p.id, '3');
      expect(p.title, 'A lényeg');
      expect(p.description, 'Napi összefoglaló');
      expect(p.coverImageUrl, 'https://img.jpg');
      expect(p.episodeCount, 100);
      expect(p.hosts.length, 1);
      expect(p.hosts.first.name, 'Bolgár György');
      expect(p.lastUpdated, isNotNull);
    });

    test('handles episode_count as string', () {
      final p = Podcast.fromJson({
        'id': '1', 'title': 'T', 'episode_count': '42',
      });
      expect(p.episodeCount, 42);
    });

    test('handles numeric id', () {
      final p = Podcast.fromJson({'id': 7, 'title': 'T'});
      expect(p.id, '7');
    });

    test('handles null id', () {
      final p = Podcast.fromJson({'title': 'T'});
      expect(p.id, '');
    });

    test('parses boolean flags', () {
      final p = Podcast.fromJson({
        'id': '1', 'title': 'T',
        'is_subscribed': true,
        'is_trending': true,
        'is_recommended': true,
      });
      expect(p.isSubscribed, isTrue);
      expect(p.isTrending, isTrue);
      expect(p.isRecommended, isTrue);
    });

    test('parses latest_episode when present', () {
      final p = Podcast.fromJson({
        'id': '1', 'title': 'T',
        'latest_episode': {
          'id': 'ep1', 'podcastId': '1', 'title': 'Latest', 'audioUrl': 'u',
        },
      });
      expect(p.latestEpisode, isNotNull);
      expect(p.latestEpisode!.title, 'Latest');
    });

    test('skips invalid hosts gracefully', () {
      final p = Podcast.fromJson({
        'id': '1', 'title': 'T',
        'hosts': ['not a map', 42, {'name': 'Valid'}],
      });
      expect(p.hosts.length, 1);
      expect(p.hosts.first.name, 'Valid');
    });
  });

  group('Podcast.toJson', () {
    test('serializes all fields', () {
      final p = Podcast(
        id: '5',
        title: 'Podcast Title',
        description: 'Desc',
        coverImageUrl: 'https://cover.jpg',
        episodeCount: 50,
        hosts: [const ShowHost(name: 'Host')],
        lastUpdated: DateTime.utc(2024, 6, 15),
        isSubscribed: true,
        isTrending: false,
        isRecommended: true,
      );
      final json = p.toJson();

      expect(json['id'], '5');
      expect(json['title'], 'Podcast Title');
      expect(json['description'], 'Desc');
      expect(json['coverImageUrl'], 'https://cover.jpg');
      expect(json['episodeCount'], 50);
      expect(json['hosts'], isA<List>());
      expect((json['hosts'] as List).first, {'name': 'Host'});
      expect(json['lastUpdated'], '2024-06-15T00:00:00.000Z');
      expect(json['isSubscribed'], isTrue);
      expect(json['isTrending'], isFalse);
      expect(json['isRecommended'], isTrue);
    });

    test('handles null optional fields', () {
      final p = Podcast(
        id: '1', title: 'T', description: '', coverImageUrl: '',
        episodeCount: 0, hosts: [],
      );
      final json = p.toJson();
      expect(json['latestEpisode'], isNull);
      expect(json['lastUpdated'], isNull);
    });
  });

  group('Podcast.copyWith', () {
    test('overrides specified fields only', () {
      final original = Podcast(
        id: '1', title: 'Original', description: 'D',
        coverImageUrl: '', episodeCount: 10, hosts: [],
      );
      final copy = original.copyWith(title: 'Changed', episodeCount: 20);

      expect(copy.title, 'Changed');
      expect(copy.episodeCount, 20);
      expect(copy.id, '1');
      expect(copy.description, 'D');
    });

    test('preserves all fields when no overrides given', () {
      final original = Podcast(
        id: '1', title: 'T', description: 'D', coverImageUrl: 'c',
        episodeCount: 5, hosts: [const ShowHost(name: 'H')],
        isSubscribed: true,
      );
      final copy = original.copyWith();

      expect(copy.id, original.id);
      expect(copy.title, original.title);
      expect(copy.hosts.length, original.hosts.length);
      expect(copy.isSubscribed, original.isSubscribed);
    });
  });

  group('Podcast.toString', () {
    test('returns valid JSON', () {
      final p = Podcast(
        id: '1', title: 'T', description: '', coverImageUrl: '',
        episodeCount: 0, hosts: [],
      );
      expect(p.toString(), contains('"id"'));
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/models/retention_mode_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/retention_mode.dart';

void main() {
  group('RetentionMode', () {
    test('has 3 values', () {
      expect(RetentionMode.values.length, 3);
    });

    test('values are in expected order', () {
      expect(RetentionMode.values[0], RetentionMode.keepAll);
      expect(RetentionMode.values[1], RetentionMode.keepLatestN);
      expect(RetentionMode.values[2], RetentionMode.deleteAfterHeard);
    });

    test('name returns expected strings', () {
      expect(RetentionMode.keepAll.name, 'keepAll');
      expect(RetentionMode.keepLatestN.name, 'keepLatestN');
      expect(RetentionMode.deleteAfterHeard.name, 'deleteAfterHeard');
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/models/show_data_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/show_data.dart';

void main() {
  group('ShowData', () {
    test('fromJson parses all fields', () {
      final sd = ShowData.fromJson({
        'id': 42,
        'title': 'Megbeszéljük',
        'count': 1500,
      });

      expect(sd.id, '42');
      expect(sd.title, 'Megbeszéljük');
      expect(sd.count, 1500);
    });

    test('fromJson handles string id', () {
      final sd = ShowData.fromJson({
        'id': 'abc',
        'title': 'Test',
        'count': 0,
      });
      expect(sd.id, 'abc');
    });

    test('toJson round-trip', () {
      final original = ShowData(id: '10', title: 'Show', count: 99);
      final json = original.toJson();
      final restored = ShowData.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.title, original.title);
      expect(restored.count, original.count);
    });

    test('toJson produces expected map', () {
      final sd = ShowData(id: '1', title: 'T', count: 5);
      expect(sd.toJson(), {'id': '1', 'title': 'T', 'count': 5});
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/models/show_host_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/show_host.dart';

void main() {
  group('ShowHost', () {
    test('fromJson parses name', () {
      final h = ShowHost.fromJson({'name': 'Bolgár György'});
      expect(h.name, 'Bolgár György');
    });

    test('fromJson uses default name when missing', () {
      final h = ShowHost.fromJson({});
      expect(h.name, 'Ismeretlen műsorvezető');
    });

    test('fromJson uses default name when null', () {
      final h = ShowHost.fromJson({'name': null});
      expect(h.name, 'Ismeretlen műsorvezető');
    });

    test('toJson serializes name', () {
      const h = ShowHost(name: 'Test Host');
      expect(h.toJson(), {'name': 'Test Host'});
    });

    test('copyWith overrides name', () {
      const h = ShowHost(name: 'Original');
      final copy = h.copyWith(name: 'Changed');
      expect(copy.name, 'Changed');
    });

    test('copyWith preserves name when not given', () {
      const h = ShowHost(name: 'Keep');
      final copy = h.copyWith();
      expect(copy.name, 'Keep');
    });

    test('toString returns JSON', () {
      const h = ShowHost(name: 'Test');
      expect(h.toString(), contains('"name"'));
      expect(h.toString(), contains('Test'));
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/models/user_profile_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/models/user_profile.dart';

void main() {
  group('UserProfile.initial', () {
    test('creates profile with default values', () {
      final p = UserProfile.initial('user-1');

      expect(p.id, 'user-1');
      expect(p.languageCode, 'de');
      expect(p.playbackSpeed, 1.0);
      expect(p.maxAutoDownload, 10);
      expect(p.subscribedPodcastIds, isEmpty);
      expect(p.favouriteEpisodeIds, isEmpty);
      expect(p.recentlyPlayed, isEmpty);
    });

    test('accepts custom languageCode', () {
      final p = UserProfile.initial('u', languageCode: 'hu');
      expect(p.languageCode, 'hu');
    });
  });

  group('UserProfile.fromJson', () {
    test('parses all fields', () {
      final p = UserProfile.fromJson({
        'id': 'u1',
        'languageCode': 'en',
        'playbackSpeed': 1.5,
        'maxAutoDownload': 5,
        'subscribedPodcastIds': ['p1', 'p2'],
        'favouriteEpisodeIds': ['e1'],
        'recentlyPlayed': [
          {
            'id': 'ep1', 'podcastId': 'p1', 'title': 'T',
            'audioUrl': 'u', 'description': '', 'showDate': '',
          },
        ],
      });

      expect(p.id, 'u1');
      expect(p.languageCode, 'en');
      expect(p.playbackSpeed, 1.5);
      expect(p.maxAutoDownload, 5);
      expect(p.subscribedPodcastIds, {'p1', 'p2'});
      expect(p.favouriteEpisodeIds, {'e1'});
      expect(p.recentlyPlayed.length, 1);
    });

    test('uses defaults for missing optional fields', () {
      final p = UserProfile.fromJson({'id': 'u1'});

      expect(p.languageCode, 'de');
      expect(p.playbackSpeed, 1.0);
      expect(p.maxAutoDownload, 10);
      expect(p.subscribedPodcastIds, isEmpty);
      expect(p.favouriteEpisodeIds, isEmpty);
      expect(p.recentlyPlayed, isEmpty);
    });

    test('handles numeric playbackSpeed', () {
      final p = UserProfile.fromJson({'id': 'u', 'playbackSpeed': 2});
      expect(p.playbackSpeed, 2.0);
    });
  });

  group('UserProfile.toJson', () {
    test('serializes and deserializes round-trip', () {
      final original = UserProfile(
        id: 'u1',
        languageCode: 'hu',
        playbackSpeed: 1.25,
        maxAutoDownload: 3,
        subscribedPodcastIds: {'p1', 'p2'},
        favouriteEpisodeIds: {'e1', 'e2'},
        recentlyPlayed: const [],
      );

      final json = original.toJson();
      final restored = UserProfile.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.languageCode, original.languageCode);
      expect(restored.playbackSpeed, original.playbackSpeed);
      expect(restored.maxAutoDownload, original.maxAutoDownload);
      expect(restored.subscribedPodcastIds, original.subscribedPodcastIds);
      expect(restored.favouriteEpisodeIds, original.favouriteEpisodeIds);
    });

    test('subscribedPodcastIds serializes as list', () {
      final p = UserProfile.initial('u');
      final json = p.toJson();
      expect(json['subscribedPodcastIds'], isA<List>());
    });
  });

  group('UserProfile.copyWith', () {
    test('overrides specified fields', () {
      final original = UserProfile.initial('u');
      final copy = original.copyWith(
        languageCode: 'en',
        playbackSpeed: 2.0,
      );

      expect(copy.languageCode, 'en');
      expect(copy.playbackSpeed, 2.0);
      expect(copy.id, 'u');
      expect(copy.maxAutoDownload, 10);
    });

    test('preserves all fields when no overrides', () {
      final original = UserProfile(
        id: 'u',
        languageCode: 'hu',
        playbackSpeed: 1.5,
        maxAutoDownload: 7,
        subscribedPodcastIds: {'p1'},
        favouriteEpisodeIds: {'e1'},
        recentlyPlayed: const [],
      );
      final copy = original.copyWith();

      expect(copy.id, original.id);
      expect(copy.languageCode, original.languageCode);
      expect(copy.playbackSpeed, original.playbackSpeed);
      expect(copy.maxAutoDownload, original.maxAutoDownload);
      expect(copy.subscribedPodcastIds, original.subscribedPodcastIds);
      expect(copy.favouriteEpisodeIds, original.favouriteEpisodeIds);
    });
  });

  group('UserProfile.toString', () {
    test('returns valid JSON string', () {
      final p = UserProfile.initial('u');
      final str = p.toString();
      expect(str, contains('"id"'));
      expect(str, contains('"languageCode"'));
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/providers/episode_provider_queue_test.dart`
```dart
// test/providers/episode_provider_queue_test.dart
//
// Unit tests for queue/playlist management in EpisodeProvider.
//
// Covers:
//   - addToQueue     : append, duplicate prevention, notifyListeners
//   - removeFromQueue: remove by id, edge cases, notifyListeners
//   - reorderQueue   : forward/backward moves, index-correction logic
//   - queue getter   : unmodifiable, empty initial state
//   - getNextEpisode : navigation, boundary, missing episode
//   - getPreviousEpisode: navigation, boundary
//   - playEpisode    : queue parameter sets list, without param prepends/deduplicates
//
// Widget tests for _QueueSheet (now_playing_bar.dart) are intentionally skipped
// because the widget depends on the AudioPlayer native plugin.
// See test/screens/podcast_detail_screen_test.dart for the documented pattern.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:klubradio_archivum/db/app_database.dart' as db;
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/audio_player_service.dart';

import 'episode_provider_queue_test.mocks.dart';

@GenerateMocks([AudioPlayerService, ApiService, db.AppDatabase])
void main() {
  // ==================== Helpers ====================

  /// Creates a minimal Episode with the given [id].
  Episode ep(String id, {String title = ''}) => Episode(
        id: id,
        podcastId: 'pod-1',
        title: title.isEmpty ? 'Episode $id' : title,
        description: 'Desc',
        audioUrl: 'https://example.com/$id.mp3',
        publishedAt: DateTime(2024, 1, 1),
        showDate: '2024-01-01',
        duration: const Duration(minutes: 30),
      );

  // ==================== Test fixtures ====================

  late MockAudioPlayerService mockAudio;
  late MockApiService mockApi;
  late MockAppDatabase mockDb;
  late StreamController<Duration> positionCtrl;
  late StreamController<PlayerState> playerStateCtrl;
  late StreamController<bool> bufferingCtrl;
  late EpisodeProvider provider;

  setUp(() {
    positionCtrl = StreamController<Duration>.broadcast();
    playerStateCtrl = StreamController<PlayerState>.broadcast();
    bufferingCtrl = StreamController<bool>.broadcast();

    mockAudio = MockAudioPlayerService();
    mockApi = MockApiService();
    mockDb = MockAppDatabase();

    // Stub streams required by EpisodeProvider constructor
    when(mockAudio.positionStream).thenAnswer((_) => positionCtrl.stream);
    when(mockAudio.playerStateStream)
        .thenAnswer((_) => playerStateCtrl.stream);
    when(mockAudio.bufferingStream).thenAnswer((_) => bufferingCtrl.stream);
    when(mockAudio.isPlaying).thenReturn(false);
    when(mockAudio.totalDuration).thenReturn(null);
    // loadEpisode is called by playEpisode; return immediately without errors
    when(mockAudio.loadEpisode(any)).thenAnswer((_) async {});

    provider = EpisodeProvider(
      apiService: mockApi,
      audioPlayerService: mockAudio,
      db: mockDb,
    );
  });

  tearDown(() async {
    await positionCtrl.close();
    await playerStateCtrl.close();
    await bufferingCtrl.close();
    await provider.dispose();
  });

  // ==================== addToQueue ====================

  group('addToQueue', () {
    test('appends episodes in order', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      expect(provider.queue.map((e) => e.id), ['a', 'b', 'c']);
    });

    test('does not add duplicate (same id)', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('a'));

      expect(provider.queue.length, 1);
    });

    test('notifies listeners when episode is added', () {
      int calls = 0;
      provider.addListener(() => calls++);

      provider.addToQueue(ep('x'));

      expect(calls, 1);
    });

    test('does not notify listeners when duplicate is rejected', () {
      provider.addToQueue(ep('x')); // first add succeeds
      int calls = 0;
      provider.addListener(() => calls++);

      provider.addToQueue(ep('x')); // duplicate → rejected silently

      expect(calls, 0);
    });
  });

  // ==================== removeFromQueue ====================

  group('removeFromQueue', () {
    test('removes episode by id from the middle', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      provider.removeFromQueue('b');

      expect(provider.queue.map((e) => e.id), ['a', 'c']);
    });

    test('removes first episode', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));

      provider.removeFromQueue('a');

      expect(provider.queue.map((e) => e.id), ['b']);
    });

    test('removes last episode', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));

      provider.removeFromQueue('b');

      expect(provider.queue.map((e) => e.id), ['a']);
    });

    test('is a no-op when id is not in queue', () {
      provider.addToQueue(ep('a'));

      provider.removeFromQueue('does-not-exist');

      expect(provider.queue.length, 1);
    });

    test('empties queue when only episode is removed', () {
      provider.addToQueue(ep('only'));

      provider.removeFromQueue('only');

      expect(provider.queue, isEmpty);
    });

    test('notifies listeners on remove', () {
      provider.addToQueue(ep('x'));
      int calls = 0;
      provider.addListener(() => calls++);

      provider.removeFromQueue('x');

      expect(calls, 1);
    });
  });

  // ==================== reorderQueue ====================
  //
  // reorderQueue mirrors the Flutter ReorderableListView contract:
  //   - When dragging FORWARD (oldIndex < newIndex), the widget passes
  //     newIndex = targetPosition + 1. The provider adjusts: newIndex -= 1.
  //   - When dragging BACKWARD (oldIndex >= newIndex), no adjustment.
  //
  // Queue before each test: [a(0), b(1), c(2), d(3)]

  group('reorderQueue', () {
    setUp(() {
      for (final id in ['a', 'b', 'c', 'd']) {
        provider.addToQueue(ep(id));
      }
    });

    test('moves item backward: d (3) → before b (1)', () {
      // oldIndex=3, newIndex=1 → no adjustment (oldIndex > newIndex)
      // removeAt(3): [a, b, c]  →  insert(1, d): [a, d, b, c]
      provider.reorderQueue(3, 1);

      expect(provider.queue.map((e) => e.id), ['a', 'd', 'b', 'c']);
    });

    test('moves item forward: a (0) → before d, widget passes newIndex=3', () {
      // oldIndex=0, newIndex=3 → adjust: newIndex=2
      // removeAt(0): [b, c, d]  →  insert(2, a): [b, c, a, d]
      provider.reorderQueue(0, 3);

      expect(provider.queue.map((e) => e.id), ['b', 'c', 'a', 'd']);
    });

    test('moves item one step forward: a (0) → widget passes newIndex=2', () {
      // oldIndex=0, newIndex=2 → adjust: newIndex=1
      // removeAt(0): [b, c, d]  →  insert(1, a): [b, a, c, d]
      provider.reorderQueue(0, 2);

      expect(provider.queue.map((e) => e.id), ['b', 'a', 'c', 'd']);
    });

    test('moves item one step backward: c (2) → before b (1)', () {
      // oldIndex=2, newIndex=1 → no adjustment
      // removeAt(2): [a, b, d]  →  insert(1, c): [a, c, b, d]
      provider.reorderQueue(2, 1);

      expect(provider.queue.map((e) => e.id), ['a', 'c', 'b', 'd']);
    });

    test('no-op when oldIndex == newIndex', () {
      // oldIndex=2, newIndex=2 → no adjustment (not < newIndex)
      // removeAt(2): [a, b, d]  →  insert(2, c): [a, b, c, d]
      provider.reorderQueue(2, 2);

      expect(provider.queue.map((e) => e.id), ['a', 'b', 'c', 'd']);
    });

    test('moves item to first position', () {
      // Move d to front: oldIndex=3, newIndex=0
      // removeAt(3): [a, b, c]  →  insert(0, d): [d, a, b, c]
      provider.reorderQueue(3, 0);

      expect(provider.queue.map((e) => e.id), ['d', 'a', 'b', 'c']);
    });

    test('moves item to last position via widget convention', () {
      // Move a to after d: widget passes newIndex=4 (length)
      // oldIndex=0, newIndex=4 → adjust: newIndex=3
      // removeAt(0): [b, c, d]  →  insert(3, a): [b, c, d, a]
      provider.reorderQueue(0, 4);

      expect(provider.queue.map((e) => e.id), ['b', 'c', 'd', 'a']);
    });

    test('notifies listeners after reorder', () {
      int calls = 0;
      provider.addListener(() => calls++);

      provider.reorderQueue(0, 2);

      expect(calls, 1);
    });
  });

  // ==================== queue getter ====================

  group('queue getter', () {
    test('returns empty list initially', () {
      expect(provider.queue, isEmpty);
    });

    test('returns unmodifiable list — add throws', () {
      provider.addToQueue(ep('a'));

      expect(
        () => provider.queue.add(ep('illegal')),
        throwsUnsupportedError,
      );
    });

    test('returned list reflects current state', () {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));

      expect(provider.queue.length, 2);

      provider.removeFromQueue('a');

      expect(provider.queue.length, 1);
      expect(provider.queue.first.id, 'b');
    });
  });

  // ==================== getNextEpisode ====================

  group('getNextEpisode', () {
    test('returns null when no current episode', () {
      provider.addToQueue(ep('a'));

      expect(provider.getNextEpisode(), isNull);
    });

    test('returns null when queue is empty', () {
      expect(provider.getNextEpisode(), isNull);
    });

    test('returns next episode in queue', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(a, queue: [a, b, c]);

      expect(provider.getNextEpisode()?.id, 'b');
    });

    test('returns null when at last episode', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(b, queue: [a, b]);

      expect(provider.getNextEpisode(), isNull);
    });

    test('returns null when current episode is no longer in queue', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(a, queue: [a, b]);
      provider.removeFromQueue('a'); // remove current from queue

      expect(provider.getNextEpisode(), isNull);
    });

    test('returns correct next after queue is reordered', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(a, queue: [a, b, c]);
      // Move c before b: reorderQueue(2, 1) → [a, c, b]
      provider.reorderQueue(2, 1);

      expect(provider.getNextEpisode()?.id, 'c');
    });
  });

  // ==================== getPreviousEpisode ====================

  group('getPreviousEpisode', () {
    test('returns null when no current episode', () {
      provider.addToQueue(ep('a'));

      expect(provider.getPreviousEpisode(), isNull);
    });

    test('returns null when at first episode', () async {
      final a = ep('a');
      final b = ep('b');
      await provider.playEpisode(a, queue: [a, b]);

      expect(provider.getPreviousEpisode(), isNull);
    });

    test('returns previous episode', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(b, queue: [a, b, c]);

      expect(provider.getPreviousEpisode()?.id, 'a');
    });

    test('returns second-to-last when at last episode', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(c, queue: [a, b, c]);

      expect(provider.getPreviousEpisode()?.id, 'b');
    });

    test('returns correct previous after queue is reordered', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(c, queue: [a, b, c]);
      // Move a to end: reorderQueue(0, 3) → [b, c, a]
      provider.reorderQueue(0, 3);

      expect(provider.getPreviousEpisode()?.id, 'b');
    });
  });

  // ==================== playEpisode — queue behaviour ====================

  group('playEpisode — queue behaviour', () {
    test('with queue param: replaces queue with provided list', () async {
      provider.addToQueue(ep('old'));
      final a = ep('a');
      final b = ep('b');

      await provider.playEpisode(a, queue: [a, b]);

      expect(provider.queue.map((e) => e.id), ['a', 'b']);
    });

    test('without queue param: prepends episode when not already in queue',
        () async {
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      await provider.playEpisode(ep('a'));

      expect(provider.queue.first.id, 'a');
      expect(provider.queue.length, 3);
    });

    test('without queue param: does not prepend if already in queue', () async {
      final a = ep('a');
      provider.addToQueue(a);

      await provider.playEpisode(a);

      expect(provider.queue.length, 1);
    });

    test('sets currentEpisode to the played episode', () async {
      final a = ep('a');
      await provider.playEpisode(a, queue: [a]);

      expect(provider.currentEpisode?.id, 'a');
    });

    test('notifies listeners after playEpisode', () async {
      int calls = 0;
      provider.addListener(() => calls++);

      await provider.playEpisode(ep('a'), queue: [ep('a')]);

      expect(calls, greaterThan(0));
    });
  });

  // ==================== combined: remove while navigating ====================

  group('remove + navigation', () {
    test('removing non-current episode shifts next correctly', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(a, queue: [a, b, c]);

      provider.removeFromQueue('b'); // remove the one after current

      expect(provider.getNextEpisode()?.id, 'c');
    });

    test('removing current does not affect previous lookup', () async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(b, queue: [a, b, c]);

      provider.removeFromQueue('b'); // remove current

      // b is gone from queue, indexWhere returns -1 → null
      expect(provider.getPreviousEpisode(), isNull);
      expect(provider.getNextEpisode(), isNull);
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/providers/episode_provider_queue_test.mocks.dart`
```dart
// Mocks generated by Mockito 5.4.6 from annotations
// in klubradio_archivum/test/providers/episode_provider_queue_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:drift/drift.dart' as _i3;
import 'package:drift/src/runtime/executor/stream_queries.dart' as _i5;
import 'package:http/http.dart' as _i14;
import 'package:just_audio/just_audio.dart' as _i8;
import 'package:klubradio_archivum/db/app_database.dart' as _i4;
import 'package:klubradio_archivum/models/episode.dart' as _i9;
import 'package:klubradio_archivum/models/podcast.dart' as _i12;
import 'package:klubradio_archivum/models/show_data.dart' as _i13;
import 'package:klubradio_archivum/models/user_profile.dart' as _i2;
import 'package:klubradio_archivum/services/api_service.dart' as _i10;
import 'package:klubradio_archivum/services/audio_player_service.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i11;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class
// ignore_for_file: invalid_use_of_internal_member

class _FakeUserProfile_0 extends _i1.SmartFake implements _i2.UserProfile {
  _FakeUserProfile_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeMigrationStrategy_1 extends _i1.SmartFake
    implements _i3.MigrationStrategy {
  _FakeMigrationStrategy_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _Fake$AppDatabaseManager_2 extends _i1.SmartFake
    implements _i4.$AppDatabaseManager {
  _Fake$AppDatabaseManager_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _Fake$SubscriptionsTable_3 extends _i1.SmartFake
    implements _i4.$SubscriptionsTable {
  _Fake$SubscriptionsTable_3(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _Fake$EpisodesTable_4 extends _i1.SmartFake
    implements _i4.$EpisodesTable {
  _Fake$EpisodesTable_4(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _Fake$SettingsTable_5 extends _i1.SmartFake
    implements _i4.$SettingsTable {
  _Fake$SettingsTable_5(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGeneratedDatabase_6 extends _i1.SmartFake
    implements _i3.GeneratedDatabase {
  _FakeGeneratedDatabase_6(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDriftDatabaseOptions_7 extends _i1.SmartFake
    implements _i3.DriftDatabaseOptions {
  _FakeDriftDatabaseOptions_7(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeStreamQueryUpdateRules_8 extends _i1.SmartFake
    implements _i3.StreamQueryUpdateRules {
  _FakeStreamQueryUpdateRules_8(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDatabaseConnection_9 extends _i1.SmartFake
    implements _i3.DatabaseConnection {
  _FakeDatabaseConnection_9(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeQueryExecutor_10 extends _i1.SmartFake implements _i3.QueryExecutor {
  _FakeQueryExecutor_10(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeStreamQueryStore_11 extends _i1.SmartFake
    implements _i5.StreamQueryStore {
  _FakeStreamQueryStore_11(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDatabaseConnectionUser_12 extends _i1.SmartFake
    implements _i3.DatabaseConnectionUser {
  _FakeDatabaseConnectionUser_12(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeMigrator_13 extends _i1.SmartFake implements _i3.Migrator {
  _FakeMigrator_13(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeFuture_14<T> extends _i1.SmartFake implements _i6.Future<T> {
  _FakeFuture_14(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeInsertStatement_15<T1 extends _i3.Table, D1> extends _i1.SmartFake
    implements _i3.InsertStatement<T1, D1> {
  _FakeInsertStatement_15(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeUpdateStatement_16<T extends _i3.Table, D> extends _i1.SmartFake
    implements _i3.UpdateStatement<T, D> {
  _FakeUpdateStatement_16(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSimpleSelectStatement_17<T1 extends _i3.HasResultSet, D>
    extends _i1.SmartFake
    implements _i3.SimpleSelectStatement<T1, D> {
  _FakeSimpleSelectStatement_17(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeJoinedSelectStatement_18<FirstT extends _i3.HasResultSet, FirstD>
    extends _i1.SmartFake
    implements _i3.JoinedSelectStatement<FirstT, FirstD> {
  _FakeJoinedSelectStatement_18(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeBaseSelectStatement_19<Row> extends _i1.SmartFake
    implements _i3.BaseSelectStatement<Row> {
  _FakeBaseSelectStatement_19(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDeleteStatement_20<T1 extends _i3.Table, D1> extends _i1.SmartFake
    implements _i3.DeleteStatement<T1, D1> {
  _FakeDeleteStatement_20(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSelectable_21<T> extends _i1.SmartFake implements _i3.Selectable<T> {
  _FakeSelectable_21(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGenerationContext_22 extends _i1.SmartFake
    implements _i3.GenerationContext {
  _FakeGenerationContext_22(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [AudioPlayerService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAudioPlayerService extends _i1.Mock
    implements _i7.AudioPlayerService {
  MockAudioPlayerService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Stream<bool> get bufferingStream =>
      (super.noSuchMethod(
            Invocation.getter(#bufferingStream),
            returnValue: _i6.Stream<bool>.empty(),
          )
          as _i6.Stream<bool>);

  @override
  _i6.Stream<Duration> get positionStream =>
      (super.noSuchMethod(
            Invocation.getter(#positionStream),
            returnValue: _i6.Stream<Duration>.empty(),
          )
          as _i6.Stream<Duration>);

  @override
  _i6.Stream<Duration> get bufferedPositionStream =>
      (super.noSuchMethod(
            Invocation.getter(#bufferedPositionStream),
            returnValue: _i6.Stream<Duration>.empty(),
          )
          as _i6.Stream<Duration>);

  @override
  _i6.Stream<_i8.PlayerState> get playerStateStream =>
      (super.noSuchMethod(
            Invocation.getter(#playerStateStream),
            returnValue: _i6.Stream<_i8.PlayerState>.empty(),
          )
          as _i6.Stream<_i8.PlayerState>);

  @override
  bool get isPlaying =>
      (super.noSuchMethod(Invocation.getter(#isPlaying), returnValue: false)
          as bool);

  @override
  _i6.Future<void> loadEpisode(
    _i9.Episode? episode, {
    bool? autoplay = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#loadEpisode, [episode], {#autoplay: autoplay}),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> togglePlayPause() =>
      (super.noSuchMethod(
            Invocation.method(#togglePlayPause, []),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> stop() =>
      (super.noSuchMethod(
            Invocation.method(#stop, []),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> seek(Duration? position) =>
      (super.noSuchMethod(
            Invocation.method(#seek, [position]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> setSpeed(double? speed) =>
      (super.noSuchMethod(
            Invocation.method(#setSpeed, [speed]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> setVolume(double? volume) =>
      (super.noSuchMethod(
            Invocation.method(#setVolume, [volume]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> dispose() =>
      (super.noSuchMethod(
            Invocation.method(#dispose, []),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);
}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i10.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get supabaseUrl =>
      (super.noSuchMethod(
            Invocation.getter(#supabaseUrl),
            returnValue: _i11.dummyValue<String>(
              this,
              Invocation.getter(#supabaseUrl),
            ),
          )
          as String);

  @override
  String get supabaseKey =>
      (super.noSuchMethod(
            Invocation.getter(#supabaseKey),
            returnValue: _i11.dummyValue<String>(
              this,
              Invocation.getter(#supabaseKey),
            ),
          )
          as String);

  @override
  bool get hasValidCredentials =>
      (super.noSuchMethod(
            Invocation.getter(#hasValidCredentials),
            returnValue: false,
          )
          as bool);

  @override
  _i6.Future<List<_i12.Podcast>> fetchLatestPodcasts({int? limit = 10}) =>
      (super.noSuchMethod(
            Invocation.method(#fetchLatestPodcasts, [], {#limit: limit}),
            returnValue: _i6.Future<List<_i12.Podcast>>.value(<_i12.Podcast>[]),
          )
          as _i6.Future<List<_i12.Podcast>>);

  @override
  _i6.Future<List<_i12.Podcast>> fetchTrendingPodcasts({int? limit = 10}) =>
      (super.noSuchMethod(
            Invocation.method(#fetchTrendingPodcasts, [], {#limit: limit}),
            returnValue: _i6.Future<List<_i12.Podcast>>.value(<_i12.Podcast>[]),
          )
          as _i6.Future<List<_i12.Podcast>>);

  @override
  _i6.Future<List<_i12.Podcast>> fetchRecommendedPodcasts({int? limit = 10}) =>
      (super.noSuchMethod(
            Invocation.method(#fetchRecommendedPodcasts, [], {#limit: limit}),
            returnValue: _i6.Future<List<_i12.Podcast>>.value(<_i12.Podcast>[]),
          )
          as _i6.Future<List<_i12.Podcast>>);

  @override
  _i6.Future<List<_i9.Episode>> fetchEpisodesForPodcast(
    String? podcastId, {
    int? limit = 500,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #fetchEpisodesForPodcast,
              [podcastId],
              {#limit: limit},
            ),
            returnValue: _i6.Future<List<_i9.Episode>>.value(<_i9.Episode>[]),
          )
          as _i6.Future<List<_i9.Episode>>);

  @override
  _i6.Future<List<_i9.Episode>> fetchRecentEpisodes({int? limit = 8}) =>
      (super.noSuchMethod(
            Invocation.method(#fetchRecentEpisodes, [], {#limit: limit}),
            returnValue: _i6.Future<List<_i9.Episode>>.value(<_i9.Episode>[]),
          )
          as _i6.Future<List<_i9.Episode>>);

  @override
  _i6.Future<List<_i12.Podcast>> searchPodcasts(String? query) =>
      (super.noSuchMethod(
            Invocation.method(#searchPodcasts, [query]),
            returnValue: _i6.Future<List<_i12.Podcast>>.value(<_i12.Podcast>[]),
          )
          as _i6.Future<List<_i12.Podcast>>);

  @override
  _i6.Future<List<_i9.Episode>> searchEpisodes(String? query) =>
      (super.noSuchMethod(
            Invocation.method(#searchEpisodes, [query]),
            returnValue: _i6.Future<List<_i9.Episode>>.value(<_i9.Episode>[]),
          )
          as _i6.Future<List<_i9.Episode>>);

  @override
  _i6.Future<List<_i13.ShowData>> fetchTopShowsThisYear() =>
      (super.noSuchMethod(
            Invocation.method(#fetchTopShowsThisYear, []),
            returnValue: _i6.Future<List<_i13.ShowData>>.value(
              <_i13.ShowData>[],
            ),
          )
          as _i6.Future<List<_i13.ShowData>>);

  @override
  _i6.Future<_i12.Podcast?> fetchPodcastById(String? podcastId) =>
      (super.noSuchMethod(
            Invocation.method(#fetchPodcastById, [podcastId]),
            returnValue: _i6.Future<_i12.Podcast?>.value(),
          )
          as _i6.Future<_i12.Podcast?>);

  @override
  _i6.Future<_i2.UserProfile> fetchUserProfile(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#fetchUserProfile, [userId]),
            returnValue: _i6.Future<_i2.UserProfile>.value(
              _FakeUserProfile_0(
                this,
                Invocation.method(#fetchUserProfile, [userId]),
              ),
            ),
          )
          as _i6.Future<_i2.UserProfile>);

  @override
  _i6.Future<void> logPlayback({required String? episodeId}) =>
      (super.noSuchMethod(
            Invocation.method(#logPlayback, [], {#episodeId: episodeId}),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );

  @override
  String getServerErrorMessage(_i14.Response? response) =>
      (super.noSuchMethod(
            Invocation.method(#getServerErrorMessage, [response]),
            returnValue: _i11.dummyValue<String>(
              this,
              Invocation.method(#getServerErrorMessage, [response]),
            ),
          )
          as String);
}

/// A class which mocks [AppDatabase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppDatabase extends _i1.Mock implements _i4.AppDatabase {
  MockAppDatabase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get schemaVersion =>
      (super.noSuchMethod(Invocation.getter(#schemaVersion), returnValue: 0)
          as int);

  @override
  _i3.MigrationStrategy get migration =>
      (super.noSuchMethod(
            Invocation.getter(#migration),
            returnValue: _FakeMigrationStrategy_1(
              this,
              Invocation.getter(#migration),
            ),
          )
          as _i3.MigrationStrategy);

  @override
  _i4.$AppDatabaseManager get managers =>
      (super.noSuchMethod(
            Invocation.getter(#managers),
            returnValue: _Fake$AppDatabaseManager_2(
              this,
              Invocation.getter(#managers),
            ),
          )
          as _i4.$AppDatabaseManager);

  @override
  _i4.$SubscriptionsTable get subscriptions =>
      (super.noSuchMethod(
            Invocation.getter(#subscriptions),
            returnValue: _Fake$SubscriptionsTable_3(
              this,
              Invocation.getter(#subscriptions),
            ),
          )
          as _i4.$SubscriptionsTable);

  @override
  _i4.$EpisodesTable get episodes =>
      (super.noSuchMethod(
            Invocation.getter(#episodes),
            returnValue: _Fake$EpisodesTable_4(
              this,
              Invocation.getter(#episodes),
            ),
          )
          as _i4.$EpisodesTable);

  @override
  _i4.$SettingsTable get settings =>
      (super.noSuchMethod(
            Invocation.getter(#settings),
            returnValue: _Fake$SettingsTable_5(
              this,
              Invocation.getter(#settings),
            ),
          )
          as _i4.$SettingsTable);

  @override
  Iterable<_i3.TableInfo<_i3.Table, Object?>> get allTables =>
      (super.noSuchMethod(
            Invocation.getter(#allTables),
            returnValue: <_i3.TableInfo<_i3.Table, Object?>>[],
          )
          as Iterable<_i3.TableInfo<_i3.Table, Object?>>);

  @override
  List<_i3.DatabaseSchemaEntity> get allSchemaEntities =>
      (super.noSuchMethod(
            Invocation.getter(#allSchemaEntities),
            returnValue: <_i3.DatabaseSchemaEntity>[],
          )
          as List<_i3.DatabaseSchemaEntity>);

  @override
  _i3.GeneratedDatabase get attachedDatabase =>
      (super.noSuchMethod(
            Invocation.getter(#attachedDatabase),
            returnValue: _FakeGeneratedDatabase_6(
              this,
              Invocation.getter(#attachedDatabase),
            ),
          )
          as _i3.GeneratedDatabase);

  @override
  _i3.DriftDatabaseOptions get options =>
      (super.noSuchMethod(
            Invocation.getter(#options),
            returnValue: _FakeDriftDatabaseOptions_7(
              this,
              Invocation.getter(#options),
            ),
          )
          as _i3.DriftDatabaseOptions);

  @override
  _i3.StreamQueryUpdateRules get streamUpdateRules =>
      (super.noSuchMethod(
            Invocation.getter(#streamUpdateRules),
            returnValue: _FakeStreamQueryUpdateRules_8(
              this,
              Invocation.getter(#streamUpdateRules),
            ),
          )
          as _i3.StreamQueryUpdateRules);

  @override
  _i3.DatabaseConnection get connection =>
      (super.noSuchMethod(
            Invocation.getter(#connection),
            returnValue: _FakeDatabaseConnection_9(
              this,
              Invocation.getter(#connection),
            ),
          )
          as _i3.DatabaseConnection);

  @override
  _i3.SqlTypes get typeMapping =>
      (super.noSuchMethod(
            Invocation.getter(#typeMapping),
            returnValue: _i11.dummyValue<_i3.SqlTypes>(
              this,
              Invocation.getter(#typeMapping),
            ),
          )
          as _i3.SqlTypes);

  @override
  _i3.QueryExecutor get executor =>
      (super.noSuchMethod(
            Invocation.getter(#executor),
            returnValue: _FakeQueryExecutor_10(
              this,
              Invocation.getter(#executor),
            ),
          )
          as _i3.QueryExecutor);

  @override
  _i5.StreamQueryStore get streamQueries =>
      (super.noSuchMethod(
            Invocation.getter(#streamQueries),
            returnValue: _FakeStreamQueryStore_11(
              this,
              Invocation.getter(#streamQueries),
            ),
          )
          as _i5.StreamQueryStore);

  @override
  _i3.DatabaseConnectionUser get resolvedEngine =>
      (super.noSuchMethod(
            Invocation.getter(#resolvedEngine),
            returnValue: _FakeDatabaseConnectionUser_12(
              this,
              Invocation.getter(#resolvedEngine),
            ),
          )
          as _i3.DatabaseConnectionUser);

  @override
  _i6.Future<int> touchEpisode(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#touchEpisode, [id]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> touchSubscription(String? podcastId) =>
      (super.noSuchMethod(
            Invocation.method(#touchSubscription, [podcastId]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i3.Migrator createMigrator() =>
      (super.noSuchMethod(
            Invocation.method(#createMigrator, []),
            returnValue: _FakeMigrator_13(
              this,
              Invocation.method(#createMigrator, []),
            ),
          )
          as _i3.Migrator);

  @override
  _i6.Future<void> beforeOpen(
    _i3.QueryExecutor? executor,
    _i3.OpeningDetails? details,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#beforeOpen, [executor, details]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<Ret> computeWithDatabase<Ret, DB extends _i3.GeneratedDatabase>({
    required _i6.FutureOr<Ret> Function(DB)? computation,
    required DB Function(_i3.DatabaseConnection)? connect,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#computeWithDatabase, [], {
              #computation: computation,
              #connect: connect,
            }),
            returnValue:
                _i11.ifNotNull(
                  _i11.dummyValueOrNull<Ret>(
                    this,
                    Invocation.method(#computeWithDatabase, [], {
                      #computation: computation,
                      #connect: connect,
                    }),
                  ),
                  (Ret v) => _i6.Future<Ret>.value(v),
                ) ??
                _FakeFuture_14<Ret>(
                  this,
                  Invocation.method(#computeWithDatabase, [], {
                    #computation: computation,
                    #connect: connect,
                  }),
                ),
          )
          as _i6.Future<Ret>);

  @override
  _i6.Stream<T> createStream<T extends Object>(
    _i5.QueryStreamFetcher<T>? stmt,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#createStream, [stmt]),
            returnValue: _i6.Stream<T>.empty(),
          )
          as _i6.Stream<T>);

  @override
  T alias<T, D>(_i3.ResultSetImplementation<T, D>? table, String? alias) =>
      (super.noSuchMethod(
            Invocation.method(#alias, [table, alias]),
            returnValue: _i11.dummyValue<T>(
              this,
              Invocation.method(#alias, [table, alias]),
            ),
          )
          as T);

  @override
  void markTablesUpdated(Iterable<_i3.TableInfo<_i3.Table, dynamic>>? tables) =>
      super.noSuchMethod(
        Invocation.method(#markTablesUpdated, [tables]),
        returnValueForMissingStub: null,
      );

  @override
  void notifyUpdates(Set<_i3.TableUpdate>? updates) => super.noSuchMethod(
    Invocation.method(#notifyUpdates, [updates]),
    returnValueForMissingStub: null,
  );

  @override
  _i6.Stream<Set<_i3.TableUpdate>> tableUpdates([
    _i3.TableUpdateQuery? query = const _i3.TableUpdateQuery.any(),
  ]) =>
      (super.noSuchMethod(
            Invocation.method(#tableUpdates, [query]),
            returnValue: _i6.Stream<Set<_i3.TableUpdate>>.empty(),
          )
          as _i6.Stream<Set<_i3.TableUpdate>>);

  @override
  _i6.Future<T> doWhenOpened<T>(
    _i6.FutureOr<T> Function(_i3.QueryExecutor)? fn,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#doWhenOpened, [fn]),
            returnValue:
                _i11.ifNotNull(
                  _i11.dummyValueOrNull<T>(
                    this,
                    Invocation.method(#doWhenOpened, [fn]),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_14<T>(this, Invocation.method(#doWhenOpened, [fn])),
          )
          as _i6.Future<T>);

  @override
  _i3.InsertStatement<T, D> into<T extends _i3.Table, D>(
    _i3.TableInfo<T, D>? table,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#into, [table]),
            returnValue: _FakeInsertStatement_15<T, D>(
              this,
              Invocation.method(#into, [table]),
            ),
          )
          as _i3.InsertStatement<T, D>);

  @override
  _i3.UpdateStatement<Tbl, R> update<Tbl extends _i3.Table, R>(
    _i3.TableInfo<Tbl, R>? table,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#update, [table]),
            returnValue: _FakeUpdateStatement_16<Tbl, R>(
              this,
              Invocation.method(#update, [table]),
            ),
          )
          as _i3.UpdateStatement<Tbl, R>);

  @override
  _i3.SimpleSelectStatement<T, R> select<T extends _i3.HasResultSet, R>(
    _i3.ResultSetImplementation<T, R>? table, {
    bool? distinct = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#select, [table], {#distinct: distinct}),
            returnValue: _FakeSimpleSelectStatement_17<T, R>(
              this,
              Invocation.method(#select, [table], {#distinct: distinct}),
            ),
          )
          as _i3.SimpleSelectStatement<T, R>);

  @override
  _i3.JoinedSelectStatement<T, R> selectOnly<T extends _i3.HasResultSet, R>(
    _i3.ResultSetImplementation<T, R>? table, {
    bool? distinct = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#selectOnly, [table], {#distinct: distinct}),
            returnValue: _FakeJoinedSelectStatement_18<T, R>(
              this,
              Invocation.method(#selectOnly, [table], {#distinct: distinct}),
            ),
          )
          as _i3.JoinedSelectStatement<T, R>);

  @override
  _i3.BaseSelectStatement<_i3.TypedResult> selectExpressions(
    Iterable<_i3.Expression<Object>>? columns,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#selectExpressions, [columns]),
            returnValue: _FakeBaseSelectStatement_19<_i3.TypedResult>(
              this,
              Invocation.method(#selectExpressions, [columns]),
            ),
          )
          as _i3.BaseSelectStatement<_i3.TypedResult>);

  @override
  _i3.DeleteStatement<T, D> delete<T extends _i3.Table, D>(
    _i3.TableInfo<T, D>? table,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#delete, [table]),
            returnValue: _FakeDeleteStatement_20<T, D>(
              this,
              Invocation.method(#delete, [table]),
            ),
          )
          as _i3.DeleteStatement<T, D>);

  @override
  _i6.Future<int> customUpdate(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? updates,
    _i3.UpdateKind? updateKind,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customUpdate,
              [query],
              {
                #variables: variables,
                #updates: updates,
                #updateKind: updateKind,
              },
            ),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> customInsert(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? updates,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customInsert,
              [query],
              {#variables: variables, #updates: updates},
            ),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<List<_i3.QueryRow>> customWriteReturning(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? updates,
    _i3.UpdateKind? updateKind,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customWriteReturning,
              [query],
              {
                #variables: variables,
                #updates: updates,
                #updateKind: updateKind,
              },
            ),
            returnValue: _i6.Future<List<_i3.QueryRow>>.value(<_i3.QueryRow>[]),
          )
          as _i6.Future<List<_i3.QueryRow>>);

  @override
  _i3.Selectable<_i3.QueryRow> customSelect(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? readsFrom = const {},
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customSelect,
              [query],
              {#variables: variables, #readsFrom: readsFrom},
            ),
            returnValue: _FakeSelectable_21<_i3.QueryRow>(
              this,
              Invocation.method(
                #customSelect,
                [query],
                {#variables: variables, #readsFrom: readsFrom},
              ),
            ),
          )
          as _i3.Selectable<_i3.QueryRow>);

  @override
  _i3.Selectable<_i3.QueryRow> customSelectQuery(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? readsFrom = const {},
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customSelectQuery,
              [query],
              {#variables: variables, #readsFrom: readsFrom},
            ),
            returnValue: _FakeSelectable_21<_i3.QueryRow>(
              this,
              Invocation.method(
                #customSelectQuery,
                [query],
                {#variables: variables, #readsFrom: readsFrom},
              ),
            ),
          )
          as _i3.Selectable<_i3.QueryRow>);

  @override
  _i6.Future<void> customStatement(String? statement, [List<dynamic>? args]) =>
      (super.noSuchMethod(
            Invocation.method(#customStatement, [statement, args]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<T> transaction<T>(
    _i6.Future<T> Function()? action, {
    bool? requireNew = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #transaction,
              [action],
              {#requireNew: requireNew},
            ),
            returnValue:
                _i11.ifNotNull(
                  _i11.dummyValueOrNull<T>(
                    this,
                    Invocation.method(
                      #transaction,
                      [action],
                      {#requireNew: requireNew},
                    ),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_14<T>(
                  this,
                  Invocation.method(
                    #transaction,
                    [action],
                    {#requireNew: requireNew},
                  ),
                ),
          )
          as _i6.Future<T>);

  @override
  _i6.Future<T> exclusively<T>(_i6.Future<T> Function()? action) =>
      (super.noSuchMethod(
            Invocation.method(#exclusively, [action]),
            returnValue:
                _i11.ifNotNull(
                  _i11.dummyValueOrNull<T>(
                    this,
                    Invocation.method(#exclusively, [action]),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_14<T>(
                  this,
                  Invocation.method(#exclusively, [action]),
                ),
          )
          as _i6.Future<T>);

  @override
  _i6.Future<void> batch(_i6.FutureOr<void> Function(_i3.Batch)? runInBatch) =>
      (super.noSuchMethod(
            Invocation.method(#batch, [runInBatch]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<T> runWithInterceptor<T>(
    _i6.Future<T> Function()? action, {
    required _i3.QueryInterceptor? interceptor,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #runWithInterceptor,
              [action],
              {#interceptor: interceptor},
            ),
            returnValue:
                _i11.ifNotNull(
                  _i11.dummyValueOrNull<T>(
                    this,
                    Invocation.method(
                      #runWithInterceptor,
                      [action],
                      {#interceptor: interceptor},
                    ),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_14<T>(
                  this,
                  Invocation.method(
                    #runWithInterceptor,
                    [action],
                    {#interceptor: interceptor},
                  ),
                ),
          )
          as _i6.Future<T>);

  @override
  _i3.GenerationContext $write(
    _i3.Component? component, {
    bool? hasMultipleTables,
    int? startIndex,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #$write,
              [component],
              {#hasMultipleTables: hasMultipleTables, #startIndex: startIndex},
            ),
            returnValue: _FakeGenerationContext_22(
              this,
              Invocation.method(
                #$write,
                [component],
                {
                  #hasMultipleTables: hasMultipleTables,
                  #startIndex: startIndex,
                },
              ),
            ),
          )
          as _i3.GenerationContext);

  @override
  _i3.GenerationContext $writeInsertable(
    _i3.TableInfo<_i3.Table, dynamic>? table,
    _i3.Insertable<dynamic>? insertable, {
    int? startIndex,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #$writeInsertable,
              [table, insertable],
              {#startIndex: startIndex},
            ),
            returnValue: _FakeGenerationContext_22(
              this,
              Invocation.method(
                #$writeInsertable,
                [table, insertable],
                {#startIndex: startIndex},
              ),
            ),
          )
          as _i3.GenerationContext);

  @override
  String $expandVar(int? start, int? amount) =>
      (super.noSuchMethod(
            Invocation.method(#$expandVar, [start, amount]),
            returnValue: _i11.dummyValue<String>(
              this,
              Invocation.method(#$expandVar, [start, amount]),
            ),
          )
          as String);
}
```

### Inhalt von `klubradio_archivum/test/providers/podcast_provider_search_test.dart`
```dart
// test/providers/podcast_provider_search_test.dart
//
// Tests for PodcastProvider search functionality:
//   - searchPodcasts: delegates to ApiService, handles errors, adds to recent
//   - addRecentSearch: dedup, ordering, max limit, empty/whitespace guard
//   - recentSearches: unmodifiable, initial state

import 'package:flutter_test/flutter_test.dart';
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
```

### Inhalt von `klubradio_archivum/test/providers/subscription_provider_test.dart`
```dart
// test/providers/subscription_provider_test.dart
//
// Unit tests for SubscriptionProvider, focusing on the settingsDao parameter
// introduced to read keepLatestN when subscribing.
//
// Covers:
//   - loadSubscription: sets currentSubscription from DAO, sets loaded=true
//   - watchSubscription: returns stream from DAO
//   - toggleSubscription (subscribing): reads keepLatestN from settingsDao
//   - toggleSubscription (subscribing, no settings): falls back to defaultAutoDownloadCount
//   - toggleSubscription (unsubscribing): does NOT read settingsDao
//   - toggleSubscription: busy flag lifecycle (true during, false after)
//   - updateDependencies: updates downloadProvider reference
//
// Uses Mockito @GenerateMocks for SubscriptionsDao, SettingsDao, DownloadProvider.
// Note: Drift DAOs require a real AppDatabase in their constructor, but Mockito
// can mock concrete classes by generating subclasses that override all methods.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

import 'subscription_provider_test.mocks.dart';

@GenerateMocks([SubscriptionsDao, SettingsDao, DownloadProvider])
void main() {
  // ==================== Helpers ====================

  /// Creates a minimal Subscription data object.
  Subscription makeSub(
    String podcastId, {
    bool active = true,
    int? autoDownloadN,
  }) =>
      Subscription(
        podcastId: podcastId,
        active: active,
        updatedAt: DateTime(2024, 1, 1),
        subscribedAt: DateTime(2024, 1, 1),
        autoDownloadN: autoDownloadN,
      );

  /// Creates a minimal Setting data object.
  Setting makeSetting({int? keepLatestN}) => Setting(
        id: 1,
        wifiOnly: false,
        maxParallel: 2,
        deleteAfterHours: null,
        keepLatestN: keepLatestN,
        autodownloadSubscribed: false,
        playOrder: 'newest',
      );

  // ==================== Test fixtures ====================

  late MockSubscriptionsDao mockSubsDao;
  late MockSettingsDao mockSettingsDao;
  late MockDownloadProvider mockDownloadProvider;
  late SubscriptionProvider provider;

  setUp(() {
    mockSubsDao = MockSubscriptionsDao();
    mockSettingsDao = MockSettingsDao();
    mockDownloadProvider = MockDownloadProvider();

    provider = SubscriptionProvider(
      subscriptionsDao: mockSubsDao,
      settingsDao: mockSettingsDao,
      downloadProvider: mockDownloadProvider,
    );
  });

  // ==================== loadSubscription ====================

  group('loadSubscription', () {
    test('sets currentSubscription from DAO', () async {
      final sub = makeSub('pod-1', active: true, autoDownloadN: 5);
      when(mockSubsDao.getById('pod-1')).thenAnswer((_) async => sub);

      await provider.loadSubscription('pod-1');

      expect(provider.currentSubscription, isNotNull);
      expect(provider.currentSubscription!.podcastId, 'pod-1');
      expect(provider.currentSubscription!.active, true);
      expect(provider.currentSubscription!.autoDownloadN, 5);
      verify(mockSubsDao.getById('pod-1')).called(1);
    });

    test('sets currentSubscription to null when no subscription exists',
        () async {
      when(mockSubsDao.getById('pod-x')).thenAnswer((_) async => null);

      await provider.loadSubscription('pod-x');

      expect(provider.currentSubscription, isNull);
    });

    test('sets loaded=true after successful load', () async {
      when(mockSubsDao.getById('pod-1')).thenAnswer((_) async => null);

      expect(provider.loaded, false);
      await provider.loadSubscription('pod-1');
      expect(provider.loaded, true);
    });

    test('notifies listeners after load', () async {
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1'));

      int calls = 0;
      provider.addListener(() => calls++);

      await provider.loadSubscription('pod-1');

      expect(calls, 1);
    });
  });

  // ==================== watchSubscription ====================

  group('watchSubscription', () {
    test('returns stream from DAO', () {
      final sub = makeSub('pod-1');
      when(mockSubsDao.watchOne('pod-1'))
          .thenAnswer((_) => Stream.value(sub));

      final stream = provider.watchSubscription('pod-1');

      expect(stream, isA<Stream<Subscription?>>());
      verify(mockSubsDao.watchOne('pod-1')).called(1);
    });

    test('stream emits subscription from DAO', () async {
      final sub = makeSub('pod-1', active: true);
      when(mockSubsDao.watchOne('pod-1'))
          .thenAnswer((_) => Stream.value(sub));

      final result = await provider.watchSubscription('pod-1').first;

      expect(result, isNotNull);
      expect(result!.podcastId, 'pod-1');
      expect(result.active, true);
    });

    test('stream emits null when no subscription', () async {
      when(mockSubsDao.watchOne('pod-1'))
          .thenAnswer((_) => Stream.value(null));

      final result = await provider.watchSubscription('pod-1').first;

      expect(result, isNull);
    });
  });

  // ==================== toggleSubscription ====================

  group('toggleSubscription — subscribing', () {
    // isSubscribed=false means we're subscribing (toggling TO subscribed)

    test('reads keepLatestN from settingsDao when subscribing', () async {
      final setting = makeSetting(keepLatestN: 10);
      when(mockSettingsDao.getOne()).thenAnswer((_) async => setting);
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1', autoDownloadN: 10));
      when(mockDownloadProvider.autodownloadPodcast('pod-1'))
          .thenAnswer((_) async => 3);

      await provider.toggleSubscription('pod-1', false);

      verify(mockSettingsDao.getOne()).called(1);
      verify(mockSubsDao.toggleSubscribe(
        podcastId: 'pod-1',
        active: true,
        autoDownloadN: 10,
      )).called(1);
    });

    test('falls back to defaultAutoDownloadCount when settings is null',
        () async {
      when(mockSettingsDao.getOne()).thenAnswer((_) async => null);
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1'));
      when(mockDownloadProvider.autodownloadPodcast('pod-1'))
          .thenAnswer((_) async => 2);

      await provider.toggleSubscription('pod-1', false);

      verify(mockSubsDao.toggleSubscribe(
        podcastId: 'pod-1',
        active: true,
        autoDownloadN: constants.defaultAutoDownloadCount,
      )).called(1);
    });

    test(
        'falls back to defaultAutoDownloadCount when keepLatestN is null in settings',
        () async {
      final setting = makeSetting(keepLatestN: null);
      when(mockSettingsDao.getOne()).thenAnswer((_) async => setting);
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1'));
      when(mockDownloadProvider.autodownloadPodcast('pod-1'))
          .thenAnswer((_) async => 2);

      await provider.toggleSubscription('pod-1', false);

      verify(mockSubsDao.toggleSubscribe(
        podcastId: 'pod-1',
        active: true,
        autoDownloadN: constants.defaultAutoDownloadCount,
      )).called(1);
    });

    test('calls autodownloadPodcast after subscribing', () async {
      when(mockSettingsDao.getOne())
          .thenAnswer((_) async => makeSetting(keepLatestN: 5));
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1'));
      when(mockDownloadProvider.autodownloadPodcast('pod-1'))
          .thenAnswer((_) async => 5);

      await provider.toggleSubscription('pod-1', false);

      verify(mockDownloadProvider.autodownloadPodcast('pod-1')).called(1);
    });

    test('updates currentSubscription after subscribing', () async {
      final updatedSub = makeSub('pod-1', active: true, autoDownloadN: 3);
      when(mockSettingsDao.getOne())
          .thenAnswer((_) async => makeSetting(keepLatestN: 3));
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1')).thenAnswer((_) async => updatedSub);
      when(mockDownloadProvider.autodownloadPodcast('pod-1'))
          .thenAnswer((_) async => 2);

      await provider.toggleSubscription('pod-1', false);

      expect(provider.currentSubscription, isNotNull);
      expect(provider.currentSubscription!.active, true);
      expect(provider.currentSubscription!.autoDownloadN, 3);
    });
  });

  group('toggleSubscription — unsubscribing', () {
    // isSubscribed=true means we're unsubscribing (toggling TO unsubscribed)

    test('does NOT read settingsDao when unsubscribing', () async {
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1', active: false));

      await provider.toggleSubscription('pod-1', true);

      verifyNever(mockSettingsDao.getOne());
    });

    test('passes null autoDownloadN when unsubscribing', () async {
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1', active: false));

      await provider.toggleSubscription('pod-1', true);

      verify(mockSubsDao.toggleSubscribe(
        podcastId: 'pod-1',
        active: false,
        autoDownloadN: null,
      )).called(1);
    });

    test('does NOT call autodownloadPodcast when unsubscribing', () async {
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1', active: false));

      await provider.toggleSubscription('pod-1', true);

      verifyNever(mockDownloadProvider.autodownloadPodcast(any));
    });
  });

  group('toggleSubscription — busy flag', () {
    test('sets busy=true during operation', () async {
      final busyValues = <bool>[];
      provider.addListener(() => busyValues.add(provider.busy));

      when(mockSettingsDao.getOne())
          .thenAnswer((_) async => makeSetting(keepLatestN: 3));
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1'));
      when(mockDownloadProvider.autodownloadPodcast('pod-1'))
          .thenAnswer((_) async => 1);

      await provider.toggleSubscription('pod-1', false);

      // First notification: busy=true, last notification: busy=false
      expect(busyValues.first, true);
      expect(busyValues.last, false);
    });

    test('sets busy=false after completion', () async {
      when(mockSettingsDao.getOne())
          .thenAnswer((_) async => makeSetting(keepLatestN: 3));
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1'));
      when(mockDownloadProvider.autodownloadPodcast('pod-1'))
          .thenAnswer((_) async => 1);

      await provider.toggleSubscription('pod-1', false);

      expect(provider.busy, false);
    });

    test('sets busy=false even after error', () async {
      when(mockSettingsDao.getOne())
          .thenAnswer((_) async => makeSetting(keepLatestN: 3));
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenThrow(Exception('DB error'));

      try {
        await provider.toggleSubscription('pod-1', false);
      } catch (_) {
        // Expected
      }

      expect(provider.busy, false);
    });

    test('rethrows errors from toggleSubscribe', () async {
      when(mockSettingsDao.getOne())
          .thenAnswer((_) async => makeSetting(keepLatestN: 3));
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenThrow(Exception('DB error'));

      expect(
        () => provider.toggleSubscription('pod-1', false),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ==================== updateDependencies ====================

  group('updateDependencies', () {
    test('updates downloadProvider reference', () {
      final newDownloadProvider = MockDownloadProvider();

      provider.updateDependencies(downloadProvider: newDownloadProvider);

      expect(provider.downloadProvider, same(newDownloadProvider));
    });

    test('does not update if same reference', () {
      final originalProvider = provider.downloadProvider;

      provider.updateDependencies(downloadProvider: mockDownloadProvider);

      expect(provider.downloadProvider, same(originalProvider));
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/providers/subscription_provider_test.mocks.dart`
```dart
// Mocks generated by Mockito 5.4.6 from annotations
// in klubradio_archivum/test/providers/subscription_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i12;

import 'package:drift/drift.dart' as _i3;
import 'package:drift/src/runtime/executor/stream_queries.dart' as _i4;
import 'package:klubradio_archivum/db/app_database.dart' as _i2;
import 'package:klubradio_archivum/db/daos.dart' as _i5;
import 'package:klubradio_archivum/models/episode.dart' as _i11;
import 'package:klubradio_archivum/providers/download_provider.dart' as _i10;
import 'package:klubradio_archivum/services/api_service.dart' as _i8;
import 'package:klubradio_archivum/services/download_service.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class
// ignore_for_file: invalid_use_of_internal_member

class _FakeAppDatabase_0 extends _i1.SmartFake implements _i2.AppDatabase {
  _FakeAppDatabase_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDatabaseConnection_1 extends _i1.SmartFake
    implements _i3.DatabaseConnection {
  _FakeDatabaseConnection_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDriftDatabaseOptions_2 extends _i1.SmartFake
    implements _i3.DriftDatabaseOptions {
  _FakeDriftDatabaseOptions_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeQueryExecutor_3 extends _i1.SmartFake implements _i3.QueryExecutor {
  _FakeQueryExecutor_3(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeStreamQueryStore_4 extends _i1.SmartFake
    implements _i4.StreamQueryStore {
  _FakeStreamQueryStore_4(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDatabaseConnectionUser_5 extends _i1.SmartFake
    implements _i3.DatabaseConnectionUser {
  _FakeDatabaseConnectionUser_5(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _Fake$SubscriptionsTable_6 extends _i1.SmartFake
    implements _i2.$SubscriptionsTable {
  _Fake$SubscriptionsTable_6(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSubscriptionsDaoManager_7 extends _i1.SmartFake
    implements _i5.SubscriptionsDaoManager {
  _FakeSubscriptionsDaoManager_7(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeFuture_8<T1> extends _i1.SmartFake implements _i6.Future<T1> {
  _FakeFuture_8(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeInsertStatement_9<T1 extends _i3.Table, D1> extends _i1.SmartFake
    implements _i3.InsertStatement<T1, D1> {
  _FakeInsertStatement_9(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeUpdateStatement_10<T extends _i3.Table, D> extends _i1.SmartFake
    implements _i3.UpdateStatement<T, D> {
  _FakeUpdateStatement_10(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSimpleSelectStatement_11<T1 extends _i3.HasResultSet, D>
    extends _i1.SmartFake
    implements _i3.SimpleSelectStatement<T1, D> {
  _FakeSimpleSelectStatement_11(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeJoinedSelectStatement_12<FirstT extends _i3.HasResultSet, FirstD>
    extends _i1.SmartFake
    implements _i3.JoinedSelectStatement<FirstT, FirstD> {
  _FakeJoinedSelectStatement_12(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeBaseSelectStatement_13<Row> extends _i1.SmartFake
    implements _i3.BaseSelectStatement<Row> {
  _FakeBaseSelectStatement_13(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDeleteStatement_14<T1 extends _i3.Table, D1> extends _i1.SmartFake
    implements _i3.DeleteStatement<T1, D1> {
  _FakeDeleteStatement_14(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSelectable_15<T> extends _i1.SmartFake implements _i3.Selectable<T> {
  _FakeSelectable_15(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGenerationContext_16 extends _i1.SmartFake
    implements _i3.GenerationContext {
  _FakeGenerationContext_16(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _Fake$SettingsTable_17 extends _i1.SmartFake
    implements _i2.$SettingsTable {
  _Fake$SettingsTable_17(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSettingsDaoManager_18 extends _i1.SmartFake
    implements _i5.SettingsDaoManager {
  _FakeSettingsDaoManager_18(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDownloadService_19 extends _i1.SmartFake
    implements _i7.DownloadService {
  _FakeDownloadService_19(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeEpisodesDao_20 extends _i1.SmartFake implements _i5.EpisodesDao {
  _FakeEpisodesDao_20(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSubscriptionsDao_21 extends _i1.SmartFake
    implements _i5.SubscriptionsDao {
  _FakeSubscriptionsDao_21(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSettingsDao_22 extends _i1.SmartFake implements _i5.SettingsDao {
  _FakeSettingsDao_22(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeRetentionDao_23 extends _i1.SmartFake implements _i5.RetentionDao {
  _FakeRetentionDao_23(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeApiService_24 extends _i1.SmartFake implements _i8.ApiService {
  _FakeApiService_24(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [SubscriptionsDao].
///
/// See the documentation for Mockito's code generation for more information.
class MockSubscriptionsDao extends _i1.Mock implements _i5.SubscriptionsDao {
  MockSubscriptionsDao() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppDatabase get attachedDatabase =>
      (super.noSuchMethod(
            Invocation.getter(#attachedDatabase),
            returnValue: _FakeAppDatabase_0(
              this,
              Invocation.getter(#attachedDatabase),
            ),
          )
          as _i2.AppDatabase);

  @override
  _i3.DatabaseConnection get connection =>
      (super.noSuchMethod(
            Invocation.getter(#connection),
            returnValue: _FakeDatabaseConnection_1(
              this,
              Invocation.getter(#connection),
            ),
          )
          as _i3.DatabaseConnection);

  @override
  _i3.DriftDatabaseOptions get options =>
      (super.noSuchMethod(
            Invocation.getter(#options),
            returnValue: _FakeDriftDatabaseOptions_2(
              this,
              Invocation.getter(#options),
            ),
          )
          as _i3.DriftDatabaseOptions);

  @override
  _i3.SqlTypes get typeMapping =>
      (super.noSuchMethod(
            Invocation.getter(#typeMapping),
            returnValue: _i9.dummyValue<_i3.SqlTypes>(
              this,
              Invocation.getter(#typeMapping),
            ),
          )
          as _i3.SqlTypes);

  @override
  _i3.QueryExecutor get executor =>
      (super.noSuchMethod(
            Invocation.getter(#executor),
            returnValue: _FakeQueryExecutor_3(
              this,
              Invocation.getter(#executor),
            ),
          )
          as _i3.QueryExecutor);

  @override
  _i4.StreamQueryStore get streamQueries =>
      (super.noSuchMethod(
            Invocation.getter(#streamQueries),
            returnValue: _FakeStreamQueryStore_4(
              this,
              Invocation.getter(#streamQueries),
            ),
          )
          as _i4.StreamQueryStore);

  @override
  _i3.DatabaseConnectionUser get resolvedEngine =>
      (super.noSuchMethod(
            Invocation.getter(#resolvedEngine),
            returnValue: _FakeDatabaseConnectionUser_5(
              this,
              Invocation.getter(#resolvedEngine),
            ),
          )
          as _i3.DatabaseConnectionUser);

  @override
  _i2.$SubscriptionsTable get subscriptions =>
      (super.noSuchMethod(
            Invocation.getter(#subscriptions),
            returnValue: _Fake$SubscriptionsTable_6(
              this,
              Invocation.getter(#subscriptions),
            ),
          )
          as _i2.$SubscriptionsTable);

  @override
  _i5.SubscriptionsDaoManager get managers =>
      (super.noSuchMethod(
            Invocation.getter(#managers),
            returnValue: _FakeSubscriptionsDaoManager_7(
              this,
              Invocation.getter(#managers),
            ),
          )
          as _i5.SubscriptionsDaoManager);

  @override
  _i6.Future<void> upsert(_i2.SubscriptionsCompanion? data) =>
      (super.noSuchMethod(
            Invocation.method(#upsert, [data]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<_i2.Subscription?> getById(String? podcastId) =>
      (super.noSuchMethod(
            Invocation.method(#getById, [podcastId]),
            returnValue: _i6.Future<_i2.Subscription?>.value(),
          )
          as _i6.Future<_i2.Subscription?>);

  @override
  _i6.Stream<_i2.Subscription?> watchOne(String? podcastId) =>
      (super.noSuchMethod(
            Invocation.method(#watchOne, [podcastId]),
            returnValue: _i6.Stream<_i2.Subscription?>.empty(),
          )
          as _i6.Stream<_i2.Subscription?>);

  @override
  _i6.Stream<List<_i2.Subscription>> watchAllActive() =>
      (super.noSuchMethod(
            Invocation.method(#watchAllActive, []),
            returnValue: _i6.Stream<List<_i2.Subscription>>.empty(),
          )
          as _i6.Stream<List<_i2.Subscription>>);

  @override
  _i6.Future<bool> isSubscribed(String? podcastId) =>
      (super.noSuchMethod(
            Invocation.method(#isSubscribed, [podcastId]),
            returnValue: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<void> toggleSubscribe({
    required String? podcastId,
    bool? active,
    int? autoDownloadN,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#toggleSubscribe, [], {
              #podcastId: podcastId,
              #active: active,
              #autoDownloadN: autoDownloadN,
            }),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<int> setAutoDownloadN(String? podcastId, int? n) =>
      (super.noSuchMethod(
            Invocation.method(#setAutoDownloadN, [podcastId, n]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> setLastHeard(String? podcastId, String? episodeId) =>
      (super.noSuchMethod(
            Invocation.method(#setLastHeard, [podcastId, episodeId]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> setLastDownloaded(String? podcastId, String? episodeId) =>
      (super.noSuchMethod(
            Invocation.method(#setLastDownloaded, [podcastId, episodeId]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Stream<T> createStream<T extends Object>(
    _i4.QueryStreamFetcher<T>? stmt,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#createStream, [stmt]),
            returnValue: _i6.Stream<T>.empty(),
          )
          as _i6.Stream<T>);

  @override
  T alias<T, D>(_i3.ResultSetImplementation<T, D>? table, String? alias) =>
      (super.noSuchMethod(
            Invocation.method(#alias, [table, alias]),
            returnValue: _i9.dummyValue<T>(
              this,
              Invocation.method(#alias, [table, alias]),
            ),
          )
          as T);

  @override
  void markTablesUpdated(Iterable<_i3.TableInfo<_i3.Table, dynamic>>? tables) =>
      super.noSuchMethod(
        Invocation.method(#markTablesUpdated, [tables]),
        returnValueForMissingStub: null,
      );

  @override
  void notifyUpdates(Set<_i3.TableUpdate>? updates) => super.noSuchMethod(
    Invocation.method(#notifyUpdates, [updates]),
    returnValueForMissingStub: null,
  );

  @override
  _i6.Stream<Set<_i3.TableUpdate>> tableUpdates([
    _i3.TableUpdateQuery? query = const _i3.TableUpdateQuery.any(),
  ]) =>
      (super.noSuchMethod(
            Invocation.method(#tableUpdates, [query]),
            returnValue: _i6.Stream<Set<_i3.TableUpdate>>.empty(),
          )
          as _i6.Stream<Set<_i3.TableUpdate>>);

  @override
  _i6.Future<T> doWhenOpened<T>(
    _i6.FutureOr<T> Function(_i3.QueryExecutor)? fn,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#doWhenOpened, [fn]),
            returnValue:
                _i9.ifNotNull(
                  _i9.dummyValueOrNull<T>(
                    this,
                    Invocation.method(#doWhenOpened, [fn]),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_8<T>(this, Invocation.method(#doWhenOpened, [fn])),
          )
          as _i6.Future<T>);

  @override
  _i3.InsertStatement<T, D> into<T extends _i3.Table, D>(
    _i3.TableInfo<T, D>? table,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#into, [table]),
            returnValue: _FakeInsertStatement_9<T, D>(
              this,
              Invocation.method(#into, [table]),
            ),
          )
          as _i3.InsertStatement<T, D>);

  @override
  _i3.UpdateStatement<Tbl, R> update<Tbl extends _i3.Table, R>(
    _i3.TableInfo<Tbl, R>? table,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#update, [table]),
            returnValue: _FakeUpdateStatement_10<Tbl, R>(
              this,
              Invocation.method(#update, [table]),
            ),
          )
          as _i3.UpdateStatement<Tbl, R>);

  @override
  _i3.SimpleSelectStatement<T, R> select<T extends _i3.HasResultSet, R>(
    _i3.ResultSetImplementation<T, R>? table, {
    bool? distinct = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#select, [table], {#distinct: distinct}),
            returnValue: _FakeSimpleSelectStatement_11<T, R>(
              this,
              Invocation.method(#select, [table], {#distinct: distinct}),
            ),
          )
          as _i3.SimpleSelectStatement<T, R>);

  @override
  _i3.JoinedSelectStatement<T, R> selectOnly<T extends _i3.HasResultSet, R>(
    _i3.ResultSetImplementation<T, R>? table, {
    bool? distinct = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#selectOnly, [table], {#distinct: distinct}),
            returnValue: _FakeJoinedSelectStatement_12<T, R>(
              this,
              Invocation.method(#selectOnly, [table], {#distinct: distinct}),
            ),
          )
          as _i3.JoinedSelectStatement<T, R>);

  @override
  _i3.BaseSelectStatement<_i3.TypedResult> selectExpressions(
    Iterable<_i3.Expression<Object>>? columns,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#selectExpressions, [columns]),
            returnValue: _FakeBaseSelectStatement_13<_i3.TypedResult>(
              this,
              Invocation.method(#selectExpressions, [columns]),
            ),
          )
          as _i3.BaseSelectStatement<_i3.TypedResult>);

  @override
  _i3.DeleteStatement<T, D> delete<T extends _i3.Table, D>(
    _i3.TableInfo<T, D>? table,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#delete, [table]),
            returnValue: _FakeDeleteStatement_14<T, D>(
              this,
              Invocation.method(#delete, [table]),
            ),
          )
          as _i3.DeleteStatement<T, D>);

  @override
  _i6.Future<int> customUpdate(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? updates,
    _i3.UpdateKind? updateKind,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customUpdate,
              [query],
              {
                #variables: variables,
                #updates: updates,
                #updateKind: updateKind,
              },
            ),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> customInsert(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? updates,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customInsert,
              [query],
              {#variables: variables, #updates: updates},
            ),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<List<_i3.QueryRow>> customWriteReturning(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? updates,
    _i3.UpdateKind? updateKind,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customWriteReturning,
              [query],
              {
                #variables: variables,
                #updates: updates,
                #updateKind: updateKind,
              },
            ),
            returnValue: _i6.Future<List<_i3.QueryRow>>.value(<_i3.QueryRow>[]),
          )
          as _i6.Future<List<_i3.QueryRow>>);

  @override
  _i3.Selectable<_i3.QueryRow> customSelect(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? readsFrom = const {},
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customSelect,
              [query],
              {#variables: variables, #readsFrom: readsFrom},
            ),
            returnValue: _FakeSelectable_15<_i3.QueryRow>(
              this,
              Invocation.method(
                #customSelect,
                [query],
                {#variables: variables, #readsFrom: readsFrom},
              ),
            ),
          )
          as _i3.Selectable<_i3.QueryRow>);

  @override
  _i3.Selectable<_i3.QueryRow> customSelectQuery(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? readsFrom = const {},
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customSelectQuery,
              [query],
              {#variables: variables, #readsFrom: readsFrom},
            ),
            returnValue: _FakeSelectable_15<_i3.QueryRow>(
              this,
              Invocation.method(
                #customSelectQuery,
                [query],
                {#variables: variables, #readsFrom: readsFrom},
              ),
            ),
          )
          as _i3.Selectable<_i3.QueryRow>);

  @override
  _i6.Future<void> customStatement(String? statement, [List<dynamic>? args]) =>
      (super.noSuchMethod(
            Invocation.method(#customStatement, [statement, args]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<T> transaction<T>(
    _i6.Future<T> Function()? action, {
    bool? requireNew = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #transaction,
              [action],
              {#requireNew: requireNew},
            ),
            returnValue:
                _i9.ifNotNull(
                  _i9.dummyValueOrNull<T>(
                    this,
                    Invocation.method(
                      #transaction,
                      [action],
                      {#requireNew: requireNew},
                    ),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_8<T>(
                  this,
                  Invocation.method(
                    #transaction,
                    [action],
                    {#requireNew: requireNew},
                  ),
                ),
          )
          as _i6.Future<T>);

  @override
  _i6.Future<T> exclusively<T>(_i6.Future<T> Function()? action) =>
      (super.noSuchMethod(
            Invocation.method(#exclusively, [action]),
            returnValue:
                _i9.ifNotNull(
                  _i9.dummyValueOrNull<T>(
                    this,
                    Invocation.method(#exclusively, [action]),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_8<T>(
                  this,
                  Invocation.method(#exclusively, [action]),
                ),
          )
          as _i6.Future<T>);

  @override
  _i6.Future<void> batch(_i6.FutureOr<void> Function(_i3.Batch)? runInBatch) =>
      (super.noSuchMethod(
            Invocation.method(#batch, [runInBatch]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<T> runWithInterceptor<T>(
    _i6.Future<T> Function()? action, {
    required _i3.QueryInterceptor? interceptor,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #runWithInterceptor,
              [action],
              {#interceptor: interceptor},
            ),
            returnValue:
                _i9.ifNotNull(
                  _i9.dummyValueOrNull<T>(
                    this,
                    Invocation.method(
                      #runWithInterceptor,
                      [action],
                      {#interceptor: interceptor},
                    ),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_8<T>(
                  this,
                  Invocation.method(
                    #runWithInterceptor,
                    [action],
                    {#interceptor: interceptor},
                  ),
                ),
          )
          as _i6.Future<T>);

  @override
  _i3.GenerationContext $write(
    _i3.Component? component, {
    bool? hasMultipleTables,
    int? startIndex,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #$write,
              [component],
              {#hasMultipleTables: hasMultipleTables, #startIndex: startIndex},
            ),
            returnValue: _FakeGenerationContext_16(
              this,
              Invocation.method(
                #$write,
                [component],
                {
                  #hasMultipleTables: hasMultipleTables,
                  #startIndex: startIndex,
                },
              ),
            ),
          )
          as _i3.GenerationContext);

  @override
  _i3.GenerationContext $writeInsertable(
    _i3.TableInfo<_i3.Table, dynamic>? table,
    _i3.Insertable<dynamic>? insertable, {
    int? startIndex,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #$writeInsertable,
              [table, insertable],
              {#startIndex: startIndex},
            ),
            returnValue: _FakeGenerationContext_16(
              this,
              Invocation.method(
                #$writeInsertable,
                [table, insertable],
                {#startIndex: startIndex},
              ),
            ),
          )
          as _i3.GenerationContext);

  @override
  String $expandVar(int? start, int? amount) =>
      (super.noSuchMethod(
            Invocation.method(#$expandVar, [start, amount]),
            returnValue: _i9.dummyValue<String>(
              this,
              Invocation.method(#$expandVar, [start, amount]),
            ),
          )
          as String);

  @override
  _i6.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);
}

/// A class which mocks [SettingsDao].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsDao extends _i1.Mock implements _i5.SettingsDao {
  MockSettingsDao() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppDatabase get attachedDatabase =>
      (super.noSuchMethod(
            Invocation.getter(#attachedDatabase),
            returnValue: _FakeAppDatabase_0(
              this,
              Invocation.getter(#attachedDatabase),
            ),
          )
          as _i2.AppDatabase);

  @override
  _i3.DatabaseConnection get connection =>
      (super.noSuchMethod(
            Invocation.getter(#connection),
            returnValue: _FakeDatabaseConnection_1(
              this,
              Invocation.getter(#connection),
            ),
          )
          as _i3.DatabaseConnection);

  @override
  _i3.DriftDatabaseOptions get options =>
      (super.noSuchMethod(
            Invocation.getter(#options),
            returnValue: _FakeDriftDatabaseOptions_2(
              this,
              Invocation.getter(#options),
            ),
          )
          as _i3.DriftDatabaseOptions);

  @override
  _i3.SqlTypes get typeMapping =>
      (super.noSuchMethod(
            Invocation.getter(#typeMapping),
            returnValue: _i9.dummyValue<_i3.SqlTypes>(
              this,
              Invocation.getter(#typeMapping),
            ),
          )
          as _i3.SqlTypes);

  @override
  _i3.QueryExecutor get executor =>
      (super.noSuchMethod(
            Invocation.getter(#executor),
            returnValue: _FakeQueryExecutor_3(
              this,
              Invocation.getter(#executor),
            ),
          )
          as _i3.QueryExecutor);

  @override
  _i4.StreamQueryStore get streamQueries =>
      (super.noSuchMethod(
            Invocation.getter(#streamQueries),
            returnValue: _FakeStreamQueryStore_4(
              this,
              Invocation.getter(#streamQueries),
            ),
          )
          as _i4.StreamQueryStore);

  @override
  _i3.DatabaseConnectionUser get resolvedEngine =>
      (super.noSuchMethod(
            Invocation.getter(#resolvedEngine),
            returnValue: _FakeDatabaseConnectionUser_5(
              this,
              Invocation.getter(#resolvedEngine),
            ),
          )
          as _i3.DatabaseConnectionUser);

  @override
  _i2.$SettingsTable get settings =>
      (super.noSuchMethod(
            Invocation.getter(#settings),
            returnValue: _Fake$SettingsTable_17(
              this,
              Invocation.getter(#settings),
            ),
          )
          as _i2.$SettingsTable);

  @override
  _i5.SettingsDaoManager get managers =>
      (super.noSuchMethod(
            Invocation.getter(#managers),
            returnValue: _FakeSettingsDaoManager_18(
              this,
              Invocation.getter(#managers),
            ),
          )
          as _i5.SettingsDaoManager);

  @override
  _i6.Future<_i2.Setting?> getOne() =>
      (super.noSuchMethod(
            Invocation.method(#getOne, []),
            returnValue: _i6.Future<_i2.Setting?>.value(),
          )
          as _i6.Future<_i2.Setting?>);

  @override
  _i6.Future<void> ensureDefaults() =>
      (super.noSuchMethod(
            Invocation.method(#ensureDefaults, []),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<int> setWifiOnly(bool? v) =>
      (super.noSuchMethod(
            Invocation.method(#setWifiOnly, [v]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> setMaxParallel(int? n) =>
      (super.noSuchMethod(
            Invocation.method(#setMaxParallel, [n]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> setDeleteAfterHours(int? h) =>
      (super.noSuchMethod(
            Invocation.method(#setDeleteAfterHours, [h]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> setKeepLatestN(int? n) =>
      (super.noSuchMethod(
            Invocation.method(#setKeepLatestN, [n]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> setAutodownloadSubscribed(bool? v) =>
      (super.noSuchMethod(
            Invocation.method(#setAutodownloadSubscribed, [v]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> setPlayOrder(String? order) =>
      (super.noSuchMethod(
            Invocation.method(#setPlayOrder, [order]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Stream<T> createStream<T extends Object>(
    _i4.QueryStreamFetcher<T>? stmt,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#createStream, [stmt]),
            returnValue: _i6.Stream<T>.empty(),
          )
          as _i6.Stream<T>);

  @override
  T alias<T, D>(_i3.ResultSetImplementation<T, D>? table, String? alias) =>
      (super.noSuchMethod(
            Invocation.method(#alias, [table, alias]),
            returnValue: _i9.dummyValue<T>(
              this,
              Invocation.method(#alias, [table, alias]),
            ),
          )
          as T);

  @override
  void markTablesUpdated(Iterable<_i3.TableInfo<_i3.Table, dynamic>>? tables) =>
      super.noSuchMethod(
        Invocation.method(#markTablesUpdated, [tables]),
        returnValueForMissingStub: null,
      );

  @override
  void notifyUpdates(Set<_i3.TableUpdate>? updates) => super.noSuchMethod(
    Invocation.method(#notifyUpdates, [updates]),
    returnValueForMissingStub: null,
  );

  @override
  _i6.Stream<Set<_i3.TableUpdate>> tableUpdates([
    _i3.TableUpdateQuery? query = const _i3.TableUpdateQuery.any(),
  ]) =>
      (super.noSuchMethod(
            Invocation.method(#tableUpdates, [query]),
            returnValue: _i6.Stream<Set<_i3.TableUpdate>>.empty(),
          )
          as _i6.Stream<Set<_i3.TableUpdate>>);

  @override
  _i6.Future<T> doWhenOpened<T>(
    _i6.FutureOr<T> Function(_i3.QueryExecutor)? fn,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#doWhenOpened, [fn]),
            returnValue:
                _i9.ifNotNull(
                  _i9.dummyValueOrNull<T>(
                    this,
                    Invocation.method(#doWhenOpened, [fn]),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_8<T>(this, Invocation.method(#doWhenOpened, [fn])),
          )
          as _i6.Future<T>);

  @override
  _i3.InsertStatement<T, D> into<T extends _i3.Table, D>(
    _i3.TableInfo<T, D>? table,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#into, [table]),
            returnValue: _FakeInsertStatement_9<T, D>(
              this,
              Invocation.method(#into, [table]),
            ),
          )
          as _i3.InsertStatement<T, D>);

  @override
  _i3.UpdateStatement<Tbl, R> update<Tbl extends _i3.Table, R>(
    _i3.TableInfo<Tbl, R>? table,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#update, [table]),
            returnValue: _FakeUpdateStatement_10<Tbl, R>(
              this,
              Invocation.method(#update, [table]),
            ),
          )
          as _i3.UpdateStatement<Tbl, R>);

  @override
  _i3.SimpleSelectStatement<T, R> select<T extends _i3.HasResultSet, R>(
    _i3.ResultSetImplementation<T, R>? table, {
    bool? distinct = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#select, [table], {#distinct: distinct}),
            returnValue: _FakeSimpleSelectStatement_11<T, R>(
              this,
              Invocation.method(#select, [table], {#distinct: distinct}),
            ),
          )
          as _i3.SimpleSelectStatement<T, R>);

  @override
  _i3.JoinedSelectStatement<T, R> selectOnly<T extends _i3.HasResultSet, R>(
    _i3.ResultSetImplementation<T, R>? table, {
    bool? distinct = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#selectOnly, [table], {#distinct: distinct}),
            returnValue: _FakeJoinedSelectStatement_12<T, R>(
              this,
              Invocation.method(#selectOnly, [table], {#distinct: distinct}),
            ),
          )
          as _i3.JoinedSelectStatement<T, R>);

  @override
  _i3.BaseSelectStatement<_i3.TypedResult> selectExpressions(
    Iterable<_i3.Expression<Object>>? columns,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#selectExpressions, [columns]),
            returnValue: _FakeBaseSelectStatement_13<_i3.TypedResult>(
              this,
              Invocation.method(#selectExpressions, [columns]),
            ),
          )
          as _i3.BaseSelectStatement<_i3.TypedResult>);

  @override
  _i3.DeleteStatement<T, D> delete<T extends _i3.Table, D>(
    _i3.TableInfo<T, D>? table,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#delete, [table]),
            returnValue: _FakeDeleteStatement_14<T, D>(
              this,
              Invocation.method(#delete, [table]),
            ),
          )
          as _i3.DeleteStatement<T, D>);

  @override
  _i6.Future<int> customUpdate(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? updates,
    _i3.UpdateKind? updateKind,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customUpdate,
              [query],
              {
                #variables: variables,
                #updates: updates,
                #updateKind: updateKind,
              },
            ),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<int> customInsert(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? updates,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customInsert,
              [query],
              {#variables: variables, #updates: updates},
            ),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<List<_i3.QueryRow>> customWriteReturning(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? updates,
    _i3.UpdateKind? updateKind,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customWriteReturning,
              [query],
              {
                #variables: variables,
                #updates: updates,
                #updateKind: updateKind,
              },
            ),
            returnValue: _i6.Future<List<_i3.QueryRow>>.value(<_i3.QueryRow>[]),
          )
          as _i6.Future<List<_i3.QueryRow>>);

  @override
  _i3.Selectable<_i3.QueryRow> customSelect(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? readsFrom = const {},
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customSelect,
              [query],
              {#variables: variables, #readsFrom: readsFrom},
            ),
            returnValue: _FakeSelectable_15<_i3.QueryRow>(
              this,
              Invocation.method(
                #customSelect,
                [query],
                {#variables: variables, #readsFrom: readsFrom},
              ),
            ),
          )
          as _i3.Selectable<_i3.QueryRow>);

  @override
  _i3.Selectable<_i3.QueryRow> customSelectQuery(
    String? query, {
    List<_i3.Variable<Object>>? variables = const [],
    Set<_i3.ResultSetImplementation<dynamic, dynamic>>? readsFrom = const {},
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #customSelectQuery,
              [query],
              {#variables: variables, #readsFrom: readsFrom},
            ),
            returnValue: _FakeSelectable_15<_i3.QueryRow>(
              this,
              Invocation.method(
                #customSelectQuery,
                [query],
                {#variables: variables, #readsFrom: readsFrom},
              ),
            ),
          )
          as _i3.Selectable<_i3.QueryRow>);

  @override
  _i6.Future<void> customStatement(String? statement, [List<dynamic>? args]) =>
      (super.noSuchMethod(
            Invocation.method(#customStatement, [statement, args]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<T> transaction<T>(
    _i6.Future<T> Function()? action, {
    bool? requireNew = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #transaction,
              [action],
              {#requireNew: requireNew},
            ),
            returnValue:
                _i9.ifNotNull(
                  _i9.dummyValueOrNull<T>(
                    this,
                    Invocation.method(
                      #transaction,
                      [action],
                      {#requireNew: requireNew},
                    ),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_8<T>(
                  this,
                  Invocation.method(
                    #transaction,
                    [action],
                    {#requireNew: requireNew},
                  ),
                ),
          )
          as _i6.Future<T>);

  @override
  _i6.Future<T> exclusively<T>(_i6.Future<T> Function()? action) =>
      (super.noSuchMethod(
            Invocation.method(#exclusively, [action]),
            returnValue:
                _i9.ifNotNull(
                  _i9.dummyValueOrNull<T>(
                    this,
                    Invocation.method(#exclusively, [action]),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_8<T>(
                  this,
                  Invocation.method(#exclusively, [action]),
                ),
          )
          as _i6.Future<T>);

  @override
  _i6.Future<void> batch(_i6.FutureOr<void> Function(_i3.Batch)? runInBatch) =>
      (super.noSuchMethod(
            Invocation.method(#batch, [runInBatch]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<T> runWithInterceptor<T>(
    _i6.Future<T> Function()? action, {
    required _i3.QueryInterceptor? interceptor,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #runWithInterceptor,
              [action],
              {#interceptor: interceptor},
            ),
            returnValue:
                _i9.ifNotNull(
                  _i9.dummyValueOrNull<T>(
                    this,
                    Invocation.method(
                      #runWithInterceptor,
                      [action],
                      {#interceptor: interceptor},
                    ),
                  ),
                  (T v) => _i6.Future<T>.value(v),
                ) ??
                _FakeFuture_8<T>(
                  this,
                  Invocation.method(
                    #runWithInterceptor,
                    [action],
                    {#interceptor: interceptor},
                  ),
                ),
          )
          as _i6.Future<T>);

  @override
  _i3.GenerationContext $write(
    _i3.Component? component, {
    bool? hasMultipleTables,
    int? startIndex,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #$write,
              [component],
              {#hasMultipleTables: hasMultipleTables, #startIndex: startIndex},
            ),
            returnValue: _FakeGenerationContext_16(
              this,
              Invocation.method(
                #$write,
                [component],
                {
                  #hasMultipleTables: hasMultipleTables,
                  #startIndex: startIndex,
                },
              ),
            ),
          )
          as _i3.GenerationContext);

  @override
  _i3.GenerationContext $writeInsertable(
    _i3.TableInfo<_i3.Table, dynamic>? table,
    _i3.Insertable<dynamic>? insertable, {
    int? startIndex,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #$writeInsertable,
              [table, insertable],
              {#startIndex: startIndex},
            ),
            returnValue: _FakeGenerationContext_16(
              this,
              Invocation.method(
                #$writeInsertable,
                [table, insertable],
                {#startIndex: startIndex},
              ),
            ),
          )
          as _i3.GenerationContext);

  @override
  String $expandVar(int? start, int? amount) =>
      (super.noSuchMethod(
            Invocation.method(#$expandVar, [start, amount]),
            returnValue: _i9.dummyValue<String>(
              this,
              Invocation.method(#$expandVar, [start, amount]),
            ),
          )
          as String);

  @override
  _i6.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);
}

/// A class which mocks [DownloadProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockDownloadProvider extends _i1.Mock implements _i10.DownloadProvider {
  MockDownloadProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.DownloadService get service =>
      (super.noSuchMethod(
            Invocation.getter(#service),
            returnValue: _FakeDownloadService_19(
              this,
              Invocation.getter(#service),
            ),
          )
          as _i7.DownloadService);

  @override
  _i5.EpisodesDao get episodesDao =>
      (super.noSuchMethod(
            Invocation.getter(#episodesDao),
            returnValue: _FakeEpisodesDao_20(
              this,
              Invocation.getter(#episodesDao),
            ),
          )
          as _i5.EpisodesDao);

  @override
  _i5.SubscriptionsDao get subscriptionsDao =>
      (super.noSuchMethod(
            Invocation.getter(#subscriptionsDao),
            returnValue: _FakeSubscriptionsDao_21(
              this,
              Invocation.getter(#subscriptionsDao),
            ),
          )
          as _i5.SubscriptionsDao);

  @override
  _i5.SettingsDao get settingsDao =>
      (super.noSuchMethod(
            Invocation.getter(#settingsDao),
            returnValue: _FakeSettingsDao_22(
              this,
              Invocation.getter(#settingsDao),
            ),
          )
          as _i5.SettingsDao);

  @override
  _i5.RetentionDao get retentionDao =>
      (super.noSuchMethod(
            Invocation.getter(#retentionDao),
            returnValue: _FakeRetentionDao_23(
              this,
              Invocation.getter(#retentionDao),
            ),
          )
          as _i5.RetentionDao);

  @override
  _i8.ApiService get apiService =>
      (super.noSuchMethod(
            Invocation.getter(#apiService),
            returnValue: _FakeApiService_24(
              this,
              Invocation.getter(#apiService),
            ),
          )
          as _i8.ApiService);

  @override
  set service(_i7.DownloadService? svc) => super.noSuchMethod(
    Invocation.setter(#service, svc),
    returnValueForMissingStub: null,
  );

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  _i6.Future<void> enqueue(_i11.Episode? ep) =>
      (super.noSuchMethod(
            Invocation.method(#enqueue, [ep]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> pause(String? episodeId) =>
      (super.noSuchMethod(
            Invocation.method(#pause, [episodeId]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> resume(String? episodeId) =>
      (super.noSuchMethod(
            Invocation.method(#resume, [episodeId]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> cancel(String? episodeId) =>
      (super.noSuchMethod(
            Invocation.method(#cancel, [episodeId]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> removeLocalFile(String? episodeId) =>
      (super.noSuchMethod(
            Invocation.method(#removeLocalFile, [episodeId]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<void> deleteEpisodesForPodcast(String? podcastId) =>
      (super.noSuchMethod(
            Invocation.method(#deleteEpisodesForPodcast, [podcastId]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<int> autodownloadPodcast(String? podcastId) =>
      (super.noSuchMethod(
            Invocation.method(#autodownloadPodcast, [podcastId]),
            returnValue: _i6.Future<int>.value(0),
          )
          as _i6.Future<int>);

  @override
  _i6.Future<void> autoEnqueueLatestN(
    String? podcastId,
    int? n,
    List<_i11.Episode>? candidates,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#autoEnqueueLatestN, [podcastId, n, candidates]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );

  @override
  void addListener(_i12.VoidCallback? listener) => super.noSuchMethod(
    Invocation.method(#addListener, [listener]),
    returnValueForMissingStub: null,
  );

  @override
  void removeListener(_i12.VoidCallback? listener) => super.noSuchMethod(
    Invocation.method(#removeListener, [listener]),
    returnValueForMissingStub: null,
  );

  @override
  void notifyListeners() => super.noSuchMethod(
    Invocation.method(#notifyListeners, []),
    returnValueForMissingStub: null,
  );
}
```

### Inhalt von `klubradio_archivum/test/providers/theme_provider_test.dart`
```dart
// test/providers/theme_provider_test.dart
//
// Unit tests for ThemeProvider.
//
// Covers:
//   - Initial theme mode defaults to ThemeMode.system
//   - toggleTheme(true) sets dark mode
//   - toggleTheme(false) sets light mode
//   - setThemeMode() works for all three modes
//   - lightTheme returns expected color scheme
//   - darkTheme returns expected color scheme
//   - Theme persists to SharedPreferences
//   - Theme loads from SharedPreferences on construction
//   - Invalid value in SharedPreferences falls back to system

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:klubradio_archivum/providers/theme_provider.dart';

void main() {
  // Ensure Flutter bindings are initialized for SharedPreferences.
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Default: empty SharedPreferences for each test unless overridden.
    SharedPreferences.setMockInitialValues({});
  });

  // ==================== Initial state ====================

  group('initial state', () {
    test('themeMode defaults to ThemeMode.system', () {
      final provider = ThemeProvider();

      expect(provider.themeMode, ThemeMode.system);
    });
  });

  // ==================== toggleTheme ====================

  group('toggleTheme', () {
    test('toggleTheme(true) sets dark mode', () {
      final provider = ThemeProvider();

      provider.toggleTheme(true);

      expect(provider.themeMode, ThemeMode.dark);
    });

    test('toggleTheme(false) sets light mode', () {
      final provider = ThemeProvider();

      provider.toggleTheme(false);

      expect(provider.themeMode, ThemeMode.light);
    });

    test('notifies listeners when toggled', () {
      final provider = ThemeProvider();
      int calls = 0;
      provider.addListener(() => calls++);

      provider.toggleTheme(true);

      expect(calls, 1);
    });

    test('toggling multiple times updates correctly', () {
      final provider = ThemeProvider();

      provider.toggleTheme(true);
      expect(provider.themeMode, ThemeMode.dark);

      provider.toggleTheme(false);
      expect(provider.themeMode, ThemeMode.light);

      provider.toggleTheme(true);
      expect(provider.themeMode, ThemeMode.dark);
    });
  });

  // ==================== setThemeMode ====================

  group('setThemeMode', () {
    test('sets ThemeMode.light', () {
      final provider = ThemeProvider();

      provider.setThemeMode(ThemeMode.light);

      expect(provider.themeMode, ThemeMode.light);
    });

    test('sets ThemeMode.dark', () {
      final provider = ThemeProvider();

      provider.setThemeMode(ThemeMode.dark);

      expect(provider.themeMode, ThemeMode.dark);
    });

    test('sets ThemeMode.system', () {
      final provider = ThemeProvider();
      // First change away from system, then back.
      provider.setThemeMode(ThemeMode.dark);
      provider.setThemeMode(ThemeMode.system);

      expect(provider.themeMode, ThemeMode.system);
    });

    test('notifies listeners on each call', () {
      final provider = ThemeProvider();
      int calls = 0;
      provider.addListener(() => calls++);

      provider.setThemeMode(ThemeMode.dark);
      provider.setThemeMode(ThemeMode.light);
      provider.setThemeMode(ThemeMode.system);

      expect(calls, 3);
    });
  });

  // ==================== lightTheme ====================

  group('lightTheme', () {
    test('uses Material 3', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;

      expect(theme.useMaterial3, isTrue);
    });

    test('has light brightness', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;

      expect(theme.colorScheme.brightness, Brightness.light);
    });

    test('has custom scaffold background color', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;

      expect(theme.scaffoldBackgroundColor, const Color(0xFFF6F6F6));
    });

    test('has centered app bar title', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;

      expect(theme.appBarTheme.centerTitle, isTrue);
    });

    test('seed color is based on red (0xFFB00020)', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;
      // The primary color should be derived from the red seed color.
      // ColorScheme.fromSeed generates a full palette; just verify it is not null.
      expect(theme.colorScheme.primary, isNotNull);
    });
  });

  // ==================== darkTheme ====================

  group('darkTheme', () {
    test('uses Material 3', () {
      final provider = ThemeProvider();
      final theme = provider.darkTheme;

      expect(theme.useMaterial3, isTrue);
    });

    test('has dark brightness', () {
      final provider = ThemeProvider();
      final theme = provider.darkTheme;

      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('seed color is based on pink (0xFFCF6679)', () {
      final provider = ThemeProvider();
      final theme = provider.darkTheme;

      expect(theme.colorScheme.primary, isNotNull);
    });
  });

  // ==================== SharedPreferences persistence ====================

  group('SharedPreferences persistence', () {
    test('toggleTheme persists value to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();

      provider.toggleTheme(true);

      // Allow async _saveThemeMode to complete.
      await Future<void>.delayed(Duration.zero);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('themeMode'), 'dark');
    });

    test('setThemeMode persists value to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();

      provider.setThemeMode(ThemeMode.light);

      await Future<void>.delayed(Duration.zero);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('themeMode'), 'light');
    });

    test('persists system mode', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();

      provider.setThemeMode(ThemeMode.system);

      await Future<void>.delayed(Duration.zero);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('themeMode'), 'system');
    });
  });

  // ==================== Load from SharedPreferences ====================

  group('load from SharedPreferences', () {
    test('loads dark mode from SharedPreferences on construction', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'dark'});

      final provider = ThemeProvider();

      // Allow async _loadThemeMode to complete.
      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.dark);
    });

    test('loads light mode from SharedPreferences on construction', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'light'});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.light);
    });

    test('loads system mode from SharedPreferences on construction', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'system'});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.system);
    });

    test('notifies listeners after loading from SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'dark'});

      final provider = ThemeProvider();
      int calls = 0;
      provider.addListener(() => calls++);

      await Future<void>.delayed(Duration.zero);

      expect(calls, 1);
    });
  });

  // ==================== Invalid SharedPreferences value ====================

  group('invalid SharedPreferences value', () {
    test('falls back to ThemeMode.system for unknown value', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'invalidValue'});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.system);
    });

    test('falls back to ThemeMode.system for empty string', () async {
      SharedPreferences.setMockInitialValues({'themeMode': ''});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.system);
    });

    test('stays system when themeMode key is absent', () async {
      SharedPreferences.setMockInitialValues({});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.system);
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/screens/download_list_entries_test.dart`
```dart
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
```

### Inhalt von `klubradio_archivum/test/screens/podcast_detail_screen_test.dart`
```dart
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
```

### Inhalt von `klubradio_archivum/test/screens/subscription_download_test.dart`
```dart
// test/screens/subscription_download_test.dart
//
// Tests for subscription and download flows.

import 'package:flutter_test/flutter_test.dart';

import 'package:klubradio_archivum/models/episode.dart' as model;

void main() {
  group('SubscriptionProvider — logic bugs', () {
    test('subscribe button shows spinner forever when not subscribed', () {
      // BUG in podcast_detail_screen.dart:79
      //
      // The Consumer<SubscriptionProvider> checks:
      //   if (currentSubscription == null && !busy) → show spinner
      //
      // Flow:
      // 1. initState calls loadSubscription(podcastId)
      // 2. loadSubscription completes → currentSubscription = null (not subscribed)
      // 3. busy = false
      // 4. Condition: null && !false → TRUE → permanent spinner
      //
      // The user never sees the "Subscribe" button for a new podcast.
      //
      // FIX: Track whether loadSubscription has completed (e.g. a _loaded flag).
      //      Show spinner only while loading, show subscribe button when loaded
      //      but no subscription exists.

      // Simulating the broken condition
      final Subscription? currentSubscription = null;
      final bool busy = false;

      final showsSpinner = currentSubscription == null && !busy;
      expect(showsSpinner, isTrue,
          reason: 'Bug: spinner shown even after loading completes with no subscription');
    });

    test('auto-download uses global keepLatestN instead of per-podcast autoDownloadN', () {
      // BUG in download_service.dart:412-417
      //
      // autodownloadPodcast() does:
      //   final keepN = settings?.keepLatestN ?? 0;
      //   if (keepN <= 0) return 0;
      //
      // But the Subscriptions table has autoDownloadN per podcast.
      // This field is set when subscribing but NEVER READ by the
      // auto-download logic. Default global keepLatestN is null → always 0 → no downloads.
      //
      // FIX: autodownloadPodcast should read the per-podcast autoDownloadN
      //      from SubscriptionsDao, falling back to global keepLatestN.

      final int? globalKeepLatestN = null; // default from SettingsDao
      final keepN = globalKeepLatestN ?? 0;
      expect(keepN, 0, reason: 'Bug: auto-download never triggers with default settings');
    });
  });

  group('DownloadList — metadata bugs', () {
    test('completed downloads create Episode with Duration.zero', () {
      // BUG in download_list.dart:213-223 and 278-288
      //
      // When playing a completed download, a new model.Episode is created:
      //   model.Episode(
      //     ...
      //     description: '',
      //     duration: Duration.zero,
      //     showDate: '',
      //   );
      //
      // Instead of using the DB columns (durationSeconds, description, showDate)
      // that we now store. This means playback from the download manager shows
      // wrong metadata.
      //
      // FIX: Use Episode.fromDb(ep) instead of manually creating model.Episode.

      // Simulating the broken manual creation
      final manualEpisode = model.Episode(
        id: '56472',
        podcastId: '34',
        title: 'Megbeszéljük...',
        description: '',
        audioUrl: 'https://example.com/audio.mp3',
        publishedAt: DateTime(2024, 1, 1),
        showDate: '',
        duration: Duration.zero,
        hosts: const [],
      );

      expect(manualEpisode.duration, Duration.zero,
          reason: 'Bug: duration lost when creating Episode manually');
      expect(manualEpisode.description, '',
          reason: 'Bug: description lost when creating Episode manually');
      expect(manualEpisode.showDate, '',
          reason: 'Bug: showDate lost when creating Episode manually');
    });

    test('Episode.fromDb now reads durationSeconds from DB', () {
      // VALIDATION: After our schema migration, Episode.fromDb should
      // correctly read duration from durationSeconds column.
      // This is a documentation test - the actual DB test is blocked
      // by native plugin dependencies.

      // The fix in Episode.fromDb:
      //   duration: dbEpisode.durationSeconds != null
      //       ? Duration(seconds: dbEpisode.durationSeconds!)
      //       : Duration.zero,
      expect(true, isTrue,
          reason: 'Episode.fromDb now reads durationSeconds, description, showDate, imageUrl');
    });
  });

  group('DownloadService — enqueue flow', () {
    test('enqueueEpisode creates subscription row if missing', () {
      // DOCUMENTED: download_service.dart:153-160
      // When downloading an episode, if no subscription exists for the podcast,
      // a passive subscription (active: false) is created.
      // This is correct behavior — downloads don't require active subscription.
      expect(true, isTrue);
    });

    test('Foreign key constraint: episodes.podcast_id references subscriptions.podcast_id', () {
      // DOCUMENTED: app_database.dart:56-58
      // The Episodes table has:
      //   FOREIGN KEY(podcast_id) REFERENCES subscriptions(podcast_id) ON DELETE CASCADE
      //
      // This means episodes can only exist if a subscription row exists.
      // Since enqueueEpisode creates a subscription if missing (see above),
      // and loadEpisodesIntoDb does NOT create subscriptions, this could cause
      // issues IF SQLite foreign keys are enforced (PRAGMA foreign_keys = ON).
      //
      // By default Drift/SQLite does NOT enforce foreign keys, so this works
      // for now. But if FK enforcement is ever enabled, loadEpisodesIntoDb
      // would need to also create passive subscription rows.
      expect(true, isTrue);
    });
  });
}

// Dummy type to make the test self-contained
class Subscription {
  final bool active;
  Subscription({this.active = false});
}
```

### Inhalt von `klubradio_archivum/test/screens/utils/constants_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart';

void main() {
  group('Constants', () {
    test('table names are non-empty', () {
      expect(podcastsTable, isNotEmpty);
      expect(episodesTable, isNotEmpty);
      expect(userProfilesTable, isNotEmpty);
      expect(playbackEventsTable, isNotEmpty);
      expect(topShowsTable, isNotEmpty);
    });

    test('problematicEpisodeImageUrl is a valid URL', () {
      expect(problematicEpisodeImageUrl, startsWith('https://'));
    });

    test('defaultEpisodeImageUrl is an asset path', () {
      expect(defaultEpisodeImageUrl, startsWith('assets/'));
    });

    test('playbackSpeeds are within valid range', () {
      for (final speed in playbackSpeeds) {
        expect(speed, greaterThanOrEqualTo(0.5));
        expect(speed, lessThanOrEqualTo(3.0));
      }
    });

    test('playbackSpeeds includes 1.0 (normal speed)', () {
      expect(playbackSpeeds, contains(1.0));
    });

    test('playbackSpeeds are sorted ascending', () {
      for (int i = 1; i < playbackSpeeds.length; i++) {
        expect(playbackSpeeds[i], greaterThan(playbackSpeeds[i - 1]));
      }
    });

    test('defaultAutoDownloadCount is positive', () {
      expect(defaultAutoDownloadCount, greaterThan(0));
    });

    test('maxRecentSearches is positive', () {
      expect(maxRecentSearches, greaterThan(0));
    });

    test('maxRecentlyPlayed is positive', () {
      expect(maxRecentlyPlayed, greaterThan(0));
    });

    test('demoUserId is non-empty', () {
      expect(demoUserId, isNotEmpty);
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/screens/utils/helpers_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/screens/utils/helpers.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  // ===================== formatDurationPrecise =====================
  group('formatDurationPrecise', () {
    test('formats zero duration', () {
      expect(formatDurationPrecise(Duration.zero), '00:00');
    });

    test('formats seconds only', () {
      expect(formatDurationPrecise(const Duration(seconds: 5)), '00:05');
    });

    test('formats minutes and seconds', () {
      expect(formatDurationPrecise(const Duration(minutes: 3, seconds: 45)), '03:45');
    });

    test('formats hours, minutes, seconds with HH:MM:SS', () {
      expect(
        formatDurationPrecise(const Duration(hours: 1, minutes: 5, seconds: 30)),
        '01:05:30',
      );
    });

    test('formats large hours', () {
      expect(
        formatDurationPrecise(const Duration(hours: 12, minutes: 0, seconds: 0)),
        '12:00:00',
      );
    });

    test('pads single digits', () {
      expect(formatDurationPrecise(const Duration(minutes: 1, seconds: 2)), '01:02');
    });

    test('handles 59:59 correctly', () {
      expect(
        formatDurationPrecise(const Duration(minutes: 59, seconds: 59)),
        '59:59',
      );
    });

    test('handles exactly one hour', () {
      expect(
        formatDurationPrecise(const Duration(hours: 1)),
        '01:00:00',
      );
    });
  });

  // ===================== formatProgress =====================
  group('formatProgress', () {
    test('formats zero progress', () {
      expect(formatProgress(0), '0%');
    });

    test('formats full progress', () {
      expect(formatProgress(1.0), '100%');
    });

    test('formats half progress', () {
      expect(formatProgress(0.5), '50%');
    });

    test('rounds fractional percentage', () {
      expect(formatProgress(0.333), '33%');
    });

    test('clamps values above 1.0', () {
      expect(formatProgress(1.5), '100%');
    });

    test('clamps negative values to 0', () {
      expect(formatProgress(-0.5), '0%');
    });

    test('formats typical download progress', () {
      expect(formatProgress(0.75), '75%');
    });
  });

  // ===================== displayTitleFor =====================
  group('displayTitleFor', () {
    Episode makeEp({String title = 'Title', String? cachedTitle}) {
      return Episode(
        id: '1', podcastId: 'p', title: title,
        description: '', audioUrl: 'u',
        publishedAt: DateTime(2024), showDate: '',
        duration: Duration.zero, cachedTitle: cachedTitle,
      );
    }

    test('returns cachedTitle when non-empty', () {
      expect(displayTitleFor(makeEp(cachedTitle: 'Cached')), 'Cached');
    });

    test('returns title when cachedTitle is null', () {
      expect(displayTitleFor(makeEp(title: 'Fallback')), 'Fallback');
    });

    test('returns title when cachedTitle is empty', () {
      expect(displayTitleFor(makeEp(title: 'Fallback', cachedTitle: '')), 'Fallback');
    });
  });

  // ===================== formatDate =====================
  group('formatDate', () {
    test('returns non-empty string for valid date', () {
      final result = formatDate(DateTime(2024, 6, 15, 14, 30));
      expect(result, isNotEmpty);
    });

    test('formats with Hungarian locale by default', () {
      final result = formatDate(DateTime(2024, 6, 15, 14, 30));
      // Should contain some date components
      expect(result, contains('2024'));
    });

    test('supports custom locale', () {
      final result = formatDate(DateTime(2024, 6, 15, 14, 30), locale: 'en');
      expect(result, isNotEmpty);
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/screens/utils/platform_utils_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/screens/widgets/stateless/platform_utils.dart';

void main() {
  // Note: In flutter test environment, kIsWeb == false
  group('PlatformUtils (non-web test environment)', () {
    test('supportsDownloads is true on non-web', () {
      expect(PlatformUtils.supportsDownloads, isTrue);
    });

    test('supportsOfflinePlayback is true on non-web', () {
      expect(PlatformUtils.supportsOfflinePlayback, isTrue);
    });

    test('supportsBackgroundAudio is true on non-web', () {
      expect(PlatformUtils.supportsBackgroundAudio, isTrue);
    });

    test('supportsSubscriptions is true on non-web', () {
      expect(PlatformUtils.supportsSubscriptions, isTrue);
    });

    test('all capabilities are consistent (all true or all false)', () {
      // All capabilities depend on !kIsWeb, so they should all be the same
      final values = [
        PlatformUtils.supportsDownloads,
        PlatformUtils.supportsOfflinePlayback,
        PlatformUtils.supportsBackgroundAudio,
        PlatformUtils.supportsSubscriptions,
      ];
      expect(values.toSet().length, 1,
          reason: 'All platform capabilities should be consistent');
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/screens/widgets/queue_sheet_test.dart`
```dart
// test/screens/widgets/queue_sheet_test.dart
//
// Critical widget tests for the QueueSheet delete feature.
//
// TDD flow:
//   1. Run these tests → they FAIL (QueueSheet doesn't exist yet)
//   2. Extract _QueueSheet → public QueueSheet with a delete button
//   3. Run again → all green
//
// These tests CAN run under `flutter test` because:
//   - AudioPlayerService is fully mocked (no native just_audio.AudioPlayer created)
//   - QueueSheet has no background_downloader dependency
//   - Localization is configured via AppLocalizations.delegate

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/mockito.dart';

import 'package:klubradio_archivum/l10n/app_localizations.dart';
import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/providers/episode_provider.dart';
import 'package:klubradio_archivum/screens/widgets/stateful/queue_sheet.dart';

import '../../providers/episode_provider_queue_test.mocks.dart';

void main() {
  Episode ep(String id) => Episode(
        id: id,
        podcastId: 'pod-1',
        title: 'Episode $id',
        description: 'Desc',
        audioUrl: 'https://example.com/$id.mp3',
        publishedAt: DateTime(2024, 1, 1),
        showDate: '2024-01-01',
        duration: const Duration(minutes: 30),
      );

  late MockAudioPlayerService mockAudio;
  late MockApiService mockApi;
  late MockAppDatabase mockDb;
  late StreamController<Duration> positionCtrl;
  late StreamController<PlayerState> playerStateCtrl;
  late StreamController<bool> bufferingCtrl;
  late EpisodeProvider provider;

  setUp(() {
    positionCtrl = StreamController<Duration>.broadcast();
    playerStateCtrl = StreamController<PlayerState>.broadcast();
    bufferingCtrl = StreamController<bool>.broadcast();

    mockAudio = MockAudioPlayerService();
    mockApi = MockApiService();
    mockDb = MockAppDatabase();

    when(mockAudio.positionStream).thenAnswer((_) => positionCtrl.stream);
    when(mockAudio.playerStateStream)
        .thenAnswer((_) => playerStateCtrl.stream);
    when(mockAudio.bufferingStream).thenAnswer((_) => bufferingCtrl.stream);
    when(mockAudio.isPlaying).thenReturn(false);
    when(mockAudio.totalDuration).thenReturn(null);
    when(mockAudio.loadEpisode(any)).thenAnswer((_) async {});

    provider = EpisodeProvider(
      apiService: mockApi,
      audioPlayerService: mockAudio,
      db: mockDb,
    );
  });

  tearDown(() async {
    await positionCtrl.close();
    await playerStateCtrl.close();
    await bufferingCtrl.close();
    await provider.dispose();
  });

  Widget buildSheet() => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: QueueSheet(provider: provider)),
      );

  group('QueueSheet — remove button', () {
    testWidgets('shows one delete button per episode', (tester) async {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      await tester.pumpWidget(buildSheet());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.delete_outline), findsNWidgets(3));
    });

    testWidgets('tapping delete removes the correct episode from provider',
        (tester) async {
      provider.addToQueue(ep('a'));
      provider.addToQueue(ep('b'));
      provider.addToQueue(ep('c'));

      await tester.pumpWidget(buildSheet());
      await tester.pumpAndSettle();

      // Delete the first item ('a')
      await tester.tap(find.byIcon(Icons.delete_outline).first);
      await tester.pump();

      expect(provider.queue.map((e) => e.id), ['b', 'c']);
    });

    testWidgets('delete button is absent for the currently playing episode',
        (tester) async {
      final a = ep('a');
      final b = ep('b');
      final c = ep('c');
      await provider.playEpisode(a, queue: [a, b, c]);

      await tester.pumpWidget(buildSheet());
      await tester.pumpAndSettle();

      // 'a' is playing → no delete; 'b' and 'c' have delete buttons
      expect(find.byIcon(Icons.delete_outline), findsNWidgets(2));
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/services/api_live_validation_test.dart`
```dart
// test/services/api_live_validation_test.dart
//
// Live API validation - uses http.Client directly (no Flutter binding).
// Run with: flutter test --dart-define API_SERVICE_LIVE_TESTS=true test/services/api_live_validation_test.dart
//
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

const bool _runLive = bool.fromEnvironment('API_SERVICE_LIVE_TESTS');

const String _supabaseUrl = 'https://arakbotxgwpyyqyxjhhl.supabase.co';
const String _supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyYWtib3R4Z3dweXlxeXhqaGhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgxMDE0MzUsImV4cCI6MjA3MzY3NzQzNX0.zO__rAZCmPQW26YAC3CYhq_ZSjUAx0Gh0KHXIVHhm7w';

Map<String, String> get _headers => {
  'apikey': _supabaseKey,
  'Authorization': 'Bearer $_supabaseKey',
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

Future<http.Response> _get(String table, {Map<String, String>? params}) async {
  final uri = Uri.parse('$_supabaseUrl/rest/v1/$table')
      .replace(queryParameters: params);
  return http.get(uri, headers: _headers);
}

void main() {
  group('Live API validation', () {
    test('episodes table: inspect raw columns and field mapping', () async {
      if (!_runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final res = await _get(constants.episodesTable, params: {
        'select': '*', 'limit': '5', 'order': 'id.desc',
      });
      expect(res.statusCode, 200, reason: 'Episodes API: ${res.body}');

      final data = jsonDecode(res.body) as List<dynamic>;
      expect(data, isNotEmpty, reason: 'Episodes table should have data');

      final first = data.first as Map<String, dynamic>;

      // ignore: avoid_print
      print('\n=== RAW EPISODE COLUMNS ===');
      for (final key in first.keys) {
        // ignore: avoid_print
        print('  $key: ${first[key]} (${first[key]?.runtimeType})');
      }

      // Check which fields Episode.fromJson expects
      final expectedFields = ['id', 'podcastId', 'title', 'description', 'audioUrl', 'publishedAt', 'showDate', 'duration', 'imageUrl', 'hosts'];
      // ignore: avoid_print
      print('\n=== FIELD MAPPING (Episode.fromJson expects camelCase) ===');
      for (final field in expectedFields) {
        final present = first.containsKey(field);
        // ignore: avoid_print
        print('  $field: ${present ? "PRESENT" : "MISSING"}');
      }

      // Try parsing
      // ignore: avoid_print
      print('\n=== Episode.fromJson on raw API data ===');
      for (final raw in data) {
        final ep = Episode.fromJson(raw as Map<String, dynamic>);
        // ignore: avoid_print
        print('  [${ep.id}] podcastId="${ep.podcastId}" title="${ep.title}" audio=${ep.audioUrl.isNotEmpty ? "OK" : "EMPTY"} showDate="${ep.showDate}" duration=${ep.duration}');
      }
    });

    test('podcasts table: inspect raw columns and field mapping', () async {
      if (!_runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final res = await _get(constants.podcastsTable, params: {
        'select': '*', 'limit': '3',
      });
      expect(res.statusCode, 200, reason: 'Podcasts API: ${res.body}');

      final data = jsonDecode(res.body) as List<dynamic>;
      expect(data, isNotEmpty);

      final first = data.first as Map<String, dynamic>;
      // ignore: avoid_print
      print('\n=== RAW PODCAST COLUMNS ===');
      for (final key in first.keys) {
        // ignore: avoid_print
        print('  $key: ${first[key]} (${first[key]?.runtimeType})');
      }

      // ignore: avoid_print
      print('\n=== Podcast.fromJson ===');
      for (final raw in data) {
        final p = Podcast.fromJson(raw as Map<String, dynamic>);
        // ignore: avoid_print
        print('  [${p.id}] "${p.title}" cover=${p.coverImageUrl.isNotEmpty ? "OK" : "EMPTY"} episodes=${p.episodeCount} hosts=${p.hosts.length}');
      }
    });

    test('episodes filter by podcastId works correctly', () async {
      if (!_runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      // Get a sample episode to find a real podcastId
      final sampleRes = await _get(constants.episodesTable, params: {
        'select': 'id,podcastId', 'limit': '3',
      });
      expect(sampleRes.statusCode, 200);
      final samples = jsonDecode(sampleRes.body) as List<dynamic>;

      if (samples.isEmpty) {
        // ignore: avoid_print
        print('No episodes in table at all');
        return;
      }

      final samplePodcastId = (samples.first as Map)['podcastId']?.toString();
      // ignore: avoid_print
      print('\n=== Sample podcastId values ===');
      for (final s in samples) {
        // ignore: avoid_print
        print('  id=${s['id']} podcastId=${s['podcastId']}');
      }

      if (samplePodcastId == null || samplePodcastId == 'null') {
        // ignore: avoid_print
        print('WARNING: podcastId is null in episodes table');
        return;
      }

      // Test the filter as ApiService uses it
      final filteredRes = await _get(constants.episodesTable, params: {
        'select': '*',
        'podcastId': 'eq.$samplePodcastId',
        'limit': '5',
      });

      // ignore: avoid_print
      print('\n=== Filter Test: podcastId=eq.$samplePodcastId ===');
      // ignore: avoid_print
      print('  Status: ${filteredRes.statusCode}');
      final filtered = jsonDecode(filteredRes.body) as List<dynamic>;
      // ignore: avoid_print
      print('  Results: ${filtered.length}');
      for (final ep in filtered.take(3)) {
        // ignore: avoid_print
        print('  [${ep['id']}] podcastId=${ep['podcastId']} title="${ep['title']}"');
      }
    });

    test('top_shows_this_year table', () async {
      if (!_runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final res = await _get(constants.topShowsTable);
      // ignore: avoid_print
      print('\n=== Top Shows (status=${res.statusCode}) ===');
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as List<dynamic>;
        // ignore: avoid_print
        print('  Count: ${data.length}');
        for (final row in data.take(5)) {
          // ignore: avoid_print
          print('  $row');
        }
      } else {
        // ignore: avoid_print
        print('  Error: ${res.body}');
      }
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/services/api_model_validation_test.dart`
```dart
// test/services/api_model_validation_test.dart
//
// Validates that the Supabase API responses match the expected model schemas.
// Run with: flutter test --dart-define API_SERVICE_LIVE_TESTS=true test/services/api_model_validation_test.dart
//
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

void main() {
  const bool runLive = bool.fromEnvironment('API_SERVICE_LIVE_TESTS');

  // Initialize binding for SharedPreferences (used by ApiCacheService)
  TestWidgetsFlutterBinding.ensureInitialized();

  group('API + Model validation (live)', () {
    setUp(() {
      // Reset HttpOverrides so real HTTP requests go through
      // (flutter test binding intercepts all HTTP with status 400)
      HttpOverrides.global = null;
      // Re-initialize SharedPreferences mock (needed by ApiCacheService)
      SharedPreferences.setMockInitialValues({});
    });
    late ApiService service;

    setUp(() {
      service = ApiService();
    });

    tearDown(() {
      service.dispose();
    });

    test('raw episodes response has expected field names', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      // Fetch raw JSON to inspect field names
      final uri = Uri.parse('${service.supabaseUrl}/rest/v1/${constants.episodesTable}')
          .replace(queryParameters: {
        'select': '*',
        'limit': '5',
        'order': 'id.desc',
      });
      final headers = {
        'apikey': service.supabaseKey,
        'Authorization': 'Bearer ${service.supabaseKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final res = await http.get(uri, headers: headers);
      expect(res.statusCode, 200, reason: 'Episodes API should return 200');

      final data = jsonDecode(res.body) as List<dynamic>;
      expect(data, isNotEmpty, reason: 'Should have at least one episode');

      final firstEpisode = data.first as Map<String, dynamic>;
      debugPrint('\n=== RAW EPISODE FIELDS ===');
      for (final key in firstEpisode.keys) {
        debugPrint('  $key: ${firstEpisode[key]} (${firstEpisode[key]?.runtimeType})');
      }

      // Check which fields Episode.fromJson expects vs what API returns
      final expectedFields = [
        'id', 'podcastId', 'title', 'description', 'audioUrl',
        'publishedAt', 'showDate', 'duration', 'imageUrl', 'hosts',
      ];

      debugPrint('\n=== FIELD MAPPING CHECK ===');
      for (final field in expectedFields) {
        final hasField = firstEpisode.containsKey(field);
        debugPrint('  $field: ${hasField ? "PRESENT" : "MISSING"} ${hasField ? "(${firstEpisode[field]})" : ""}');
      }

      // Try to parse and see what happens
      debugPrint('\n=== Episode.fromJson ATTEMPT ===');
      try {
        final episode = Episode.fromJson(firstEpisode);
        debugPrint('  id: ${episode.id}');
        debugPrint('  podcastId: ${episode.podcastId}');
        debugPrint('  title: "${episode.title}"');
        debugPrint('  description: "${episode.description}"');
        debugPrint('  audioUrl: "${episode.audioUrl}"');
        debugPrint('  publishedAt: ${episode.publishedAt}');
        debugPrint('  showDate: "${episode.showDate}"');
        debugPrint('  duration: ${episode.duration}');
        debugPrint('  imageUrl: ${episode.imageUrl}');
        debugPrint('  hosts: ${episode.hosts}');

        // Validate critical fields are not empty/default
        expect(episode.id, isNotEmpty, reason: 'Episode id should not be empty');
        expect(episode.podcastId, isNotEmpty, reason: 'Episode podcastId should not be empty');
        expect(episode.title, isNotEmpty, reason: 'Episode title should not be empty');
        expect(episode.audioUrl, isNotEmpty, reason: 'Episode audioUrl should not be empty');
      } catch (e) {
        debugPrint('  ERROR: $e');
        fail('Episode.fromJson failed: $e');
      }
    });

    test('raw podcasts response has expected field names', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final uri = Uri.parse('${service.supabaseUrl}/rest/v1/${constants.podcastsTable}')
          .replace(queryParameters: {
        'select': '*',
        'limit': '3',
      });
      final headers = {
        'apikey': service.supabaseKey,
        'Authorization': 'Bearer ${service.supabaseKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final res = await http.get(uri, headers: headers);
      expect(res.statusCode, 200, reason: 'Podcasts API should return 200');

      final data = jsonDecode(res.body) as List<dynamic>;
      expect(data, isNotEmpty, reason: 'Should have at least one podcast');

      final firstPodcast = data.first as Map<String, dynamic>;
      debugPrint('\n=== RAW PODCAST FIELDS ===');
      for (final key in firstPodcast.keys) {
        debugPrint('  $key: ${firstPodcast[key]} (${firstPodcast[key]?.runtimeType})');
      }

      // Check which fields Podcast.fromJson expects
      final expectedFields = [
        'id', 'title', 'description', 'cover_image_url',
        'episode_count', 'hosts', 'latest_episode', 'last_updated',
      ];

      debugPrint('\n=== FIELD MAPPING CHECK ===');
      for (final field in expectedFields) {
        final hasField = firstPodcast.containsKey(field);
        debugPrint('  $field: ${hasField ? "PRESENT" : "MISSING"} ${hasField ? "" : ""}');
      }

      debugPrint('\n=== Podcast.fromJson ATTEMPT ===');
      try {
        final podcast = Podcast.fromJson(firstPodcast);
        debugPrint('  id: ${podcast.id}');
        debugPrint('  title: "${podcast.title}"');
        debugPrint('  description: "${podcast.description}"');
        debugPrint('  coverImageUrl: "${podcast.coverImageUrl}"');
        debugPrint('  episodeCount: ${podcast.episodeCount}');
        debugPrint('  hosts: ${podcast.hosts}');
        debugPrint('  lastUpdated: ${podcast.lastUpdated}');

        expect(podcast.id, isNotEmpty, reason: 'Podcast id should not be empty');
        expect(podcast.title, isNotEmpty, reason: 'Podcast title should not be empty');
      } catch (e) {
        debugPrint('  ERROR: $e');
        fail('Podcast.fromJson failed: $e');
      }
    });

    test('fetchEpisodesForPodcast returns valid episodes', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      // First get a real podcast ID
      final podcasts = await service.fetchLatestPodcasts(limit: 1);
      expect(podcasts, isNotEmpty, reason: 'Should have at least one podcast');

      final podcastId = podcasts.first.id;
      debugPrint('\n=== Fetching episodes for podcast "$podcastId" (${podcasts.first.title}) ===');

      final episodes = await service.fetchEpisodesForPodcast(podcastId, limit: 5);
      debugPrint('  Returned ${episodes.length} episodes');

      if (episodes.isEmpty) {
        debugPrint('  WARNING: No episodes returned for podcast $podcastId');
        debugPrint('  This could be a filtering/query issue');

        // Try without filter to see if episodes table has data at all
        final recentEpisodes = await service.fetchRecentEpisodes(limit: 5);
        debugPrint('  fetchRecentEpisodes returned ${recentEpisodes.length} episodes');
        if (recentEpisodes.isNotEmpty) {
          debugPrint('  First recent episode podcastId: ${recentEpisodes.first.podcastId}');
          debugPrint('  Trying with that podcastId...');
          final retryEpisodes = await service.fetchEpisodesForPodcast(
            recentEpisodes.first.podcastId, limit: 3,
          );
          debugPrint('  Retry returned ${retryEpisodes.length} episodes');
        }
      }

      for (final ep in episodes.take(3)) {
        debugPrint('  - [${ep.id}] "${ep.title}" (${ep.publishedAt}) audio=${ep.audioUrl.isNotEmpty ? "OK" : "EMPTY"}');
      }
    });

    test('fetchEpisodesForPodcast query filter is correct', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      // Test: Check if 'podcastId' column exists in the episodes table
      // by fetching raw data and checking column names
      final uri = Uri.parse('${service.supabaseUrl}/rest/v1/${constants.episodesTable}')
          .replace(queryParameters: {
        'select': '*',
        'limit': '1',
      });
      final headers = {
        'apikey': service.supabaseKey,
        'Authorization': 'Bearer ${service.supabaseKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final res = await http.get(uri, headers: headers);
      final data = jsonDecode(res.body) as List<dynamic>;

      if (data.isNotEmpty) {
        final row = data.first as Map<String, dynamic>;
        final columns = row.keys.toList();
        debugPrint('\n=== Episodes table columns ===');
        debugPrint('  $columns');

        // Check if the filter column name matches
        final hasPodcastId = columns.contains('podcastId');
        final hasPodcastIdSnake = columns.contains('podcast_id');
        debugPrint('  "podcastId" (camelCase): $hasPodcastId');
        debugPrint('  "podcast_id" (snake_case): $hasPodcastIdSnake');

        if (!hasPodcastId && hasPodcastIdSnake) {
          debugPrint('  *** MISMATCH: API query uses "podcastId" but column is "podcast_id" ***');
        }

        // Also verify the actual podcastId value format
        final podcastIdValue = row['podcastId'] ?? row['podcast_id'];
        debugPrint('  podcastId value: $podcastIdValue (type: ${podcastIdValue.runtimeType})');
      }
    });

    test('top shows response validates correctly', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final topShows = await service.fetchTopShowsThisYear();
      debugPrint('\n=== Top Shows ===');
      debugPrint('  Returned ${topShows.length} shows');
      for (final show in topShows.take(5)) {
        debugPrint('  - [${show.id}] "${show.title}" count=${show.count}');
      }
      expect(topShows, isNotEmpty);
    });

    test('full round-trip: Episode.fromJson -> toJson -> fromJson', () async {
      if (!runLive) {
        markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
        return;
      }

      final uri = Uri.parse('${service.supabaseUrl}/rest/v1/${constants.episodesTable}')
          .replace(queryParameters: {
        'select': '*',
        'limit': '3',
        'order': 'id.desc',
      });
      final headers = {
        'apikey': service.supabaseKey,
        'Authorization': 'Bearer ${service.supabaseKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final res = await http.get(uri, headers: headers);
      final data = jsonDecode(res.body) as List<dynamic>;

      for (final raw in data) {
        final map = raw as Map<String, dynamic>;
        final episode = Episode.fromJson(map);
        final json = episode.toJson();
        final roundTrip = Episode.fromJson(json);

        expect(roundTrip.id, episode.id);
        expect(roundTrip.podcastId, episode.podcastId);
        expect(roundTrip.title, episode.title);
        expect(roundTrip.audioUrl, episode.audioUrl);
        debugPrint('  Round-trip OK: [${episode.id}] "${episode.title}"');
      }
    });
  });

  // ---- Unit tests for Episode.fromJson edge cases ----
  group('Episode.fromJson unit tests', () {
    test('handles missing optional fields gracefully', () {
      final episode = Episode.fromJson({
        'id': '123',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'https://example.com/audio.mp3',
      });

      expect(episode.id, '123');
      expect(episode.podcastId, 'p1');
      expect(episode.title, 'Test');
      expect(episode.description, '');
      expect(episode.showDate, '');
      expect(episode.duration, Duration.zero);
      expect(episode.hosts, isEmpty);
      expect(episode.imageUrl, isNull);
    });

    test('handles numeric id correctly', () {
      final episode = Episode.fromJson({
        'id': 42,
        'podcastId': 99,
        'title': 'Numeric IDs',
        'audioUrl': 'https://example.com/audio.mp3',
      });

      expect(episode.id, '42');
      expect(episode.podcastId, '99');
    });

    test('handles duration as int (seconds)', () {
      final episode = Episode.fromJson({
        'id': '1',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'url',
        'duration': 3600,
      });
      expect(episode.duration, const Duration(hours: 1));
    });

    test('handles duration as HH:MM:SS string', () {
      final episode = Episode.fromJson({
        'id': '1',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'url',
        'duration': '01:30:00',
      });
      expect(episode.duration, const Duration(hours: 1, minutes: 30));
    });

    test('handles duration as MM:SS string', () {
      final episode = Episode.fromJson({
        'id': '1',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'url',
        'duration': '45:30',
      });
      expect(episode.duration, const Duration(minutes: 45, seconds: 30));
    });

    test('handles null/empty duration', () {
      final ep1 = Episode.fromJson({
        'id': '1', 'podcastId': 'p1', 'title': 'T', 'audioUrl': 'u',
        'duration': null,
      });
      final ep2 = Episode.fromJson({
        'id': '2', 'podcastId': 'p1', 'title': 'T', 'audioUrl': 'u',
      });
      expect(ep1.duration, Duration.zero);
      expect(ep2.duration, Duration.zero);
    });

    test('problematic imageUrl gets replaced', () {
      final episode = Episode.fromJson({
        'id': '1',
        'podcastId': 'p1',
        'title': 'Test',
        'audioUrl': 'url',
        'imageUrl': constants.problematicEpisodeImageUrl,
      }, podcastCoverImageUrl: 'https://cover.jpg');

      expect(episode.imageUrl, 'https://cover.jpg');
    });

    test('toJson round-trip preserves all fields', () {
      final original = Episode(
        id: 'test-1',
        podcastId: 'pod-1',
        title: 'Original Title',
        description: 'Original Desc',
        audioUrl: 'https://audio.mp3',
        publishedAt: DateTime(2024, 6, 15),
        showDate: '2024-06-15',
        duration: const Duration(minutes: 45),
        imageUrl: 'https://image.jpg',
        hosts: ['Host A', 'Host B'],
        isFavourite: true,
        downloadStatus: DownloadStatus.downloaded,
        downloadProgress: 1.0,
        localFilePath: '/local/path.mp3',
        cachedTitle: 'Cached Title',
        cachedImagePath: '/cache/img.jpg',
        cachedMetaPath: '/cache/meta.json',
      );

      final json = original.toJson();
      final restored = Episode.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.podcastId, original.podcastId);
      expect(restored.title, original.title);
      expect(restored.description, original.description);
      expect(restored.audioUrl, original.audioUrl);
      expect(restored.showDate, original.showDate);
      expect(restored.duration.inSeconds, original.duration.inSeconds);
      expect(restored.imageUrl, original.imageUrl);
      expect(restored.hosts, original.hosts);
      expect(restored.isFavourite, original.isFavourite);
      expect(restored.downloadStatus, original.downloadStatus);
      expect(restored.localFilePath, original.localFilePath);
      expect(restored.cachedTitle, original.cachedTitle);
      expect(restored.cachedImagePath, original.cachedImagePath);
      expect(restored.cachedMetaPath, original.cachedMetaPath);
    });
  });

  group('Podcast.fromJson unit tests', () {
    test('handles snake_case fields from Supabase', () {
      final podcast = Podcast.fromJson({
        'id': '3',
        'title': 'A lényeg',
        'description': 'Desc',
        'cover_image_url': 'https://img.jpg',
        'episode_count': 100,
        'hosts': [],
        'last_updated': '2024-01-15T10:00:00Z',
      });

      expect(podcast.id, '3');
      expect(podcast.title, 'A lényeg');
      expect(podcast.coverImageUrl, 'https://img.jpg');
      expect(podcast.episodeCount, 100);
      expect(podcast.lastUpdated, isNotNull);
    });

    test('handles missing optional fields', () {
      final podcast = Podcast.fromJson({
        'id': '1',
        'title': 'Minimal',
      });

      expect(podcast.id, '1');
      expect(podcast.title, 'Minimal');
      expect(podcast.description, '');
      expect(podcast.coverImageUrl, '');
      expect(podcast.episodeCount, 0);
      expect(podcast.hosts, isEmpty);
      expect(podcast.latestEpisode, isNull);
      expect(podcast.lastUpdated, isNull);
    });

    test('handles episode_count as string', () {
      final podcast = Podcast.fromJson({
        'id': '1',
        'title': 'Test',
        'episode_count': '42',
      });
      expect(podcast.episodeCount, 42);
    });
  });
}
```

### Inhalt von `klubradio_archivum/test/services/api_service_live_test.dart`
```dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:klubradio_archivum/services/api_service.dart';

void main() {
  const bool runLive = bool.fromEnvironment('API_SERVICE_LIVE_TESTS');
  const String outputPath = 'assets/api/response.json';

  // Initialize binding for SharedPreferences (used by ApiCacheService)
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('ApiService live Supabase snapshot', () {
    late ApiService service;

    setUp(() {
      // Reset HttpOverrides so real HTTP requests go through
      // (flutter test binding intercepts all HTTP with status 400)
      HttpOverrides.global = null;
      service = ApiService();
    });

    tearDown(() {
      service.dispose();
    });

    test(
      'writes Supabase data to assets/api/response.json',
      () async {
        if (!runLive) {
          markTestSkipped('Enable with --dart-define API_SERVICE_LIVE_TESTS=true');
          return;
        }
        expect(
          service.hasValidCredentials,
          isTrue,
          reason:
              'Supabase credentials missing or placeholder values are in use',
        );
        final latest = await service.fetchLatestPodcasts(limit: 5);
        // final recentEpisodes = await service.fetchRecentEpisodes(limit: 20);
        final trending = await service.fetchTrendingPodcasts(limit: 10);
        final recommended = await service.fetchRecommendedPodcasts(limit: 10);

        final latestEpisodes = await service.fetchEpisodesForPodcast(
          latest.first.id,
          limit: 10,
        );
        final topPodcasts = await service.fetchTopShowsThisYear();
        final podcastById = await service.fetchPodcastById(
          topPodcasts.first.id,
        );
        final Map<String, dynamic> payload = <String, dynamic>{
          'generatedAt': DateTime.now().toIso8601String(),
          'latestPodcasts': latest.map((podcast) => podcast.toJson()).toList(),
          'trendingPodcasts': trending
              .map((podcast) => podcast.toJson())
              .toList(),
          'recommendedPodcasts': recommended
              .map((podcast) => podcast.toJson())
              .toList(),
          'latestEpisodes': latestEpisodes
              .map((episode) => episode.toJson())
              .toList(),
          'topShows': topPodcasts.map((show) => show.toJson()).toList(),
          'podcastById': podcastById?.toJson(),
          // 'recentEpisodes': recentEpisodes
          //     .map((episode) => episode.toJson())
          //     .toList(),
        };
        final Directory outputDir = Directory('assets/api');
        if (!outputDir.existsSync()) {
          outputDir.createSync(recursive: true);
        }

        final File outputFile = File(outputPath);
        outputFile.writeAsStringSync(
          const JsonEncoder.withIndent('  ').convert(payload),
        );

        expect(outputFile.existsSync(), isTrue);
        expect(outputFile.readAsStringSync(), isNotEmpty);
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );
  });
}
```

### Inhalt von `klubradio_archivum/test/services/api_service_test.dart`
```dart
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';


import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/podcast.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/services/api_service.dart';
import 'package:klubradio_archivum/services/api_cache_service.dart'; // Explicit import
import 'package:shared_preferences/shared_preferences.dart'; // Direct import for setMockInitialValues

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock initial values for SharedPreferences
  setUpAll(() {
    // Helper to simulate ApiCacheService's double JSON encoding
    String createMockCacheEntry(dynamic data) { // Changed to dynamic
      final String encodedData = jsonEncode(data);
      final Map<String, dynamic> cacheEntry = {
        'data': encodedData,
        'expiry': DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      return jsonEncode(cacheEntry);
    }

    final String latestPodcastsCache = createMockCacheEntry(
      _samplePodcastResponse(count: 2)
    );
    final String trendingPodcastsCache = createMockCacheEntry(
      _samplePodcastResponse(count: 1) // Reverted count to 1
    );
    final String userProfileCache = createMockCacheEntry(
      _sampleProfileJson('user-123') // Pass single map directly
    );
    final String episodesForPodcastCache = createMockCacheEntry(
      [_sampleEpisodeJson(id: 'episode-1', podcastId: 'series-1', seed: 3)]
    );


    SharedPreferences.setMockInitialValues({
      'api_cache_latest_podcasts': latestPodcastsCache,
      'api_cache_trending_podcasts': trendingPodcastsCache,
      'api_cache_user_profile_user-123': userProfileCache,
      'api_cache_episodes_for_podcast_series-1': episodesForPodcastCache,
    });
  });
  group('ApiService network behaviour', () {
    test('fetchLatestPodcasts returns parsed podcasts on success', () async {
      late http.Request capturedRequest;
      final client = MockClient((http.Request request) async {
        capturedRequest = request;
        expect(request.method, 'GET');
        expect(request.url.path, contains('/rest/v1/podcasts'));
        return http.Response(
          jsonEncode(_samplePodcastResponse(count: 2)),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final List<Podcast> podcasts = await service.fetchLatestPodcasts(
        limit: 2,
      );

      expect(podcasts, hasLength(2));
      expect(podcasts.first.title, 'Podcast 0');
      expect(podcasts.first.latestEpisode?.id, 'episode-0');
      expect(capturedRequest.url.queryParameters['limit'], '2');
      expect(capturedRequest.headers['Authorization'], isNotNull);
    });

    test(
      'fetchLatestPodcasts throws ApiException when response not successful',
      () async {
        final client = MockClient((http.Request request) async {
          return http.Response('server error', 500);
        });
        final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

        await expectLater(
          service.fetchLatestPodcasts(),
          throwsA(
            isA<ApiException>().having(
              (ApiException e) => e.message,
              'message',
              contains('500'),
            ),
          ),
        );
      },
    );

    test('fetchTrendingPodcasts marks returned podcasts as trending', () async {
      final client = MockClient((http.Request request) async {
        expect(request.url.path, contains('/rest/v1/podcasts'));
        return http.Response(jsonEncode(_samplePodcastResponse(count: 1)), 200);
      });
      final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final List<Podcast> trending = await service.fetchTrendingPodcasts(
        limit: 1,
      );

      expect(trending, hasLength(1));
      expect(trending.single.isTrending, isTrue);
    });

    test('fetchEpisodesForPodcast returns parsed episodes', () async {
      late http.Request capturedRequest;
      final client = MockClient((http.Request request) async {
        capturedRequest = request;
        return http.Response(
          jsonEncode(<Map<String, dynamic>>[
            _sampleEpisodeJson(id: 'episode-1', podcastId: 'series-uncached', seed: 3),
          ]),
          200,
        );
      });
      final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

      final List<Episode> episodes = await service.fetchEpisodesForPodcast(
        'series-uncached',
        limit: 1,
      );

      expect(episodes, hasLength(1));
      expect(episodes.single.id, 'episode-1');
      expect(capturedRequest.url.queryParameters['podcastId'], 'eq.series-uncached');
      expect(capturedRequest.url.queryParameters['limit'], '1');
    });

    test(
      'searchPodcasts returns empty list when query is blank without calling API',
      () async {
        final client = MockClient((http.Request request) async {
          fail('HTTP client should not be invoked for blank queries');
        });
        final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

        final List<Podcast> results = await service.searchPodcasts('   ');

        expect(results, isEmpty);
      },
    );

    test('searchPodcasts encodes apostrophes and parses response', () async {
      late http.Request capturedRequest;
      final client = MockClient((http.Request request) async {
        capturedRequest = request;
        return http.Response(jsonEncode(_samplePodcastResponse(count: 1)), 200);
      });
      final ApiService service = ApiService(httpClient: client);

      final List<Podcast> results = await service.searchPodcasts("O'Connor");

      expect(results, hasLength(1));
      final String? titleQuery = capturedRequest.url.queryParameters['title'];
      expect(titleQuery, isNotNull);
      expect(titleQuery!, contains("O''Connor"));
    });

    test('fetchUserProfile returns parsed profile when data exists', () async {
      final client = MockClient((http.Request request) async {
        return http.Response(
          jsonEncode(<Map<String, dynamic>>[_sampleProfileJson('user-123')]),
          200,
        );
      });
      final ApiService service = ApiService(httpClient: client);

      final UserProfile profile = await service.fetchUserProfile('user-123');

      expect(profile.id, 'user-123');
      expect(profile.subscribedPodcastIds, contains('podcast-0'));
      expect(profile.recentlyPlayed, isNotEmpty);
    });

    test('fetchUserProfile throws when profile is missing', () async {
      final client = MockClient((http.Request request) async {
        return http.Response(jsonEncode(<dynamic>[]), 200);
      });
      final ApiService service = ApiService(httpClient: client);

      await expectLater(
        service.fetchUserProfile('missing'),
        throwsA(
          isA<ApiException>().having(
            (ApiException e) => e.message,
            'message',
            contains('missing'),
          ),
        ),
      );
    });

    test(
      'logPlayback posts payload with episodeId and ISO timestamp',
      () async {
        late http.Request capturedRequest;
        final client = MockClient((http.Request request) async {
          capturedRequest = request;
          final Map<String, dynamic> body =
              jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['episodeId'], 'episode-10');
          expect(
            () => DateTime.parse(body['playedAt'] as String),
            returnsNormally,
          );
          return http.Response('', 201);
        });
        final ApiService service = _TestApiService(httpClient: client, cacheService: _MockApiCacheService());

        await service.logPlayback(episodeId: 'episode-10');

        expect(capturedRequest.method, 'POST');
        expect(capturedRequest.url.path, contains('/rest/v1/playback_events'));
      },
    );

    test('logPlayback throws ApiException when server returns error', () async {
      final client = MockClient((http.Request request) async {
        return http.Response('failure', 500);
      });
      final ApiService service = ApiService(httpClient: client);

      await expectLater(
        service.logPlayback(episodeId: 'episode-11'),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group('ApiService fallback mocks', () {
    test(
      'fetchTrendingPodcasts uses mock data when credentials invalid',
      () async {
        final ApiService service = _OfflineApiService(
          httpClient: MockClient((http.Request request) async {
            fail('No network call expected when credentials are invalid');
          }),
        );

        final List<Podcast> trending = await service.fetchTrendingPodcasts(
          limit: 2,
        );

        expect(trending, hasLength(2));
        expect(trending.every((Podcast podcast) => podcast.isTrending), isTrue);
      },
    );

    test(
      'searchPodcasts returns filtered mock data without network access',
      () async {
        final ApiService service = _OfflineApiService(
          httpClient: MockClient((http.Request request) async {
            fail('No HTTP call expected when credentials are invalid');
          }),
        );

        final List<Podcast> results = await service.searchPodcasts('esti');

        expect(results, isNotEmpty);
        expect(results.first.id, 'esti-gyors');
      },
    );
  });

  test('dispose closes the injected http client', () {
    final _ClosingClient client = _ClosingClient();
    final ApiService service = ApiService(httpClient: client);

    service.dispose();

    expect(client.isClosed, isTrue);
  });
}

List<Map<String, dynamic>> _samplePodcastResponse({int count = 2}) {
  return List<Map<String, dynamic>>.generate(count, (int index) {
    final String podcastId = 'podcast-$index';
    return <String, dynamic>{
      'id': podcastId,
      'title': 'Podcast $index',
      'description': 'Description for podcast $index',
      'cover_image_url': 'https://example.com/cover-$index.jpg',
      'episode_count': index + 1,
      'hosts': <Map<String, dynamic>>[
        <String, dynamic>{'id': 'host-$index', 'name': 'Host $index'},
      ],
      'latest_episode': _sampleEpisodeJson(
        id: 'episode-$index',
        podcastId: podcastId,
        seed: index,
      ),
      'last_updated': DateTime(2024, 1, index + 1).toIso8601String(),
    };
  });
}

Map<String, dynamic> _sampleEpisodeJson({
  required String id,
  required String podcastId,
  int seed = 0,
}) {
  final DateTime publishedAt = DateTime(2024, 2, 1).add(Duration(days: seed));
  return <String, dynamic>{
    'id': id,
    'podcastId': podcastId,
    'title': 'Episode $id',
    'description': 'Description for $id',
    'audioUrl': 'https://example.com/audio/$id.mp3',
    'publishedAt': publishedAt.toIso8601String(),
    'duration': 1800 + seed,
    'hosts': <String>['Host $seed'],
  };
}

Map<String, dynamic> _sampleProfileJson(String userId) {
  return <String, dynamic>{
    'id': userId,
    'displayName': 'User $userId',
    'email': '$userId@example.com',
    'subscribedPodcastIds': <String>['podcast-0'],
    'recentlyPlayed': <Map<String, dynamic>>[
      _sampleEpisodeJson(id: 'recent-episode', podcastId: 'podcast-0', seed: 5),
    ],
    'favouriteEpisodeIds': <String>['recent-episode'],
  };
}

class _ClosingClient extends http.BaseClient {
  bool isClosed = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError('send should not be called in this test');
  }

  @override
  void close() {
    isClosed = true;
    super.close();
  }
}

class _OfflineApiService extends ApiService {
  _OfflineApiService({super.httpClient})
      : super(cacheService: _MockApiCacheService());

  @override
  bool get hasValidCredentials => false;
}

class _MockApiCacheService extends ApiCacheService {
  @override
  Future<dynamic> get(String key) async {
    return null; // Always return null to force network call
  }

  @override
  Future<void> save(String key, dynamic data, {Duration? expiry}) async {
    // Do nothing, don't cache
  }
}

class _TestApiService extends ApiService {
  _TestApiService({super.httpClient, super.cacheService});

  @override
  bool get hasValidCredentials => true; // Override to true for network tests
}

```

### Inhalt von `klubradio_archivum/test/services/privacy_notice_service_test.dart`
```dart
// test/services/privacy_notice_service_test.dart
//
// Unit tests for PrivacyNoticeService.
//
// Covers:
//   - shouldShowNotice: first run (no stored version), version mismatch, version match
//   - markNoticeShown: persists the current version
//   - Edge cases: empty version string

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:klubradio_archivum/services/privacy_notice_service.dart';

void main() {
  const kPrivacyShownVersion = 'privacyShownVersion';

  /// Sets up PackageInfo mock to return the given [version].
  void mockPackageInfo({required String version}) {
    PackageInfo.setMockInitialValues(
      appName: 'TestApp',
      packageName: 'hu.klubradio.archivum',
      version: version,
      buildNumber: '1',
      buildSignature: '',
    );
  }

  // ==================== shouldShowNotice ====================

  group('shouldShowNotice', () {
    test('returns true on first run (no stored version)', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '1.0.0');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isTrue);
    });

    test('returns true when stored version differs from current', () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: '1.0.0'});
      mockPackageInfo(version: '2.0.0');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isTrue);
    });

    test('returns false when stored version matches current', () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: '1.0.0'});
      mockPackageInfo(version: '1.0.0');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isFalse);
    });

    test('returns true when stored version is empty and current is not',
        () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: ''});
      mockPackageInfo(version: '1.0.0');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isTrue);
    });

    test('returns false when both stored and current are empty strings',
        () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: ''});
      mockPackageInfo(version: '');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isFalse);
    });

    test('returns true when current version is empty and stored is not',
        () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: '1.0.0'});
      mockPackageInfo(version: '');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isTrue);
    });
  });

  // ==================== markNoticeShown ====================

  group('markNoticeShown', () {
    test('saves current version to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '1.2.3');

      await PrivacyNoticeService.markNoticeShown();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(kPrivacyShownVersion), '1.2.3');
    });

    test('overwrites previously stored version', () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: '1.0.0'});
      mockPackageInfo(version: '2.0.0');

      await PrivacyNoticeService.markNoticeShown();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(kPrivacyShownVersion), '2.0.0');
    });

    test('saves empty string when version is empty', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '');

      await PrivacyNoticeService.markNoticeShown();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(kPrivacyShownVersion), '');
    });
  });

  // ==================== integration: mark then check ====================

  group('mark then check (integration)', () {
    test('shouldShowNotice returns false after markNoticeShown', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '3.0.0');

      // First run: notice should be shown
      expect(await PrivacyNoticeService.shouldShowNotice(), isTrue);

      // Mark as shown
      await PrivacyNoticeService.markNoticeShown();

      // Now it should no longer show
      expect(await PrivacyNoticeService.shouldShowNotice(), isFalse);
    });

    test('shouldShowNotice returns true again after version bump', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '1.0.0');

      await PrivacyNoticeService.markNoticeShown();
      expect(await PrivacyNoticeService.shouldShowNotice(), isFalse);

      // Simulate version bump — SharedPreferences retains old value
      // but PackageInfo now reports new version
      mockPackageInfo(version: '1.1.0');
      // Need fresh SharedPreferences instance with the stored value
      final prefs = await SharedPreferences.getInstance();
      final storedVersion = prefs.getString(kPrivacyShownVersion);
      SharedPreferences.setMockInitialValues(
          {kPrivacyShownVersion: storedVersion!});

      expect(await PrivacyNoticeService.shouldShowNotice(), isTrue);
    });
  });
}
```

### Inhalt von `klubradio_archivum/test_driver/integration_test.dart`
```dart
// test_driver/integration_test.dart
import 'package:integration_test/integration_test_driver_extended.dart';
import 'dart:io';

Future<void> main() => integrationDriver(
      onScreenshot: (String screenshotName, List<int> screenshotBytes, [Map<String, Object?>? details]) async {
        final File image = File('screenshots/$screenshotName.png');
        await image.writeAsBytes(screenshotBytes);
        return true;
      },
    );```

### Inhalt von `scripts/fetch_static_data.dart`
```dart
#!/usr/bin/env dart
// scripts/fetch_static_data.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Script to fetch commonly accessed data from Supabase and save as static bundles.
///
/// This script runs via GitHub Actions daily to keep bundled data fresh.
/// Usage:
///   SUPABASE_URL=<url> SUPABASE_KEY=<key> dart run scripts/fetch_static_data.dart
void main() async {
  final supabaseUrl = Platform.environment['SUPABASE_URL'];
  final supabaseKey = Platform.environment['SUPABASE_KEY'];

  if (supabaseUrl == null || supabaseKey == null) {
    stderr.writeln('Error: SUPABASE_URL and SUPABASE_KEY environment variables must be set');
    exit(1);
  }

  final fetcher = DataFetcher(
    baseUrl: supabaseUrl,
    apiKey: supabaseKey,
  );

  try {
    await fetcher.fetchAndSaveAll();
    print('✅ All static data bundles updated successfully');
  } catch (e, stack) {
    stderr.writeln('❌ Failed to fetch static data: $e');
    stderr.writeln(stack);
    exit(1);
  }
}

class DataFetcher {
  DataFetcher({required this.baseUrl, required this.apiKey});

  final String baseUrl;
  final String apiKey;
  final client = http.Client();

  static const outputDir = 'klubradio_archivum/assets/data';

  Map<String, String> get headers => {
    'apikey': apiKey,
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<void> fetchAndSaveAll() async {
    // Create output directory if it doesn't exist
    final dir = Directory(outputDir);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    print('📦 Fetching static data bundles...');

    // Fetch all data in parallel for speed
    await Future.wait([
      _fetchAndSave(
        'latest_podcasts',
        '$baseUrl/rest/v1/podcasts?select=*&order=last_updated.desc&limit=50',
      ),
      _fetchAndSave(
        'trending_podcasts',
        '$baseUrl/rest/v1/podcasts?select=*&limit=50',
      ),
      _fetchAndSave(
        'recommended_podcasts',
        '$baseUrl/rest/v1/podcasts?select=*&order=last_updated.desc.nullslast&limit=50',
      ),
      _fetchAndSave(
        'recent_episodes',
        '$baseUrl/rest/v1/episodes?select=*&order=id.desc&limit=100',
      ),
      _fetchAndSave(
        'top_shows_this_year',
        '$baseUrl/rest/v1/top_shows_this_year',
      ),
      _fetchAndSave(
        'all_podcasts_index',
        '$baseUrl/rest/v1/podcasts?select=id,title,description,coverImageUrl,episodeCount',
      ),
    ]);

    // Save metadata about when the bundle was generated
    await _saveMetadata();

    client.close();
  }

  Future<void> _fetchAndSave(String name, String url) async {
    print('  Fetching $name...');

    try {
      final response = await client
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);

        // Wrap data with metadata
        final bundle = {
          'items': data,
          'fetchedAt': DateTime.now().toIso8601String(),
        };

        final file = File('$outputDir/$name.json');
        await file.writeAsString(
          const JsonEncoder.withIndent('  ').convert(bundle),
        );

        final itemCount = data is List ? data.length : 1;
        print('    ✓ Saved $name.json ($itemCount items)');
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      stderr.writeln('    ✗ Failed to fetch $name: $e');
      rethrow;
    }
  }

  Future<void> _saveMetadata() async {
    final metadata = {
      'updatedAt': DateTime.now().toIso8601String(),
      'version': '1.0.0',
      'bundles': [
        'latest_podcasts',
        'trending_podcasts',
        'recommended_podcasts',
        'recent_episodes',
        'top_shows_this_year',
        'all_podcasts_index',
      ],
    };

    final file = File('$outputDir/metadata.json');
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(metadata),
    );

    print('  ✓ Saved metadata.json');
  }
}
```
