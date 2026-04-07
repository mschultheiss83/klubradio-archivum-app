import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/repositories/profile_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProfileRepository repo;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repo = ProfileRepository();
  });

  group('ProfileRepository', () {
    test('save() persists profile to SharedPreferences', () async {
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

      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('user_profile.json');
      expect(raw, isNotNull);
      final decoded = jsonDecode(raw!) as Map<String, dynamic>;
      expect(decoded['id'], 'test-id-42');
      expect(decoded['languageCode'], 'en');
      expect(decoded['playbackSpeed'], 1.5);
    });

    test('load() with pre-populated valid JSON returns parsed profile', () async {
      final profile = UserProfile.initial('pre-existing-id');
      SharedPreferences.setMockInitialValues({
        'user_profile.json': jsonEncode(profile.toJson()),
      });

      final loaded = await repo.load();

      expect(loaded.id, 'pre-existing-id');
      expect(loaded.languageCode, 'de');
      expect(loaded.playbackSpeed, 1.0);
      expect(loaded.autoDownloadEpisodeCount, 2);
    });

    test('save() then load() round-trip preserves all fields', () async {
      final profile = UserProfile(
        id: 'round-trip-id',
        languageCode: 'hu',
        playbackSpeed: 2.0,
        autoDownloadEpisodeCount: 5,
        subscribedPodcastIds: {'pod-a', 'pod-b'},
        favouriteEpisodeIds: {'ep-x', 'ep-y'},
        recentlyPlayed: const [],
      );

      await repo.save(profile);
      final loaded = await repo.load();

      expect(loaded.id, 'round-trip-id');
      expect(loaded.languageCode, 'hu');
      expect(loaded.playbackSpeed, 2.0);
      expect(loaded.autoDownloadEpisodeCount, 5);
      expect(loaded.subscribedPodcastIds, containsAll(['pod-a', 'pod-b']));
      expect(loaded.favouriteEpisodeIds, containsAll(['ep-x', 'ep-y']));
    });

    test('save() overwrites existing profile', () async {
      final first = UserProfile.initial('first-id');
      final second = UserProfile.initial('second-id');

      await repo.save(first);
      await repo.save(second);
      final loaded = await repo.load();

      expect(loaded.id, 'second-id');
    });

    test('load() with corrupted JSON falls back to fresh profile', () async {
      SharedPreferences.setMockInitialValues({
        'user_profile.json': 'NOT VALID JSON {{{{',
      });

      // The corrupted-JSON branch calls AppIdentity.getAppId() which
      // requires platform plugins unavailable in unit tests.
    }, skip: 'Corrupted-JSON branch calls AppIdentity — requires platform plugin or refactoring');

    test('load() with no saved data creates and persists a fresh profile', () async {
      // The raw == null branch calls AppIdentity.getAppId() which
      // requires platform plugins unavailable in unit tests.
    }, skip: 'Empty-prefs branch calls AppIdentity — requires platform plugin or refactoring');
  });
}
