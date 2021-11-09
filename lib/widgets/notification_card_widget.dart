import 'package:esentai/models/notification/back_notification.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({Key? key, required this.notification})
      : super(key: key);

  final BackNotification notification;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: Column(
        children: [
          Expandable(
            collapsed: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '${notification.createdAt}',
                          style:
                              DefaultAppTheme.bodyText2.override(fontSize: 13),
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${notification.title}',
                                style: DefaultAppTheme.title2,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text('${notification.body}',
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: DefaultAppTheme.bodyText2),
                              ),
                            ],
                          ),
                        ),
                        if (notification.body!.length > 60)
                          ExpandableButton(
                            child: Image.asset(
                              'assets/images/ic_arrow_down.png',
                              width: 15,
                              height: 15,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            expanded: Column(children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text('${notification.createdAt}',
                              style: DefaultAppTheme.bodyText2
                                  .override(fontSize: 13))),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${notification.title}',
                                  style: DefaultAppTheme.title2,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text('${notification.body}',
                                      style: DefaultAppTheme.bodyText2),
                                ),
                              ],
                            ),
                          ),
                          ExpandableButton(
                            child: Image.asset(
                              'assets/images/ic_arrow_up.png',
                              width: 15,
                              height: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
