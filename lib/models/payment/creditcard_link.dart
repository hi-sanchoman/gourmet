import 'dart:convert';

class CreditCardLink {
  String? message;
  CreditCardLink({
    this.message,
  });

  CreditCardLink copyWith({
    String? message,
  }) {
    return CreditCardLink(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory CreditCardLink.fromMap(Map<String, dynamic> map) {
    return CreditCardLink(
      message: map['message'] != null ? map['message'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCardLink.fromJson(String source) =>
      CreditCardLink.fromMap(json.decode(source));

  @override
  String toString() => 'CreditCardLink(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreditCardLink && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
