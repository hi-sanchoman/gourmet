import 'dart:convert';

class Postcard {
  int? id;
  String? name;
  String? mainImage;
  String? price;
  int? amount;
  String? text;

  Postcard({
    this.id,
    this.name,
    this.mainImage,
    this.price,
    this.amount,
    this.text,
  });

  Postcard copyWith({
    int? id,
    String? name,
    String? mainImage,
    String? price,
    int? amount,
    String? text,
  }) {
    return Postcard(
      id: id ?? this.id,
      name: name ?? this.name,
      mainImage: mainImage ?? this.mainImage,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mainImage': mainImage,
      'price': price,
      'amount': amount,
      'text': text,
    };
  }

  factory Postcard.fromMap(Map<String, dynamic> map) {
    return Postcard(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      mainImage: map['mainImage'] != null ? map['mainImage'] : null,
      price: map['price'] != null ? map['price'] : null,
      amount: map['amount'] != null ? map['amount'] : null,
      text: map['text'] != null ? map['text'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Postcard.fromJson(String source) =>
      Postcard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Postcard(id: $id, name: $name, mainImage: $mainImage, price: $price, amount: $amount, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Postcard &&
        other.id == id &&
        other.name == name &&
        other.mainImage == mainImage &&
        other.price == price &&
        other.amount == amount &&
        other.text == text;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mainImage.hashCode ^
        price.hashCode ^
        amount.hashCode ^
        text.hashCode;
  }

  void setText(String? value) {
    text = value;
  }
}
