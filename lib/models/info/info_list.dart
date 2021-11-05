import 'package:esentai/models/info/info.dart';
import 'package:esentai/models/post/post.dart';

class InfoList {
  final List<InfoPage>? items;

  InfoList({
    this.items,
  });

  factory InfoList.fromMap(Map<String, dynamic> json) {
    // print("from infolist... " + json.toString());

    List<InfoPage> items = <InfoPage>[];
    List<dynamic> results = json['results'];

    items = results.map((item) => InfoPage.fromMap(item)).toList();

    return InfoList(
      items: items,
    );
  }
}
