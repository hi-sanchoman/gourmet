import 'package:esentai/models/catalog/category.dart';
import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/post/post.dart';

class CategoryList {
  final List<Category>? items;

  CategoryList({
    this.items,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    // print("json is $json");

    List<Category> items = <Category>[];
    List<dynamic> results = json['results'];

    items = results.map((item) => Category.fromMap(item)).toList();

    return CategoryList(
      items: items,
    );
  }
}
