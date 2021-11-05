class Subcategory {
  int? id;
  String? name;
  String? image;
  int? position;
  int? categoryId;

  Subcategory({this.id, this.name, this.image, this.position, this.categoryId});

  factory Subcategory.fromMap(Map<String, dynamic> json) => Subcategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      position: json['position'],
      categoryId: json['category']);

  @override
  String toString() {
    return "Subcategory($id, $name, $image, $position, $categoryId)";
  }
}
