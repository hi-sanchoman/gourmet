import 'package:esentai/models/catalog/category.dart';
import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/payment/creditcard.dart';
import 'package:esentai/models/post/post.dart';

class CardList {
  final List<CreditCard>? items;

  CardList({
    this.items,
  });

  factory CardList.fromMap(Map<String, dynamic> map) {
    List<CreditCard> items = <CreditCard>[];
    List<dynamic> results = map['message'];

    // print("cardlist $results");

    items = results.map((item) => CreditCard.fromMap(item)).toList();

    return CardList(
      items: items,
    );
  }
}
