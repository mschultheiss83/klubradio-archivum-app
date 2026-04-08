// lib/utils/device_id.dart
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppIdentity {
  static const _kAnonId = 'anon.genId';

  /// Builds: {gen}-{build}-{osName-osVersion}
  static Future<String> getAppId() async {
    final prefs = await SharedPreferences.getInstance();
    var genId = prefs.getString(_kAnonId);
    if (genId == null || genId.isEmpty) {
      genId = const Uuid().v4().split('-').first; // kurz & anonym
      await prefs.setString(_kAnonId, genId);
    }

    final pkg = await PackageInfo.fromPlatform();
    final buildId = pkg.buildNumber.isEmpty ? '0' : pkg.buildNumber;

    final osTag = await _osTag();
    return '$genId-$buildId-$osTag';
  }

  static Future<String> _osTag() async {
    if (kIsWeb) return 'web-0';
    final info = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final a = await info.androidInfo;
        return 'android-${a.version.release}';
      }
      if (Platform.isIOS) {
        final i = await info.iosInfo;
        return 'ios-${i.systemVersion}';
      }
      if (Platform.isWindows) {
        final w = await info.windowsInfo;
        return 'windows-${w.majorVersion}.${w.minorVersion}';
      }
      if (Platform.isMacOS) {
        final m = await info.macOsInfo;
        return 'macos-${m.osRelease}';
      }
      if (Platform.isLinux) {
        final l = await info.linuxInfo;
        debugPrint('linuxInfo: $l');
        final ver = (l.version ?? l.prettyName).split(' ').first;
        return 'linux-$ver';
      }
      debugPrint(
        'Platform: isLinux: ${Platform.isLinux}'
        ' isMacOS: ${Platform.isMacOS}'
        ' isWindows: ${Platform.isWindows}'
        ' isIOS: ${Platform.isIOS}'
        ' isAndroid: ${Platform.isAndroid}',
      );
    } catch (_) {
      /* fallthrough */
    }
    // Fallback
    return 'unknown-0';
  }
}
