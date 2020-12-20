import 'package:daily_needs/provider.dart';
import 'package:daily_needs/screens/MyOrders/MyOrders.dart';
import 'package:daily_needs/screens/generalPages/ContactScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'homescreen.dart';
import 'package:flutter/material.dart';

//final _firestore = Firestore.instance;
String fcmToken;

FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//void navigateToItemDetail=navigateToItemDetail()

class FireBaseMessagingClass {
  BuildContext homeScontext;
  FireBaseMessagingClass(this.homeScontext);
  void firebaseConfigure() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: ${message['data']['screen']}");
        if (message['data']['screen'] == 'orders') {
          _navigateToItemDetail(message, navigatorKey.currentContext);
        }
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        firebaseMessaging.onTokenRefresh;

        print("onMessageLaunc: ${message['data']['page']}");
        String _route = await message['data']['screen'];
        print('messaging finished');
        if (message['data']['screen'] == 'orders') {
          _navigateToItemDetail(message, navigatorKey.currentContext);
        }
      },
      onResume: (Map<String, dynamic> message) async {
        firebaseMessaging.onTokenRefresh;

        print('fcm onResume');
        String _route = await message['data']['page'];
        print('messaging finished');
        if (message['data']['screen'] == 'orders') {
          _navigateToItemDetail(message, navigatorKey.currentContext);
        }
      },
    );
  }

  void fcmSubscribe() {
    firebaseMessaging.subscribeToTopic('all');
  }

  Future<String> getFirebaseToken() async {
    firebaseMessaging.subscribeToTopic('all');
    String token = await firebaseMessaging.getToken();
    print('tolken $token');
    return token;
  }

  update(String token) {
    print(token);
//    new DateTime.now()
    fcmToken = token;

//    _firestore.collection('tokens').document('$id').setData({
//      'token': token,
//    });
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
//    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
//    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

void _navigateToItemDetail(Map<String, dynamic> message, BuildContext context) {
  final MessageBean item = _itemForMessage(message);
  // Clear away dialogs
  Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
  // Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.id));

  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
  // );
  if (!item.route.isCurrent) {
    Navigator.push(context, item.route);
  }
}

final Map<String, MessageBean> _items = <String, MessageBean>{};
MessageBean _itemForMessage(Map<String, dynamic> message) {
  //If the message['data'] is non-null, we will return its value, else return map message object
  final dynamic data = message['data'] ?? message;
  final String itemId = data['screen'];
  final MessageBean item = _items.putIfAbsent(
      itemId, () => MessageBean(itemId: itemId))
    ..status = data['status'];
  return item;
}

class MessageBean {
  MessageBean({this.itemId});
  final String itemId;

  StreamController<MessageBean> _controller =
      StreamController<MessageBean>.broadcast();
  Stream<MessageBean> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => MyOrders(fromWhere: 'notnull'),
      ),
    );
  }
}
