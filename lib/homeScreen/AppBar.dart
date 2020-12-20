import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/common/cartBadge.dart';
import 'package:daily_needs/commonProviders.dart';
import 'package:daily_needs/homeScreen/notification/notificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/theme.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Cherupuzha      ',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            '670511',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      Positioned(
                        top: -4,
                        right: 0,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 10),
              Spacer(),
              StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection('home/670511/notifications')
                    .doc('v2.1')
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  List notifications = [];
                  if (snapshot.hasData) {
                    if (snapshot.data.data() == null) {
                      notifications = [];
                    } else {
                      notifications = snapshot.data.data()['notifications'];
                    }
                  }
                  return NotificationBadge(notifications);
                },
              ),
              SizedBox(width: 10),
              CartBadge(),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final List notifications;
  NotificationBadge(this.notifications);
  @override
  Widget build(BuildContext context) {
    int now = DateTime.now().millisecondsSinceEpoch;
    print('now $now');
    return Consumer<CommonProvider>(
      builder: (context, provider, child) {
        int lastViewed = provider.lastViewed;
        int badgeNo = getNotificationsBadgeNo(notifications, lastViewed);
        print('last viewed $lastViewed');
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NotificationScreen(returnedNotifications)));
            int now = DateTime.now().millisecondsSinceEpoch;
            provider.setLastViewed(now);
          },
          child: SizedBox(
            width: 35,
            height: 30,
            child: Stack(
              children: [
                Positioned(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_active,
                        size: 25,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  left: 0,
                  top: 4,
                ),
                badgeNo > 0
                    ? Positioned(
                        right: 3,
                        top: 0,
                        child: Container(
                          child: Text(
                            '${getNotificationsBadgeNo(notifications, lastViewed)}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          height: 17,
                          width: 17,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xffEF4F45),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

List returnedNotifications = [];
int getNotificationsBadgeNo(List notifications, int lastViewed) {
  returnedNotifications = [];
  int badgeNo = 0;
  var notificationsReversed = notifications.reversed;
  int i = 0;
  for (Map notification in notificationsReversed) {
    if (notification['time'] > lastViewed) {
      badgeNo++;
    }
    returnedNotifications.add(notification);

    if (i == 5) {
      break;
    }
    i++;
  }
  return badgeNo;
}
