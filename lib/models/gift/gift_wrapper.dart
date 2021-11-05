import 'dart:convert';

import 'package:esentai/models/catalog/gift.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/gift/package.dart';
import 'package:esentai/models/gift/postcard.dart';

class GiftWrapper {
  Product gift;
  Package? package;
  Postcard? postcard;

  GiftWrapper({
    required this.gift,
    this.package,
    this.postcard,
  });

  GiftWrapper copyWith({
    Product? gift,
    Package? package,
    Postcard? postcard,
  }) {
    return GiftWrapper(
      gift: gift ?? this.gift,
      package: package ?? this.package,
      postcard: postcard ?? this.postcard,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gift': gift.toMap(),
      'package': package?.toMap(),
      'postcard': postcard?.toMap(),
    };
  }

  factory GiftWrapper.fromMap(Map<String, dynamic> map) {
    return GiftWrapper(
      gift: Product.fromMap(map['gift']),
      package: map['package'] != null ? Package.fromMap(map['package']) : null,
      postcard:
          map['postcard'] != null ? Postcard.fromMap(map['postcard']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftWrapper.fromJson(String source) =>
      GiftWrapper.fromMap(json.decode(source));

  @override
  String toString() =>
      'GiftWrapper(gift: $gift, package: $package, postcard: $postcard)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GiftWrapper &&
        other.gift == gift &&
        other.package == package &&
        other.postcard == postcard;
  }

  @override
  int get hashCode => gift.hashCode ^ package.hashCode ^ postcard.hashCode;
}
