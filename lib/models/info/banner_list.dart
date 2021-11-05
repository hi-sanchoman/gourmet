import 'package:esentai/models/info/banner.dart';
import 'package:esentai/models/info/info.dart';
import 'package:esentai/models/post/post.dart';

class BannerList {
  final List<BannerPage>? items;

  BannerList({
    this.items,
  });

  factory BannerList.fromMap(Map<String, dynamic> json) {
    // print("from BannerList... " + json.toString());

    List<BannerPage> items = <BannerPage>[];
    List<dynamic> results = json['results'];

    items = results.map((item) => BannerPage.fromMap(item)).toList();

    return BannerList(
      items: items,
    );
  }
}
