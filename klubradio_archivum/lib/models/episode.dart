import 'dart:convert';

class Episode {
  const Episode({
    required this.id,
    required this.podcastId,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.duration,
    required this.publishedAt,
    this.imageUrl = '',
    this.isDownloaded = false,
    this.localFilePath,
    this.playbackPosition = Duration.zero,
  });

  final String id;
  final String podcastId;
  final String title;
  final String description;
  final String audioUrl;
  final Duration duration;
  final DateTime publishedAt;
  final String imageUrl;
  final bool isDownloaded;
  final String? localFilePath;
  final Duration playbackPosition;

  Episode copyWith({
    String? id,
    String? podcastId,
    String? title,
    String? description,
    String? audioUrl,
    Duration? duration,
    DateTime? publishedAt,
    String? imageUrl,
    bool? isDownloaded,
    String? localFilePath,
    Duration? playbackPosition,
  }) {
    return Episode(
      id: id ?? this.id,
      podcastId: podcastId ?? this.podcastId,
      title: title ?? this.title,
      description: description ?? this.description,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      publishedAt: publishedAt ?? this.publishedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      localFilePath: localFilePath ?? this.localFilePath,
      playbackPosition: playbackPosition ?? this.playbackPosition,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'podcast_id': podcastId,
      'title': title,
      'description': description,
      'audio_url': audioUrl,
      'duration_seconds': duration.inSeconds,
      'published_at': publishedAt.toIso8601String(),
      'image_url': imageUrl,
      'is_downloaded': isDownloaded,
      'local_file_path': localFilePath,
      'playback_position_seconds': playbackPosition.inSeconds,
    };
  }

  factory Episode.fromJson(Map<String, dynamic> json) {
    final durationValue = json['duration_seconds'];
    final playbackValue = json['playback_position_seconds'];

    return Episode(
      id: json['id']?.toString() ?? '',
      podcastId: json['podcast_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      audioUrl: json['audio_url']?.toString() ?? '',
      duration: _parseDuration(durationValue),
      publishedAt: _parseDate(json['published_at']),
      imageUrl: json['image_url']?.toString() ?? '',
      isDownloaded: json['is_downloaded'] == true,
      localFilePath: json['local_file_path']?.toString(),
      playbackPosition: _parseDuration(playbackValue),
    );
  }

  static Duration _parseDuration(dynamic value) {
    if (value == null) {
      return Duration.zero;
    }

    if (value is int) {
      return Duration(seconds: value);
    }

    if (value is double) {
      return Duration(milliseconds: (value * 1000).round());
    }

    if (value is String && value.isNotEmpty) {
      final parsed = int.tryParse(value);
      if (parsed != null) {
        return Duration(seconds: parsed);
      }
      final components = value.split(':');
      if (components.length == 3) {
        final hours = int.tryParse(components[0]) ?? 0;
        final minutes = int.tryParse(components[1]) ?? 0;
        final seconds = int.tryParse(components[2]) ?? 0;
        return Duration(hours: hours, minutes: minutes, seconds: seconds);
      }
    }

    return Duration.zero;
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) {
      return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    }

    if (value is DateTime) {
      return value.toLocal();
    }

    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value * 1000, isUtc: true)
          .toLocal();
    }

    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value)?.toLocal() ?? DateTime.now();
    }

    return DateTime.now();
  }

  static List<Episode> decodeList(String source) {
    final List<dynamic> rawList = jsonDecode(source) as List<dynamic>;
    return rawList
        .whereType<Map<String, dynamic>>()
        .map(Episode.fromJson)
        .toList();
  }

  static String encodeList(List<Episode> episodes) {
    return jsonEncode(episodes.map((episode) => episode.toJson()).toList());
  }
}
