import 'package:app_settings/app_settings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/constants/constants.dart';
import 'package:daily_needs/screens/CheckOutPage/Apicall/getLocation.dart';
import 'file:///C:/Users/attaramackal/AndroidStudioProjects/daily_needs/lib/screens/CheckOutPage/reviewPage/ReviewPage.dart';
import 'package:daily_needs/screens/Extracted/ExtractedAdressBox.dart';
import 'package:daily_needs/screens/Extracted/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

double height = 260;

bool _showSpinner = false;
String _selectedDelivarySlot;

DateTime now = DateTime.now();
String formattedTime = DateFormat.Hm().format(now); //5:08 PM
String h = formattedTime.split(':')[0];
int hour = int.parse(h);

bool isLocationEnabled = false;
bool isgpsEnabled = false;
String location;

class DelivarySlot extends StatefulWidget {
  final address;
  final String email;
  final Map user;
  DelivarySlot({this.address, this.email, @required this.user});
  @override
  _DeliverySlotState createState() => _DeliverySlotState();
}

class _DeliverySlotState extends State<DelivarySlot>
    with WidgetsBindingObserver {
  AppLifecycleState _lastLifecycleState;

  @override
  void initState() {
    hour = int.parse(h);
    _selectedDelivarySlot = null;
    _showSpinner = false;
    isLocationEnabled = false;
    isgpsEnabled = false;
    initFunctions();
    callLocationFunction();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  callLocationFunction() async {
    await Permission.location.request();

    if (await Permission.location.isPermanentlyDenied) {
      print('denided permission');
      isLocationEnabled = false;
//      openSettingsMenu('ACTION_MANAGE_ALL_APPLICATIONS_SETTINGS');
    }
    if (await Permission.location.isGranted) {
      print('granded permission');
      isLocationEnabled = true;
      location = await gpsFunction();
//      openSettingsMenu('ACTION_MANAGE_ALL_APPLICATIONS_SETTINGS');
    }
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      isgpsEnabled = true;
    } else {
//      openSettingsMenu("ACTION_LOCATION_SOURCE_SETTINGS");
    }
    setState(() {});
  }

  initFunctions() {
    now = DateTime.now();
    formattedTime = DateFormat.Hm().format(now); //5:08 PM
//    h = formattedTime.split(':')[0];
    hour = int.parse(h);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    _lastLifecycleState = state;
    if (state == AppLifecycleState.resumed) {
      location = await gpsFunction();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
//    var cartItems = Provider.of<IsInList>(context, listen: false).allDetails;
//    var totalAmount = Provider.of<IsInList>(context, listen: false).totalAmount;
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              Container(
                height: 30,
                color: Colors.purple[600],
              ),
              Column(
                children: <Widget>[
                  CommonAppbar(title: 'Delivery Details'),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: AddressBoxWithoutCheckbox(
                                  details: widget.address,
                                ),
                              ),
                              Container(
                                width: 80,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text('Change'),
                                        padding: EdgeInsets.all(8),
                                        decoration:
                                            contaionerBlackOutlineButtonDecoration,
                                      ),
                                    ],
                                  ),
                                ),
                                height: 152,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      top: BorderSide(
                                          width: 1,
                                          color: Colors.black.withOpacity(0.1)),
                                      bottom: BorderSide(
                                        width: 1,
                                        color: Colors.black.withOpacity(0.1),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Material(
                          color: Colors.white,
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            height: hour > 13 ? 210 : 260,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Select delivery slot',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.purple),
                                ),
                                Divider(),
                                StreamBuilder<DocumentSnapshot>(
                                    stream: _firestore
                                        .collection(
                                            'delivery/670511/deliverySlot')
                                        .document('670511')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      List deliverySlotList = snapshot.data
                                          .data()['deliverySlotList'];
                                      return deliverySlotFunction(
                                          deliverySlotList);
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () async {
              if (_selectedDelivarySlot == null) {
                _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(
                    duration: Duration(milliseconds: 1000),
                    backgroundColor: Colors.lightGreen,
                    content: new Text('Please select a delivery slot !'),
                  ),
                );
              } else if (isgpsEnabled == false) {
                Fluttertoast.showToast(
                    msg: "Please enable gps !",
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white);
                await Future.delayed(Duration(milliseconds: 700));
                AppSettings.openLocationSettings();
              } else {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return ReviewPage(
                    email: widget.email,
                    user: widget.user,
                    location: location,
                    address: widget.address,
                    delivarySlot: _selectedDelivarySlot,
                  );
                }, transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                  var begin = Offset(1.0, 0.0);
                  var end = Offset(0.0, 0.0);
                  var tween = Tween(begin: begin, end: end);
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                }));
              }
              setState(() {
                _showSpinner = false;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              color: Colors.purple[500].withOpacity(0.90),
              height: 48,
              child: Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          )),
    );
  }

  deliverySlotFunction(List deliverySlotList) {
    if (hour > 12) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            deliverySlotList[5]['slot'] != ''
                ? buildOneSlot(deliverySlotList, 5, hour)
                : Container(),
            deliverySlotList[3]['slot'] != ''
                ? buildOneSlot(deliverySlotList, 3, hour)
                : Container(),
            deliverySlotList[4]['slot'] != ''
                ? buildOneSlot(deliverySlotList, 4, hour)
                : Container(),
          ],
        ),
      );
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          deliverySlotList[0]['slot'] != ''
              ? buildOneSlot(deliverySlotList, 0, hour)
              : Container(),
          deliverySlotList[1]['slot'] != ''
              ? buildOneSlot(deliverySlotList, 1, hour)
              : Container(),
          deliverySlotList[2]['slot'] != ''
              ? buildOneSlot(deliverySlotList, 2, hour)
              : Container(),
          deliverySlotList[4]['slot'] != ''
              ? buildOneSlot(deliverySlotList, 5, hour)
              : Container(),
        ],
      ),
    );
  }

  buildOneSlot(List deliverySlotList, int i, int h) {
    String h = formattedTime.split(':')[0];
    int hour = int.parse(h);
    int limit = deliverySlotList[i]['limit'];
    bool isAvailable = deliverySlotList[i]['isAvailable'];
    return GestureDetector(
      onTap: () {
        if (hour <= limit && isAvailable != false) {
          _selectedDelivarySlot = deliverySlotList[i]['slot'];
          setState(() {});
        }
      },
      child: Container(
        margin: EdgeInsets.all(4),
        child: Material(
            color: hour <= limit
                ? _selectedDelivarySlot == deliverySlotList[i]['slot'] &&
                        isAvailable != false
                    ? Colors.purple.shade100
                    : Colors.white
                : Colors.white,
            elevation: 2,
            child: Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                child: AutoSizeText(
                  deliverySlotList[i]['slot'],
                  maxLines: 1,
                  style: TextStyle(
                      color: hour <= limit && isAvailable != false
                          ? Colors.black
                          : Colors.black12),
                ))),
      ),
    );
  }
}

Future<String> gpsFunction() async {
  String location = '';
  if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    isgpsEnabled = true;
    location = await Location().getCurrentLocation();
    print('loaction req $location');
  } else {
    isgpsEnabled = false;
  }
  return location;
}
