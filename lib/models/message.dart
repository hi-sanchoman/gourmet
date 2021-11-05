import 'dart:convert';

class Message {
  String? message;

  Message({
    this.message,
  });

  Message copyWith({
    String? message,
  }) {
    return Message(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] != null ? map['message'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() => 'Message(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
