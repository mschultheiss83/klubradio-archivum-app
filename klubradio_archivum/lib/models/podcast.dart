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
    this.episodeCount = 0,
    this.isFeatured = false,
    this.weeklyListens = 0,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final String coverImageUrl;
  final String language;
  final List<ShowHost> hosts;
  final int episodeCount;
  final bool isFeatured;
  final int weeklyListens;

  Podcast copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? coverImageUrl,
    String? language,
    List<ShowHost>? hosts,
    int? episodeCount,
    bool? isFeatured,
    int? weeklyListens,
  }) {
    return Podcast(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      language: language ?? this.language,
      hosts: hosts ?? this.hosts,
      episodeCount: episodeCount ?? this.episodeCount,
      isFeatured: isFeatured ?? this.isFeatured,
      weeklyListens: weeklyListens ?? this.weeklyListens,
    );
  }

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Ismeretlen műsor',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Egyéb',
      coverImageUrl: json['cover_image_url']?.toString() ?? '',
      language: json['language']?.toString() ?? 'hu',
      hosts: (json['hosts'] as List<dynamic>? ?? const <dynamic>[])
          .whereType<Map<String, dynamic>>()
          .map(ShowHost.fromJson)
          .toList(),
      episodeCount: json['episode_count'] is int
          ? json['episode_count'] as int
          : int.tryParse(json['episode_count']?.toString() ?? '') ?? 0,
      isFeatured: json['is_featured'] == true,
      weeklyListens: json['weekly_listens'] is int
          ? json['weekly_listens'] as int
          : int.tryParse(json['weekly_listens']?.toString() ?? '') ?? 0,
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
      'episode_count': episodeCount,
      'is_featured': isFeatured,
      'weekly_listens': weeklyListens,
    };
  }

  @override
  int get hashCode => Object.hash(
        id,
        title,
        description,
        category,
        coverImageUrl,
        language,
        episodeCount,
        isFeatured,
        weeklyListens,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Podcast &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.coverImageUrl == coverImageUrl &&
        other.language == language &&
        other.episodeCount == episodeCount &&
        other.isFeatured == isFeatured &&
        other.weeklyListens == weeklyListens;
  }
}
