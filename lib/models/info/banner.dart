import 'dart:convert';

class BannerPage {
  int? id;
  String? image;
  String? content;
  String? title;

  BannerPage({
    this.id,
    this.image,
    this.content,
    this.title,
  });

  BannerPage copyWith({
    int? id,
    String? image,
    String? content,
    String? title,
  }) {
    return BannerPage(
      id: id ?? this.id,
      image: image ?? this.image,
      content: content ?? this.content,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'content': content,
      'title': title,
    };
  }

  factory BannerPage.fromMap(Map<String, dynamic> map) {
    return BannerPage(
      id: map['id'] != null ? map['id'] : null,
      image: map['image'] != null ? map['image'] : null,
      content: map['content'] != null ? map['content'] : null,
      title: map['title'] != null ? map['title'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerPage.fromJson(String source) =>
      BannerPage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Banner(id: $id, image: $image, content: $content, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannerPage &&
        other.id == id &&
        other.image == image &&
        other.content == content &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^ image.hashCode ^ content.hashCode ^ title.hashCode;
  }
}
