import 'dart:convert';

import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/catalog/product_list.dart';

class SearchResult {
  int? id;
  String? name;
  String? image;
  List<Map<String, dynamic>>? products;

  SearchResult({
    this.id,
    this.name,
    this.image,
    this.products,
  });

  SearchResult copyWith({
    int? id,
    String? name,
    String? image,
    List<Map<String, dynamic>>? products,
  }) {
    return SearchResult(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'products': products,
    };
  }

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    // print("map in searchresult: $map");

    // print("map ${map['products']}");

    return SearchResult(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      image: map['image'] != null ? map['image'] : null,
      products: map['products'] != null
          ? List<Map<String, dynamic>>.from(map['products'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchResult.fromJson(String source) =>
      SearchResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchResult(id: $id, name: $name, image: $image, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchResult &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.products == products;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ image.hashCode ^ products.hashCode;
  }
}
