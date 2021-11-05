import 'dart:convert';

import 'package:esentai/models/order/order_item_list.dart';
import 'package:esentai/models/order/order_user.dart';

class Order {
  int? id;
  int? paymentMethod;
  String? totalPrice;
  String? bonusReturned;
  String? updatedAt;
  OrderItemList? goods;
  String? status;
  String? address;
  OrderUser? user;
  String? review;
  String? comment;
  String? paymentStatus;
  String? deliveryType;

  Order(
      {this.id,
      this.paymentMethod,
      this.totalPrice,
      this.bonusReturned,
      this.updatedAt,
      this.goods,
      this.status,
      this.address,
      this.user,
      this.review,
      this.comment,
      this.deliveryType,
      this.paymentStatus});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'payment_method': paymentMethod,
      'total_price': totalPrice,
      'bonus_returned': bonusReturned,
      'updated_at': updatedAt,
      'goods': goods,
      'status': status,
      'address': address,
      'user': user,
      'review': review,
      'comment': comment,
      'paymentStatus': paymentStatus,
      'deliveryType': deliveryType,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    // var goods = OrderItemList.fromMap(map['goods']);
    // print("prepare order goods..." + map['goods'].toString());
    // print(goods);

    var order = Order(
        id: map['id'],
        paymentMethod: map['payment_method'],
        totalPrice: map['total_price'],
        bonusReturned: map['bonus_returned'],
        updatedAt: map['updated_at'],
        goods:
            map['goods'] != null ? OrderItemList.fromMap(map['goods']) : null,
        status: map['status'],
        address: map['address'],
        review: map['review'],
        comment: map['comment'],
        paymentStatus: map['payment_status'],
        deliveryType: map['delivery_type'],
        user: map['user'] != null ? OrderUser.fromMap(map['user']) : null);

    return order;
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, status: $status, deliveryType: $deliveryType, paymentMethod: $paymentMethod, totalPrice: $totalPrice, bonusReturened: $bonusReturned, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.status == other.status &&
        other.paymentMethod == paymentMethod &&
        other.totalPrice == totalPrice &&
        other.bonusReturned == bonusReturned &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        paymentMethod.hashCode ^
        totalPrice.hashCode ^
        bonusReturned.hashCode ^
        updatedAt.hashCode;
  }
}
