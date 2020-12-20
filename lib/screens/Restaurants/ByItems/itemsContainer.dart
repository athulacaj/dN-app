import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_needs/extracted/shaderMaskLoadingWidget.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:daily_needs/provider.dart';

bool _showSpinner;

class FruitsContainer1 extends StatefulWidget {
  final String image;
  final String title;
  final amount;
  final desc;
  final int quantity;
  final bool isVeg;
  final List types;
  final String unit;
  final String imageType;
  final String shopName;
  final int openHour;
  final String category;
  final bool isClosed;
  final bool isAvailable;
  FruitsContainer1(
      {this.image,
      this.title,
      this.amount,
      @required this.desc,
      @required this.isAvailable,
      this.openHour,
      this.quantity,
      this.shopName,
      this.imageType,
      @required this.isVeg,
      @required this.types,
      @required this.category,
      @required this.isClosed,
      this.unit});

  @override
  _FruitsContainer1State createState() => _FruitsContainer1State();
}

class _FruitsContainer1State extends State<FruitsContainer1> {
  String type = '';
  var _quantity = 0;
  int dropIndex = 0;
  var _amount = 0;
  // important
  int _baseAmount = 0;
  int _baseQuantity = 0;
//
  bool _isVeg;
  var _image;
  var _name;
  var _unit;
  String _shopName;

  List<String> _cartItemsList = [];

  AnimationController rotationController;

  void onPressed(String whatButton, BuildContext context) async {
    print(_baseAmount);
    Map individualItem = {
      'name': '$_name',
      'image': '$_image',
      'amount': _amount,
      'quantity': _quantity,
      'baseAmount': _baseAmount,
      'unit': _unit,
      'baseQuantity': _baseQuantity,
      'shopName': '$_shopName',
      'imageType': widget.imageType,
      'category': 'food'
    };
    if (_quantity > 0) {
      var isInListMap = {'$_name': true};
      Provider.of<IsInList>(context, listen: false)
          .addAllDetails(individualItem, context);
    } else {
      if (whatButton == 'add') {
//        _amount = widget.amount;
//        _quantity = widget.quantity;
        _amount = callThis()[0];
        _quantity = callThis()[1];
        print(_amount);
        Map individualItem = {
          'name': '$_name',
          'image': '$_image',
          'amount': _amount,
          'unit': _unit,
          'quantity': _quantity,
          'baseAmount': _baseAmount,
          'baseQuantity': _baseQuantity,
          'shopName': '$_shopName',
          'imageType': widget.imageType,
          'category': 'food'
        };
        Provider.of<IsInList>(context, listen: false)
            .addAllDetails(individualItem, context);
      } else {
        Provider.of<IsInList>(context, listen: false).removeByName(_name);
      }
    }
  }

  Image _netWorkImage;
  bool _loading = true;
  @override
  void initState() {
    _netWorkImage = new Image.network(
      '${widget.image}',
    );
    _netWorkImage.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          print('Networkimage is fully loaded and saved');
          _loading = false;
          setState(() {});
          // do something
        },
      ),
    );

    dropIndex = 0;
    _name = widget.title;
//    _amount = widget.amount;
//    _quantity = widget.quantity;

    setState(() {});
    super.initState();
  }

  void getProviderData(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 100));
    callThis();
    var dataByName =
        Provider.of<IsInList>(context, listen: false).getDetailsByName(_name);
    _amount = dataByName != null ? dataByName['amount'] : 0;
    if (dataByName != null) {
      // _quantity = dataByName['quantity'];
      // _amount = dataByName['amount'];
    }
    _amount = dataByName != null ? dataByName['amount'] : 0;
    _quantity = dataByName != null ? dataByName['quantity'] : 0;
  }

  List callThis() {
    if (widget.types == null) {
      _name = widget.title;
      _amount = widget.amount;
      _quantity = widget.quantity;
      _baseAmount = widget.amount;
      _baseQuantity = widget.quantity;
    } else {
      _name = '${widget.title} - ${widget.types[dropIndex]['type']}';
      _amount = widget.types[dropIndex]['amount'];
      _quantity = widget.types[dropIndex]['quantity'];
      _baseAmount = widget.types[dropIndex]['amount'];
      _baseQuantity = widget.types[dropIndex]['quantity'];
    }
    return [_amount, _quantity];
  }

  @override
  Widget build(BuildContext context) {
    _image = widget.image;
    _unit = widget.unit;
    _shopName = widget.shopName;
    callThis();
    getProviderData(context);
    return Container(
      margin: EdgeInsets.only(bottom: 4, top: 5, right: 8),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        elevation: 3,
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                width: (MediaQuery.of(context).size.width / 2) - 12,
                height: widget.category == 'Add On' ? 210 : 314,
                child: ShaderMaskLoading()),
            _loading
                ? Container()
                : Container(
                    padding: EdgeInsets.all(0),
                    width: (MediaQuery.of(context).size.width / 2) - 12,
                    height: widget.category == 'Add On' ? 210 : 314,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 130,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(13),
                                          topLeft: Radius.circular(13)),
                                      image: DecorationImage(
                                        image: widget.imageType != 'offline'
                                            ? NetworkImage(widget.image)
                                            : AssetImage(widget.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  widget.isVeg != null
                                      ? Positioned(
                                          left: 4,
                                          top: 4,
                                          child: Image.asset(
                                            widget.isVeg
                                                ? 'assets/vegNew.png'
                                                : 'assets/nonVegNew.png',
                                            scale: 20,
                                          ),
                                        )
                                      : Container(),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: Container(
                                      height: 28,
                                      width: 60,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '₹ $_amount',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15.5,
                                            color: Colors.white),
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.black,
                                              Colors.black26
                                            ]),
                                        color: Colors.black,
//                            borderRadius: BorderRadius.only(
//                                topLeft: Radius.circular(0),
//                                topRight: Radius.circular(50),
//                                bottomRight: Radius.circular(0),
//                                bottomLeft: Radius.circular(0))
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              height: widget.category == 'Add On' ? 80 : 184,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 4),
                                  Text(
                                    '$_name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 4),
                                  widget.desc != 'null'
                                      ? AutoSizeText(
                                          '${widget.desc}',
                                          maxLines: 3,
                                          maxFontSize: 15,
                                          minFontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
//                                fontSize: 14,
                                              color: Colors.black),
                                        )
                                      : Container(),
                                  Spacer(),
                                  Stack(
                                    children: [
                                      Text(
                                        widget.types != null ? 'Size' : '',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade700),
                                      ),
                                      Column(
                                        children: [
//                            SizedBox(height: 5),
                                          widget.types != null
                                              ? DropdownButton<String>(
                                                  items: widget.types
                                                      .map((var value) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      value: value['type'],
                                                      child: Container(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2) -
                                                            60,
                                                        child: AutoSizeText(
                                                          '${value['type']}',
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  value: widget.types[dropIndex]
                                                      ['type'],
                                                  onChanged: (String value) {
                                                    int i = 0;
                                                    try {
                                                      for (Map typeMap
                                                          in widget.types) {
                                                        if (typeMap['type'] ==
                                                            value) {
                                                          _name =
                                                              '${widget.title} - $type';
                                                          _amount =
                                                              typeMap['amount'];
                                                          dropIndex = i;
                                                          print(i);
                                                        }
                                                        i++;
                                                      }
                                                    } catch (e) {}
                                                    setState(() {});
                                                  },
                                                )
                                              : Container(
                                                  height: 0,
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Consumer<IsInList>(
                                    builder: (context, isInList, child) {
                                      var _detail;
                                      var _allDetails =
                                          isInList.allDetails ?? [];
                                      for (var _details in _allDetails) {
                                        if (_details['name'] == _name) {
                                          _detail = true;
                                          break;
                                        } else {
                                          _detail = false;
                                        }
                                      }
                                      getProviderData(context);

                                      return _detail == true
                                          ? Container(
                                              width: 110,
                                              child: Row(children: <Widget>[
                                                Material(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  child: Container(
                                                    child: InkWell(
                                                      child: Icon(Icons.remove,
                                                          size: 28,
                                                          color: Colors.purple),
                                                      onTap: () {
//
                                                        var dataByName = Provider
                                                                .of<IsInList>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .getDetailsByName(
                                                                _name);
                                                        _amount =
                                                            dataByName != null
                                                                ? dataByName[
                                                                    'amount']
                                                                : 0;
                                                        _quantity =
                                                            dataByName != null
                                                                ? dataByName[
                                                                    'quantity']
                                                                : 0;
//
                                                        if (_quantity != 0) {
                                                          _quantity =
                                                              _quantity -
                                                                  _baseQuantity;
                                                          _amount = _amount -
                                                              _baseAmount;

                                                          onPressed(
                                                              'null', context);
                                                        }
                                                      },
                                                      splashColor:
                                                          Colors.purpleAccent,
                                                    ),
                                                    padding: EdgeInsets.all(1),
                                                    decoration:
                                                        contaionerButtonDecoration,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                    '${quantityFormat(_quantity, _unit)}',
                                                    style: TextStyle(
                                                        color: Colors.purple,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Spacer(),
                                                Material(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(11)),
                                                  child: Container(
                                                    child: InkWell(
                                                      child: Icon(Icons.add,
                                                          size: 28,
                                                          color: Colors.purple),
                                                      onTap: () {
                                                        var dataByName = Provider
                                                                .of<IsInList>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .getDetailsByName(
                                                                _name);
                                                        _amount =
                                                            dataByName != null
                                                                ? dataByName[
                                                                    'amount']
                                                                : 0;
                                                        _quantity =
                                                            dataByName != null
                                                                ? dataByName[
                                                                    'quantity']
                                                                : 0;
//
                                                        _quantity = _quantity +
                                                            _baseQuantity;
                                                        _amount = _amount +
                                                            _baseAmount;
                                                        onPressed(
                                                            'null', context);
                                                      },
                                                      splashColor:
                                                          Colors.purpleAccent,
                                                    ),
                                                    padding: EdgeInsets.all(1),
                                                    decoration:
                                                        contaionerButtonDecoration,
                                                  ),
                                                ),
                                              ]),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            )
                                          : Container();
                                    },
                                  ),
                                  checkOpen(widget.openHour) == false
                                      ? AutoSizeText(
                                          '* Opens at ${timeConvertTOTwelve(widget.openHour)}',
                                          maxLines: 1,
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      : widget.isClosed
                                          ? Text(
                                              'Shop Closed',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              child: Consumer<IsInList>(builder:
                                                  (context, isInList, child) {
                                                var _detail;
                                                var _allDetails =
                                                    isInList.allDetails ?? [];
                                                for (var _details
                                                    in _allDetails) {
                                                  if (_details['name'] ==
                                                      _name) {
                                                    _detail = true;
                                                    break;
                                                  } else {
                                                    _detail = false;
                                                  }
                                                }
                                                return AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 80),
                                                  width:
                                                      _detail == true ? 0 : 100,
                                                  child: AnimatedContainer(
                                                    height: _detail == true
                                                        ? 0
                                                        : 30,
                                                    duration: Duration(
                                                        milliseconds: 80),
                                                    child: Padding(
                                                      padding: _detail == true
                                                          ? EdgeInsets.all(0)
                                                          : EdgeInsets.all(0),
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4)),
                                                        child: InkWell(
                                                          onTap: () {
                                                            print(widget
                                                                .openHour);
                                                            onPressed(
                                                                'add', context);
                                                          },
                                                          child: _detail == true
                                                              ? null
                                                              : Container(
                                                                  width: double
                                                                      .infinity,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .purple),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(4)),
                                                                  ),
                                                                  child: Text(
                                                                    'ADD',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .purple,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                          splashColor: Colors
                                                              .purpleAccent,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                  SizedBox(height: 6),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(13),
                                    bottomRight: Radius.circular(13)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                    ),
                  ),
            _loading
                ? Container()
                : widget.isAvailable == false
                    ? Container(
                        height: widget.category == 'Add On' ? 210 : 314,
                        width: (MediaQuery.of(context).size.width / 2) - 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Spacer(),
                            AutoSizeText(
                              'Not available',
                              maxLines: 1,
                              maxFontSize: 16,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 70),
                          ],
                        ),
                      )
                    : Container()
          ],
        ),
      ),
    );
  }
}

BoxDecoration contaionerButtonDecoration = BoxDecoration(
  border: Border.all(color: Colors.purple),
  borderRadius: BorderRadius.all(Radius.circular(5)),
);

String timeConvertTOTwelve(int h) {
  if (h < 12) {
    return '$h am';
  } else if (h == 12) {
    return '12 noon';
  } else if (h == 24) {
    return '12 midnight';
  } else {
    return '${h - 12} pm';
  }
}

bool checkOpen(int h) {
  DateTime now = DateTime.now();
  if (h == null) {
    return true;
  } else if (now.hour >= h) {
    return true;
  } else {
    return false;
  }
}
