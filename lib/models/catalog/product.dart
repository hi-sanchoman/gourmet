import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  int? id;
  String? mainImage;
  String? name;
  String? description;
  // int? loyaltyId;
  String? priceCurrency;
  double? price;
  int? amount;
  int? position;
  bool? isNew;
  bool? isActive;
  List<int>? subcategories;
  bool? isLiked;
  String? itemType;

  Product({
    this.id,
    this.mainImage,
    this.name,
    this.description,
    // this.loyaltyId,
    this.priceCurrency,
    this.price,
    this.amount,
    this.position,
    this.isNew,
    this.isActive,
    this.subcategories,
    this.isLiked,
    this.itemType,
  });

  Product copyWith({
    int? id,
    String? mainImage,
    String? name,
    String? description,
    int? loyaltyId,
    String? priceCurrency,
    double? price,
    int? amount,
    int? position,
    bool? isNew,
    bool? isActive,
    List<int>? subcategories,
    bool? isLiked,
    String? itemType,
  }) {
    return Product(
      id: id ?? this.id,
      mainImage: mainImage ?? this.mainImage,
      name: name ?? this.name,
      description: description ?? this.description,
      // loyaltyId: loyaltyId ?? this.loyaltyId,
      priceCurrency: priceCurrency ?? this.priceCurrency,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      position: position ?? this.position,
      isNew: isNew ?? this.isNew,
      isActive: isActive ?? this.isActive,
      subcategories: subcategories ?? this.subcategories,
      isLiked: isLiked ?? this.isLiked,
      itemType: itemType ?? this.itemType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mainImage': mainImage,
      'name': name,
      'description': description,
      // 'loyaltyId': loyaltyId,
      'priceCurrency': priceCurrency,
      'price': price,
      'amount': amount,
      'position': position,
      'isNew': isNew,
      'isActive': isActive,
      'subcategories': subcategories,
      'isLiked': isLiked,
      'itemType': itemType,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    // print("product $map");

    return Product(
      id: map['id'],
      mainImage: map['main_image'],
      name: map['name'],
      description: map['description'],
      // loyaltyId: map['loyalty_id'],
      priceCurrency: map['price_currency'],
      price: double.parse(map['price'] ?? "0"),
      amount: map['amount'],
      position: map['position'],
      isNew: map['is_new'],
      isActive: map['is_active'],
      subcategories: map['subcategories'] != null
          ? List<int>.from(map['subcategory'])
          : null,
      isLiked: map['is_liked'],
      itemType: map['item_type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, itemType: $itemType, mainImage: $mainImage, name: $name, priceCurrency: $priceCurrency, price: $price, amount: $amount, position: $position, isNew: $isNew, isActive: $isActive, subcategories: $subcategories, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.mainImage == mainImage &&
        other.name == name &&
        other.description == description &&
        // other.loyaltyId == loyaltyId &&
        other.priceCurrency == priceCurrency &&
        other.price == price &&
        other.amount == amount &&
        other.position == position &&
        other.isNew == isNew &&
        other.isActive == isActive &&
        other.itemType == itemType &&
        listEquals(other.subcategories, subcategories) &&
        other.isLiked == isLiked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        mainImage.hashCode ^
        name.hashCode ^
        description.hashCode ^
        // loyaltyId.hashCode ^
        priceCurrency.hashCode ^
        price.hashCode ^
        amount.hashCode ^
        position.hashCode ^
        isNew.hashCode ^
        isActive.hashCode ^
        itemType.hashCode ^
        subcategories.hashCode ^
        isLiked.hashCode;
  }
}
