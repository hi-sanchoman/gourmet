import 'dart:convert';

import 'package:esentai/models/order/order_gift.dart';
import 'package:esentai/models/order/order_gift_item.dart';
import 'package:esentai/models/order/order_product.dart';

class OrderItem {
  int? id;
  OrderProduct? product;
  OrderGiftItem? gift;
  int? count;

  OrderItem({
    this.id,
    this.product,
    this.gift,
    this.count,
  });

  OrderItem copyWith({
    int? id,
    OrderProduct? product,
    OrderGiftItem? gift,
    int? count,
  }) {
    return OrderItem(
      id: id ?? this.id,
      product: product ?? this.product,
      gift: gift ?? this.gift,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product?.toMap(),
      'gift_order': gift?.toMap(),
      'product_count': count,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    // print("order item ...");
    // print(map);

    return OrderItem(
      id: map['id'] != null ? map['id'] : null,
      product:
          map['product'] != null ? OrderProduct.fromMap(map['product']) : null,
      gift: map['gift_order'] != null
          ? OrderGiftItem.fromMap(map['gift_order'])
          : null,
      count: map['product_count'] != null ? map['product_count'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItem(id: $id, product: $product, gift: $gift, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItem &&
        other.id == id &&
        other.product == product &&
        other.gift == gift &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^ product.hashCode ^ gift.hashCode ^ count.hashCode;
  }
}
