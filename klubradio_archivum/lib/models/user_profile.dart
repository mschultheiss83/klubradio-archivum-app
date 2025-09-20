class UserProfile {
  const UserProfile({
    required this.id,
    required this.displayName,
    required this.email,
    this.avatarUrl = '',
    this.subscribedPodcastIds = const <String>[],
    this.downloadedEpisodeIds = const <String>[],
    this.recentlyPlayedEpisodeIds = const <String>[],
    this.maxAutoDownloadEpisodes = 5,
    this.notificationsEnabled = false,
  });

  final String id;
  final String displayName;
  final String email;
  final String avatarUrl;
  final List<String> subscribedPodcastIds;
  final List<String> downloadedEpisodeIds;
  final List<String> recentlyPlayedEpisodeIds;
  final int maxAutoDownloadEpisodes;
  final bool notificationsEnabled;

  UserProfile copyWith({
    String? id,
    String? displayName,
    String? email,
    String? avatarUrl,
    List<String>? subscribedPodcastIds,
    List<String>? downloadedEpisodeIds,
    List<String>? recentlyPlayedEpisodeIds,
    int? maxAutoDownloadEpisodes,
    bool? notificationsEnabled,
  }) {
    return UserProfile(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      subscribedPodcastIds:
          subscribedPodcastIds ?? this.subscribedPodcastIds,
      downloadedEpisodeIds:
          downloadedEpisodeIds ?? this.downloadedEpisodeIds,
      recentlyPlayedEpisodeIds:
          recentlyPlayedEpisodeIds ?? this.recentlyPlayedEpisodeIds,
      maxAutoDownloadEpisodes:
          maxAutoDownloadEpisodes ?? this.maxAutoDownloadEpisodes,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id']?.toString() ?? '',
      displayName: json['display_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      avatarUrl: json['avatar_url']?.toString() ?? '',
      subscribedPodcastIds: (json['subscribed_podcast_ids'] as List<dynamic>?)
              ?.map((value) => value.toString())
              .toList() ??
          const <String>[],
      downloadedEpisodeIds: (json['downloaded_episode_ids'] as List<dynamic>?)
              ?.map((value) => value.toString())
              .toList() ??
          const <String>[],
      recentlyPlayedEpisodeIds:
          (json['recently_played_episode_ids'] as List<dynamic>?)
                  ?.map((value) => value.toString())
                  .toList() ??
              const <String>[],
      maxAutoDownloadEpisodes:
          json['max_auto_download_episodes'] is int
              ? json['max_auto_download_episodes'] as int
              : int.tryParse(
                      json['max_auto_download_episodes']?.toString() ?? '') ??
                  5,
      notificationsEnabled: json['notifications_enabled'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'display_name': displayName,
      'email': email,
      'avatar_url': avatarUrl,
      'subscribed_podcast_ids': subscribedPodcastIds,
      'downloaded_episode_ids': downloadedEpisodeIds,
      'recently_played_episode_ids': recentlyPlayedEpisodeIds,
      'max_auto_download_episodes': maxAutoDownloadEpisodes,
      'notifications_enabled': notificationsEnabled,
    };
  }
}
