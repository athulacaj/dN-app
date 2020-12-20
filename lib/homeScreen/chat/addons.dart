import 'package:daily_needs/homeScreen/timeConvertor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessageBox extends StatelessWidget {
  final String email;
  final Map messageMap;
  final size;
  ChatMessageBox(this.email, this.size, this.messageMap);
  @override
  Widget build(BuildContext context) {
    int _nowInMS = DateTime.now().millisecondsSinceEpoch;
    int deliveredTimeInMs = messageMap['time'];
    DateTime deliveredTime =
        DateTime.fromMillisecondsSinceEpoch(deliveredTimeInMs);
    return new Row(
      mainAxisAlignment: email == messageMap['email']
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.all(4),
          width: size.width / 1.4,
          child: new Padding(
            padding: new EdgeInsets.all(6.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  children: checkIsLinkOrPhoneNumber(messageMap['message']),
                ),
                SizedBox(height: 3),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${timeConvertor(_nowInMS - deliveredTimeInMs, deliveredTime)}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          decoration: email == messageMap['email']
              ? BoxDecoration(
                  boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 1.0,
                      ),
                    ],
                  color: Color(0xfffDCF8C6),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    topLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ))
              : BoxDecoration(
                  boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 1.0,
                      ),
                    ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  )),
        ),
      ],
    );
  }
}

const KtextfieldDecoration = InputDecoration(
  hintText: 'Type a message',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

List<Widget> checkIsLinkOrPhoneNumber(String messages) {
  List messageList = messages.split(' ');
  List<Widget> toReturn = [];
  for (String message in messageList) {
    int isNumberIndex = -1;
    if (message.length == 10) {
      // checking a number is phoneNumber
      try {
        isNumberIndex = int.parse(message);
      } catch (e) {
        print(e);
      }
    }
    if (message.length > 4 && message.toLowerCase().substring(0, 4) == 'http' ||
        message.length > 4 && message.toLowerCase().substring(0, 4) == 'www.') {
      Widget textToAdd = GestureDetector(
        onTap: () {
          print('link open');
          launchURL('$message');
        },
        child: Text(
          '$message ',
          style: TextStyle(color: Colors.blue, height: 1.2, fontSize: 16),
        ),
      );
      toReturn.add(textToAdd);
    } else if (isNumberIndex != -1) {
      Widget textToAdd = GestureDetector(
        onTap: () {
          int phoneNumber = int.parse(message);
          launchCaller(phoneNumber);
        },
        child: Text(
          '$message ',
          style: TextStyle(color: Colors.blue, height: 1.2, fontSize: 16),
        ),
      );
      toReturn.add(textToAdd);
    } else {
      Widget textToAdd = Text(
        '$message  ',
        style: TextStyle(color: Colors.black, height: 1.2, fontSize: 16),
      );
      toReturn.add(textToAdd);
    }
  }
  return toReturn;
}

launchURL(String link) async {
//  const url = 'https://flutter.dev';
  String url = link;
  if (link.toLowerCase().substring(0, 1) != 'h') {
    url = 'https://$link';
  }
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchCaller(int phoneNo) async {
  var _url = "tel:$phoneNo";
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
