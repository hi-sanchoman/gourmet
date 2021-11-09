import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:esentai/models/order/order_package.dart';

class OrderPackageList {
  List<OrderPackage> items;

  OrderPackageList({
    required this.items,
  });

  OrderPackageList copyWith({
    List<OrderPackage>? items,
  }) {
    return OrderPackageList(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items?.map((x) => x.toMap())?.toList(),
    };
  }

  factory OrderPackageList.fromMap(List<dynamic> map) {
    return OrderPackageList(
      items: List<OrderPackage>.from(map.map((x) => OrderPackage.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderPackageList.fromJson(String source) =>
      OrderPackageList.fromMap(json.decode(source));

  @override
  String toString() => 'OrderPackageList(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderPackageList && listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}
