import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 12),
              SizedBox(
                  height: 100,
                  child: Image.asset(
                    'assets/logo.png',
                    colorBlendMode: BlendMode.darken,
                  )),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'Hi!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 4),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'We are ready to help you,',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: SizedBox(
                  width: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _launchCaller(8075170415);
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.purple,
                              child: Icon(
                                Icons.phone,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Call us',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _sendmail();
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.purple,
                              radius: 24,
                              child: Icon(
                                Icons.email,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Email us',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

_launchCaller(int phoneNo) async {
  var _url = "tel:$phoneNo";
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw 'Could not launch $_url';
  }
}

_sendmail() async {
  var _url = 'mailto:dailyneeds.rawfoods@gmail.com';
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
