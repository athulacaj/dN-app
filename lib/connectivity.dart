import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> checkConnectivity(_scaffoldKey) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.mobile) {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        result = null;
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      showNoNetworkSnackBar(_scaffoldKey);
      return false;
    }
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        result = null;
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      showNoNetworkSnackBar(_scaffoldKey);
      return false;
    }
  } else {
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        duration: Duration(milliseconds: 2500),
        backgroundColor: Colors.grey.shade800,
        content: new Text("You are offline! Please check connection",
            style: TextStyle(color: Colors.white)),
      ),
    );
//
    StreamSubscription subscription;
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.mobile) {
        try {
          var result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
          _scaffoldKey.currentState.showSnackBar(
            new SnackBar(
              duration: Duration(milliseconds: 2500),
              backgroundColor: Colors.green,
              content: new Text("You are online",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
            ),
          );
          subscription.cancel();
        } on SocketException catch (_) {
          print('not connected');
        }
      } else if (result == ConnectivityResult.wifi) {
        try {
          await Future.delayed(Duration(milliseconds: 200));
          var result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('online');
            _scaffoldKey.currentState.showSnackBar(
              new SnackBar(
                duration: Duration(milliseconds: 2500),
                backgroundColor: Colors.green,
                content: Text("You are online",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
              ),
            );
            subscription.cancel();
            result = null;
          }
          result = null;
        } on SocketException catch (_) {
          print('not connected');
        }
      }
    });
  }
//
//

  return false;
}

void showNoNetworkSnackBar(_scaffoldKey) {
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    duration: Duration(milliseconds: 2500),
    backgroundColor: Colors.grey.shade800,
    content: Text("You are offline! Please check connection",
        textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
  ));
}
