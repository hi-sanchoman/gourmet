import 'dart:convert';

class BackNotification {
  int? id;
  String? title;
  String? body;
  String? createdAt;
  BackNotification({
    this.id,
    this.title,
    this.body,
    this.createdAt,
  });

  BackNotification copyWith({
    int? id,
    String? title,
    String? body,
    String? createdAt,
  }) {
    return BackNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt,
    };
  }

  factory BackNotification.fromMap(Map<String, dynamic> map) {
    return BackNotification(
      id: map['id'] != null ? map['id'] : null,
      title: map['title'] != null ? map['title'] : null,
      body: map['body'] != null ? map['body'] : null,
      createdAt: map['created_at'] != null ? map['created_at'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BackNotification.fromJson(String source) =>
      BackNotification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BackNotification(id: $id, title: $title, body: $body, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BackNotification &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ body.hashCode ^ createdAt.hashCode;
  }
}
