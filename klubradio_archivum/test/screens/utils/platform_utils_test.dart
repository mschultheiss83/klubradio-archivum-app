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
