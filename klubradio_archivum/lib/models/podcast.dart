import 'dart:convert';

import 'episode.dart';
import 'show_host.dart';

/// Represents a podcast or show within the Klubrádió archive.
class Podcast {
  Podcast({
    required this.id,
    required this.title,
    required this.description,
    required this.categories,
    required this.coverImageUrl,
    required this.language,
    required this.episodeCount,
    required this.hosts,
    this.latestEpisode,
    this.lastUpdated,
    this.isSubscribed = false,
    this.isTrending = false,
    this.isRecommended = false,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    final hostsJson = json['hosts'];
    final categoriesJson = json['categories'];
    return Podcast(
      id: json['id'].toString(),
      title: json['title'] as String? ?? 'Ismeretlen műsor',
      description: json['description'] as String? ?? '',
      categories: categoriesJson is List
          ? categoriesJson.map((dynamic e) => e.toString()).toList()
          : const <String>[],
      coverImageUrl: json['coverImageUrl'] as String? ?? '',
      language: json['language'] as String? ?? 'hu',
      episodeCount: json['episodeCount'] is int
          ? json['episodeCount'] as int
          : int.tryParse(json['episodeCount']?.toString() ?? '') ?? 0,
      hosts: hostsJson is List
          ? hostsJson
              .whereType<Map<String, dynamic>>()
              .map(ShowHost.fromJson)
              .toList()
          : const <ShowHost>[],
      latestEpisode: json['latestEpisode'] is Map<String, dynamic>
          ? Episode.fromJson(json['latestEpisode'] as Map<String, dynamic>)
          : null,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.tryParse(json['lastUpdated'].toString())
          : null,
      isSubscribed: json['isSubscribed'] as bool? ?? false,
      isTrending: json['isTrending'] as bool? ?? false,
      isRecommended: json['isRecommended'] as bool? ?? false,
    );
  }

  final String id;
  final String title;
  final String description;
  final List<String> categories;
  final String coverImageUrl;
  final String language;
  final int episodeCount;
  final List<ShowHost> hosts;
  final Episode? latestEpisode;
  final DateTime? lastUpdated;
  final bool isSubscribed;
  final bool isTrending;
  final bool isRecommended;

  Podcast copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? categories,
    String? coverImageUrl,
    String? language,
    int? episodeCount,
    List<ShowHost>? hosts,
    Episode? latestEpisode,
    DateTime? lastUpdated,
    bool? isSubscribed,
    bool? isTrending,
    bool? isRecommended,
  }) {
    return Podcast(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categories: categories ?? List<String>.from(this.categories),
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      language: language ?? this.language,
      episodeCount: episodeCount ?? this.episodeCount,
      hosts: hosts ?? List<ShowHost>.from(this.hosts),
      latestEpisode: latestEpisode ?? this.latestEpisode,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      isTrending: isTrending ?? this.isTrending,
      isRecommended: isRecommended ?? this.isRecommended,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'categories': categories,
      'coverImageUrl': coverImageUrl,
      'language': language,
      'episodeCount': episodeCount,
      'hosts': hosts.map((ShowHost host) => host.toJson()).toList(),
      'latestEpisode': latestEpisode?.toJson(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'isSubscribed': isSubscribed,
      'isTrending': isTrending,
      'isRecommended': isRecommended,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
