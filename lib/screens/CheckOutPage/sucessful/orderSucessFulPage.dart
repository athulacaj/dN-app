import 'dart:async';

import 'package:daily_needs/extracted/extractedButton.dart';
import 'package:daily_needs/homeScreen/homescreen.dart';
import 'package:daily_needs/screens/CheckOutPage/sucessful/circleDrawAnimation.dart';
import 'package:daily_needs/screens/MyOrders/MyOrders.dart';
import 'package:daily_needs/screens/splashscreen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SuccessfulPage extends StatefulWidget {
  @override
  _SuccessfulPageState createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        return new Future(() => false);
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: 30,
              color: Colors.purple[600],
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: MediaQuery.of(context).size.height / 3,
                            child: FlareActor(
                              "assets/flare/success.flr",
                              animation: 'animate',
                              fit: BoxFit.contain,
                            ))
                        // CircleDraw()),
                        ),
                    TweenAnimationBuilder(
                        tween:
                            ColorTween(begin: Colors.white, end: Colors.black),
                        duration: Duration(milliseconds: 2000),
                        builder: (context, value, child) {
                          return Text(
                            'Your order Placed successfully',
                            style: TextStyle(color: value),
                          );
                        }),
                    Spacer(),
                    ExtractedButton(
                      colour: Colors.purple,
                      text: 'View orders',
                      onclick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrders()));
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}
