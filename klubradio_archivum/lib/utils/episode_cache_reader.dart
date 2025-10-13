// lib/utils/episode_cache_reader.dart
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:klubradio_archivum/models/episode.dart' as model;

/// Liest eine Episode aus der Cache-JSON (reiches Format ab schemaVersion 1).
/// Gibt null zurück, wenn Datei fehlt oder JSON unbrauchbar ist.
Future<model.Episode?> readEpisodeFromCacheJson(String metaPath) async {
  try {
    final file = File(metaPath);
    if (!await file.exists()) return null;

    final dir = file.parent.path;
    final map = jsonDecode(await file.readAsString());
    if (map is! Map<String, dynamic>) return null;

    // Schema prüfen (optional, tolerant)
    final schemaVersion = (map['schemaVersion'] is int)
        ? map['schemaVersion'] as int
        : 0;
    if (schemaVersion < 1) {
      // very old/minimal JSON – versuchen wir es trotzdem best-effort
    }

    String _str(String key, [String fallback = '']) {
      final v = map[key];
      return (v is String) ? v : fallback;
    }

    int _int(String key, [int fallback = 0]) {
      final v = map[key];
      if (v is int) return v;
      if (v is num) return v.toInt();
      return fallback;
    }

    List<String> _strList(String key) {
      final v = map[key];
      if (v is List) {
        return v.whereType<String>().toList(growable: false);
      }
      return const <String>[];
    }

    DateTime? _dt(String key) {
      final v = map[key];
      if (v is String && v.isNotEmpty) {
        try {
          return DateTime.parse(v);
        } catch (_) {}
      }
      return null;
    }

    final id = _str('id');
    final podcastId = _str('podcastId');
    if (id.isEmpty || podcastId.isEmpty) return null;

    final title = _str('title');
    final description = _str('description');
    final audioUrl = _str('audioUrl');

    // publishedAt (Fallback: createdAt)
    final publishedAt =
        _dt('publishedAt') ?? _dt('createdAt') ?? DateTime.now();

    // Dauer in Sekunden
    final durationSecs = _int('duration', 0);
    final duration = Duration(seconds: durationSecs);

    // bereits formatiert (von dir) – übernehmen wie ist
    final showDate = _str('showDate');

    final hosts = _strList('hosts');

    // Bild & MP3 – relative Dateinamen zu absoluten Pfaden auflösen
    final cachedImageFile = _str('cachedImageFile');
    final imageUrl = _str('imageUrl'); // nur als Fallback/Info
    final imageAbsPath = cachedImageFile.isNotEmpty
        ? p.join(dir, cachedImageFile)
        : null;

    final mp3Rel = _str('mp3File');
    final mp3AbsPath = mp3Rel.isNotEmpty ? p.join(dir, mp3Rel) : null;

    // Modell befüllen – Felder benutzen, die dein Player/Provider erwartet
    return model.Episode(
      id: id,
      podcastId: podcastId,
      title: title,
      description: description,
      audioUrl: audioUrl,
      imageUrl: imageUrl.isNotEmpty ? imageUrl : null,
      publishedAt: publishedAt,
      duration: duration,
      hosts: hosts,
      showDate: showDate,
      // Lokale Pfade zurück in dein Modell spiegeln:
      localFilePath: (mp3AbsPath != null && File(mp3AbsPath).existsSync())
          ? mp3AbsPath
          : null,
      cachedImagePath: (imageAbsPath != null && File(imageAbsPath).existsSync())
          ? imageAbsPath
          : null,
      cachedMetaPath: metaPath,
      // Falls du weitere optionale Felder im Model hast, hier setzbar.
    );
  } catch (_) {
    return null;
  }
}
