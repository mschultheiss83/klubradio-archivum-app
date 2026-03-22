// test/services/privacy_notice_service_test.dart
//
// Unit tests for PrivacyNoticeService.
//
// Covers:
//   - shouldShowNotice: first run (no stored version), version mismatch, version match
//   - markNoticeShown: persists the current version
//   - Edge cases: empty version string

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:klubradio_archivum/services/privacy_notice_service.dart';

void main() {
  const kPrivacyShownVersion = 'privacyShownVersion';

  /// Sets up PackageInfo mock to return the given [version].
  void mockPackageInfo({required String version}) {
    PackageInfo.setMockInitialValues(
      appName: 'TestApp',
      packageName: 'hu.klubradio.archivum',
      version: version,
      buildNumber: '1',
      buildSignature: '',
    );
  }

  // ==================== shouldShowNotice ====================

  group('shouldShowNotice', () {
    test('returns true on first run (no stored version)', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '1.0.0');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isTrue);
    });

    test('returns true when stored version differs from current', () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: '1.0.0'});
      mockPackageInfo(version: '2.0.0');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isTrue);
    });

    test('returns false when stored version matches current', () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: '1.0.0'});
      mockPackageInfo(version: '1.0.0');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isFalse);
    });

    test('returns true when stored version is empty and current is not',
        () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: ''});
      mockPackageInfo(version: '1.0.0');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isTrue);
    });

    test('returns false when both stored and current are empty strings',
        () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: ''});
      mockPackageInfo(version: '');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isFalse);
    });

    test('returns true when current version is empty and stored is not',
        () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: '1.0.0'});
      mockPackageInfo(version: '');

      final result = await PrivacyNoticeService.shouldShowNotice();

      expect(result, isTrue);
    });
  });

  // ==================== markNoticeShown ====================

  group('markNoticeShown', () {
    test('saves current version to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '1.2.3');

      await PrivacyNoticeService.markNoticeShown();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(kPrivacyShownVersion), '1.2.3');
    });

    test('overwrites previously stored version', () async {
      SharedPreferences.setMockInitialValues({kPrivacyShownVersion: '1.0.0'});
      mockPackageInfo(version: '2.0.0');

      await PrivacyNoticeService.markNoticeShown();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(kPrivacyShownVersion), '2.0.0');
    });

    test('saves empty string when version is empty', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '');

      await PrivacyNoticeService.markNoticeShown();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(kPrivacyShownVersion), '');
    });
  });

  // ==================== integration: mark then check ====================

  group('mark then check (integration)', () {
    test('shouldShowNotice returns false after markNoticeShown', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '3.0.0');

      // First run: notice should be shown
      expect(await PrivacyNoticeService.shouldShowNotice(), isTrue);

      // Mark as shown
      await PrivacyNoticeService.markNoticeShown();

      // Now it should no longer show
      expect(await PrivacyNoticeService.shouldShowNotice(), isFalse);
    });

    test('shouldShowNotice returns true again after version bump', () async {
      SharedPreferences.setMockInitialValues({});
      mockPackageInfo(version: '1.0.0');

      await PrivacyNoticeService.markNoticeShown();
      expect(await PrivacyNoticeService.shouldShowNotice(), isFalse);

      // Simulate version bump — SharedPreferences retains old value
      // but PackageInfo now reports new version
      mockPackageInfo(version: '1.1.0');
      // Need fresh SharedPreferences instance with the stored value
      final prefs = await SharedPreferences.getInstance();
      final storedVersion = prefs.getString(kPrivacyShownVersion);
      SharedPreferences.setMockInitialValues(
          {kPrivacyShownVersion: storedVersion!});

      expect(await PrivacyNoticeService.shouldShowNotice(), isTrue);
    });
  });
}
