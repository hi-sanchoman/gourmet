import 'package:esentai/models/notification/back_notification.dart';

class NotificationList {
  List<BackNotification>? items;

  NotificationList({
    this.items,
  });

  factory NotificationList.fromMap(Map<String, dynamic> json) {
    // print("json is $json");

    List<BackNotification> items = <BackNotification>[];
    List<dynamic> results = json['results'];

    items = results.map((item) => BackNotification.fromMap(item)).toList();

    return NotificationList(
      items: items,
    );
  }
}
