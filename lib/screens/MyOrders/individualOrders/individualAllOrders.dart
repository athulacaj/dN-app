import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:daily_needs/provider.dart';
import 'package:daily_needs/screens/MyOrders/timeComparison.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'rating.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
List _orders = [];
bool isOrderConfirmed = false;

class IndividualOrders extends StatefulWidget {
  final int index;
  final String allOrdersId;
  final individualId;
  final String email;
  IndividualOrders(
      {@required this.individualId,
      @required this.index,
      @required this.email,
      @required this.allOrdersId});
  @override
  _IndividualOrdersState createState() => _IndividualOrdersState();
}

class _IndividualOrdersState extends State<IndividualOrders> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  int reviewNo = 0;
  @override
  void initState() {
    print(widget.individualId);
    isOrderConfirmed = false;
    reviewNo = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<IsInList>(context, listen: false).userDetails;

    int index = widget.index;
    int _nowInMS = DateTime.now().millisecondsSinceEpoch;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Order details '),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: _firestore
                      .collection('orders/by/${user['email']}')
                      .doc('${widget.individualId}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: size.height - 74,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    }
                    var _details = snapshot.data;
                    _orders = [];
                    List<Widget> columWidget = [];
                    List ordersList = _details.data()['ordersList'];
                    String status = _details.data()['status'];
                    String _documentId = (_details.id);
                    DateTime time = _details.data()['time'].toDate();
                    String message = _details.data()['message'];
                    String paymentMethod = _details.data()['paymentMethod'];
                    var deliveryFee = _details.data()['deliveryFee'];
                    Timestamp deliveredTime =
                        _details.data()['deliveredTime'] ?? null;
                    int total = 0;
                    print(time);
                    Timestamp timeD = _details.data()['time'];

                    for (Map individualorder in ordersList) {
                      total = individualorder['amount'] + total;
                      Widget toAdd = Padding(
                        padding: const EdgeInsets.only(
                            left: 0, top: 6, bottom: 6, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              child: individualorder['imageType'] != 'offline'
                                  ? CachedNetworkImage(
                                      imageUrl: '${individualorder['image']}',
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          SpinKitThreeBounce(
                                        color: Colors.grey,
                                        size: 20.0,
                                      ),
                                    )
                                  : Image.asset(
                                      '${individualorder['image']}',
                                      fit: BoxFit.fill,
                                    ),
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(width: 8),
                            Expanded(child: Text('${individualorder['name']}')),
                            SizedBox(width: 8),
                            Text(
                                ' ${quantityFormat(individualorder['quantity'], individualorder['unit'])}'),
                            Text(' / ₹${individualorder['amount']}.00')
                          ],
                        ),
                      );
                      columWidget.add(toAdd);
                    }
                    return Container(
                      margin: EdgeInsets.all(4),
                      child: SingleChildScrollView(
                        child: Material(
                          color: Colors.white,
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'Ordered : ${timeConvertor(_nowInMS - time.millisecondsSinceEpoch, timeD)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      fontSize: 11),
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children: columWidget,
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'All items',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    Spacer(),
                                    Text(
                                      '₹$total.00',
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Delivery Charge',
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                    Spacer(),
                                    Text(
                                      '₹$deliveryFee.00',
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        status != null
                                            ? Text(
                                                "${status.substring(0, 1).toUpperCase()}${status.substring(1)} " ??
                                                    'null',
                                                style: TextStyle(
                                                    color: status == 'ordered'
                                                        ? Colors.purple
                                                        : status == 'canceled'
                                                            ? Colors.grey
                                                            : status ==
                                                                    'shipped'
                                                                ? Colors.orange
                                                                : Colors.green),
                                              )
                                            : Container(),
                                        SizedBox(width: 10),
                                        deliveredTime != null
                                            ? Text(
                                                '${timeConvertor(_nowInMS - deliveredTime.millisecondsSinceEpoch, deliveredTime)}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey,
                                                    fontSize: 11),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    Text(
                                      'Total : ₹ ${total + deliveryFee}.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.purple),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                                Divider(),
                                SizedBox(height: 20),
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Payment mode :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(width: 8),
                                      ],
                                    ),
                                    Text(
                                      paymentMethod == 'byCash'
                                          ? 'Cash'
                                          : 'Online',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                                SizedBox(height: 7),
                                status == 'ordered' && isOrderConfirmed == false
                                    ? FlatButton(
                                        color: Colors.grey.shade700,
                                        child: Container(
                                          child: Text(
                                            'Cancel Order',
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.9)),
                                          ),
                                          padding: EdgeInsets.all(8),
                                        ),
                                        onPressed: () async {
                                          Timestamp _date = user['time'];
                                          var _id = time
                                              .toIso8601String()
                                              .substring(0, 10);

                                          showDialog(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Are you sure you want to cancel the items?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('No'),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'cancel');
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Yes'),
                                                    onPressed: () {
                                                      _firestore
                                                          .collection(
                                                              'orders/by/${user['email']}')
                                                          .doc(_documentId)
                                                          .update({
                                                        'status': 'canceled'
                                                      });
                                                      _firestore
                                                          .collection(
                                                              'orders/byTime/$_id')
                                                          .doc(_documentId)
                                                          .update({
                                                        'status': 'canceled'
                                                      });

                                                      Navigator.pop(
                                                          context, 'remove');
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 15),
              StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection('orders/byTime/${widget.allOrdersId}')
                    .doc('${widget.individualId + widget.email}')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data.exists == false) {
                    return Container();
                  }
                  if (snapshot.data.data()['refNo'] != null) {
                    isOrderConfirmed = true;
                    print('ref No ${snapshot.data.data()['refNo']}');
                    Map _allData = snapshot.data.data();
                    Timestamp timeStamp = _allData['time'];
                    DateTime now = DateTime.now();
                    int timeDiff = ((now.millisecondsSinceEpoch -
                                timeStamp.millisecondsSinceEpoch) ~/
                            60000)
                        .toInt();
                    print('time diff $timeDiff');
                    int weekDay = timeStamp.toDate().weekday;
                    int month = timeStamp.toDate().month;
                    String oderId = 'DN$month$weekDay${_allData['refNo']}';
                    print('isReviewd ${_allData['isReviewed']}');
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              alignment: Alignment.center,
                              child: Text(
                                _allData['status'] == 'ordered'
                                    ? 'Your Order is Confirmed'
                                    : _allData['status'] == 'delivered'
                                        ? 'Your Order is Delivered'
                                        : _allData['status'] == 'canceled'
                                            ? 'Your Order is Canceled'
                                            : 'Your Order is Shipped',
                                style: TextStyle(
                                    color: _allData['status'] == 'ordered'
                                        ? Colors.purple
                                        : _allData['status'] == 'canceled'
                                            ? Colors.grey
                                            : _allData['status'] == 'shipped'
                                                ? Colors.orange
                                                : Colors.green),
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text('Order id : $oderId'),
                            ),
                            SizedBox(height: 10),
                            //
                            // after 5 mnts of conformation
                            _allData['status'] == 'ordered'
                                ? Column(
                                    children: [
                                      SizedBox(height: 10),
                                      SpinKitCircle(
                                        size: 30,
                                        color: Colors.lightBlueAccent,
                                      ),
                                      Text(
                                        'Connecting to a delivery person',
                                        style: TextStyle(color: Colors.black45),
                                      )
                                    ],
                                  )
                                : _allData['status'] == 'canceled'
                                    ? Container()
                                    : Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: 150,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  _allData['boyDetails']
                                                              ['photo'] !=
                                                          null
                                                      ? SizedBox(
                                                          height: 60,
                                                          width: 60,
                                                          child: CircleAvatar(
                                                            child: ClipOval(
                                                              child: Image.network(
                                                                  _allData[
                                                                          'boyDetails']
                                                                      [
                                                                      'photo']),
                                                            ),
                                                          ),
                                                        )
                                                      : Icon(
                                                          Icons.account_circle,
                                                          size: 60,
                                                        ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '${_allData['boyDetails']['name']}',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    '(Delivery Person)',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                  FlatButton(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          ' ${_allData['boyDetails']['phone']}',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        _allData['status'] ==
                                                                'delivered'
                                                            ? Container(
                                                                width: 0,
                                                                height: 0)
                                                            : Icon(
                                                                Icons
                                                                    .phone_forwarded_outlined,
                                                                size: 20,
                                                              )
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      if (_allData['status'] ==
                                                          'delivered') {
                                                      } else {
                                                        launchCaller(_allData[
                                                                'boyDetails']
                                                            ['phone']);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          _allData['status'] == 'delivered'
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  child: StarRating(
                                                    onChanged: (revNo) {
                                                      reviewNo = revNo;

                                                      DocumentReference
                                                          firstRef = _firestore
                                                              .collection(
                                                                  'orders/byTime/${widget.allOrdersId}')
                                                              .doc(
                                                                  '${widget.individualId + widget.email}');

                                                      firstRef.update({
                                                        'review': revNo,
                                                        'isReviewed': true,
                                                      });
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Thank you for the review ...');
                                                      setState(() {});
                                                    },
                                                    value: _allData[
                                                                'isReviewed'] ==
                                                            true
                                                        ? _allData['review']
                                                        : reviewNo,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      )
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

//

launchCaller(String phoneNo) async {
  var _url = "tel:$phoneNo";
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
