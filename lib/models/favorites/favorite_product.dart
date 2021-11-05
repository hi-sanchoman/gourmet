import 'dart:convert';

class FavoriteProduct {
  int? id;
  String? name;
  String? mainImage;
  String? price;
  int? amount;
  bool? isLiked;
  bool? isActive;
  String? itemType;

  FavoriteProduct({
    this.id,
    this.name,
    this.mainImage,
    this.price,
    this.amount,
    this.isLiked,
    this.isActive,
    this.itemType,
  });

  FavoriteProduct copyWith({
    int? id,
    String? name,
    String? mainImage,
    String? price,
    int? amount,
    bool? isLiked,
    bool? isActive,
    String? itemType,
  }) {
    return FavoriteProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      mainImage: mainImage ?? this.mainImage,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      isLiked: isLiked ?? this.isLiked,
      isActive: isActive ?? this.isActive,
      itemType: itemType ?? this.itemType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mainImage': mainImage,
      'price': price,
      'amount': amount,
      'isLiked': isLiked,
      'isActive': isActive,
      'itemType': itemType,
    };
  }

  factory FavoriteProduct.fromMap(Map<String, dynamic> map) {
    return FavoriteProduct(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      mainImage: map['main_image'] != null ? map['main_image'] : null,
      price: map['price'] != null ? map['price'] : null,
      amount: map['amount'] != null ? map['amount'] : null,
      isLiked: map['is_liked'] != null ? map['is_liked'] : null,
      isActive: map['is_active'] != null ? map['is_active'] : null,
      itemType: map['item_type'] != null ? map['item_type'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteProduct.fromJson(String source) =>
      FavoriteProduct.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavoriteProduct(id: $id, name: $name, mainImage: $mainImage, price: $price, amount: $amount, isLiked: $isLiked, isActive: $isActive, itemType: $itemType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteProduct &&
        other.id == id &&
        other.name == name &&
        other.mainImage == mainImage &&
        other.price == price &&
        other.amount == amount &&
        other.isLiked == isLiked &&
        other.isActive == isActive &&
        other.itemType == itemType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mainImage.hashCode ^
        price.hashCode ^
        amount.hashCode ^
        isLiked.hashCode ^
        isActive.hashCode ^
        itemType.hashCode;
  }
}
