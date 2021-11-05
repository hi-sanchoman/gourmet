import 'dart:convert';

class Package {
  int? id;
  String? name;
  String? mainImage;
  String? price;
  int? amount;

  Package({
    this.id,
    this.name,
    this.mainImage,
    this.price,
    this.amount,
  });

  Package copyWith({
    int? id,
    String? name,
    String? mainImage,
    String? price,
    int? amount,
  }) {
    return Package(
      id: id ?? this.id,
      name: name ?? this.name,
      mainImage: mainImage ?? this.mainImage,
      price: price ?? this.price,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mainImage': mainImage,
      'price': price,
      'amount': amount,
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    // print("map is $map");
    return Package(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      mainImage: map['main_image'] != null ? map['main_image'] : null,
      price: map['price'] != null ? map['price'] : null,
      amount: map['package_amount'] != null ? map['package_amount'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Package.fromJson(String source) =>
      Package.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Package(id: $id, name: $name, mainImage: $mainImage, price: $price, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Package &&
        other.id == id &&
        other.name == name &&
        other.mainImage == mainImage &&
        other.price == price &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mainImage.hashCode ^
        price.hashCode ^
        amount.hashCode;
  }
}
