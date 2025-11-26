import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtils {
  static bool get supportsDownloads => !kIsWeb;
  static bool get supportsOfflinePlayback => !kIsWeb;
  static bool get supportsBackgroundAudio => !kIsWeb;
  static bool get supportsSubscriptions => !kIsWeb;
}