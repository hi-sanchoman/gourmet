import 'dart:convert';

class FavoriteAdd {
  int? id;
  int? favorite;
  FavoriteAdd({
    this.id,
    this.favorite,
  });

  FavoriteAdd copyWith({
    int? id,
    int? favorite,
  }) {
    return FavoriteAdd(
      id: id ?? this.id,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'favorite': favorite,
    };
  }

  factory FavoriteAdd.fromMap(Map<String, dynamic> map) {
    return FavoriteAdd(
      id: map['id'] != null ? map['id'] : null,
      favorite:
          map['favorite_product'] != null ? map['favorite_product'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteAdd.fromJson(String source) =>
      FavoriteAdd.fromMap(json.decode(source));

  @override
  String toString() => 'FavoriteAdd(id: $id, favorite: $favorite)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteAdd && other.id == id && other.favorite == favorite;
  }

  @override
  int get hashCode => id.hashCode ^ favorite.hashCode;
}
