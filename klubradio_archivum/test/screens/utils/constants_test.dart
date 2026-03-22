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
