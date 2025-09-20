import 'dart:convert';

import 'episode.dart';

class UserProfile {
  UserProfile({
    required this.id,
    required this.displayName,
    this.email,
    this.avatarUrl,
    this.languageCode = 'hu',
    this.playbackSpeed = 1.0,
    this.maxAutoDownload = 5,
    this.subscribedPodcastIds = const <String>{},
    this.recentlyPlayed = const <Episode>[],
    this.favouriteEpisodeIds = const <String>{},
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final subscribed = json['subscribedPodcastIds'];
    final favourites = json['favouriteEpisodeIds'];
    final recentlyPlayedJson = json['recentlyPlayed'];
    return UserProfile(
      id: json['id'].toString(),
      displayName: json['displayName'] as String? ?? 'Hallgató',
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      languageCode: json['languageCode'] as String? ?? 'hu',
      playbackSpeed: (json['playbackSpeed'] as num?)?.toDouble() ?? 1.0,
      maxAutoDownload: json['maxAutoDownload'] as int? ?? 5,
      subscribedPodcastIds: subscribed is List
          ? subscribed.map((dynamic id) => id.toString()).toSet()
          : const <String>{},
      recentlyPlayed: recentlyPlayedJson is List
          ? recentlyPlayedJson
              .whereType<Map<String, dynamic>>()
              .map(Episode.fromJson)
              .toList()
          : const <Episode>[],
      favouriteEpisodeIds: favourites is List
          ? favourites.map((dynamic id) => id.toString()).toSet()
          : const <String>{},
    );
  }

  final String id;
  final String displayName;
  final String? email;
  final String? avatarUrl;
  final String languageCode;
  final double playbackSpeed;
  final int maxAutoDownload;
  final Set<String> subscribedPodcastIds;
  final List<Episode> recentlyPlayed;
  final Set<String> favouriteEpisodeIds;

  UserProfile copyWith({
    String? id,
    String? displayName,
    String? email,
    String? avatarUrl,
    String? languageCode,
    double? playbackSpeed,
    int? maxAutoDownload,
    Set<String>? subscribedPodcastIds,
    List<Episode>? recentlyPlayed,
    Set<String>? favouriteEpisodeIds,
  }) {
    return UserProfile(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      languageCode: languageCode ?? this.languageCode,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      maxAutoDownload: maxAutoDownload ?? this.maxAutoDownload,
      subscribedPodcastIds:
          subscribedPodcastIds ?? Set<String>.from(this.subscribedPodcastIds),
      recentlyPlayed: recentlyPlayed ?? List<Episode>.from(this.recentlyPlayed),
      favouriteEpisodeIds:
          favouriteEpisodeIds ?? Set<String>.from(this.favouriteEpisodeIds),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'displayName': displayName,
      'email': email,
      'avatarUrl': avatarUrl,
      'languageCode': languageCode,
      'playbackSpeed': playbackSpeed,
      'maxAutoDownload': maxAutoDownload,
      'subscribedPodcastIds': subscribedPodcastIds.toList(),
      'recentlyPlayed': recentlyPlayed.map((Episode e) => e.toJson()).toList(),
      'favouriteEpisodeIds': favouriteEpisodeIds.toList(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
