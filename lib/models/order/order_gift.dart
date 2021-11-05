import 'dart:convert';

class OrderGift {
  int? id;
  String? name;
  String? price;
  String? mainImage;
  OrderGift({
    this.id,
    this.name,
    this.price,
    this.mainImage,
  });

  OrderGift copyWith({
    int? id,
    String? name,
    String? price,
    String? mainImage,
  }) {
    return OrderGift(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      mainImage: mainImage ?? this.mainImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'main_image': mainImage,
    };
  }

  factory OrderGift.fromMap(Map<String, dynamic> map) {
    return OrderGift(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      mainImage: map['main_image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderGift.fromJson(String source) =>
      OrderGift.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderGift(id: $id, name: $name, price: $price, mainImage: $mainImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderGift &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.mainImage == mainImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ price.hashCode ^ mainImage.hashCode;
  }
}
