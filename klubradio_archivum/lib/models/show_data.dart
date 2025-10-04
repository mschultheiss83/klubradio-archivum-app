class ShowData {
  final String id;
  final String title;
  final int count;

  ShowData({required this.id, required this.title, required this.count});

  factory ShowData.fromJson(Map<String, dynamic> json) {
    return ShowData(
      id: json['id'].toString(),
      title: json['title'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'title': title, 'count': count};
  }
}
