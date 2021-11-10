import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/post/post.dart';

class SubcategoryList {
  final List<Subcategory>? items;

  SubcategoryList({
    this.items,
  });

  SubcategoryList copyWith({
    List<Subcategory>? items,
  }) {
    return SubcategoryList(
      items: items ?? this.items,
    );
  }

  factory SubcategoryList.fromJson(Map<String, dynamic> json) {
    // print("subcategories are $json");

    List<Subcategory> items = <Subcategory>[];
    List<dynamic> results = json['results'];

    items = results.map((item) => Subcategory.fromMap(item)).toList();

    return SubcategoryList(
      items: items,
    );
  }

  factory SubcategoryList.fromJsonList(List<dynamic> json) {
    List<Subcategory> items = <Subcategory>[];

    items = json
        .map((item) => Subcategory.fromMap(item))
        .toList()
        .cast<Subcategory>();

    return SubcategoryList(
      items: items,
    );
  }

  @override
  String toString() => 'SubcategoryList(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubcategoryList && listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}
