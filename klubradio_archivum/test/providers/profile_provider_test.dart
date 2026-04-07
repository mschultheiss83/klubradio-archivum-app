// test/providers/profile_provider_test.dart
//
// Unit tests for ProfileProvider:
//   - Initial state (null profile, not loading)
//   - load(): loading lifecycle, notifyListeners count, profile assignment
//   - setLanguage: updates language, saves, null profile no-op
//   - setPlaybackSpeed: updates speed, saves
//   - setAutoDownloadEpisodeCount: updates count, saves
//   - toggleFavouriteEpisode: add/remove toggle
//   - setSubscriptions: replaces subscribed IDs
//   - addRecentlyPlayed: front insertion, dedup, max limit
//   - All mutators with null profile are no-ops

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:klubradio_archivum/models/episode.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/providers/profile_provider.dart';
import 'package:klubradio_archivum/repositories/profile_repository.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

@GenerateMocks([ProfileRepository])
import 'profile_provider_test.mocks.dart';

// ==================== Helpers ====================

UserProfile _defaultProfile() => UserProfile.initial('test-user-1');

Episode _ep(String id) => Episode(
      id: id,
      podcastId: 'pod-1',
      title: 'Ep $id',
      description: '',
      audioUrl: 'https://x.com/$id.mp3',
      publishedAt: DateTime(2024),
      showDate: '2024-01-01',
      duration: const Duration(minutes: 30),
    );

// ==================== Tests ====================

void main() {
  late MockProfileRepository mockRepo;
  late ProfileProvider provider;
  late int notifyCount;

  setUp(() {
    mockRepo = MockProfileRepository();
    provider = ProfileProvider(repo: mockRepo);
    notifyCount = 0;
    provider.addListener(() => notifyCount++);
  });

  group('initial state', () {
    test('profileOrNull is null', () {
      expect(provider.profileOrNull, isNull);
    });

    test('loading is false', () {
      expect(provider.loading, isFalse);
    });
  });

  group('load', () {
    test('sets loading=true then false and assigns profile', () async {
      final profile = _defaultProfile();
      when(mockRepo.load()).thenAnswer((_) async => profile);

      await provider.load();

      expect(provider.loading, isFalse);
      expect(provider.profileOrNull, equals(profile));
    });

    test('notifies listeners twice (loading start + end)', () async {
      when(mockRepo.load()).thenAnswer((_) async => _defaultProfile());

      await provider.load();

      expect(notifyCount, 2);
    });
  });

  group('setLanguage', () {
    test('updates language and saves', () async {
      when(mockRepo.load()).thenAnswer((_) async => _defaultProfile());
      when(mockRepo.save(any)).thenAnswer((_) async {});
      await provider.load();
      notifyCount = 0;

      await provider.setLanguage('en');

      expect(provider.profileOrNull!.languageCode, 'en');
      verify(mockRepo.save(argThat(
        predicate<UserProfile>((p) => p.languageCode == 'en'),
      ))).called(1);
      expect(notifyCount, 1);
    });

    test('with null profile does nothing', () async {
      await provider.setLanguage('en');

      verifyNever(mockRepo.save(any));
      expect(notifyCount, 0);
    });
  });

  group('setPlaybackSpeed', () {
    test('updates speed and saves', () async {
      when(mockRepo.load()).thenAnswer((_) async => _defaultProfile());
      when(mockRepo.save(any)).thenAnswer((_) async {});
      await provider.load();
      notifyCount = 0;

      await provider.setPlaybackSpeed(1.5);

      expect(provider.profileOrNull!.playbackSpeed, 1.5);
      verify(mockRepo.save(argThat(
        predicate<UserProfile>((p) => p.playbackSpeed == 1.5),
      ))).called(1);
      expect(notifyCount, 1);
    });

    test('with null profile does nothing', () async {
      await provider.setPlaybackSpeed(2.0);

      verifyNever(mockRepo.save(any));
      expect(notifyCount, 0);
    });
  });

  group('setAutoDownloadEpisodeCount', () {
    test('updates count and saves', () async {
      when(mockRepo.load()).thenAnswer((_) async => _defaultProfile());
      when(mockRepo.save(any)).thenAnswer((_) async {});
      await provider.load();
      notifyCount = 0;

      await provider.setAutoDownloadEpisodeCount(5);

      expect(provider.profileOrNull!.autoDownloadEpisodeCount, 5);
      verify(mockRepo.save(argThat(
        predicate<UserProfile>((p) => p.autoDownloadEpisodeCount == 5),
      ))).called(1);
      expect(notifyCount, 1);
    });

    test('with null profile does nothing', () async {
      await provider.setAutoDownloadEpisodeCount(10);

      verifyNever(mockRepo.save(any));
      expect(notifyCount, 0);
    });
  });

  group('toggleFavouriteEpisode', () {
    test('adds episode to favourites', () async {
      when(mockRepo.load()).thenAnswer((_) async => _defaultProfile());
      when(mockRepo.save(any)).thenAnswer((_) async {});
      await provider.load();
      notifyCount = 0;

      await provider.toggleFavouriteEpisode('ep-42');

      expect(provider.profileOrNull!.favouriteEpisodeIds, contains('ep-42'));
      verify(mockRepo.save(any)).called(1);
      expect(notifyCount, 1);
    });

    test('removes existing favourite (toggle off)', () async {
      final profile = _defaultProfile().copyWith(
        favouriteEpisodeIds: {'ep-42', 'ep-99'},
      );
      when(mockRepo.load()).thenAnswer((_) async => profile);
      when(mockRepo.save(any)).thenAnswer((_) async {});
      await provider.load();
      notifyCount = 0;

      await provider.toggleFavouriteEpisode('ep-42');

      expect(
        provider.profileOrNull!.favouriteEpisodeIds,
        isNot(contains('ep-42')),
      );
      expect(provider.profileOrNull!.favouriteEpisodeIds, contains('ep-99'));
      verify(mockRepo.save(any)).called(1);
    });

    test('with null profile does nothing', () async {
      await provider.toggleFavouriteEpisode('ep-1');

      verifyNever(mockRepo.save(any));
      expect(notifyCount, 0);
    });
  });

  group('setSubscriptions', () {
    test('replaces subscribed IDs and saves', () async {
      when(mockRepo.load()).thenAnswer((_) async => _defaultProfile());
      when(mockRepo.save(any)).thenAnswer((_) async {});
      await provider.load();
      notifyCount = 0;

      await provider.setSubscriptions({'pod-a', 'pod-b'});

      expect(
        provider.profileOrNull!.subscribedPodcastIds,
        equals({'pod-a', 'pod-b'}),
      );
      verify(mockRepo.save(any)).called(1);
      expect(notifyCount, 1);
    });

    test('with null profile does nothing', () async {
      await provider.setSubscriptions({'pod-a'});

      verifyNever(mockRepo.save(any));
      expect(notifyCount, 0);
    });
  });

  group('addRecentlyPlayed', () {
    test('adds episode to front', () async {
      when(mockRepo.load()).thenAnswer((_) async => _defaultProfile());
      when(mockRepo.save(any)).thenAnswer((_) async {});
      await provider.load();
      notifyCount = 0;

      final episode = _ep('ep-new');
      await provider.addRecentlyPlayed(episode);

      expect(provider.profileOrNull!.recentlyPlayed.first.id, 'ep-new');
      verify(mockRepo.save(any)).called(1);
      expect(notifyCount, 1);
    });

    test('moves duplicate to front (dedup)', () async {
      final profile = _defaultProfile().copyWith(
        recentlyPlayed: [_ep('ep-a'), _ep('ep-b'), _ep('ep-c')],
      );
      when(mockRepo.load()).thenAnswer((_) async => profile);
      when(mockRepo.save(any)).thenAnswer((_) async {});
      await provider.load();
      notifyCount = 0;

      await provider.addRecentlyPlayed(_ep('ep-c'));

      final ids =
          provider.profileOrNull!.recentlyPlayed.map((e) => e.id).toList();
      expect(ids, ['ep-c', 'ep-a', 'ep-b']);
      // No duplicates
      expect(ids.where((id) => id == 'ep-c').length, 1);
    });

    test('respects max limit (${constants.maxRecentlyPlayed})', () async {
      // Pre-fill profile to exactly maxRecentlyPlayed
      final episodes = List.generate(
        constants.maxRecentlyPlayed,
        (i) => _ep('existing-$i'),
      );
      final profile = _defaultProfile().copyWith(recentlyPlayed: episodes);
      when(mockRepo.load()).thenAnswer((_) async => profile);
      when(mockRepo.save(any)).thenAnswer((_) async {});
      await provider.load();

      // Add one more beyond the limit
      await provider.addRecentlyPlayed(_ep('overflow'));

      final recent = provider.profileOrNull!.recentlyPlayed;
      expect(recent.length, constants.maxRecentlyPlayed);
      expect(recent.first.id, 'overflow');
      // The last existing episode should have been evicted
      expect(
        recent.any((e) => e.id == 'existing-${constants.maxRecentlyPlayed - 1}'),
        isFalse,
      );
    });

    test('with null profile does nothing', () async {
      await provider.addRecentlyPlayed(_ep('ep-1'));

      verifyNever(mockRepo.save(any));
      expect(notifyCount, 0);
    });
  });
}

/// Helper matcher: creates a predicate-based Matcher for mockito's argThat.
Matcher predicate<T>(bool Function(T) test) =>
    isA<T>().having((v) => test(v), 'predicate', isTrue);
