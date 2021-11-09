import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/catalog/subcategory_list.dart';

class Category {
  int? id;
  String? name;
  String? image;
  int? position;
  SubcategoryList? subcategories;

  Category({this.id, this.name, this.image, this.position, this.subcategories});

  factory Category.fromMap(Map<String, dynamic> json) => Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      position: json['position'],
      subcategories: SubcategoryList.fromJson(json['sub_categories']));
}
