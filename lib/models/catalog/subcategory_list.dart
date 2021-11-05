import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/post/post.dart';

class SubcategoryList {
  final List<Subcategory>? items;

  SubcategoryList({
    this.items,
  });

  factory SubcategoryList.fromJson(List<dynamic> json) {
    // print("subcategories are $json");

    List<Subcategory> items = <Subcategory>[];
    items = json
        .map((item) => Subcategory.fromMap(item))
        .toList()
        .cast<Subcategory>();

    return SubcategoryList(
      items: items,
    );
  }
}
