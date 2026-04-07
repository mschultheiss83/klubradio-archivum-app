import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klubradio_archivum/db/app_database.dart';
import 'package:klubradio_archivum/db/daos.dart';

void main() {
  late AppDatabase db;
  late SettingsDao dao;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dao = SettingsDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'setPlayOrder creates defaults when settings row does not exist',
    () async {
      expect(await dao.getOne(), isNull);

      await dao.setPlayOrder('oldest');

      final settings = await dao.getOne();
      expect(settings, isNotNull);
      expect(settings!.id, 1);
      expect(settings.playOrder, 'oldest');
    },
  );

  // ==================== H13: ensureDefaults idempotency ====================

  group('ensureDefaults (H13 — insertOrIgnore)', () {
    test('creates default row on first call', () async {
      expect(await dao.getOne(), isNull);

      await dao.ensureDefaults();

      final settings = await dao.getOne();
      expect(settings, isNotNull);
      expect(settings!.id, 1);
      expect(settings.autodownloadSubscribed, false);
      expect(settings.maxParallel, 2);
      expect(settings.keepLatestN, isNull);
      expect(settings.deleteAfterHours, isNull);
      expect(settings.playOrder, 'newest');
    });

    test('is idempotent — second call does not reset user changes', () async {
      await dao.ensureDefaults();
      await dao.setAutodownloadSubscribed(true);
      await dao.setKeepLatestN(10);

      // Second call must NOT overwrite user settings
      await dao.ensureDefaults();

      final settings = await dao.getOne();
      expect(settings!.autodownloadSubscribed, true,
          reason: 'ensureDefaults must not reset user setting');
      expect(settings.keepLatestN, 10,
          reason: 'ensureDefaults must not reset user setting');
    });

    test('concurrent calls do not throw or corrupt data', () async {
      // Fire multiple ensureDefaults concurrently — insertOrIgnore prevents conflict
      await Future.wait([
        dao.ensureDefaults(),
        dao.ensureDefaults(),
        dao.ensureDefaults(),
      ]);

      final settings = await dao.getOne();
      expect(settings, isNotNull);
      expect(settings!.id, 1);
    });
  });

  // ==================== Individual setters ====================

  group('SettingsDao setters', () {
    setUp(() async {
      await dao.ensureDefaults();
    });

    test('setWifiOnly updates wifi setting', () async {
      await dao.setWifiOnly(true);
      final s = await dao.getOne();
      expect(s!.wifiOnly, true);

      await dao.setWifiOnly(false);
      final s2 = await dao.getOne();
      expect(s2!.wifiOnly, false);
    });

    test('setMaxParallel updates parallel downloads', () async {
      await dao.setMaxParallel(4);
      final s = await dao.getOne();
      expect(s!.maxParallel, 4);
    });

    test('setDeleteAfterHours updates deletion threshold', () async {
      await dao.setDeleteAfterHours(48);
      final s = await dao.getOne();
      expect(s!.deleteAfterHours, 48);
    });

    test('setDeleteAfterHours with 0 sets null', () async {
      await dao.setDeleteAfterHours(48);
      await dao.setDeleteAfterHours(0);
      final s = await dao.getOne();
      expect(s!.deleteAfterHours, isNull);
    });

    test('setDeleteAfterHours with negative sets null', () async {
      await dao.setDeleteAfterHours(-1);
      final s = await dao.getOne();
      expect(s!.deleteAfterHours, isNull);
    });

    test('setKeepLatestN updates retention limit', () async {
      await dao.setKeepLatestN(5);
      final s = await dao.getOne();
      expect(s!.keepLatestN, 5);
    });

    test('setKeepLatestN with 0 sets null', () async {
      await dao.setKeepLatestN(5);
      await dao.setKeepLatestN(0);
      final s = await dao.getOne();
      expect(s!.keepLatestN, isNull);
    });

    test('setAutodownloadSubscribed updates flag', () async {
      await dao.setAutodownloadSubscribed(true);
      final s = await dao.getOne();
      expect(s!.autodownloadSubscribed, true);

      await dao.setAutodownloadSubscribed(false);
      final s2 = await dao.getOne();
      expect(s2!.autodownloadSubscribed, false);
    });
  });
}
