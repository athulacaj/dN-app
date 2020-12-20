import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/homeScreen/firebaseMessaging.dart';
import 'package:daily_needs/screens/CartPage/sendFcm.dart';
import 'package:daily_needs/screens/CheckOutPage/Apicall/getLocation.dart';
import 'package:daily_needs/screens/CheckOutPage/reviewPage/saveOrder2Database.dart';
import 'package:daily_needs/screens/CheckOutPage/sucessful/orderSucessFulPage.dart';
import 'package:daily_needs/screens/Extracted/MeatItems.dart';
import 'package:daily_needs/screens/Extracted/commonAppBar.dart';
import 'package:daily_needs/screens/paymentGateway/paymentPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:daily_needs/screens/Extracted/ExtractedAdressBox.dart';
import 'package:daily_needs/provider.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

bool _showSpinner = false;
int _delivaryFee = 0;
bool payOnline;
ScrollController _scrollController;
PaymentGateWay _paymentGateWay;

class ReviewPage extends StatefulWidget {
  final address;
  final String email;
  final Map user;
  final String location;
  final String delivarySlot;
  ReviewPage(
      {this.address,
      this.email,
      this.delivarySlot,
      @required this.user,
      @required this.location});
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    _scrollController = ScrollController();
    payOnline = null;
    _delivaryFee = 0;
    _showSpinner = false;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _paymentGateWay.disposePaymentGateWay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<IsInList>(context, listen: false).allDetails;
    var totalAmount = Provider.of<IsInList>(context, listen: false).totalAmount;
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
                  CommonAppbar(title: 'Review Your Order'),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 1000),
                      child: ListView(
                        shrinkWrap: true,
                        controller: _scrollController,
                        padding: EdgeInsets.all(8),
                        children: <Widget>[
                          CartItems(cartItems: cartItems),
                          SizedBox(height: 18),
                          Material(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Bill Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Container(height: 1, color: Colors.grey),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Subtotal',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        '₹ $totalAmount.00',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 11),
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: _firestore
                                        .collection('delivery/670511/amount')
                                        .doc('670511')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return SpinKitWave(
                                          color: Colors.white70,
                                          size: 30,
                                        );
                                      }
                                      if (widget.delivarySlot ==
                                          'Express Delivery') {
                                        print(widget.delivarySlot);
                                        _delivaryFee = snapshot.data
                                            .data()['Express Delivery'];
                                      } else {
                                        _delivaryFee =
                                            snapshot.data.data()['other'];
                                      }
                                      return _delivaryFee == 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                  Text(
                                                    'Shipping',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15),
                                                  ),
                                                  Text(
                                                    'Free Delivery',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                ])
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                  Text(
                                                    'Shipping',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15),
                                                  ),
                                                  Text(
                                                    '₹$_delivaryFee',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15),
                                                  ),
                                                ]);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          Material(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Delivery',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Divider(),
                                  Text(
                                    '${widget.delivarySlot}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          AddressBoxWithoutCheckbox(
                            details: widget.address,
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Divider(),
                                SizedBox(height: 4),
                                StreamBuilder<DocumentSnapshot>(
                                  stream: _firestore
                                      .collection('delivery/670511/paymentMode')
                                      .doc('v2.1')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    List methods = [];
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SpinKitRotatingCircle(
                                          color: Colors.purple,
                                          size: 30,
                                        ),
                                      );
                                    } else {
                                      methods = snapshot.data.data()['methods'];
                                    }
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (methods[0]['available']) {
                                              payOnline = true;
                                            }
                                            setState(() {});
                                          },
                                          child: Material(
                                            elevation: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 12),
                                              child: Row(
                                                children: [
                                                  payOnline == true
                                                      ? Icon(
                                                          Icons.check_box,
                                                          color: Colors.green,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .check_box_outline_blank,
                                                          color: methods[0]
                                                                  ['available']
                                                              ? Colors.black
                                                              : Colors.grey,
                                                        ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Pay Online',
                                                    style: TextStyle(
                                                        color: methods[0]
                                                                ['available']
                                                            ? Colors.black
                                                            : Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () {
                                            if (methods[1]['available']) {
                                              payOnline = false;
                                            }
                                            setState(() {});
                                          },
                                          child: Material(
                                            elevation: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 12),
                                              child: Row(
                                                children: [
                                                  payOnline == false
                                                      ? Icon(
                                                          Icons.check_box,
                                                          color: Colors.green,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .check_box_outline_blank,
                                                          color: methods[1]
                                                                  ['available']
                                                              ? Colors.black
                                                              : Colors.grey,
                                                        ),
                                                  SizedBox(width: 10),
                                                  Text('Cash on Delivery',
                                                      style: TextStyle(
                                                          color: methods[1]
                                                                  ['available']
                                                              ? Colors.black
                                                              : Colors.grey)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          bottomNavigationBar: StreamBuilder<DocumentSnapshot>(
              stream: _firestore
                  .collection('delivery/670511/amount')
                  .document('670511')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SpinKitCircle(
                    color: Colors.purple,
                    size: 30,
                  );
                }
                if (widget.delivarySlot == 'Express Delivery') {
                  print(widget.delivarySlot);
                  _delivaryFee = snapshot.data.data()['Express Delivery'];
                } else {
                  _delivaryFee = snapshot.data.data()['other'];
                }
                return GestureDetector(
                  onTap: () async {
                    Map _user = Provider.of<IsInList>(context, listen: false)
                        .userDetails;
                    String fcmID =
                        Provider.of<IsInList>(context, listen: false).fcmId;

                    String location = widget.location;

                    if (payOnline == null) {
                      _scrollController.animateTo(
                        (70.0 * cartItems.length) + 160,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                      selectPaymentOptionSnackBar(_scaffoldKey);
                    }
                    if (payOnline != null) {
                      setState(() {
                        _showSpinner = true;
                      });
                      if (payOnline == true) {
                        _paymentGateWay = PaymentGateWay({
                          'amount': totalAmount,
                          'name': '',
                        }, cartItems, widget, location, _delivaryFee, context,
                            _user['email'], (bool status, var response) async {
                          if (status) {
                            await saveOrderToDataBaseForOnlinePayment(
                                cartItems: cartItems,
                                widget: widget,
                                deliveryFee: _delivaryFee,
                                location: location,
                                isPaid: true,
                                fcmID: fcmID,
                                paymentId: response.paymentId);
                            Provider.of<IsInList>(context, listen: false)
                                .removeAllDetails();
                          }
                          _showSpinner = false;
                          setState(() {});
                        });
                        //email is now phone number

                        _paymentGateWay.initFunctions();
                      }
                      if (payOnline == false) {
//                  change payOnline==false
//                  save order to database

                        await saveOrderToDataBase(cartItems, widget, location,
                            context, _delivaryFee, fcmID);
                        Provider.of<IsInList>(context, listen: false)
                            .removeAllDetails();
                      }
                      setState(() {
                        _showSpinner = false;
                      });
                    }
                  },
                  child: BottomNavContainer(totalAmount: totalAmount),
                );
              }),
        ));
  }
}

//
//
void selectPaymentOptionSnackBar(scaffoldkey) {
  scaffoldkey.currentState.showSnackBar(
    new SnackBar(
      duration: Duration(milliseconds: 1000),
      backgroundColor: Colors.grey.shade800,
      content: new Text('Please select a payment method !',
          style: TextStyle(color: Colors.white)),
    ),
  );
}
//
//

class BottomNavContainer extends StatelessWidget {
  const BottomNavContainer({
    Key key,
    @required this.totalAmount,
  }) : super(key: key);

  final int totalAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      color: Colors.purple[500].withOpacity(0.90),
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              Text(
                '₹ ${totalAmount + _delivaryFee}.00',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                'Amount to pay',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              Spacer(),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Place Order',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }
}
