import 'dart:convert';

class FavoriteGift {
  int? id;
  String? name;
  String? mainImage;
  String? price;
  int? amount;
  bool? isActive;
  bool? isLiked;
  String? itemType;

  FavoriteGift({
    this.id,
    this.name,
    this.mainImage,
    this.price,
    this.amount,
    this.isActive,
    this.isLiked,
    this.itemType,
  });

  FavoriteGift copyWith({
    int? id,
    String? name,
    String? mainImage,
    String? price,
    int? amount,
    bool? isActive,
    bool? isLiked,
    String? itemType,
  }) {
    return FavoriteGift(
      id: id ?? this.id,
      name: name ?? this.name,
      mainImage: mainImage ?? this.mainImage,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      isActive: isActive ?? this.isActive,
      isLiked: isLiked ?? this.isLiked,
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
      'isActive': isActive,
      'isLiked': isLiked,
      'itemType': itemType,
    };
  }

  factory FavoriteGift.fromMap(Map<String, dynamic> map) {
    return FavoriteGift(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      mainImage: map['main_image'] != null ? map['main_image'] : null,
      price: map['price'] != null ? map['price'] : null,
      amount: map['amount'] != null ? map['amount'] : null,
      isActive: map['is_active'] != null ? map['is_active'] : null,
      isLiked: map['is_liked'] != null ? map['is_liked'] : null,
      itemType: map['item_type'] != null ? map['item_type'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteGift.fromJson(String source) =>
      FavoriteGift.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavoriteGift(id: $id, name: $name, mainImage: $mainImage, price: $price, amount: $amount, isActive: $isActive, isLiked: $isLiked, itemType: $itemType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteGift &&
        other.id == id &&
        other.name == name &&
        other.mainImage == mainImage &&
        other.price == price &&
        other.amount == amount &&
        other.isActive == isActive &&
        other.isLiked == isLiked &&
        other.itemType == itemType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mainImage.hashCode ^
        price.hashCode ^
        amount.hashCode ^
        isActive.hashCode ^
        isLiked.hashCode ^
        itemType.hashCode;
  }
}
