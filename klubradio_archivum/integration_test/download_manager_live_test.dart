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
