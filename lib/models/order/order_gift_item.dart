import 'dart:convert';

import 'package:esentai/models/order/order_gift.dart';
import 'package:esentai/models/order/order_package.dart';
import 'package:esentai/models/order/order_package_list.dart';

class OrderGiftItem {
  OrderGift? gift;

  OrderGiftItem({
    this.gift,
  });

  OrderGiftItem copyWith({
    OrderGift? gift,
  }) {
    return OrderGiftItem(
      gift: gift ?? this.gift,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gift': gift?.toMap(),
    };
  }

  factory OrderGiftItem.fromMap(Map<String, dynamic> map) {
    return OrderGiftItem(
      gift: map['gift'] != null ? OrderGift.fromMap(map['gift']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderGiftItem.fromJson(String source) =>
      OrderGiftItem.fromMap(json.decode(source));

  @override
  String toString() => 'OrderGiftItem(gift: $gift)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderGiftItem && other.gift == gift;
  }

  @override
  int get hashCode => gift.hashCode;
}
