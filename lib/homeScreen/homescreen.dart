import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/brain/CakesAndIceCreams.dart';
import 'package:daily_needs/brain/brain.dart';
import 'package:daily_needs/brain/deliverySoltBrain.dart';
import 'package:daily_needs/brain/groceryBrain.dart';
import 'package:daily_needs/brain/notifiactionsBrain.dart';
import 'package:daily_needs/brain/restaurants/restaurantsBrain.dart';
import 'package:daily_needs/brain/vegitableFruits.dart';
import 'package:daily_needs/commonProviders.dart';
import 'package:daily_needs/extracted/shaderMaskLoadingWidget.dart';
import 'package:daily_needs/functions/navigatorFunctions.dart';
import 'package:daily_needs/screens/CartPage/sendFcm.dart';
import 'package:daily_needs/screens/CheckOutPage/Apicall/httpCall.dart';
import 'package:daily_needs/screens/CheckOutPage/sucessful/orderSucessFulPage.dart';
import 'package:daily_needs/screens/Restaurants/RestaurantsIndex.dart';
import 'package:daily_needs/screens/cakesAndIceCream/cakesIceCreamsIndex.dart';
import 'package:daily_needs/screens/grocery/grocery.dart';
import 'package:daily_needs/screens/maps/maps.dart';
import 'package:daily_needs/screens/meat/meat.dart';
import 'package:daily_needs/screens/vegitablesFruitsPage/vegitablesFruitsIndex.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_needs/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/ViewCart_BottomNavBar.dart';
import '../provider.dart';
import 'AppBar.dart';
import 'Carousel.dart';
import 'MyHomeScreenCard.dart';
import 'drawer.dart';
import 'firebaseMessaging.dart';
import 'package:daily_needs/functions/shopCloseCheck.dart';
import 'package:daily_needs/functions/testMain.dart';
import 'package:flutter/services.dart';

bool _showSpinner = false;
var _meatBrain;
var _updateInfo;
List _homeAds = [];
List _meatAds = [];
List<Widget> imageSliders = [];
FirebaseFirestore _firestore = FirebaseFirestore.instance;
Widget carousel;
Map _vegFruitsAllDetails; // all details
Map _cakesIceCreamsAllDetails;
bool load = true;

class HomeScreen extends StatefulWidget {
  static String id = 'Home_Screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    load = true;
    getFcmToken();
    initializeFlutterFire();
    _vegFruitsAllDetails = null;
    _cakesIceCreamsAllDetails = null;

    firebaseFunctions();
    getUserDataAndNotifications();
    setState(() {});
    super.initState();
  }

  cleaChache() async {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
    await FirebaseFirestore.instance.clearPersistence();
    _showSpinner = false;
    load = false;
    setState(() {});
  }

  getFcmToken() async {
    FireBaseMessagingClass fireBaseMessagingClass =
        FireBaseMessagingClass(context);
    fireBaseMessagingClass.firebaseConfigure();
    String fcmId = await fireBaseMessagingClass.getFirebaseToken();
    Provider.of<IsInList>(context, listen: false).setFcmId(fcmId);
    fireBaseMessagingClass.fcmSubscribe();
  }

  bool _initialized = false;
  void initializeFlutterFire() async {
    // int indianTimeH = await getIndianHour();
    // print('indian hour= $indianTimeH');
    // Provider.of<IsInList>(context, listen: false).setIndianH(indianTimeH);

    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        print('firebase initialized');
      });
    } catch (e) {
      setState(() {
//        _error = true;
      });
    }
    // FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
    // await FirebaseFirestore.instance.clearPersistence();
  }

  Future getUserDataAndNotifications() async {
    final localData = await SharedPreferences.getInstance();
    String userData = localData.getString('userNew') ?? '';
    if (userData != '') {
      Map user = jsonDecode(userData);
      Provider.of<IsInList>(context, listen: false).addUser(user);
    }
    Provider.of<CommonProvider>(context, listen: false).getLastViewed();
  }

  firebaseFunctions() async {
    try {
      DocumentSnapshot snap = await _firestore
          .collection('home/670511/ads')
          .doc('670511')
          .get()
          .timeout(Duration(seconds: 15));
      _homeAds = snap.data()['homeAds'];
      List homeAds = _homeAds.reversed.toList();
      _meatAds = snap.data()['meatAds'];
      imageSliders = getImageSliders(homeAds);

      setState(() {});
    } catch (e) {}
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) => _showError(e));
  }

  void _showError(dynamic exception) {
    print(exception);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (_showSpinner == false || load == true) {
      carousel = makeCarouousel(imageSliders, size);
    }
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();

        return new Future(() => true);
      },
      child: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        progressIndicator: RefreshProgressIndicator(),
        child: Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(),
          backgroundColor: Colors.white.withOpacity(.94),
          body: Column(
            children: <Widget>[
              MyAppBar(scaffoldKey: _scaffoldKey),
              Expanded(
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: constraints.copyWith(
                        minHeight: constraints.maxHeight,
                        maxHeight: double.infinity,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5),
                            //  carousel
                            carousel,
                            SizedBox(height: 0),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 10),
                              child: Material(
//                              color: Colors.white,
                                shadowColor: Colors.black,
                                elevation: 3,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 12),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                _showSpinner = true;
                                              });
                                              bool isConnection =
                                                  await checkConnectivity(
                                                      _scaffoldKey);
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                              if (isConnection == true) {
                                                setState(() {
                                                  _showSpinner = true;
                                                });
                                                _meatBrain =
                                                    await getMeatData();
                                                navigatorSlideAnimationFunction(
                                                    context,
                                                    MeatPage(
                                                      brain: _meatBrain,
                                                      meatAds: _meatAds,
                                                    ));
                                              }
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                            },
                                            child: MyCard(
                                              image: 'assets/fishMeat.jpg',
                                              imageType: 'asset',
                                              title: 'Poultry, Fish & \n Meat',
                                            ),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                _showSpinner = true;
                                              });
                                              bool isConnection =
                                                  await checkConnectivity(
                                                      _scaffoldKey);
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                              if (isConnection == true) {
                                                setState(() {
                                                  _showSpinner = true;
                                                });
                                                try {
                                                  _vegFruitsAllDetails =
                                                      await getVegetablesFruts();
                                                  if (_vegFruitsAllDetails ==
                                                      null) {
                                                    // _vegFruitsAllDetails =
                                                    //     await getVegetablesFruts();
                                                  } else {
                                                    if (_vegFruitsAllDetails
                                                        .isEmpty) {
                                                      _vegFruitsAllDetails =
                                                          await getVegetablesFruts();
                                                    }
                                                  }
                                                  navigatorSlideAnimationFunction(
                                                      context,
                                                      FruitsVegetablesIndex(
                                                        title: 'Vegetables',
                                                        allDetails:
                                                            _vegFruitsAllDetails,
                                                      ));
                                                } catch (e) {
                                                  print(e);
                                                }
                                                setState(() {
                                                  _showSpinner = false;
                                                });
                                              }
                                            },
                                            child: MyCard(
                                              image: 'assets/vegetables.jpg',
                                              imageType: 'asset',
                                              title: 'Vegetables',
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                _showSpinner = true;
                                              });
                                              bool isConnection =
                                                  await checkConnectivity(
                                                      _scaffoldKey);
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                              if (isConnection == true) {
                                                setState(() {
                                                  _showSpinner = true;
                                                });
                                                try {
                                                  _vegFruitsAllDetails =
                                                      await getVegetablesFruts();
                                                  if (_vegFruitsAllDetails ==
                                                      null) {
                                                    // _vegFruitsAllDetails =
                                                    //     await getVegetablesFruts();
                                                  } else {
                                                    if (_vegFruitsAllDetails
                                                        .isEmpty) {
                                                      _vegFruitsAllDetails =
                                                          await getVegetablesFruts();
                                                    }
                                                  }
                                                  navigatorSlideAnimationFunction(
                                                      context,
                                                      FruitsVegetablesIndex(
                                                        title: 'Fruits',
                                                        allDetails:
                                                            _vegFruitsAllDetails,
                                                      ));
                                                } catch (e) {}
                                              }
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                            },
                                            child: MyCard(
                                              image: 'assets/fruits.jpg',
                                              imageType: 'asset',
                                              title: 'Fruits',
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                _showSpinner = true;
                                              });
                                              bool isConnection =
                                                  await checkConnectivity(
                                                      _scaffoldKey);
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                              if (isConnection == true) {
                                                setState(() {
                                                  _showSpinner = true;
                                                });
                                                try {
                                                  _cakesIceCreamsAllDetails =
                                                      await getCakesIceCream();
                                                  if (_cakesIceCreamsAllDetails ==
                                                      null) {
                                                    // _cakesIceCreamsAllDetails =
                                                    //     await getCakesIceCream();
                                                  } else {
                                                    if (_cakesIceCreamsAllDetails
                                                        .isEmpty) {
                                                      _cakesIceCreamsAllDetails =
                                                          await getCakesIceCream();
                                                    }
                                                  }
                                                } catch (e) {}

                                                navigatorSlideAnimationFunction(
                                                    context,
                                                    CakesIceCreams(
                                                      title: 'cakesAndBakery',
                                                      allDetails:
                                                          _cakesIceCreamsAllDetails,
                                                    ));
                                              }
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                            },
                                            child: MyCard(
                                              image: 'assets/bakery.jpg',
                                              imageType: 'asset',
                                              title: 'Cakes & Ice Cream',
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                _showSpinner = true;
                                              });
                                              Map groceryDetails;
                                              bool isConnection =
                                                  await checkConnectivity(
                                                      _scaffoldKey);
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                              if (isConnection == true) {
                                                setState(() {
                                                  _showSpinner = true;
                                                });
                                                try {
                                                  groceryDetails =
                                                      await getGrocery();
                                                } catch (e) {}

//                                            DocumentSnapshot snap =
//                                                await _firestore
//                                                    .collection(
//                                                        'location/670511/items')
//                                                    .document('grocery')
//                                                    .get();

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GroceryHomeScreen(
                                                              groceryDetails:
                                                                  groceryDetails,
                                                            )));

                                                setState(() {
                                                  _showSpinner = false;
                                                });
                                              }
                                            },
                                            child: MyCard(
                                              image: 'assets/grocery.jpg',
                                              imageType: 'asset',
                                              title: 'Groceries',
                                            ),
                                          ),
                                          // restaurants
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                _showSpinner = true;
                                              });
                                              bool isConnection =
                                                  await checkConnectivity(
                                                      _scaffoldKey);
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                              if (isConnection == true) {
                                                setState(() {
                                                  _showSpinner = true;
                                                });
                                                try {
                                                  Map _restaurantDetails =
                                                      await getRestaurants();
                                                  navigatorSlideAnimationFunction(
                                                      context,
                                                      RestaurantsIndex(
                                                        title: 'Restaurants',
                                                        // for testing offline data
                                                        // allDetails: restaurants,
                                                        allDetails:
                                                            _restaurantDetails,
                                                      ));
                                                } catch (e) {}
                                              }
                                              setState(() {
                                                _showSpinner = false;
                                              });
                                            },
                                            child: MyCard(
                                              image: 'assets/restaurant.jpg',
                                              imageType: 'asset',
                                              title: 'Restaurants',
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 45),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              FlatButton(
                color: Colors.white,
                onPressed: () async {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => MapSample()));
                  setState(() {
                    _showSpinner = true;
                  });

                  // _firestore
                  //     .collection('location/670511/items')
                  //     .doc('meat')
                  //     .set({
                  //   'allInfo': allInfo,
                  //   'menuItems': menuItems,
                  // });
                  // await _firestore
                  //     .collection('location/670511/items')
                  //     .doc('vegetablesAndFruits')
                  //     .set({
                  //   'allInfo': vegFruitsInfo,
                  // });
                  await _firestore
                      .collection('location/670511/items')
                      .doc('restaurants')
                      .set({
                    'allInfo': restaurants,
                  });
//                 await _firestore
//                     .collection('delivery/670511/deliverySlot')
//                     .doc('670511')
//                     .set({
//                   'common': '10',
//                   'deliverySlotList': deliverySlot,
//                   'epress': "20"
// //                 });
//                 await _firestore
//                     .collection('home/670511/notifications')
//                     .doc('v1.8')
//                     .set({'notifications': notifications});
//                 print('curreent widget ${navigatorKey.currentState}');
//                 sendAndRetrieveMessage();

                  // await _firestore
                  //     .collection('location/670511/items')
                  //     .doc('grocery')
                  //     .set({
                  //   'allInfo': groceyMap,
                  // });
                  await _firestore
                      .collection('location/670511/items')
                      .doc('cakesAndIceCream')
                      .set({
                    'allInfo': cakesIceCreamsMap,
                  });
                  setState(() {
                    _showSpinner = false;
                  });
                },
                child: Text('save'),
              ),
              ViewCartBottomNavigationBar(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              const url = "https://wa.me/918075170415";
              if (await canLaunch(url))
                launch(url);
              else {}
            },
            backgroundColor: Colors.purple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble),
                Text('Chat'),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}

double getGridLength(int noOfItems) {
  double a = noOfItems / 2;
  int b = a.round();
  return 133.0 * b;
}

Future<Map> getMeatData() async {
  DocumentSnapshot snapshot =
      await _firestore.collection('location/670511/items').doc('meat').get();
  var meat = snapshot.data();
  if (!snapshot.metadata.isFromCache) {
    return meat;
  } else {
    return null;
  }
  print(' is from chache ${snapshot.metadata.isFromCache}');
}

Future<Map> getVegetablesFruts() async {
  DocumentSnapshot snap = await _firestore
      .collection('location/670511/items')
      .doc('vegetablesAndFruits')
      .get();
  Map _allDetails = snap.data()['allInfo'];

  if (snap.metadata.isFromCache) {
    await Future.delayed(Duration(milliseconds: 300));
    getVegetablesFruts();
  }
  print(' is from chache ${snap.metadata.isFromCache}');
  return _allDetails;
}

Future<Map> getRestaurants() async {
  DocumentSnapshot snap = await _firestore
      .collection('location/670511/items')
      .doc('restaurants')
      .get();
  Map _allDetails = snap.data()['allInfo'];

  if (!snap.metadata.isFromCache) {
    return Map<String, dynamic>.from(_allDetails);
  } else {
    print('donot get any data from internet');
    return null;
  }
  print(' is from chache ${snap.metadata.isFromCache}');
  // return _allDetails;
}

Future<Map> getGrocery() async {
  DocumentSnapshot snap =
      await _firestore.collection('location/670511/items').doc('grocery').get();
  Map _allDetails = snap.data()['allInfo'];

  if (snap.metadata.isFromCache) {
    await Future.delayed(Duration(milliseconds: 300));
    getGrocery();
  }
  print(' is from chache ${snap.metadata.isFromCache}');
  return _allDetails;
}

Future<Map> getCakesIceCream() async {
  DocumentSnapshot snap = await _firestore
      .collection('location/670511/items')
      .document('cakesAndIceCream')
      .get();
  Map _allDetails = snap.data()['allInfo'];

  if (snap.metadata.isFromCache) {
    await Future.delayed(Duration(milliseconds: 300));
    getCakesIceCream();
  }
  print(' is from chache ${snap.metadata.isFromCache}');
  return _allDetails;
}

void showSpinnerInVegFruitsEtc(
    var _allDetails, String title, Function navFuction) {
  List items = _allDetails['$title']['items'];
  String _url = items[0]['image'];
  print(_url);
  var _image = NetworkImage("$_url");
  _image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
    (info, call) {
      navFuction();
    },
  ));
  return null;
}
