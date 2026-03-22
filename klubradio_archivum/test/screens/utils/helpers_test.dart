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
