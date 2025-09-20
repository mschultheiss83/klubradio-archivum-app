import 'dart:convert';

class ShowHost {
  const ShowHost({
    required this.id,
    required this.name,
    this.bio,
    this.avatarUrl,
    this.socialLinks = const <String, String>{},
  });

  factory ShowHost.fromJson(Map<String, dynamic> json) {
    final social = json['socialLinks'];
    return ShowHost(
      id: json['id'].toString(),
      name: json['name'] as String? ?? 'Ismeretlen műsorvezető',
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      socialLinks: social is Map
          ? social.map(
              (dynamic key, dynamic value) =>
                  MapEntry(key.toString(), value.toString()),
            )
          : const <String, String>{},
    );
  }

  final String id;
  final String name;
  final String? bio;
  final String? avatarUrl;
  final Map<String, String> socialLinks;

  ShowHost copyWith({
    String? id,
    String? name,
    String? bio,
    String? avatarUrl,
    Map<String, String>? socialLinks,
  }) {
    return ShowHost(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      socialLinks: socialLinks ?? Map<String, String>.from(this.socialLinks),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'bio': bio,
      'avatarUrl': avatarUrl,
      'socialLinks': socialLinks,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
