import 'dart:convert';

class ShowHost {
  const ShowHost({required this.name});

  factory ShowHost.fromJson(Map<String, dynamic> json) {
    return ShowHost(name: json['name'] as String? ?? 'Ismeretlen műsorvezető');
  }

  final String name;

  ShowHost copyWith({String? name}) {
    return ShowHost(name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name};
  }

  @override
  String toString() => jsonEncode(toJson());
}
