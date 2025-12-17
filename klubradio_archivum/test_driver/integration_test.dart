// test_driver/integration_test.dart
import 'package:integration_test/integration_test_driver_extended.dart';
import 'dart:io';

Future<void> main() => integrationDriver(
      onScreenshot: (String screenshotName, List<int> screenshotBytes, [Map<String, Object?>? details]) async {
        final File image = File('screenshots/$screenshotName.png');
        await image.writeAsBytes(screenshotBytes);
        return true;
      },
    );