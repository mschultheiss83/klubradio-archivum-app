import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<QueryExecutor> openConnection() async {
  final dir = (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
      ? await getApplicationSupportDirectory()
      : await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'klubradio.db'));
  return NativeDatabase.createInBackground(file);
}
