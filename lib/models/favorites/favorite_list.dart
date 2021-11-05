import 'package:esentai/models/catalog/category.dart';
import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/favorites/favorite.dart';
import 'package:esentai/models/post/post.dart';

class FavoriteList {
  final List<Favorite>? items;

  FavoriteList({
    this.items,
  });

  factory FavoriteList.fromJson(Map<String, dynamic> json) {
    // print("json is $json");

    List<Favorite> items = <Favorite>[];
    List<dynamic> results = json['results'];

    items = results.map((item) => Favorite.fromMap(item)).toList();

    // print('items...');
    // print(items);

    return FavoriteList(
      items: items,
    );
  }
}
