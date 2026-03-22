import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Manages the one-time-per-version privacy notice popup.
///
/// Checks SharedPreferences for a versioned flag. If the stored version
/// does not match the current app version, the notice should be shown.
class PrivacyNoticeService {
  static const _kPrivacyShownVersion = 'privacyShownVersion';

  /// Returns `true` if the privacy notice should be shown for this version.
  static Future<bool> shouldShowNotice() async {
    final prefs = await SharedPreferences.getInstance();
    final info = await PackageInfo.fromPlatform();
    final currentVersion = info.version;
    final shownVersion = prefs.getString(_kPrivacyShownVersion);
    return shownVersion != currentVersion;
  }

  /// Marks the privacy notice as shown for the current app version.
  static Future<void> markNoticeShown() async {
    final prefs = await SharedPreferences.getInstance();
    final info = await PackageInfo.fromPlatform();
    await prefs.setString(_kPrivacyShownVersion, info.version);
  }
}
