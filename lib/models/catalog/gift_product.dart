import 'dart:convert';

import 'package:esentai/models/catalog/product.dart';

class GiftProduct {
  int? product;
  int? quanitity;
  Product? products;

  GiftProduct({
    this.product,
    this.quanitity,
    this.products,
  });

  GiftProduct copyWith({
    int? product,
    int? quanitity,
    Product? products,
  }) {
    return GiftProduct(
      product: product ?? this.product,
      quanitity: quanitity ?? this.quanitity,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'quanitity': quanitity,
      'products': products?.toMap(),
    };
  }

  factory GiftProduct.fromMap(Map<String, dynamic> map) {
    return GiftProduct(
      product: map['product'] != null ? map['product'] : null,
      quanitity: map['quanitity'] != null ? map['quanitity'] : null,
      products:
          map['products'] != null ? Product.fromMap(map['products']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftProduct.fromJson(String source) =>
      GiftProduct.fromMap(json.decode(source));

  @override
  String toString() =>
      'GiftProduct(product: $product, quanitity: $quanitity, products: $products)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GiftProduct &&
        other.product == product &&
        other.quanitity == quanitity &&
        other.products == products;
  }

  @override
  int get hashCode => product.hashCode ^ quanitity.hashCode ^ products.hashCode;
}
