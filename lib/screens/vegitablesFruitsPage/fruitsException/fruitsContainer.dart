import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:daily_needs/provider.dart';

bool _showSpinner;

//class FruitsContainer extends StatefulWidget {
//  final String image;
//  final String title;
//  final amount;
//  final int quantity;
//  final String unit;
//  final int index;
//  final String imageType;
//  final String shopName;
//  FruitsContainer(
//      {this.image,
//      this.title,
//      this.amount,
//      this.index,
//      this.quantity,
//      this.shopName,
//      this.imageType,
//      this.unit});
//
//  @override
//  _FruitsContainerState createState() => _FruitsContainerState();
//}

//class _FruitsContainerState extends State<FruitsContainer> {
//  var _quantity = 0;
//  var _amount = 0;
//  var _image;
//  var _name;
//  var index;
//  var _unit;
//  String _shopName;
//  List<String> _cartItemsList = [];
//  AnimationController rotationController;
//
//  @override
//  void initState() {
//    print('hello');
//
//    _showSpinner = true;
//    _name = widget.title;
//    _image = widget.image;
//    _amount = widget.amount;
//    _quantity = widget.quantity;
//    index = widget.index;
//    _unit = widget.unit;
//    _shopName = widget.shopName;
//    super.initState();
//  }
//
//  void onPressed(String whatButton) async {
//    Map individualItem = {
//      'name': '$_name',
//      'image': '$_image',
//      'amount': _amount,
//      'quantity': _quantity,
//      'baseAmount': widget.amount,
//      'unit': _unit,
//      'baseQuantity': widget.quantity,
//      'shopName': '$_shopName',
//      'imageType': widget.imageType,
//    };
//    if (_quantity > 0) {
//      var isInListMap = {'$_name': true};
//      Provider.of<IsInList>(context, listen: false)
//          .addAllDetails(individualItem);
//
//      final localData = await SharedPreferences.getInstance();
////      var _jsonData = json.encode(individualItem);
////      _cartItemsList.add(_jsonData);
//      if (whatButton == 'add') {
////        localData.setStringList('CartItemList', _cartItemsList);
//      }
//    } else {
//      if (whatButton == 'add') {
//        _amount = widget.amount;
//        _quantity = widget.quantity;
//        Map individualItem = {
//          'name': '$_name',
//          'image': '$_image',
//          'amount': _amount,
//          'unit': _unit,
//          'quantity': _quantity,
//          'baseAmount': widget.amount,
//          'baseQuantity': widget.quantity,
//          'shopName': '$_shopName',
//          'imageType': widget.imageType,
//        };
//        Provider.of<IsInList>(context, listen: false)
//            .addAllDetails(individualItem);
//      } else {
//        Provider.of<IsInList>(context, listen: false).removeByName(_name);
//      }
//    }
//  }
//
//  void getProviderData() async {
//    await Future.delayed(Duration(milliseconds: 100));
//    var dataByName =
//        Provider.of<IsInList>(context, listen: false).getDetailsByName(_name);
//    _amount = dataByName != null ? dataByName['amount'] : 0;
//    _quantity = dataByName != null ? dataByName['quantity'] : 0;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    getProviderData();
//    return Padding(
//      padding: EdgeInsets.only(left: 6),
//      child: Container(
//        padding: EdgeInsets.all(6),
//        margin: EdgeInsets.only(bottom: 4),
//        width: MediaQuery.of(context).size.width,
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Container(
//                width: 60,
//                height: 60,
//                child: widget.imageType != 'offline'
//                    ? CachedNetworkImage(
//                        imageUrl: '${widget.image}',
//                        fit: BoxFit.fill,
//                        placeholder: (context, url) => SpinKitThreeBounce(
//                          color: Colors.grey,
//                          size: 20.0,
//                        ),
//                      )
//                    : Image.asset(
//                        '${widget.image}',
//                        fit: BoxFit.fill,
//                      )),
//            SizedBox(width: 8),
//            Expanded(
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Container(
//                        height: 17,
//                        width: 17,
//                        child: Image.asset('assets/vegIcon.png'),
//                      ),
//                      SizedBox(width: 8),
//                      Text(
//                        '${widget.title}',
//                        style: TextStyle(
//                            fontWeight: FontWeight.w600,
//                            fontSize: 16,
//                            color: Colors.black),
//                      ),
//                    ],
//                  ),
//                  SizedBox(height: 5),
//                  Row(
//                    children: <Widget>[
//                      SizedBox(width: 25),
//                      Text(
//                        '₹ $_amount ',
//                        textAlign: TextAlign.start,
//                        style: TextStyle(
//                            fontWeight: FontWeight.w500, fontSize: 14.5),
//                      ),
//                    ],
//                  ),
//                  Row(
//                    children: <Widget>[
//                      SizedBox(width: 25),
//                      Text(
//                        '${widget.quantity} ${widget.unit}',
//                        textAlign: TextAlign.start,
//                        style: TextStyle(
//                            fontWeight: FontWeight.w300, fontSize: 13.5),
//                      ),
//                    ],
//                  )
//                ],
//              ),
//            ),
//            Consumer<IsInList>(
//              builder: (context, isInList, child) {
//                var _detail;
//                var _allDetails = isInList.allDetails ?? [];
//                for (var _details in _allDetails) {
//                  if (_details['name'] == widget.title) {
//                    _detail = true;
//                    break;
//                  } else {
//                    _detail = false;
//                  }
//                }
//
//                return _detail == true
//                    ? Container(
//                        width: 110,
//                        child: Row(children: <Widget>[
//                          Material(
//                            child: Container(
//                              child: InkWell(
//                                child: Icon(Icons.remove,
//                                    size: 28, color: Colors.purple),
//                                onTap: () {
////
//                                  var dataByName = Provider.of<IsInList>(
//                                          context,
//                                          listen: false)
//                                      .getDetailsByName(_name);
//                                  _amount = dataByName != null
//                                      ? dataByName['amount']
//                                      : 0;
//                                  _quantity = dataByName != null
//                                      ? dataByName['quantity']
//                                      : 0;
////
//                                  if (_quantity != 0) {
//                                    _quantity = _quantity - widget.quantity;
//                                    _amount = _amount - widget.amount;
//
//                                    onPressed('null');
//                                  }
//                                },
//                                splashColor: Colors.purpleAccent,
//                              ),
//                              padding: EdgeInsets.all(1),
//                              decoration: contaionerButtonDecoration,
//                            ),
//                          ),
//                          Spacer(),
//                          Text('${quantityFormat(_quantity, _unit)}',
//                              style: TextStyle(
//                                  color: Colors.purple,
//                                  fontSize: 15,
//                                  fontWeight: FontWeight.w600)),
//                          Spacer(),
//                          Material(
//                            child: Container(
//                              child: InkWell(
//                                child: Icon(Icons.add,
//                                    size: 28, color: Colors.purple),
//                                onTap: () {
//                                  var dataByName = Provider.of<IsInList>(
//                                          context,
//                                          listen: false)
//                                      .getDetailsByName(_name);
//                                  _amount = dataByName != null
//                                      ? dataByName['amount']
//                                      : 0;
//                                  _quantity = dataByName != null
//                                      ? dataByName['quantity']
//                                      : 0;
////
//                                  _quantity = _quantity + widget.quantity;
//                                  _amount = _amount + widget.amount;
//                                  onPressed('null');
//                                  setState(() {});
//                                },
//                                splashColor: Colors.purpleAccent,
//                              ),
//                              padding: EdgeInsets.all(1),
//                              decoration: contaionerButtonDecoration,
//                            ),
//                          ),
//                        ]),
//                      )
//                    : Container();
//              },
//            ),
//            Container(
//              alignment: Alignment.center,
//              child: Consumer<IsInList>(builder: (context, isInList, child) {
//                var _detail;
//                var _allDetails = isInList.allDetails ?? [];
//                for (var _details in _allDetails) {
//                  if (_details['name'] == widget.title) {
//                    _detail = true;
//                    break;
//                  } else {
//                    _detail = false;
//                  }
//                }
//                return AnimatedContainer(
//                  duration: Duration(milliseconds: 80),
//                  width: _detail == true ? 0 : 100,
//                  child: AnimatedContainer(
//                    height: _detail == true ? 0 : 30,
//                    duration: Duration(milliseconds: 80),
//                    child: Padding(
//                      padding: _detail == true
//                          ? EdgeInsets.all(0)
//                          : EdgeInsets.all(0),
//                      child: Material(
//                        child: InkWell(
//                          onTap: () {
//                            onPressed('add');
//                          },
//                          child: _detail == true
//                              ? null
//                              : Container(
//                                  width: double.infinity,
//                                  alignment: Alignment.center,
//                                  padding: EdgeInsets.all(0),
//                                  decoration: BoxDecoration(
//                                    border: Border.all(color: Colors.purple),
//                                    borderRadius:
//                                        BorderRadius.all(Radius.circular(4)),
//                                  ),
//                                  child: Text(
//                                    'ADD',
//                                    style: TextStyle(
//                                        color: Colors.purple,
//                                        fontWeight: FontWeight.w600),
//                                  ),
//                                ),
//                          splashColor: Colors.purpleAccent,
//                        ),
//                      ),
//                    ),
//                  ),
//                );
//              }),
//            ),
//          ],
//        ),
//        decoration: BoxDecoration(
//          color: Colors.white,
//          border: Border.all(color: Colors.grey.withOpacity(0.2)),
//          borderRadius: BorderRadius.all(Radius.circular(4)),
//        ),
//      ),
//    );
//  }
//}

class FruitsContainer1 extends StatelessWidget {
  final String image;
  final String title;
  final amount;
  final int quantity;
  final String unit;
  final String imageType;
  final String shopName;
  final colorString;
  FruitsContainer1(
      {this.image,
      this.title,
      this.amount,
      this.quantity,
      this.shopName,
      this.imageType,
      this.colorString,
      this.unit});
  var _quantity = 0;
  var _amount = 0;
  var _image;
  var _name;
  var _unit;
  String _shopName;
  List<String> _cartItemsList = [];
  AnimationController rotationController;
  void onPressed(String whatButton, BuildContext context) async {
    Map individualItem = {
      'name': '$_name',
      'image': '$_image',
      'amount': _amount,
      'quantity': _quantity,
      'baseAmount': amount,
      'unit': _unit,
      'baseQuantity': quantity,
      'shopName': '$_shopName',
      'imageType': imageType,
    };
    if (_quantity > 0) {
      var isInListMap = {'$_name': true};
      Provider.of<IsInList>(context, listen: false)
          .addAllDetails(individualItem, context);

      final localData = await SharedPreferences.getInstance();
    } else {
      if (whatButton == 'add') {
        _amount = amount;
        _quantity = quantity;
        Map individualItem = {
          'name': '$_name',
          'image': '$_image',
          'amount': _amount,
          'unit': _unit,
          'quantity': _quantity,
          'baseAmount': amount,
          'baseQuantity': quantity,
          'shopName': '$_shopName',
          'imageType': imageType,
        };
        Provider.of<IsInList>(context, listen: false)
            .addAllDetails(individualItem, context);
      } else {
        Provider.of<IsInList>(context, listen: false).removeByName(_name);
      }
    }
  }

  void getProviderData(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 100));
    var dataByName =
        Provider.of<IsInList>(context, listen: false).getDetailsByName(_name);
    _amount = dataByName != null ? dataByName['amount'] : 0;
    _quantity = dataByName != null ? dataByName['quantity'] : 0;
  }

  @override
  Widget build(BuildContext context) {
    print(colorString);
    String valueString =
        colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color returnedColor = new Color(value);

    _name = title;
    _image = image;
    _amount = amount;
    _quantity = quantity;
    _unit = unit;
    _shopName = shopName;
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(bottom: 10, right: 10),
      width: (MediaQuery.of(context).size.width / 2) - 15,
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Container(
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 98,
                          child: imageType != 'offline'
                              ? CachedNetworkImage(
                                  imageUrl: '$image',
//                            fit: BoxFit.scaleDown,
                                  fit: BoxFit.fitHeight,

                                  placeholder: (context, url) =>
                                      SpinKitThreeBounce(
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                )
                              : Image.asset(
                                  '$image',
                                  fit: BoxFit.scaleDown,
                                ),
                        ),
                        Container(
                          height: 2,
                          width: (MediaQuery.of(context).size.width / 7.5),
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 8.0,
                                  offset: Offset(0.0, 0.1))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13)),
              ),
            ),
          ),
          Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 17,
                      width: 17,
                      child: Image.asset('assets/vegIcon.png'),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$title',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  '$quantity $unit',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13.5),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 8),
                    Consumer<IsInList>(
                      builder: (context, isInList, child) {
                        var _detail;
                        var _allDetails = isInList.allDetails ?? [];
                        for (var _details in _allDetails) {
                          if (_details['name'] == title) {
                            _detail = true;
                            break;
                          } else {
                            _detail = false;
                          }
                        }

                        return _detail == true
                            ? Container(
                                width: 110,
                                child: Row(children: <Widget>[
                                  Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                    child: Container(
                                      child: InkWell(
                                        child: Icon(Icons.remove,
                                            size: 28, color: Colors.purple),
                                        onTap: () {
//
                                          var dataByName =
                                              Provider.of<IsInList>(context,
                                                      listen: false)
                                                  .getDetailsByName(_name);
                                          _amount = dataByName != null
                                              ? dataByName['amount']
                                              : 0;
                                          _quantity = dataByName != null
                                              ? dataByName['quantity']
                                              : 0;
//
                                          if (_quantity != 0) {
                                            _quantity = _quantity - quantity;
                                            _amount = _amount - amount;

                                            onPressed('null', context);
                                          }
                                        },
                                        splashColor: Colors.purpleAccent,
                                      ),
                                      padding: EdgeInsets.all(1),
                                      decoration: contaionerButtonDecoration,
                                    ),
                                  ),
                                  Spacer(),
                                  Text('${quantityFormat(_quantity, _unit)}',
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                  Spacer(),
                                  Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                    child: Container(
                                      child: InkWell(
                                        child: Icon(Icons.add,
                                            size: 28, color: Colors.purple),
                                        onTap: () {
                                          var dataByName =
                                              Provider.of<IsInList>(context,
                                                      listen: false)
                                                  .getDetailsByName(_name);
                                          _amount = dataByName != null
                                              ? dataByName['amount']
                                              : 0;
                                          _quantity = dataByName != null
                                              ? dataByName['quantity']
                                              : 0;
//
                                          _quantity = _quantity + quantity;
                                          _amount = _amount + amount;
                                          onPressed('null', context);
                                        },
                                        splashColor: Colors.purpleAccent,
                                      ),
                                      padding: EdgeInsets.all(1),
                                      decoration: contaionerButtonDecoration,
                                    ),
                                  ),
                                ]),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              )
                            : Container();
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Consumer<IsInList>(
                          builder: (context, isInList, child) {
                        var _detail;
                        var _allDetails = isInList.allDetails ?? [];
                        for (var _details in _allDetails) {
                          if (_details['name'] == title) {
                            _detail = true;
                            break;
                          } else {
                            _detail = false;
                          }
                        }
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 80),
                          width: _detail == true ? 0 : 100,
                          child: AnimatedContainer(
                            height: _detail == true ? 0 : 30,
                            duration: Duration(milliseconds: 80),
                            child: Padding(
                              padding: _detail == true
                                  ? EdgeInsets.all(0)
                                  : EdgeInsets.all(0),
                              child: Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                child: InkWell(
                                  onTap: () {
                                    onPressed('add', context);
                                  },
                                  child: _detail == true
                                      ? null
                                      : Container(
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.purple),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: Text(
                                            'ADD',
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                  splashColor: Colors.purpleAccent,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 6),
              ],
            ),
            decoration: BoxDecoration(
              color: returnedColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(13)),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.white.withOpacity(0.2)),
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
    );
  }
}

//        Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Container(
//                width: 60,
//                height: 60,
//                child: imageType != 'offline'
//                    ? CachedNetworkImage(
//                        imageUrl: '$image',
//                        fit: BoxFit.fill,
//                        placeholder: (context, url) => SpinKitThreeBounce(
//                          color: Colors.grey,
//                          size: 20.0,
//                        ),
//                      )
//                    : Image.asset(
//                        '$image',
//                        fit: BoxFit.fill,
//                      )),
//            SizedBox(width: 8),
//            Expanded(
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Container(
//                        height: 17,
//                        width: 17,
//                        child: Image.asset('assets/vegIcon.png'),
//                      ),
//                      SizedBox(width: 8),
//                      Text(
//                        '$title',
//                        style: TextStyle(
//                            fontWeight: FontWeight.w600,
//                            fontSize: 16,
//                            color: Colors.black),
//                      ),
//                    ],
//                  ),
//                  SizedBox(height: 5),
//                  Row(
//                    children: <Widget>[
//                      SizedBox(width: 25),
//                      Text(
//                        '₹ $_amount ',
//                        textAlign: TextAlign.start,
//                        style: TextStyle(
//                            fontWeight: FontWeight.w500, fontSize: 14.5),
//                      ),
//                    ],
//                  ),
//                  Row(
//                    children: <Widget>[
//                      SizedBox(width: 25),
//                      Text(
//                        '$quantity $unit',
//                        textAlign: TextAlign.start,
//                        style: TextStyle(
//                            fontWeight: FontWeight.w300, fontSize: 13.5),
//                      ),
//                    ],
//                  )
//                ],
//              ),
//            ),
//            Consumer<IsInList>(
//              builder: (context, isInList, child) {
//                var _detail;
//                var _allDetails = isInList.allDetails ?? [];
//                for (var _details in _allDetails) {
//                  if (_details['name'] == title) {
//                    _detail = true;
//                    break;
//                  } else {
//                    _detail = false;
//                  }
//                }
//
//                return _detail == true
//                    ? Container(
//                        width: 110,
//                        child: Row(children: <Widget>[
//                          Material(
//                            child: Container(
//                              child: InkWell(
//                                child: Icon(Icons.remove,
//                                    size: 28, color: Colors.purple),
//                                onTap: () {
////
//                                  var dataByName = Provider.of<IsInList>(
//                                          context,
//                                          listen: false)
//                                      .getDetailsByName(_name);
//                                  _amount = dataByName != null
//                                      ? dataByName['amount']
//                                      : 0;
//                                  _quantity = dataByName != null
//                                      ? dataByName['quantity']
//                                      : 0;
////
//                                  if (_quantity != 0) {
//                                    _quantity = _quantity - quantity;
//                                    _amount = _amount - amount;
//
//                                    onPressed('null', context);
//                                  }
//                                },
//                                splashColor: Colors.purpleAccent,
//                              ),
//                              padding: EdgeInsets.all(1),
//                              decoration: contaionerButtonDecoration,
//                            ),
//                          ),
//                          Spacer(),
//                          Text('${quantityFormat(_quantity, _unit)}',
//                              style: TextStyle(
//                                  color: Colors.purple,
//                                  fontSize: 15,
//                                  fontWeight: FontWeight.w600)),
//                          Spacer(),
//                          Material(
//                            child: Container(
//                              child: InkWell(
//                                child: Icon(Icons.add,
//                                    size: 28, color: Colors.purple),
//                                onTap: () {
//                                  var dataByName = Provider.of<IsInList>(
//                                          context,
//                                          listen: false)
//                                      .getDetailsByName(_name);
//                                  _amount = dataByName != null
//                                      ? dataByName['amount']
//                                      : 0;
//                                  _quantity = dataByName != null
//                                      ? dataByName['quantity']
//                                      : 0;
////
//                                  _quantity = _quantity + quantity;
//                                  _amount = _amount + amount;
//                                  onPressed('null', context);
//                                },
//                                splashColor: Colors.purpleAccent,
//                              ),
//                              padding: EdgeInsets.all(1),
//                              decoration: contaionerButtonDecoration,
//                            ),
//                          ),
//                        ]),
//                      )
//                    : Container();
//              },
//            ),
//            Container(
//              alignment: Alignment.center,
//              child: Consumer<IsInList>(builder: (context, isInList, child) {
//                var _detail;
//                var _allDetails = isInList.allDetails ?? [];
//                for (var _details in _allDetails) {
//                  if (_details['name'] == title) {
//                    _detail = true;
//                    break;
//                  } else {
//                    _detail = false;
//                  }
//                }
//                return AnimatedContainer(
//                  duration: Duration(milliseconds: 80),
//                  width: _detail == true ? 0 : 100,
//                  child: AnimatedContainer(
//                    height: _detail == true ? 0 : 30,
//                    duration: Duration(milliseconds: 80),
//                    child: Padding(
//                      padding: _detail == true
//                          ? EdgeInsets.all(0)
//                          : EdgeInsets.all(0),
//                      child: Material(
//                        child: InkWell(
//                          onTap: () {
//                            onPressed('add', context);
//                          },
//                          child: _detail == true
//                              ? null
//                              : Container(
//                                  width: double.infinity,
//                                  alignment: Alignment.center,
//                                  padding: EdgeInsets.all(0),
//                                  decoration: BoxDecoration(
//                                    border: Border.all(color: Colors.purple),
//                                    borderRadius:
//                                        BorderRadius.all(Radius.circular(4)),
//                                  ),
//                                  child: Text(
//                                    'ADD',
//                                    style: TextStyle(
//                                        color: Colors.purple,
//                                        fontWeight: FontWeight.w600),
//                                  ),
//                                ),
//                          splashColor: Colors.purpleAccent,
//                        ),
//                      ),
//                    ),
//                  ),
//                );
//              }),
//            ),
//          ],
//        ),

BoxDecoration contaionerButtonDecoration = BoxDecoration(
  border: Border.all(color: Colors.purple),
  borderRadius: BorderRadius.all(Radius.circular(11)),
);
