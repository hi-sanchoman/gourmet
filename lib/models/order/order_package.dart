import 'dart:convert';

import 'package:esentai/models/order/order_package_item.dart';

class OrderPackage {
  int? id;
  OrderPackageItem? item;
  int? count;

  OrderPackage({
    this.id,
    this.item,
    this.count,
  });

  OrderPackage copyWith({
    int? id,
    OrderPackageItem? item,
    int? count,
  }) {
    return OrderPackage(
      id: id ?? this.id,
      item: item ?? this.item,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item': item?.toMap(),
      'package_count': count,
    };
  }

  factory OrderPackage.fromMap(Map<String, dynamic> map) {
    return OrderPackage(
      id: map['id'] != null ? map['id'] : null,
      item: map['package'] != null
          ? OrderPackageItem.fromMap(map['package'])
          : null,
      count: map['package_count'] != null ? map['package_count'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderPackage.fromJson(String source) =>
      OrderPackage.fromMap(json.decode(source));

  @override
  String toString() => 'OrderPackage(id: $id, package: $item, count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderPackage && other.id == id && other.count == count;
  }

  @override
  int get hashCode => id.hashCode ^ count.hashCode;
}
