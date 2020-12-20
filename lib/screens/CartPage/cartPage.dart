import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/constants/constants.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:daily_needs/provider.dart';
import 'package:daily_needs/screens/CheckOutPage/checkOutPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

int _minimumAmount;
bool _showSpinner;

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    _minimumAmount = 0;
    _showSpinner = true;
    initFunctions();
    super.initState();
  }

  void initFunctions() async {
    _minimumAmount = await getMinimumAmount();
    setState(() {
      _showSpinner = false;
    });
  }

  Future<int> getMinimumAmount() async {
    var _doc = await FirebaseFirestore.instance
        .collection('delivery/670511/minimumOrder')
        .doc('670511')
        .get();
    print(_doc.data()['minimum']);
    return _doc.data()['minimum'];
  }

  void onPlusOrMinusPressed(Map allDetailsMap, var quantity, var amount) async {
    // Map individualItem = {
    //   'name': '${allDetailsMap['name']}',
    //   'image': '${allDetailsMap['image']}',
    //   'unit': '${allDetailsMap['unit']}',
    //   'category': allDetailsMap['category'],
    //   'shop': allDetailsMap['shopName'],
    //   'amount': amount,
    //   'quantity': quantity,
    //   'baseAmount': allDetailsMap['baseAmount'],
    //   'baseQuantity': allDetailsMap['baseQuantity'],
    //   'imageType': allDetailsMap['imageType'],
    // };
    Map toAddIndividualItem = allDetailsMap;
    toAddIndividualItem['amount'] = amount;
    toAddIndividualItem['quantity'] = quantity;

    if (quantity > 0) {
      var isInListMap = {'${allDetailsMap['name']}': true};
      Provider.of<IsInList>(context, listen: false)
          .addAllDetails(toAddIndividualItem, context);
    } else {
//
      Provider.of<IsInList>(context, listen: false)
          .removeByName(allDetailsMap['name']);
//
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IsInList>(
      builder: (context, isInList, child) {
        var _allDetailsList = isInList.allDetails ?? [];
        var totalAmount = isInList.totalAmount ?? 0;

        return ModalProgressHUD(
          inAsyncCall: _showSpinner,
          progressIndicator: RefreshProgressIndicator(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 30,
                      color: Colors.purple[600],
                    ),
                    SafeArea(
                      child: Container(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Your Cart',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.close, size: 30)),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(0.5)),
                            )),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: _allDetailsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          delay: Duration(milliseconds: 100),
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 100.0,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      height: 60,
                                      child: Row(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                (Radius.circular(3))),
                                            child: Container(
//
                                                height: 40,
                                                width: 40,
                                                child: _allDetailsList[index]
                                                            ['imageType'] ==
                                                        'offline'
                                                    ? Image.asset(
                                                        '${_allDetailsList[index]['image']}',
                                                        fit: BoxFit.fill,
                                                      )
                                                    : CachedNetworkImage(
                                                        imageUrl:
                                                            '${_allDetailsList[index]['image']}',
                                                        fit: BoxFit.fill,
                                                        placeholder: (context,
                                                                url) =>
                                                            SpinKitThreeBounce(
                                                          color: Colors.grey,
                                                          size: 20.0,
                                                        ),
                                                      )),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                              child: Container(
                                                  height: double.infinity,
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        child: Text(
                                                          '${_allDetailsList[index]['name']}'
                                                              .split(':')[0],
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        width: double.infinity,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Expanded(
                                                          child: Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          '₹${_allDetailsList[index]['amount']}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )),
                                                    ],
                                                  ))),
                                          SizedBox(width: 12),
                                          SizedBox(width: 12),
                                        ],
                                      )),
                                  GestureDetector(
                                    onTap: () async {},
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 10, right: 10),
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Container(
                                                width: 65,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.5))),
                                                child: Text('Delete')),
                                            onTap: () {
                                              Provider.of<IsInList>(context,
                                                      listen: false)
                                                  .removeByName(
                                                      '${_allDetailsList[index]['name']}');
                                            },
                                          ),
                                          Row(children: <Widget>[
                                            Material(
                                              child: Container(
                                                child: InkWell(
                                                  onTap: () {
                                                    var _quantity =
                                                        _allDetailsList[index]
                                                            ['quantity'];
                                                    var _baseQuantity =
                                                        _allDetailsList[index]
                                                            ['baseQuantity'];
                                                    var _baseAmount =
                                                        _allDetailsList[index]
                                                            ['baseAmount'];
                                                    var _amount =
                                                        _allDetailsList[index]
                                                            ['amount'];
                                                    if (_allDetailsList[index]
                                                            ['quantity'] !=
                                                        0) {
                                                      _quantity = _quantity -
                                                          _baseQuantity;
                                                      _amount =
                                                          _amount - _baseAmount;

                                                      onPlusOrMinusPressed(
                                                          _allDetailsList[
                                                              index],
                                                          _quantity,
                                                          _amount);
                                                    }
                                                  },
                                                  child: Icon(Icons.remove,
                                                      size: 25,
                                                      color: Colors.black),
                                                  splashColor:
                                                      Colors.purpleAccent,
                                                ),
                                                decoration:
                                                    contaionerBlackOutlineButtonDecoration,
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Text(
                                                '${quantityFormat(_allDetailsList[index]['quantity'], _allDetailsList[index]['unit'])}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(width: 16),
                                            Material(
                                              child: Container(
                                                child: InkWell(
                                                  child: Icon(Icons.add,
                                                      size: 25,
                                                      color: Colors.black),
                                                  onTap: () {
                                                    var _quantity =
                                                        _allDetailsList[index]
                                                            ['quantity'];
                                                    var _baseQuantity =
                                                        _allDetailsList[index]
                                                            ['baseQuantity'];
                                                    var _baseAmount =
                                                        _allDetailsList[index]
                                                            ['baseAmount'];
                                                    var _amount =
                                                        _allDetailsList[index]
                                                            ['amount'];
                                                    print(_amount);

                                                    _quantity = _quantity +
                                                        _baseQuantity;
                                                    _amount =
                                                        _amount + _baseAmount;

                                                    onPlusOrMinusPressed(
                                                        _allDetailsList[index],
                                                        _quantity,
                                                        _amount);
                                                  },
                                                  splashColor:
                                                      Colors.purpleAccent,
                                                ),
                                                decoration:
                                                    contaionerBlackOutlineButtonDecoration,
                                              ),
                                            )
                                          ])
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 0.5,
                                        color: Colors.grey.withOpacity(0.5)),
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                totalAmount < 1
                    ? Expanded(
                        flex: 35,
                        child: Container(
                          child: Icon(
                            Icons.remove_shopping_cart,
                            color: Colors.purple,
                            size: 100,
                          ),
                        ),
                      )
                    : Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            border: Border(
                              top: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(0.5)),
                              bottom: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(0.5)),
                            )),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Provider.of<IsInList>(context, listen: false)
                                    .removeAllDetails();
                                setState(() {});
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.delete,
                                      size: 16,
                                      color: Colors.black.withOpacity(0.8)),
                                  Text('Empty Cart'),
                                ],
                              ),
                            ),
                            Spacer(),
                            Text('Subtotal:  ',
                                style: TextStyle(color: Colors.black)),
                            Consumer<IsInList>(
                                builder: (context, isInList, child) {
                              return Text(
                                '₹${isInList.totalAmount}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.black),
                              );
                            }),
                            SizedBox(width: 12),
                          ],
                        ),
                      ),
                totalAmount < 1
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          color: Colors.purple,
                          alignment: Alignment.center,
                          child: Text(
                            'Back',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      )
                    : totalAmount >= _minimumAmount - 2
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                return CheckOutPage();
                              }, transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                var begin = Offset(1.0, 0.0);
                                var end = Offset(0.0, 0.0);
                                var tween = Tween(begin: begin, end: end);
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              }));
                            },
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              color: Colors.purple[500].withOpacity(0.90),
                              alignment: Alignment.center,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Proceed to Checkout',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        : Consumer<IsInList>(
                            builder: (context, isInList, child) {
                            int _totalAmount = isInList.totalAmount;
                            double _percent =
                                ((_totalAmount * 100) / _minimumAmount) / 100;
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              height: 45,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(height: 6),
                                  LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 105,
                                    lineHeight: 22.0,
                                    percent: _percent >= 1 ? 1 : _percent,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.3),
                                    trailing: Text(' ₹ $_minimumAmount '),
                                    center: Text(
                                        '₹ ${_minimumAmount - _totalAmount} more for delivery'),
                                    leading: Text('₹ 0 '),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.green.shade300,
                                  ),
                                  SizedBox(height: 2),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                            );
                          }),
              ],
            ),
          ),
        );
      },
    );
  }
}
