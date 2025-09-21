class Episode {
  const Episode({
    required this.id,
    required this.podcastId,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.duration,
    required this.publishedAt,
    this.thumbnailUrl,
    this.localFilePath,
  });

  final String id;
  final String podcastId;
  final String title;
  final String description;
  final String audioUrl;
  final Duration duration;
  final DateTime publishedAt;
  final String? thumbnailUrl;
  final String? localFilePath;

  Episode copyWith({
    String? id,
    String? podcastId,
    String? title,
    String? description,
    String? audioUrl,
    Duration? duration,
    DateTime? publishedAt,
    String? thumbnailUrl,
    String? localFilePath,
  }) {
    return Episode(
      id: id ?? this.id,
      podcastId: podcastId ?? this.podcastId,
      title: title ?? this.title,
      description: description ?? this.description,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      publishedAt: publishedAt ?? this.publishedAt,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      localFilePath: localFilePath ?? this.localFilePath,
    );
  }

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id']?.toString() ?? '',
      podcastId: json['podcast_id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Ismeretlen epizód',
      description: json['description']?.toString() ?? '',
      audioUrl: json['audio_url']?.toString() ?? '',
      duration: _durationFromJson(json['duration'] ?? json['duration_seconds']),
      publishedAt: _dateFromJson(json['published_at'] ?? json['date']),
      thumbnailUrl: json['thumbnail_url']?.toString(),
      localFilePath: json['local_file_path']?.toString(),
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
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (localFilePath != null) 'local_file_path': localFilePath,
    };
  }

  static Duration _durationFromJson(dynamic value) {
    if (value is Duration) {
      return value;
    }
    if (value is int) {
      return Duration(seconds: value);
    }
    if (value is String) {
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

  static DateTime _dateFromJson(dynamic value) {
    if (value is DateTime) {
      return value;
    }
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value * 1000);
    }
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }

  @override
  int get hashCode => Object.hash(
        id,
        podcastId,
        title,
        description,
        audioUrl,
        duration,
        publishedAt,
        thumbnailUrl,
        localFilePath,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Episode &&
        other.id == id &&
        other.podcastId == podcastId &&
        other.title == title &&
        other.description == description &&
        other.audioUrl == audioUrl &&
        other.duration == duration &&
        other.publishedAt == publishedAt &&
        other.thumbnailUrl == thumbnailUrl &&
        other.localFilePath == localFilePath;
  }
}
