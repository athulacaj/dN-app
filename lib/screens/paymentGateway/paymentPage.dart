import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/provider.dart';
import 'package:daily_needs/screens/CartPage/sendFcm.dart';
import 'package:daily_needs/screens/CheckOutPage/sucessful/orderSucessFulPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';

Razorpay _razorpay;
bool _isPaymentSucess;

class PaymentGateWay {
  final Map productDetails;
  final cartItems;
  final widget;
  final BuildContext context;
  final location;
  final deliveryFee;
  final String mobileNo;
  final Function callback;
  PaymentGateWay(
      this.productDetails,
      this.cartItems,
      this.widget,
      this.location,
      this.deliveryFee,
      this.context,
      this.mobileNo,
      this.callback);
  Razorpay _razorpay;
  bool _isPaymentSucess;
  void initFunctions() {
    _isPaymentSucess = null;

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  void openCheckout() async {
    var options = {
      // 'key': 'rzp_test_5xNVkH7JL6NQQh',
      'key': 'rzp_live_FIFSvkUyN8PTXV',
      'amount': (productDetails['amount'] + deliveryFee) * 100,
      'name': '${productDetails['name']}',
      'description': '',
      // notes=[uid,category,documentId];
      'notes': [
        '${productDetails['uid']}',
        '${productDetails['category']}',
        '${productDetails['name']}'
      ],
      'prefill': {
        'contact': '$mobileNo',
        'email': 'dailyneeds.rawfoods@gmail.com'
      },
//      'external': {
//        'wallets': ['paytm']
//      }
    };

    try {
      _razorpay.open(options);
      Future.delayed(Duration(seconds: 1));
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    _isPaymentSucess = true;
    String fcmId = Provider.of<IsInList>(context, listen: false).fcmId;

    // widget, deliveryFee, location, true, response.paymentId
//     await saveOrderToDataBase(
//         cartItems: cartItems,
//         widget: widget,
//         deliveryFee: deliveryFee,
//         location: location,
//         isPaid: true,
//         fcmID: fcmId,
//         paymentId: response.paymentId);
//     Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green.shade400,
// //        textColor: Colors.white,
//         fontSize: 16.0);
    Provider.of<IsInList>(context, listen: false).removeAllDetails();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SuccessfulPage()));
    callback(true, response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _isPaymentSucess = false;
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message);
    callback(false, null);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName);
  }

  void disposePaymentGateWay() {
    _razorpay.clear();
  }
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;
