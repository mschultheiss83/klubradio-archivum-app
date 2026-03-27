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
}
