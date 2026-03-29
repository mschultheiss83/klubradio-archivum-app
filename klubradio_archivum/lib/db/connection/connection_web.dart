// Uses the legacy drift/web.dart (localStorage-based) instead of drift/wasm.dart
// to avoid requiring sqlite3.wasm and drift_worker.js files in the web build.
// The DB is barely used on web (downloads/subscriptions are disabled via
// PlatformUtils guards), so the deprecation trade-off is acceptable.
// ignore_for_file: deprecated_member_use
import 'package:drift/drift.dart';
import 'package:drift/web.dart';

Future<QueryExecutor> openConnection() async {
  return WebDatabase('klubradio_archivum');
}
