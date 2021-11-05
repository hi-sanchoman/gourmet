import 'dart:convert';

class OrderProduct {
  int? id;
  String? name;
  String? price;
  String? mainImage;
  OrderProduct({
    this.id,
    this.name,
    this.price,
    this.mainImage,
  });

  OrderProduct copyWith({
    int? id,
    String? name,
    String? price,
    String? mainImage,
  }) {
    return OrderProduct(
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

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      price: map['price'] != null ? map['price'] : null,
      mainImage: map['main_image'] != null ? map['main_image'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProduct.fromJson(String source) =>
      OrderProduct.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderProduct(id: $id, name: $name, price: $price, mainImage: $mainImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderProduct &&
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
