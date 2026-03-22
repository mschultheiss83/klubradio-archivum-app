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
