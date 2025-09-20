import 'episode.dart';
import 'show_host.dart';

class Podcast {
  const Podcast({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.coverImageUrl,
    required this.language,
    this.hosts = const <ShowHost>[],
    this.episodes = const <Episode>[],
    this.episodeCount = 0,
    this.isSubscribed = false,
    this.storageRssPath,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final String coverImageUrl;
  final String language;
  final List<ShowHost> hosts;
  final List<Episode> episodes;
  final int episodeCount;
  final bool isSubscribed;
  final String? storageRssPath;

  Podcast copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? coverImageUrl,
    String? language,
    List<ShowHost>? hosts,
    List<Episode>? episodes,
    int? episodeCount,
    bool? isSubscribed,
    String? storageRssPath,
  }) {
    return Podcast(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      language: language ?? this.language,
      hosts: hosts ?? this.hosts,
      episodes: episodes ?? this.episodes,
      episodeCount: episodeCount ?? this.episodeCount,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      storageRssPath: storageRssPath ?? this.storageRssPath,
    );
  }

  factory Podcast.fromJson(Map<String, dynamic> json) {
    final hosts = (json['hosts'] as List<dynamic>?)
            ?.whereType<Map<String, dynamic>>()
            .map(ShowHost.fromJson)
            .toList() ??
        const <ShowHost>[];

    final episodes = (json['episodes'] as List<dynamic>?)
            ?.whereType<Map<String, dynamic>>()
            .map(Episode.fromJson)
            .toList() ??
        const <Episode>[];

    return Podcast(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Egyéb',
      coverImageUrl: json['cover_image_url']?.toString() ?? '',
      language: json['language']?.toString() ?? 'hu',
      hosts: hosts,
      episodes: episodes,
      episodeCount: json['episode_count'] is int
          ? json['episode_count'] as int
          : int.tryParse(json['episode_count']?.toString() ?? '') ??
              episodes.length,
      isSubscribed: json['is_subscribed'] == true,
      storageRssPath: json['storage_rss_path']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'cover_image_url': coverImageUrl,
      'language': language,
      'hosts': hosts.map((host) => host.toJson()).toList(),
      'episodes': episodes.map((episode) => episode.toJson()).toList(),
      'episode_count': episodeCount,
      'is_subscribed': isSubscribed,
      'storage_rss_path': storageRssPath,
    };
  }
}
