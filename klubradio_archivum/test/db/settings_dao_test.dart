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
}
