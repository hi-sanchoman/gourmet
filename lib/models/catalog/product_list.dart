import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:esentai/models/catalog/product.dart';

class ProductList {
  List<Product>? items;
  ProductList({
    this.items,
  });

  ProductList copyWith({
    List<Product>? items,
  }) {
    return ProductList(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductList.fromMap(Map<String, dynamic> map) {
    // print("map in productlist: $map");

    return ProductList(
      items: List<Product>.from(map['items']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductList.fromJson(Map<String, dynamic> json) {
    // print("json is $json");

    List<Product> items = [];
    List<dynamic> results = json['results'];

    items = results.map((item) => Product.fromMap(item)).toList();

    // print('items in mapping... $items');

    return ProductList(
      items: items,
    );
  }

  @override
  String toString() => 'ProductList(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductList && listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}
