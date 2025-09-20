class ShowHost {
  const ShowHost({
    required this.id,
    required this.name,
    this.bio = '',
    this.avatarUrl = '',
    this.socialLinks = const <String>[],
  });

  final String id;
  final String name;
  final String bio;
  final String avatarUrl;
  final List<String> socialLinks;

  ShowHost copyWith({
    String? id,
    String? name,
    String? bio,
    String? avatarUrl,
    List<String>? socialLinks,
  }) {
    return ShowHost(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      socialLinks: socialLinks ?? this.socialLinks,
    );
  }

  factory ShowHost.fromJson(Map<String, dynamic> json) {
    return ShowHost(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      avatarUrl: json['avatar_url']?.toString() ?? '',
      socialLinks: (json['social_links'] as List<dynamic>?)
              ?.map((link) => link.toString())
              .toList() ??
          const <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'bio': bio,
      'avatar_url': avatarUrl,
      'social_links': socialLinks,
    };
  }
}
