// lib/db/daos.dart
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'; // Import for debugPrint

import 'package:drift/drift.dart';
import 'app_database.dart';

part 'daos.g.dart';

/// ---------------- Subscriptions DAO ----------------

@DriftAccessor(tables: [Subscriptions])
class SubscriptionsDao extends DatabaseAccessor<AppDatabase>
    with _$SubscriptionsDaoMixin {
  SubscriptionsDao(super.db);

  Future<void> upsert(SubscriptionsCompanion data) =>
      into(subscriptions).insertOnConflictUpdate(data);

  Future<Subscription?> getById(String podcastId) async {
    return (select(
      subscriptions,
    )..where((s) => s.podcastId.equals(podcastId))).getSingleOrNull();
  }

  // Live-State für einen Podcast (Button/UI)
  Stream<Subscription?> watchOne(String podcastId) {
    return (select(
      subscriptions,
    )..where((s) => s.podcastId.equals(podcastId))).watchSingleOrNull();
  }

  // alle aktiven Abos streamen (z. B. Auto-Download beim App-Start)
  Stream<List<Subscription>> watchAllActive() {
    return (select(subscriptions)..where((s) => s.active.equals(true))).watch();
  }

  // bool: abonniert?
  Future<bool> isSubscribed(String podcastId) async {
    final row = await getById(podcastId);
    return row?.active == true;
  }

  // aktivieren/deaktivieren OHNE Titel/Bild – nur Status & Rules
  Future<void> toggleSubscribe({
    required String podcastId,
    bool? active, // optional: explizit setzen
    int? autoDownloadN, // optional: Regel mitgeben
  }) async {
    final existing = await getById(podcastId);
    if (existing == null) {
      await into(subscriptions).insert(
        SubscriptionsCompanion.insert(
          podcastId: podcastId,
          active: Value(active ?? true),
          autoDownloadN: Value(autoDownloadN),
        ),
      );
    } else {
      final toActive = active ?? !existing.active;
      await (update(
        subscriptions,
      )..where((s) => s.podcastId.equals(podcastId))).write(
        SubscriptionsCompanion(
          active: Value(toActive),
          // Regel übernehmen, wenn übergeben
          autoDownloadN: autoDownloadN == null
              ? const Value.absent()
              : Value(autoDownloadN),
        ),
      );
    }
  }

  // Regel-Setter
  Future<int> setAutoDownloadN(String podcastId, int? n) {
    // 0 => null (aus)
    final normalized = (n ?? 0) <= 0 ? null : n;
    return (update(subscriptions)..where((s) => s.podcastId.equals(podcastId)))
        .write(SubscriptionsCompanion(autoDownloadN: Value(normalized)));
  }

  // Fortschritt updaten (optional)
  Future<int> setLastHeard(String podcastId, String episodeId) {
    return (update(subscriptions)..where((s) => s.podcastId.equals(podcastId)))
        .write(SubscriptionsCompanion(lastHeardEpisodeId: Value(episodeId)));
  }

  Future<int> setLastDownloaded(String podcastId, String episodeId) {
    return (update(
      subscriptions,
    )..where((s) => s.podcastId.equals(podcastId))).write(
      SubscriptionsCompanion(lastDownloadedEpisodeId: Value(episodeId)),
    );
  }
}

/// ---------------- Episodes DAO ----------------

@DriftAccessor(tables: [Episodes, Subscriptions])
class EpisodesDao extends DatabaseAccessor<AppDatabase>
    with _$EpisodesDaoMixin {
  EpisodesDao(super.db);

  // Upsert einzelner Episode
  Future<void> upsert(EpisodesCompanion data) =>
      into(episodes).insertOnConflictUpdate(data);

  // Bulk-Upsert (z. B. vom API-Refresh)
  Future<void> upsertAll(List<EpisodesCompanion> many) async {
    await batch((b) => b.insertAllOnConflictUpdate(episodes, many));
  }

  Future<Episode?> getById(String id) =>
      (select(episodes)..where((e) => e.id.equals(id))).getSingleOrNull();

  // Neueste N Episoden für einen Podcast (für Auto-Download-Queue)
  Future<List<Episode>> latestForPodcast(String podcastId, int n) {
    final q = select(episodes)
      ..where((e) => e.podcastId.equals(podcastId))
      ..orderBy([(e) => OrderingTerm.desc(e.publishedAt)])
      ..limit(n);
    return q.get();
  }

  Future<List<Episode>> getEpisodesByPodcastId(String podcastId) {
    return (select(episodes)..where((e) => e.podcastId.equals(podcastId))).get();
  }

  // Status-/Progress-Updates (Download-Lifecycle)
  Future<int> setQueued(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(
          status: const Value(1), // queued
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<int> setDownloading(
    String id, {
    double? progress,
    int? bytes,
    int? total,
  }) => (update(episodes)..where((e) => e.id.equals(id))).write(
    EpisodesCompanion(
      status: const Value(2), // downloading
      progress: progress == null ? const Value.absent() : Value(progress),
      bytesDownloaded: bytes == null ? const Value.absent() : Value(bytes),
      totalBytes: total == null ? const Value.absent() : Value(total),
      updatedAt: Value(DateTime.now()),
    ),
  );

  Future<int> setProgress(
    String id,
    double progress, {
    int? bytes,
    int? total,
  }) => (update(episodes)..where((e) => e.id.equals(id))).write(
    EpisodesCompanion(
      progress: Value(progress),
      bytesDownloaded: bytes == null ? const Value.absent() : Value(bytes),
      totalBytes: total == null ? const Value.absent() : Value(total),
      updatedAt: Value(DateTime.now()),
    ),
  );

  Future<int> setCompleted(
    String id,
    String localPath, {
    int? bytes,
    int? total,
  }) async {
    debugPrint('DAO.setCompleted id=$id path=$localPath');
    return (update(episodes)..where((e) => e.id.equals(id))).write(
      EpisodesCompanion(
        status: const Value(3),
        // completed
        progress: const Value(1.0),
        localPath: Value(localPath),
        bytesDownloaded: bytes == null ? const Value.absent() : Value(bytes),
        totalBytes: total == null ? const Value.absent() : Value(total),
        completedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> setFailed(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(
          status: const Value(4), // failed
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<int> setCanceled(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(
          status: const Value(5), // canceled
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<int> markPlayed(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        EpisodesCompanion(
          playedAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  // Nach File-Löschung: DB-Felder bereinigen
  Future<int> clearLocalFile(String id) =>
      (update(episodes)..where((e) => e.id.equals(id))).write(
        const EpisodesCompanion(
          localPath: Value(null),
          status: Value(0), // none
        ),
      );

  // Streams für UI
  Stream<List<Episode>> watchByPodcast(String podcastId) =>
      (select(episodes)..where((e) => e.podcastId.equals(podcastId))).watch();

  Stream<List<Episode>> watchActiveDownloads() =>
      (select(episodes)
            ..where((e) => e.status.isIn([1, 2]))) // queued or downloading
          .watch();

  // Für Retention: alle completed mit File, neueste zuerst
  Future<List<Episode>> completedWithFileDesc(String podcastId) =>
      (select(episodes)
            ..where(
              (e) =>
                  e.podcastId.equals(podcastId) &
                  e.status.equals(3) &
                  e.localPath.isNotNull(),
            )
            ..orderBy([(e) => OrderingTerm.desc(e.completedAt)]))
          .get();

  // Für Retention: gehört + älter als threshold, mit File
  Future<List<Episode>> playedBefore(DateTime threshold) =>
      (select(episodes)..where(
            (e) =>
                e.playedAt.isSmallerThanValue(threshold) &
                e.localPath.isNotNull(),
          ))
          .get();

  // Auto-Download: markiere die neuesten N als queued (ohne bereits completed)
  Future<void> enqueueLatestN(String podcastId, int n) async {
    final latest = await latestForPodcast(podcastId, n);
    await batch((b) {
      for (final ep in latest) {
        if (ep.status == 0 || ep.status == 4 || ep.status == 5) {
          b.update(
            episodes,
            EpisodesCompanion(
              status: const Value(1),
              updatedAt: Value(DateTime.now()),
            ),
            where: (tbl) => tbl.id.equals(ep.id),
          );
        }
      }
    });
  }

  Future<int> setCachedMeta(
    String id, {
    String? title,
    String? imagePath,
    String? metaPath,
  }) {
    return (update(episodes)..where((e) => e.id.equals(id))).write(
      EpisodesCompanion(
        cachedTitle: title == null ? const Value.absent() : Value(title),
        cachedImagePath: imagePath == null
            ? const Value.absent()
            : Value(imagePath),
        cachedMetaPath: metaPath == null
            ? const Value.absent()
            : Value(metaPath),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

/// ---------------- Settings DAO ----------------

@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Future<Setting?> getOne() =>
      (select(settings)..where((s) => s.id.equals(1))).getSingleOrNull();

  Future<void> ensureDefaults() async {
    final wifiDefault = Platform.isAndroid || Platform.isIOS ? true : false;
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion(
        id: const Value(1),
        wifiOnly: Value(wifiDefault), // mobil: an, desktop: aus
        maxParallel: const Value(2),
        deleteAfterHours: const Value(null), // AUS
        keepLatestN: const Value(null), // AUS
        autodownloadSubscribed: const Value(false),
      ),
    );
  }

  Future<int> setWifiOnly(bool v) => (update(
    settings,
  )..where((s) => s.id.equals(1))).write(SettingsCompanion(wifiOnly: Value(v)));

  Future<int> setMaxParallel(int n) =>
      (update(settings)..where((s) => s.id.equals(1))).write(
        SettingsCompanion(maxParallel: Value(n)),
      );

  Future<int> setDeleteAfterHours(int? h) =>
      (update(settings)..where((s) => s.id.equals(1))).write(
        SettingsCompanion(deleteAfterHours: Value((h ?? 0) <= 0 ? null : h)),
      );

  Future<int> setKeepLatestN(int? n) =>
      (update(settings)..where((s) => s.id.equals(1))).write(
        SettingsCompanion(keepLatestN: Value((n ?? 0) <= 0 ? null : n)),
      );

  Future<int> setAutodownloadSubscribed(bool v) =>
      (update(settings)..where((s) => s.id.equals(1))).write(
        SettingsCompanion(autodownloadSubscribed: Value(v)),
      );
}

/// ---------------- Retention Helper (DB-seitig) ----------------
/// Diese Funktionen liefern NUR die Kandidaten.
/// Das tatsächliche Dateilöschen passiert in der Service-Schicht.

class RetentionPlan {
  RetentionPlan({required this.toDeleteIds});
  final List<String> toDeleteIds;
}

class RetentionDao {
  RetentionDao(
    this.db,
    this.episodesDao,
    this.subscriptionsDao,
    this.settingsDao,
  );

  final AppDatabase db;
  final EpisodesDao episodesDao;
  final SubscriptionsDao subscriptionsDao;
  final SettingsDao settingsDao;

  /// Errechne zu löschende Episoden IDs gemäß:
  /// - deleteAfterHours (playedAt + h)
  /// - keepLatestN je Podcast
  Future<RetentionPlan> computePlanForPodcast(String podcastId) async {
    final planIds = <String>[];

    // 1) deleteAfterHours-Regel (global)
    final s = await settingsDao.getOne();

    // deleteAfterHours nur wenn > 0
    if (s?.deleteAfterHours != null && s!.deleteAfterHours! > 0) {
      final threshold = DateTime.now().subtract(
        Duration(hours: s.deleteAfterHours!),
      );
      final oldPlayed = await episodesDao.playedBefore(threshold);
      for (final ep in oldPlayed.where((e) => e.podcastId == podcastId)) {
        planIds.add(ep.id);
      }
    }

    // keepLatestN nur wenn > 0
    final global = await settingsDao.getOne();
    final keepN = global?.keepLatestN;

    if (keepN != null && keepN > 0) {
      final done = await episodesDao.completedWithFileDesc(podcastId);
      if (done.length > keepN) {
        final extra = done.sublist(keepN);
        planIds.addAll(extra.map((e) => e.id));
      }
    }

    // Deduplizieren
    final unique = planIds.toSet().toList();
    return RetentionPlan(toDeleteIds: unique);
  }
}
