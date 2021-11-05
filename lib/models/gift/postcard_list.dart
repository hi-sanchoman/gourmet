import 'dart:convert';

import 'package:esentai/models/gift/postcard.dart';
import 'package:flutter/foundation.dart';

import 'package:esentai/models/catalog/product.dart';

class PostcardList {
  List<Postcard>? items;

  PostcardList({
    this.items,
  });

  PostcardList copyWith({
    List<Postcard>? items,
  }) {
    return PostcardList(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  factory PostcardList.fromMap(Map<String, dynamic> json) {
    // print("from PostcardList... " + json.toString());

    List<Postcard> items = [];
    List<dynamic> results = json['results'];

    items = results.map((item) => Postcard.fromMap(item)).toList();

    // print("items...");
    // print(items);

    return PostcardList(
      items: items,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostcardList.fromJson(Map<String, dynamic> json) {
    // print("json is $json");

    List<Postcard> items = [];
    List<dynamic> results = json['results'];

    items = results.map((item) => Postcard.fromMap(item)).toList();

    // print('items in mapping... $items');

    return PostcardList(
      items: items,
    );
  }

  @override
  String toString() => 'PostcardList(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostcardList && listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}
