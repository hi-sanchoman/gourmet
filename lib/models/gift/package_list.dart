import 'dart:convert';

import 'package:esentai/models/gift/package.dart';
import 'package:flutter/foundation.dart';

import 'package:esentai/models/catalog/product.dart';

class PackageList {
  List<Package>? items;

  PackageList({
    this.items,
  });

  PackageList copyWith({
    List<Package>? items,
  }) {
    return PackageList(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  factory PackageList.fromMap(Map<String, dynamic> json) {
    // print("from PackageList... " + json.toString());

    List<Package> items = [];
    List<dynamic> results = json['results'];

    items = results.map((item) => Package.fromMap(item)).toList();

    // print("items...");
    // print(items);

    return PackageList(
      items: items,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageList.fromJson(Map<String, dynamic> json) {
    // print("json is $json");

    List<Package> items = [];
    List<dynamic> results = json['results'];

    items = results.map((item) => Package.fromMap(item)).toList();

    // print('items in mapping... $items');

    return PackageList(
      items: items,
    );
  }

  @override
  String toString() => 'PackageList(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageList && listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}
