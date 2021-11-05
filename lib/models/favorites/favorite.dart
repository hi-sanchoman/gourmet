import 'dart:convert';

import 'package:esentai/models/favorites/favorite_gift.dart';
import 'package:esentai/models/favorites/favorite_product.dart';

class Favorite {
  int? id;
  FavoriteProduct? favorite;
  FavoriteGift? gift;

  Favorite({
    this.id,
    this.favorite,
    this.gift,
  });

  Favorite copyWith({
    int? id,
    FavoriteProduct? favorite,
    FavoriteGift? gift,
  }) {
    return Favorite(
      id: id ?? this.id,
      favorite: favorite ?? this.favorite,
      gift: gift ?? this.gift,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'favorite': favorite,
      'gift': gift,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    // print("map is ${map['favorite_product']}");

    var favorite = Favorite(
      id: map['id'] != null ? map['id'] : null,
      favorite: map['favorite_product'] != null
          ? FavoriteProduct.fromMap(map['favorite_product'])
          : null,
      gift: map['favorite_gift'] != null
          ? FavoriteGift.fromMap(map['favorite_gift'])
          : null,
    );

    // print('favorite is $favorite');

    return favorite;
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source));

  @override
  String toString() => 'Favorite(id: $id, favorite: $favorite, gift: $gift)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Favorite &&
        other.id == id &&
        other.favorite == favorite &&
        other.gift == gift;
  }

  @override
  int get hashCode => id.hashCode ^ favorite.hashCode ^ gift.hashCode;
}
