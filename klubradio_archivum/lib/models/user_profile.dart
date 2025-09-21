class UserProfile {
  const UserProfile({
    required this.id,
    required this.displayName,
    required this.email,
    required this.preferredLanguage,
    this.avatarUrl,
    this.favoritePodcasts = const <String>[],
  });

  final String id;
  final String displayName;
  final String email;
  final String preferredLanguage;
  final String? avatarUrl;
  final List<String> favoritePodcasts;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id']?.toString() ?? '',
      displayName: json['display_name']?.toString() ?? 'Hallgató',
      email: json['email']?.toString() ?? '',
      preferredLanguage: json['preferred_language']?.toString() ?? 'hu',
      avatarUrl: json['avatar_url']?.toString(),
      favoritePodcasts: (json['favorite_podcasts'] as List<dynamic>? ?? const <dynamic>[])
          .map((dynamic entry) => entry.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'display_name': displayName,
      'email': email,
      'preferred_language': preferredLanguage,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      'favorite_podcasts': favoritePodcasts,
    };
  }

  @override
  int get hashCode => Object.hash(
        id,
        displayName,
        email,
        preferredLanguage,
        avatarUrl,
        favoritePodcasts.hashCode,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is UserProfile &&
        other.id == id &&
        other.displayName == displayName &&
        other.email == email &&
        other.preferredLanguage == preferredLanguage &&
        other.avatarUrl == avatarUrl &&
        _listEquals(other.favoritePodcasts, favoritePodcasts);
  }

  static bool _listEquals(List<String> a, List<String> b) {
    if (identical(a, b)) {
      return true;
    }
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}
