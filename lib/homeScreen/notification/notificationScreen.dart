import 'package:daily_needs/homeScreen/timeConvertor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  final List notifications;
  NotificationScreen(this.notifications);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: widget.notifications.length,
            itemBuilder: (context, index) {
              Map notifications = widget.notifications[index];
              String link = notifications['link'] ?? '';
              int _nowInMS = DateTime.now().millisecondsSinceEpoch;
              int deliveredTimeInMs = notifications['time'];
              DateTime deliveredTime =
                  DateTime.fromMillisecondsSinceEpoch(deliveredTimeInMs);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Material(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 8, bottom: 8),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            '${timeConvertor(_nowInMS - deliveredTimeInMs, deliveredTime)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          width: double.infinity,
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${notifications['title']}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        link != ''
                            ? Container(
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    openLink(link);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text('More ...'),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}

void openLink(String link) async {
  String url = "$link";
  if (await canLaunch(url))
    launch(url);
  else {}
}
