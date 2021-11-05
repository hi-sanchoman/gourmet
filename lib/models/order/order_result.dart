import 'dart:convert';

class OrderResult {
  int? orderId;
  String? message;

  OrderResult({
    this.orderId,
    this.message,
  });

  OrderResult copyWith({
    int? orderId,
    String? message,
  }) {
    return OrderResult(
      orderId: orderId ?? this.orderId,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'message': message,
    };
  }

  factory OrderResult.fromMap(Map<String, dynamic> map) {
    return OrderResult(
      orderId: map['order_id'] != null ? map['order_id'] : null,
      message: map['message'] != null ? map['message'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderResult.fromJson(String source) =>
      OrderResult.fromMap(json.decode(source));

  @override
  String toString() => 'OrderResult(orderId: $orderId, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderResult &&
        other.orderId == orderId &&
        other.message == message;
  }

  @override
  int get hashCode => orderId.hashCode ^ message.hashCode;
}
