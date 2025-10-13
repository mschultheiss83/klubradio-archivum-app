import 'dart:convert';

enum DownloadStatus { notDownloaded, queued, downloading, downloaded, failed }

class Episode {
  Episode({
    required this.id,
    required this.podcastId,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.publishedAt,
    required this.showDate,
    required this.duration,
    this.imageUrl,
    this.hosts = const <String>[],
    this.isFavourite = false,
    this.downloadStatus = DownloadStatus.notDownloaded,
    this.downloadProgress = 0,
    this.localFilePath,
    this.cachedTitle,
    this.cachedImagePath,
    this.cachedMetaPath,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    final hostsJson = json['hosts'];
    return Episode(
      id: json['id'].toString(),
      podcastId: json['podcastId'].toString(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      audioUrl: json['audioUrl'] as String? ?? '',
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      showDate: json['showDate'] as String? ?? '',
      duration: json['duration'] is int
          ? Duration(seconds: json['duration'] as int)
          : _durationFromString(json['duration']?.toString()),
      imageUrl: json['imageUrl'] as String?,
      hosts: hostsJson is List
          ? hostsJson.map((dynamic e) => e.toString()).toList()
          : const <String>[],
      isFavourite: json['isFavourite'] as bool? ?? false,
      downloadStatus: _downloadStatusFromJson(json['downloadStatus']),
      downloadProgress: (json['downloadProgress'] as num?)?.toDouble() ?? 0,
      localFilePath: json['localFilePath'] as String?,
      cachedTitle: json['cachedTitle'] as String?,
      cachedImagePath: json['cachedImagePath'] as String?,
      cachedMetaPath: json['cachedMetaPath'] as String?,
    );
  }

  final String id;
  final String podcastId;
  final String title;
  final String description;
  final String audioUrl;
  final DateTime publishedAt;
  final String showDate;
  final Duration duration;
  final String? imageUrl;
  final List<String> hosts;
  final bool isFavourite;
  final DownloadStatus downloadStatus;
  final double downloadProgress;
  final String? localFilePath;

  final String? cachedTitle;
  final String? cachedImagePath;
  final String? cachedMetaPath;

  /// Bevorzugter Titel für UI (offline → cachedTitle, sonst title)
  String get displayTitle =>
      (cachedTitle != null && cachedTitle!.isNotEmpty) ? cachedTitle! : title;

  /// true, wenn ein lokal gecachtes Bild verfügbar ist
  bool get hasCachedImage =>
      (cachedImagePath != null && cachedImagePath!.isNotEmpty);

  /// Bevorzugte Bild-Quelle (Pfad oder URL): zuerst lokal, dann remote
  String? get displayImagePathOrUrl =>
      hasCachedImage ? cachedImagePath : imageUrl;

  /// Kennzeichnet, ob displayImagePathOrUrl eine lokale Datei ist
  bool get isDisplayImageLocal => hasCachedImage;

  Episode copyWith({
    String? id,
    String? podcastId,
    String? title,
    String? description,
    String? audioUrl,
    DateTime? publishedAt,
    String? showDate,
    Duration? duration,
    String? imageUrl,
    List<String>? hosts,
    bool? isFavourite,
    DownloadStatus? downloadStatus,
    double? downloadProgress,
    String? localFilePath,
    String? cachedTitle,
    String? cachedImagePath,
    String? cachedMetaPath,
  }) {
    return Episode(
      id: id ?? this.id,
      podcastId: podcastId ?? this.podcastId,
      title: title ?? this.title,
      description: description ?? this.description,
      audioUrl: audioUrl ?? this.audioUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      showDate: showDate ?? this.showDate,
      duration: duration ?? this.duration,
      imageUrl: imageUrl ?? this.imageUrl,
      hosts: hosts ?? List<String>.from(this.hosts),
      isFavourite: isFavourite ?? this.isFavourite,
      downloadStatus: downloadStatus ?? this.downloadStatus,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      localFilePath: localFilePath ?? this.localFilePath,
      cachedTitle: cachedTitle ?? this.cachedTitle,
      cachedImagePath: cachedImagePath ?? this.cachedImagePath,
      cachedMetaPath: cachedMetaPath ?? this.cachedMetaPath,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'podcastId': podcastId,
      'title': title,
      'description': description,
      'audioUrl': audioUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'showDate': showDate,
      'duration': duration.inSeconds,
      'imageUrl': imageUrl,
      'hosts': hosts,
      'isFavourite': isFavourite,
      'downloadStatus': downloadStatus.name,
      'downloadProgress': downloadProgress,
      'localFilePath': localFilePath,
      'cachedTitle': cachedTitle,
      'cachedImagePath': cachedImagePath,
      'cachedMetaPath': cachedMetaPath,
    };
  }

  static Duration _durationFromString(String? value) {
    if (value == null || value.isEmpty) return Duration.zero;
    final parts = value.split(':');
    if (parts.length == 3) {
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      final seconds = int.tryParse(parts[2]) ?? 0;
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    }
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      return Duration(minutes: minutes, seconds: seconds);
    }
    return Duration(seconds: int.tryParse(value) ?? 0);
  }

  static DownloadStatus _downloadStatusFromJson(dynamic value) {
    if (value == null) return DownloadStatus.notDownloaded;
    return DownloadStatus.values.firstWhere(
      (DownloadStatus status) => status.name == value.toString(),
      orElse: () => DownloadStatus.notDownloaded,
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}
