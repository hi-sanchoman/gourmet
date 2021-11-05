import 'dart:convert';

import 'package:esentai/models/catalog/product.dart';
import 'package:flutter/foundation.dart';

import 'package:esentai/models/catalog/Gift.dart';

class GiftList {
  List<Product>? items;

  GiftList({
    this.items,
  });

  GiftList copyWith({
    List<Product>? items,
  }) {
    return GiftList(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  factory GiftList.fromMap(Map<String, dynamic> map) {
    // print("map in Giftlist: $map");

    return GiftList(
      items: List<Product>.from(map['items']?.map((x) => Gift.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftList.fromJson(Map<String, dynamic> json) {
    // print("json is $json");

    List<Product> items = [];
    List<dynamic> results = json['results'];

    items = results.map((item) => Product.fromMap(item)).toList();

    // print('items in mapping... $items');

    return GiftList(
      items: items,
    );
  }

  @override
  String toString() => 'GiftList(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GiftList && listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}
