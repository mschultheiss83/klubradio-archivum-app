// test/providers/subscription_provider_test.dart
//
// Unit tests for SubscriptionProvider, focusing on initial download seeding for
// new subscriptions and the provider's busy/load state handling.
//
// Covers:
//   - loadSubscription: sets currentSubscription from DAO, sets loaded=true
//   - watchSubscription: returns stream from DAO
//   - toggleSubscription (subscribing): uses autoDownloadEpisodeCount
//   - toggleSubscription (subscribing, no profile value): falls back to defaultAutoDownloadCount
//   - toggleSubscription (unsubscribing): does not seed downloads
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
  Setting makeSetting({
    int? keepLatestN,
    bool autodownloadSubscribed = true,
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

  // ==================== Test fixtures ====================

  late MockSubscriptionsDao mockSubsDao;
  late MockSettingsDao mockSettingsDao;
  late MockDownloadProvider mockDownloadProvider;
  late SubscriptionProvider provider;

  setUp(() {
    mockSubsDao = MockSubscriptionsDao();
    mockSettingsDao = MockSettingsDao();
    mockDownloadProvider = MockDownloadProvider();

    // Keep a default settings row stub because the provider still depends on the DAO.
    when(mockSettingsDao.getOne()).thenAnswer((_) async => makeSetting(
          keepLatestN: null,
          autodownloadSubscribed: true,
        ));

    provider = SubscriptionProvider(
      subscriptionsDao: mockSubsDao,
      settingsDao: mockSettingsDao,
      downloadProvider: mockDownloadProvider,
    )..autoDownloadEpisodeCount = 5; // default for tests
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

    test('sets loaded=true even when getById throws', () async {
      when(mockSubsDao.getById('pod-err'))
          .thenThrow(Exception('DB error'));

      expect(provider.loaded, false);
      await provider.loadSubscription('pod-err');
      expect(provider.loaded, true);
      expect(provider.currentSubscription, isNull);
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

    test('uses autoDownloadEpisodeCount when subscribing', () async {
      provider.autoDownloadEpisodeCount = 7;
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1', autoDownloadN: 7));
      when(mockDownloadProvider.autodownloadPodcast('pod-1', globalAutoDownloadN: 7))
          .thenAnswer((_) async => 3);

      await provider.toggleSubscription('pod-1', false);

      verify(mockSubsDao.toggleSubscribe(
        podcastId: 'pod-1',
        active: true,
        autoDownloadN: 7,
      )).called(1);
    });

    test('falls back to defaultAutoDownloadCount when autoDownloadEpisodeCount is null',
        () async {
      provider.autoDownloadEpisodeCount = null;
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1'));
      when(mockDownloadProvider.autodownloadPodcast('pod-1', globalAutoDownloadN: anyNamed('globalAutoDownloadN')))
          .thenAnswer((_) async => 2);

      await provider.toggleSubscription('pod-1', false);

      verify(mockSubsDao.toggleSubscribe(
        podcastId: 'pod-1',
        active: true,
        autoDownloadN: constants.defaultAutoDownloadCount,
      )).called(1);
    });

    test('uses autoDownloadEpisodeCount over defaultAutoDownloadCount',
        () async {
      provider.autoDownloadEpisodeCount = 8;
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenAnswer((_) async {});
      when(mockSubsDao.getById('pod-1'))
          .thenAnswer((_) async => makeSub('pod-1'));
      when(mockDownloadProvider.autodownloadPodcast('pod-1', globalAutoDownloadN: anyNamed('globalAutoDownloadN')))
          .thenAnswer((_) async => 2);

      await provider.toggleSubscription('pod-1', false);

      verify(mockSubsDao.toggleSubscribe(
        podcastId: 'pod-1',
        active: true,
        autoDownloadN: 8,
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
      when(mockDownloadProvider.autodownloadPodcast('pod-1', globalAutoDownloadN: anyNamed('globalAutoDownloadN')))
          .thenAnswer((_) async => 5);

      await provider.toggleSubscription('pod-1', false);

      verify(mockDownloadProvider.autodownloadPodcast('pod-1', globalAutoDownloadN: anyNamed('globalAutoDownloadN'))).called(1);
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
      when(mockDownloadProvider.autodownloadPodcast('pod-1', globalAutoDownloadN: anyNamed('globalAutoDownloadN')))
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

      verifyNever(mockDownloadProvider.autodownloadPodcast(any, globalAutoDownloadN: anyNamed('globalAutoDownloadN')));
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
      when(mockDownloadProvider.autodownloadPodcast('pod-1', globalAutoDownloadN: anyNamed('globalAutoDownloadN')))
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
      when(mockDownloadProvider.autodownloadPodcast('pod-1', globalAutoDownloadN: anyNamed('globalAutoDownloadN')))
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

    test('swallows errors from toggleSubscribe (callers never await)', () async {
      when(mockSettingsDao.getOne())
          .thenAnswer((_) async => makeSetting(keepLatestN: 3));
      when(mockSubsDao.toggleSubscribe(
        podcastId: anyNamed('podcastId'),
        active: anyNamed('active'),
        autoDownloadN: anyNamed('autoDownloadN'),
      )).thenThrow(Exception('DB error'));

      // Should complete without throwing — error is logged, not rethrown
      await provider.toggleSubscription('pod-1', false);
      expect(provider.busy, false);
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
