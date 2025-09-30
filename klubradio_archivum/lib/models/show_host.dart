import 'dart:convert';

class ShowHost {
  const ShowHost({
    required this.id,
    required this.name,
    this.bio,
    this.avatarUrl,
  });

  factory ShowHost.fromJson(Map<String, dynamic> json) {
    final social = json['socialLinks'];
    return ShowHost(
      id: json['id'].toString(),
      name: json['name'] as String? ?? 'Ismeretlen műsorvezető',
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  final String id;
  final String name;
  final String? bio;
  final String? avatarUrl;

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
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'bio': bio,
      'avatarUrl': avatarUrl,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
