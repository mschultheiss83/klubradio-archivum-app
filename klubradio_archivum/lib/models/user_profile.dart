// lib/models/user_profile.dart
import 'dart:convert';
import 'episode.dart';

class UserProfile {
  final String id; // anonymous app id
  final String languageCode; // 'de' | 'en' | 'hu'
  final double playbackSpeed; // 0.5..3.0
  final int maxAutoDownload; // z.B. 10
  final Set<String> subscribedPodcastIds;
  final Set<String> favouriteEpisodeIds;
  final List<Episode> recentlyPlayed;

  const UserProfile({
    required this.id,
    required this.languageCode,
    required this.playbackSpeed,
    required this.maxAutoDownload,
    required this.subscribedPodcastIds,
    required this.favouriteEpisodeIds,
    required this.recentlyPlayed,
  });

  UserProfile copyWith({
    String? id,
    String? languageCode,
    double? playbackSpeed,
    int? maxAutoDownload,
    Set<String>? subscribedPodcastIds,
    List<Episode>? recentlyPlayed,
    Set<String>? favouriteEpisodeIds,
  }) {
    return UserProfile(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      maxAutoDownload: maxAutoDownload ?? this.maxAutoDownload,
      subscribedPodcastIds: subscribedPodcastIds ?? this.subscribedPodcastIds,
      favouriteEpisodeIds: favouriteEpisodeIds ?? this.favouriteEpisodeIds,
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
    );
  }

  factory UserProfile.initial(String id, {String languageCode = 'de'}) {
    return UserProfile(
      id: id,
      languageCode: languageCode,
      playbackSpeed: 1.0,
      maxAutoDownload: 10,
      subscribedPodcastIds: <String>{},
      favouriteEpisodeIds: <String>{},
      recentlyPlayed: const <Episode>[],
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Migration: akzeptiere alte Felder stillschweigend, falls noch vorhanden
    return UserProfile(
      id: json['id'] as String,
      languageCode: (json['languageCode'] ?? 'de') as String,
      playbackSpeed: (json['playbackSpeed'] as num?)?.toDouble() ?? 1.0,
      maxAutoDownload: (json['maxAutoDownload'] as num?)?.toInt() ?? 10,
      subscribedPodcastIds:
          (json['subscribedPodcastIds'] as List?)
              ?.map((e) => e.toString())
              .toSet() ??
          <String>{},
      recentlyPlayed:
          (json['recentlyPlayed'] as List?)
              ?.map((e) => Episode.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          <Episode>[],
      favouriteEpisodeIds:
          (json['favouriteEpisodeIds'] as List?)
              ?.map((e) => e.toString())
              .toSet() ??
          <String>{},
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'languageCode': languageCode,
    'playbackSpeed': playbackSpeed,
    'maxAutoDownload': maxAutoDownload,
    'subscribedPodcastIds': subscribedPodcastIds.toList(),
    'recentlyPlayed': recentlyPlayed.map((e) => e.toJson()).toList(),
    'favouriteEpisodeIds': favouriteEpisodeIds.toList(),
  };

  @override
  String toString() => jsonEncode(toJson());
}
