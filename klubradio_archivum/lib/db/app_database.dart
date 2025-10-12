// lib/db/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// ---------- Tabellen ----------

class Subscriptions extends Table {
  TextColumn get podcastId => text()(); // Primary Key
  TextColumn get title => text()();
  TextColumn get imageUrl => text().nullable()();
  IntColumn get autoDownloadN =>
      integer().withDefault(const Constant(5))(); // 1/3/5/20/100
  IntColumn get keepLatestN => integer().nullable()(); // z.B. 5
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {podcastId};
}

class Episodes extends Table {
  TextColumn get id => text()(); // Primary Key (episodeId)
  TextColumn get podcastId => text()();
  TextColumn get title => text()();
  TextColumn get audioUrl => text()();
  DateTimeColumn get publishedAt => dateTime().nullable()();

  /// Download-Status:
  /// 0=none, 1=queued, 2=downloading, 3=completed, 4=failed, 5=canceled
  IntColumn get status => integer().withDefault(const Constant(0))();
  RealColumn get progress => real().withDefault(const Constant(0))(); // 0..1
  TextColumn get localPath => text().nullable()();
  IntColumn get bytesDownloaded => integer().nullable()();
  IntColumn get totalBytes => integer().nullable()();

  /// Nutzung/Retention
  DateTimeColumn get playedAt => dateTime().nullable()(); // gehört?
  DateTimeColumn get completedAt => dateTime().nullable()(); // fertig geladen
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  BoolColumn get resumable => boolean().nullable()(); // true/false/null

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(podcast_id) REFERENCES subscriptions(podcast_id) ON DELETE CASCADE',
  ];
}

class Settings extends Table {
  IntColumn get id => integer()(); // stets 1
  BoolColumn get wifiOnly => boolean().withDefault(const Constant(true))();
  IntColumn get maxParallel => integer().withDefault(const Constant(2))();
  IntColumn get deleteAfterHours =>
      integer().nullable()(); // z.B. 24 (am nächsten Tag)
  IntColumn get keepLatestN => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// ---------- DB ----------

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'klubradio.db'));
    // Stabil + Threaded I/O
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [Subscriptions, Episodes, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => await m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(settings, settings.keepLatestN);
      }
      if (from < 3) {
        await m.addColumn(episodes, episodes.resumable);
      }
    },
  );

  /// Convenience: Timestamps aktualisieren
  Future<int> touchEpisode(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(updatedAt: Value(DateTime.now())),
      );

  Future<int> touchSubscription(String podcastId) =>
      (update(subscriptions)..where((s) => s.podcastId.equals(podcastId)))
          .write(SubscriptionsCompanion(updatedAt: Value(DateTime.now())));
}
