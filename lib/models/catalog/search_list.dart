import 'dart:convert';

import 'package:esentai/models/catalog/search_result.dart';
import 'package:flutter/foundation.dart';

import 'package:esentai/models/catalog/product.dart';

class SearchList {
  List<SearchResult>? items;

  SearchList({
    this.items,
  });

  SearchList copyWith({
    List<SearchResult>? items,
  }) {
    return SearchList(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory SearchList.fromMap(Map<String, dynamic> json) {
    // print("json is $json");

    List<SearchResult> items = [];
    List<dynamic> results = json['results'];

    items = results.map((item) => SearchResult.fromMap(item)).toList();

    // print('items in mapping... $items');

    return SearchList(
      items: items,
    );
  }

  @override
  String toString() => 'SearchList(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchList && listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}
