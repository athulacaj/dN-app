import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:daily_needs/provider.dart';
import 'package:daily_needs/screens/Extracted/commonAppBar.dart';
import 'package:daily_needs/screens/MyOrders/timeComparison.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'individualOrders/individualAllOrders.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
List _orders = [];

class MyOrders extends StatefulWidget {
  static String id = 'MyOrders';

  String fromWhere;
  MyOrders({this.fromWhere});
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    _orders = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<IsInList>(context, listen: false).userDetails;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: widget.fromWhere == null
          ? () {
              if (widget.fromWhere == null) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'Home_Screen', (Route<dynamic> route) => false);
              }
              return new Future(() => false);
            }
          : null,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            CommonAppbar(
              title: 'My Orders',
              whichScreen: widget.fromWhere == null ? 'MyOrders' : '',
            ),
            user == null
                ? Container()
                : StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('orders/by/${user['email']}')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: size.height - 74,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        );
                      }
                      print('updated');
                      var _details = snapshot.data.docs;
                      _orders = [];
                      int _nowInMS = DateTime.now().millisecondsSinceEpoch;
                      return Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 2, bottom: 8),
                          itemCount: _details.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<Widget> columWidget = [];
                            List ordersList =
                                _details[index].data()['ordersList'];
                            String status = _details[index].data()['status'];
                            String _documentId = (_details[index].id);
                            Timestamp time = _details[index].data()['time'];
                            String message = _details[index].data()['message'];
                            String paymentMethod =
                                _details[index].data()['paymentMethod'];
                            var deliveryFee =
                                _details[index].data()['deliveryFee'];
                            Timestamp deliveredTime =
                                _details[index].data()['deliveredTime'] ?? null;
                            int total = 0;
                            for (Map individualorder in ordersList) {
                              total = individualorder['amount'] + total;
                              Widget toAdd = Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 6, bottom: 6, right: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(
                                      child: individualorder['imageType'] !=
                                              'offline'
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  '${individualorder['image']}',
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
                                    Expanded(
                                        child:
                                            Text('${individualorder['name']}')),
                                    SizedBox(width: 8),
                                    Text(
                                        ' ${quantityFormat(individualorder['quantity'], individualorder['unit'])}'),
                                    Text(' / ₹${individualorder['amount']}.00')
                                  ],
                                ),
                              );
                              columWidget.add(toAdd);
                            }
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 4),
                                  child: Text(
                                    '${timeConvertor(_nowInMS - time.millisecondsSinceEpoch, time)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        fontSize: 11),
                                  ),
                                ),
                                Material(
                                  elevation: 3,
                                  borderOnForeground: true,
                                  color: Colors.white,
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: status == 'ordered' ||
                                                  status == 'confirmed'
                                              ? Colors.purple
                                              : status == 'delivered'
                                                  ? Colors.green
                                                  : status == 'Shipped'
                                                      ? Colors.orange
                                                      : Colors.grey,
                                          width: 0.3),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 8,
                                            bottom: 2),
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            // Column(
                                            //   children: columWidget,
                                            // ),
                                            SizedBox(height: 6),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  'All items',
                                                  style: TextStyle(
                                                      color: Colors.black87),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '₹$total.00',
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  'Delivery Charge',
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '₹$deliveryFee.00',
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    status != null
                                                        ? Text(
                                                            "${status.substring(0, 1).toUpperCase()}${status.substring(1)} " ??
                                                                'null',
                                                            style: TextStyle(
                                                                color: status ==
                                                                        'ordered'
                                                                    ? Colors
                                                                        .purple
                                                                    : status ==
                                                                            'canceled'
                                                                        ? Colors
                                                                            .grey
                                                                        : status ==
                                                                                'shipped'
                                                                            ? Colors.orange
                                                                            : Colors.green),
                                                          )
                                                        : Container(),
                                                    SizedBox(width: 8),
                                                    deliveredTime != null
                                                        ? Text(
                                                            '${timeConvertor(_nowInMS - deliveredTime.millisecondsSinceEpoch, deliveredTime)}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 11),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                                Text(
                                                  'Total : ₹ ${total + deliveryFee}.00',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.purple),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            ),
                                            SizedBox(height: 15),
                                            SizedBox(height: 7),
                                            message == null
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            20,
                                                    child: Text(
                                                      message ?? '',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(height: 6),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    IndividualOrders(
                                                      individualId:
                                                          _details[index].id,
                                                      index: index,
                                                      email: user['email'],
                                                      allOrdersId: time
                                                          .toDate()
                                                          .toIso8601String()
                                                          .substring(0, 10),
                                                    )));
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10)
                              ],
                            );
                          },
                        ),
                      );
                    },
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
