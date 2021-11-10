import 'package:esentai/models/catalog/product_list.dart';

class Subcategory {
  int? id;
  String? name;
  String? image;
  int? position;
  int? categoryId;
  ProductList? products;

  Subcategory(
      {this.id,
      this.name,
      this.image,
      this.position,
      this.categoryId,
      this.products});

  factory Subcategory.fromMap(Map<String, dynamic> json) => Subcategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      position: json['position'],
      products: json['products'] != null
          ? ProductList.fromMap(json, subcategory: true)
          : null,
      categoryId: json['category']);

  @override
  String toString() {
    return "Subcategory($id, $name, $image, $position, $categoryId)";
  }
}
