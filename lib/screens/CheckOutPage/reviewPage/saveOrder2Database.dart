import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/homeScreen/firebaseMessaging.dart';
import 'package:daily_needs/provider.dart';
import 'package:daily_needs/screens/CartPage/sendFcm.dart';
import 'package:daily_needs/screens/CheckOutPage/sucessful/orderSucessFulPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future saveOrderToDataBase(var cartItems, var widget, location,
    BuildContext context, int deliveryFee, String fcmID) async {
  var time = DateTime.now();
  WriteBatch batch = FirebaseFirestore.instance.batch();
  DocumentReference firstRef = _firestore
      .collection('orders/byTime/${time.toString().substring(0, 10)}')
      .doc('$time${widget.email}');
  DocumentReference secondRef =
      _firestore.collection('orders/by/${widget.email}').doc('$time');
  Map details = {
    'ordersList': cartItems,
    'deliveryFee': deliveryFee,
    'deliverySlot': widget.delivarySlot,
    'address': widget.address,
    'location': '$location',
    'time': time,
    'paymentMethod': 'byCash',
    'status': 'ordered',
    'fcmId': fcmID,
  };
  batch.set(firstRef, {
    'time': time,
    'status': 'ordered',
    'deliveryFee': deliveryFee,
    'paymentMethod': 'byCash',
    'details': details,
    'fcmId': fcmID,
    'email': '${widget.email}'
  });
  batch.set(secondRef, {
    'ordersList': cartItems,
    'fcmId': fcmID,
    'deliveryFee': deliveryFee,
    'deliverySlot': widget.delivarySlot,
    'address': widget.address,
    'location': '$location',
    'time': time,
    'paymentMethod': 'byCash',
    'status': 'ordered'
  });
  // await _firestore
  //     .collection('orders/byTime/${time.toString().substring(0, 10)}')
  //     .doc('$time')
  //     .set({
  //   'time': time,
  //   'status': 'ordered',
  //   'deliveryFee': _delivaryFee,
  //   'paymentMethod': 'byCash',
  //   'email': '${widget.email}'
  // });
  // await _firestore.collection('orders/by/${widget.email}').doc('$time').set({
  //   'ordersList': cartItems,
  //   'deliveryFee': _delivaryFee,
  //   'deliverySlot': widget.delivarySlot,
  //   'address': widget.address,
  //   'location': '$location',
  //   'time': time,
  //   'paymentMethod': 'byCash',
  //   'status': 'ordered'
  // });
  await batch.commit();
  sendAndRetrieveMessage();
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SuccessfulPage()));
}

Future<void> saveOrderToDataBaseForOnlinePayment(
    {var cartItems,
    var widget,
    location,
    deliveryFee,
    bool isPaid,
    String fcmID,
    String paymentId}) async {
  var time = DateTime.now();
  WriteBatch batch = FirebaseFirestore.instance.batch();
  DocumentReference firstRef = _firestore
      .collection('orders/byTime/${time.toString().substring(0, 10)}')
      .doc('$time${widget.email}');
  DocumentReference secondRef =
      _firestore.collection('orders/by/${widget.email}').doc('$time');

  Map details = {
    'ordersList': cartItems,
    'deliveryFee': deliveryFee,
    'deliverySlot': widget.delivarySlot,
    'address': widget.address,
    'location': '$location',
    'time': time,
    'paymentMethod': 'online',
    'status': 'ordered',
    'fcmId': fcmID,
  };
  batch.set(firstRef, {
    'time': time,
    'status': 'ordered',
    'isPaid': isPaid,
    'paymentId': paymentId,
    'paymentMethod': 'online',
    'deliveryFee': deliveryFee,
    'details': details,
    'fcmId': fcmID,
    'email': '${widget.email}'
  });
  batch.set(secondRef, {
    'ordersList': cartItems,
    'deliveryFee': deliveryFee,
    'fcmId': fcmID,
    'deliverySlot': widget.delivarySlot,
    'address': widget.address,
    'location': '$location',
    'time': time,
    'paymentMethod': 'online',
    'status': 'ordered'
  });
  await batch.commit();
  sendAndRetrieveMessage();
}
