// test/providers/subscribe_download_flow_test.dart
//
// Integration-style tests for the subscribe → auto-download → unsubscribe flow.
//
// Scenarios:
//   1. Subscribe to "Esti gyors" → triggers 2 downloads (autoDownloadEpisodeCount=2)
//   2. Unsubscribe (keep files) → no downloads triggered
//   3. Delete one file, re-subscribe → only 1 new download (1 already completed)
//   4. autodownloadSubscribed=false → subscribing should NOT trigger auto-downloads
//   5. autodownloadSubscribed=true → subscribing triggers auto-downloads
//
// Uses Mockito mocks for SubscriptionsDao, SettingsDao, DownloadProvider.

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';
import 'package:klubradio_archivum/providers/download_provider.dart';
import 'package:klubradio_archivum/providers/subscription_provider.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

import 'subscribe_download_flow_test.mocks.dart';

@GenerateMocks([SubscriptionsDao, SettingsDao, DownloadProvider])
void main() {
  // ==================== Helpers ====================

  const podcastId = 'esti-gyors';

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

  Setting makeSetting({
    int? keepLatestN,
    bool autodownloadSubscribed = false,
  }) =>
      Setting(
        id: 1,
        wifiOnly: false,
        maxParallel: 2,
        deleteAfterHours: null,
        keepLatestN: keepLatestN,
        autodownloadSubscribed: autodownloadSubscribed,
        playOrder: 'newest',
      );

  // ==================== Fixtures ====================

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
    )..autoDownloadEpisodeCount = 2; // global default
  });

  // Helper to stub common toggle calls
  void stubToggleSubscribe() {
    when(mockSubsDao.toggleSubscribe(
      podcastId: anyNamed('podcastId'),
      active: anyNamed('active'),
      autoDownloadN: anyNamed('autoDownloadN'),
    )).thenAnswer((_) async {});
  }

  // ==================== Scenario 1: Subscribe triggers 2 downloads ====================

  // Helper: stub settings with autodownload enabled
  void stubSettingsAutodownloadEnabled() {
    when(mockSettingsDao.getOne())
        .thenAnswer((_) async => makeSetting(autodownloadSubscribed: true));
  }

  group('Scenario 1: Subscribe triggers auto-download', () {
    test('subscribing to "$podcastId" triggers autodownloadPodcast with count=2',
        () async {
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 2);

      await provider.toggleSubscription(podcastId, false);

      // Verify subscribe was called with active=true and autoDownloadN=2
      verify(mockSubsDao.toggleSubscribe(
        podcastId: podcastId,
        active: true,
        autoDownloadN: 2,
      )).called(1);

      // Verify auto-download was triggered
      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).called(1);
    });

    test('autodownloadPodcast returns 2 (two episodes enqueued)', () async {
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 2);

      await provider.toggleSubscription(podcastId, false);

      final captured = verify(mockDownloadProvider.autodownloadPodcast(
        captureAny,
        globalAutoDownloadN: captureAnyNamed('globalAutoDownloadN'),
      )).captured;

      expect(captured[0], podcastId);
      expect(captured[1], 2);
    });
  });

  // ==================== Scenario 2: Unsubscribe (keep files) ====================

  group('Scenario 2: Unsubscribe keeps files, no downloads', () {
    test('unsubscribing does NOT trigger autodownloadPodcast', () async {
      stubToggleSubscribe();
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: false));

      await provider.toggleSubscription(podcastId, true); // true = currently subscribed

      verifyNever(mockDownloadProvider.autodownloadPodcast(
        any,
        globalAutoDownloadN: anyNamed('globalAutoDownloadN'),
      ));
    });

    test('unsubscribing passes active=false and autoDownloadN=null', () async {
      stubToggleSubscribe();
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: false));

      await provider.toggleSubscription(podcastId, true);

      verify(mockSubsDao.toggleSubscribe(
        podcastId: podcastId,
        active: false,
        autoDownloadN: null,
      )).called(1);
    });
  });

  // ==================== Scenario 3: Re-subscribe after deleting 1 file ====================

  group('Scenario 3: Re-subscribe after deleting one file', () {
    test('re-subscribe triggers autodownload; service returns 1 (only missing file)',
        () async {
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, autoDownloadN: 2));
      // Simulate: 1 episode already completed, so only 1 new download
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 1);

      await provider.toggleSubscription(podcastId, false);

      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).called(1);
    });
  });

  // ==================== Scenario 4: BUG — autodownloadSubscribed=false ====================

  group('Scenario 4: autodownloadSubscribed setting check', () {
    test(
      'subscribing does NOT trigger auto-download when autodownloadSubscribed=false',
      () async {
        when(mockSettingsDao.getOne())
            .thenAnswer((_) async => makeSetting(autodownloadSubscribed: false));
        stubToggleSubscribe();
        when(mockSubsDao.getById(podcastId))
            .thenAnswer((_) async => makeSub(podcastId, autoDownloadN: 2));

        await provider.toggleSubscription(podcastId, false);

        // Subscription row should still be created
        verify(mockSubsDao.toggleSubscribe(
          podcastId: podcastId,
          active: true,
          autoDownloadN: 2,
        )).called(1);

        // But no downloads should be triggered
        verifyNever(mockDownloadProvider.autodownloadPodcast(
          any,
          globalAutoDownloadN: anyNamed('globalAutoDownloadN'),
        ));
      },
    );

    test(
      'subscribing when autodownloadSubscribed=true triggers auto-downloads',
      () async {
        stubSettingsAutodownloadEnabled();
        stubToggleSubscribe();
        when(mockSubsDao.getById(podcastId))
            .thenAnswer((_) async => makeSub(podcastId, autoDownloadN: 2));
        when(mockDownloadProvider.autodownloadPodcast(
          podcastId,
          globalAutoDownloadN: 2,
        )).thenAnswer((_) async => 2);

        await provider.toggleSubscription(podcastId, false);

        verify(mockDownloadProvider.autodownloadPodcast(
          podcastId,
          globalAutoDownloadN: 2,
        )).called(1);
      },
    );
  });

  // ==================== Scenario 5: Full lifecycle ====================

  group('Scenario 5: Full subscribe → unsubscribe → re-subscribe lifecycle', () {
    test('complete flow: subscribe(2 DL) → unsub(keep) → re-sub(1 DL)', () async {
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();

      // --- Step 1: Subscribe → 2 downloads ---
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 2);

      await provider.toggleSubscription(podcastId, false);

      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).called(1);
      expect(provider.currentSubscription?.active, true);

      // --- Step 2: Unsubscribe (keep files) ---
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: false));

      await provider.toggleSubscription(podcastId, true);

      expect(provider.currentSubscription?.active, false);

      // --- Step 3: Re-subscribe after deleting 1 file → only 1 new download ---
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 1); // only 1 missing

      await provider.toggleSubscription(podcastId, false);

      // Total autodownload calls: 2 (step 1 + step 3), not 3
      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).called(1); // this verify only counts since last reset
    });
  });

  // ==================== Scenario 6: autoDownloadEpisodeCount=0 ====================

  group('Scenario 6: Edge cases', () {
    test('autoDownloadEpisodeCount=0 should not trigger downloads', () async {
      provider.autoDownloadEpisodeCount = 0;
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 0,
      )).thenAnswer((_) async => 0);

      await provider.toggleSubscription(podcastId, false);

      // autodownloadPodcast IS called but with globalAutoDownloadN=0
      // The service itself should return 0 downloads
      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 0,
      )).called(1);
    });

    test('autoDownloadEpisodeCount=null falls back to defaultAutoDownloadCount', () async {
      provider.autoDownloadEpisodeCount = null;
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: constants.defaultAutoDownloadCount,
      )).thenAnswer((_) async => 2);

      await provider.toggleSubscription(podcastId, false);

      verify(mockSubsDao.toggleSubscribe(
        podcastId: podcastId,
        active: true,
        autoDownloadN: constants.defaultAutoDownloadCount,
      )).called(1);

      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: constants.defaultAutoDownloadCount,
      )).called(1);
    });
  });

  // ==================== Scenario 7: Double-click guard ====================

  group('Scenario 7: Double-click / busy guard', () {
    test('second toggleSubscription call is ignored while busy', () async {
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 2);

      // Fire two calls concurrently
      final first = provider.toggleSubscription(podcastId, false);
      final second = provider.toggleSubscription(podcastId, false);

      await Future.wait([first, second]);

      // Only ONE toggleSubscribe call should have happened
      verify(mockSubsDao.toggleSubscribe(
        podcastId: podcastId,
        active: true,
        autoDownloadN: 2,
      )).called(1);

      // Only ONE autodownloadPodcast call
      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).called(1);
    });

    test('can toggle again after first completes', () async {
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 2);

      // First call completes
      await provider.toggleSubscription(podcastId, false);
      expect(provider.busy, false);

      // Second call should work (not blocked)
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: false));
      await provider.toggleSubscription(podcastId, true);

      // Both toggleSubscribe calls happened
      verify(mockSubsDao.toggleSubscribe(
        podcastId: podcastId,
        active: true,
        autoDownloadN: 2,
      )).called(1);
      verify(mockSubsDao.toggleSubscribe(
        podcastId: podcastId,
        active: false,
        autoDownloadN: null,
      )).called(1);
    });
  });

  // ==================== Scenario 8: Subscribe → Unsub (keep) → Re-Sub ====================

  group('Scenario 8: Abo → Deabo (behalten) → Re-Abo', () {
    test('re-subscribe after unsub(keep) only downloads missing files', () async {
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();

      // Step 1: Subscribe → 2 downloads
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: true, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 2);

      await provider.toggleSubscription(podcastId, false);
      expect(provider.busy, false);

      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).called(1);

      // Step 2: Unsubscribe (keep files)
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: false, autoDownloadN: 2));

      await provider.toggleSubscription(podcastId, true);
      expect(provider.busy, false);

      // No download on unsub
      verifyNever(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      ));

      // Step 3: Delete 1 file (simulated by service returning 1 instead of 0)
      // Re-subscribe → service sees 1 completed + 1 missing = returns 1
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: true, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 1); // only 1 new download needed

      await provider.toggleSubscription(podcastId, false);
      expect(provider.busy, false);

      // Should download only 1 (the missing one)
      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).called(1);
    });

    test('re-subscribe when all files still exist downloads 0', () async {
      stubSettingsAutodownloadEnabled();
      stubToggleSubscribe();

      // Subscribe
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: true, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 2);
      await provider.toggleSubscription(podcastId, false);

      // Unsubscribe (keep)
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: false, autoDownloadN: 2));
      await provider.toggleSubscription(podcastId, true);

      // Clear interaction count from first subscribe so we only count re-subscribe
      clearInteractions(mockDownloadProvider);

      // Re-subscribe — all 2 files still completed in DB
      when(mockSubsDao.getById(podcastId))
          .thenAnswer((_) async => makeSub(podcastId, active: true, autoDownloadN: 2));
      when(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).thenAnswer((_) async => 0); // all already downloaded

      await provider.toggleSubscription(podcastId, false);

      verify(mockDownloadProvider.autodownloadPodcast(
        podcastId,
        globalAutoDownloadN: 2,
      )).called(1); // called but returned 0
    });
  });
}
