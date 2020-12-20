import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/authPage/phoneAuth/login.dart';
import 'package:daily_needs/homeScreen/Carousel.dart';
import 'package:daily_needs/homeScreen/homescreen.dart';
import 'package:daily_needs/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
List homeAdsFromSplash = [];
List meatAdsFromSplash = [];
bool _showSpinner = true;
final FirebaseAuth auth = FirebaseAuth.instance;
bool firebaseIntialised = false;

class SplashScreenWindow extends StatefulWidget {
  static String id = 'Splash_Screen';

  @override
  _SplashScreenWindowState createState() => _SplashScreenWindowState();
}

class _SplashScreenWindowState extends State<SplashScreenWindow> {
  @override
  void initState() {
    print('splash init state called');
    initFunctions();
    super.initState();
  }

  initFunctions() {
    firebaseFunctions();
  }

  Future<bool> getUserDataAndNotifications() async {
    final localData = await SharedPreferences.getInstance();
    String userData = localData.getString('userNew') ?? '';
    print('splash scren: $userData');
    if (userData == "null" || userData == '') {
      return false;
    } else {
      Map user = jsonDecode(userData);
      Provider.of<IsInList>(context, listen: false).addUser(user);
      return true;
    }
  }

  firebaseFunctions() async {
    await Firebase.initializeApp();
    bool _isLogined = await getUserDataAndNotifications();
    if (_isLogined == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PhoneLoginScreen()));
    } else {
      try {
        // Navigator.pop(context, true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {}
    }

    _showSpinner = false;
  }

  @override
  void dispose() {
    _showSpinner = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: RefreshProgressIndicator(),
      inAsyncCall: _showSpinner,
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}
