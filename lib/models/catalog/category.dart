import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/catalog/subcategory_list.dart';

class Category {
  int? id;
  String? name;
  String? image;
  int? position;
  bool? hasPermissions;
  String? permissionsText;
  SubcategoryList? subcategories;

  Category(
      {this.id,
      this.name,
      this.image,
      this.position,
      this.hasPermissions,
      this.permissionsText,
      this.subcategories});

  factory Category.fromMap(Map<String, dynamic> json) {
    Category item = Category(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        position: json['position'],
        hasPermissions: json['has_permissions'],
        permissionsText: json['permissions_text'],
        subcategories: SubcategoryList.fromJsonList(json['sub_categories']));

    // print("category: $item");
    return item;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Category ($id, $name, $permissionsText, $image)';
  }
}
