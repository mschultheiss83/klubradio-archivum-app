class ShowHost {
  const ShowHost({
    required this.id,
    required this.name,
    this.bio,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String? bio;
  final String? avatarUrl;

  factory ShowHost.fromJson(Map<String, dynamic> json) {
    return ShowHost(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Ismeretlen műsorvezető',
      bio: json['bio']?.toString(),
      avatarUrl: json['avatar_url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      if (bio != null) 'bio': bio,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    };
  }

  @override
  int get hashCode => Object.hash(id, name, bio, avatarUrl);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ShowHost &&
        other.id == id &&
        other.name == name &&
        other.bio == bio &&
        other.avatarUrl == avatarUrl;
  }
}
