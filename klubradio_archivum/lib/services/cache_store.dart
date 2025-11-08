import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CacheStore {
  Future<File> _file(String name) async {
    final dir = await getApplicationSupportDirectory();
    final cacheDir = Directory('${dir.path}/Klubradio/cache');
    if (!await cacheDir.exists()) await cacheDir.create(recursive: true);
    return File('${cacheDir.path}/$name');
  }

  Future<Map<String, dynamic>?> read(String name) async {
    final f = await _file(name);
    if (!await f.exists()) return null;
    try {
      return jsonDecode(await f.readAsString()) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> write(String name, List<Map<String, dynamic>> items) async {
    final f = await _file(name);
    final payload = jsonEncode({
      'updatedAt': DateTime.now().toIso8601String(),
      'items': items,
    });
    await f.writeAsString(payload, flush: true);
  }
}
