import 'dart:convert';

class InfoPage {
  // /admin/content/{id}/

  int? id;
  String? title;
  String? content;
  String? slug;
  InfoPage({
    this.id,
    this.title,
    this.content,
    this.slug,
  });

  InfoPage copyWith({
    int? id,
    String? title,
    String? content,
    String? slug,
  }) {
    return InfoPage(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'slug': slug,
    };
  }

  factory InfoPage.fromMap(Map<String, dynamic> map) {
    return InfoPage(
      id: map['id'] != null ? map['id'] : null,
      title: map['title'] != null ? map['title'] : null,
      content: map['content'] != null ? map['content'] : null,
      slug: map['slug'] != null ? map['slug'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoPage.fromJson(String source) =>
      InfoPage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InfoPage(id: $id, title: $title, content: $content, slug: $slug)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InfoPage &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.slug == slug;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ content.hashCode ^ slug.hashCode;
  }
}
