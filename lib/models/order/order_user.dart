import 'dart:convert';

class OrderUser {
  int? id;
  String? fullname;
  String? username;
  OrderUser({
    this.id,
    this.fullname,
    this.username,
  });

  OrderUser copyWith({
    int? id,
    String? fullname,
    String? username,
  }) {
    return OrderUser(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullname,
      'username': username,
    };
  }

  factory OrderUser.fromMap(Map<String, dynamic> map) {
    // print("user... " + map.toString());

    return OrderUser(
      id: map['id'],
      fullname: map['full_name'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderUser.fromJson(String source) =>
      OrderUser.fromMap(json.decode(source));

  @override
  String toString() =>
      'OrderUser(id: $id, fullname: $fullname, username: $username)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderUser &&
        other.id == id &&
        other.fullname == fullname &&
        other.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ fullname.hashCode ^ username.hashCode;
}
