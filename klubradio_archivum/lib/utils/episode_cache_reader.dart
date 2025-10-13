import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:klubradio_archivum/models/episode.dart' as model;

/// Liest eine Episode aus der Cache-JSON (…/<episodeId>.json).
/// - Unterstützt `cachedImageFile` & `mp3File` (relativ), wandelt zu absoluten Pfaden.
/// - Nutzt möglichst alle API-Felder aus der JSON.
/// - Setzt cachedTitle / cachedImagePath / cachedMetaPath,
///   damit die UI offline direkt mit FS > Web arbeiten kann.
Future<model.Episode?> readEpisodeFromCacheJson(String cachedMetaPath) async {
  try {
    final file = File(cachedMetaPath);
    if (!await file.exists()) return null;

    final parent = p.dirname(cachedMetaPath);
    final map = jsonDecode(await file.readAsString()) as Map<String, dynamic>;

    // JSON Felder
    final id = _asString(map['id']) ?? '';
    final podcastId = _asString(map['podcastId']) ?? '';
    final title = _asString(map['title']) ?? '';
    final description = _asString(map['description']) ?? '';
    final audioUrl = _asString(map['audioUrl']) ?? '';
    final showDate = _asString(map['showDate']) ?? '';
    final durationSec = _asInt(map['duration']) ?? 0;
    final publishedAtIso = _asString(map['publishedAt']);
    final publishedAt = publishedAtIso != null
        ? DateTime.tryParse(publishedAtIso) ?? DateTime.now()
        : DateTime.now();
    final imageUrl = _asString(map['imageUrl']);
    final hosts = _asStringList(map['hosts']) ?? const <String>[];

    // lokale (relative) Verweise
    final cachedImageFile = _asString(map['cachedImageFile']);
    final mp3File = _asString(map['mp3File']);

    final cachedImagePath =
        (cachedImageFile != null && cachedImageFile.isNotEmpty)
        ? p.join(parent, cachedImageFile)
        : null;
    final localFilePath = (mp3File != null && mp3File.isNotEmpty)
        ? p.join(parent, mp3File)
        : null;

    return model.Episode(
      id: id,
      podcastId: podcastId,
      title: title,
      description: description,
      audioUrl: audioUrl,
      publishedAt: publishedAt,
      showDate: showDate,
      duration: Duration(seconds: durationSec),
      imageUrl: imageUrl, // Web-Fallback bleibt verfügbar
      hosts: hosts,
      // Download/UI Felder
      localFilePath: localFilePath, // lokale MP3 falls vorhanden
      cachedTitle: title, // fürs Offline-Listing
      cachedImagePath: cachedImagePath, // FS > Web in Image-Widget
      cachedMetaPath: cachedMetaPath, // woher es kam
    );
  } catch (_) {
    return null;
  }
}

String? _asString(dynamic v) {
  if (v == null) return null;
  return v.toString();
}

int? _asInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  return int.tryParse(v.toString());
}

List<String>? _asStringList(dynamic v) {
  if (v == null) return null;
  if (v is List) return v.map((e) => e.toString()).toList();
  return null;
}
