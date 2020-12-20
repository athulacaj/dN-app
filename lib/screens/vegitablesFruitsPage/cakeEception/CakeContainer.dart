import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:daily_needs/provider.dart';

bool _showSpinner;

class CakeItemsContainer extends StatefulWidget {
  final String image;
  final String title;
  final amount;
  final int quantity;
  final String unit;
  final int index;
  final String imageType;
  final String shopName;
  final bool available;
  final scaffoldKey;
  CakeItemsContainer(
      {this.image,
      this.title,
      this.amount,
      this.index,
      this.quantity,
      this.shopName,
      this.imageType,
      this.available,
      this.scaffoldKey,
      this.unit});

  @override
  _CakeItemsContainerState createState() => _CakeItemsContainerState();
}

class _CakeItemsContainerState extends State<CakeItemsContainer> {
  var _quantity = 0;
  var _amount = 0;
  var _image;
  var _name;
  var index;
  var _unit;
  String _shopName;
  List<String> _cartItemsList = [];
  AnimationController rotationController;
  void _onpress;

  @override
  void initState() {
    _showSpinner = true;
    initFunctions();
    super.initState();
  }

  void initFunctions() {
    _image = widget.image;
    _amount = widget.amount;
    _quantity = widget.quantity;
    index = widget.index;
    _unit = widget.unit;
    _shopName = widget.shopName ?? '';
    _name = '${widget.title}:$_shopName';
  }

  void onPressed(String whatButton) async {
    Map individualItem = {
      'name': '$_name',
      'image': '$_image',
      'amount': _amount,
      'quantity': _quantity,
      'baseAmount': 0,
      'unit': _unit,
      'baseQuantity': 0,
      'shopName': '$_shopName',
      'imageType': widget.imageType,
    };
    if (_quantity > 0) {
      var isInListMap = {'$_name': true};
      Provider.of<IsInList>(context, listen: false)
          .addAllDetails(individualItem, context);

      final localData = await SharedPreferences.getInstance();
//      var _jsonData = json.encode(individualItem);
//      _cartItemsList.add(_jsonData);
      if (whatButton == 'add') {
//        localData.setStringList('CartItemList', _cartItemsList);
      }
    } else {
      if (whatButton == 'add') {
        _amount = widget.amount;
        _quantity = widget.quantity;
        Map individualItem = {
          'name': '$_name',
          'image': '$_image',
          'amount': _amount,
          'unit': _unit,
          'quantity': _quantity,
          'baseAmount': 0,
          'baseQuantity': 0,
          'shopName': '$_shopName',
          'imageType': widget.imageType,
        };
        Provider.of<IsInList>(context, listen: false)
            .addAllDetails(individualItem, context);
      } else {
        Provider.of<IsInList>(context, listen: false).removeByName(_name);
      }
    }
  }

  void getProviderData() async {
    await Future.delayed(Duration(milliseconds: 100));
    initFunctions();

    var dataByName =
        Provider.of<IsInList>(context, listen: false).getDetailsByName(_name);
    _amount = dataByName != null ? dataByName['amount'] : 0;
    _quantity = dataByName != null ? dataByName['quantity'] : 0;
  }

  @override
  void dispose() {
    // TODO: implement
    _quantity = 0;
    _amount = 0;
    _image = '';
    _name = '';
    var index;
    var _unit;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getProviderData();

    return Padding(
      padding: EdgeInsets.only(left: 6),
      child: Container(
        height: 105,
        margin: EdgeInsets.only(bottom: 5),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(6),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 70,
                      height: 60,
                      child: widget.imageType != 'offline'
                          ? CachedNetworkImage(
                              imageUrl: '${widget.image}',
                              fit: BoxFit.fill,
                              placeholder: (context, url) => SpinKitThreeBounce(
                                color: Colors.grey,
                                size: 20.0,
                              ),
                            )
                          : Image.asset(
                              '${widget.image}',
                              fit: BoxFit.fill,
                            )),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 17,
                              width: 17,
                              child: Image.asset('assets/vegIcon.png'),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: AutoSizeText(
                                '${_name.split(':')[0]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 25),
                            Text(
                              '₹ ${widget.amount} ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14.5),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 25),
                            Text(
                              '${widget.quantity} ${widget.unit}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 13.5),
                            ),
                            Spacer(),
                            Consumer<IsInList>(
                              builder: (context, isInList, child) {
                                var _detail;
                                var _allDetails = isInList.allDetails ?? [];
                                for (var _details in _allDetails) {
                                  if (_details['name'] == _name) {
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
                                            child: Container(
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                child: Icon(Icons.remove,
                                                    size: 32,
                                                    color: Colors.white),
                                                onTap: () {
//
                                                  var dataByName = Provider.of<
                                                              IsInList>(context,
                                                          listen: false)
                                                      .getDetailsByName(_name);
                                                  _amount = dataByName != null
                                                      ? dataByName['amount']
                                                      : 0;
                                                  _quantity = dataByName != null
                                                      ? dataByName['quantity']
                                                      : 0;
                                                  print(_quantity);
                                                  if (_quantity != 0) {
//                                                    case if quantity in gram
                                                    if (_quantity == 500 ||
                                                        _quantity == 1000) {
                                                      _quantity =
                                                          _quantity - 500;
                                                      _amount = _amount -
                                                          widget.amount;
                                                    } else if (_quantity ==
                                                        2000) {
                                                      _quantity =
                                                          _quantity - 1000;
                                                      _amount = _amount -
                                                          (widget.amount * 2);
                                                    }
//                                                    case if quantity in kg
                                                    if (_quantity == 1) {
                                                      _quantity = _quantity - 1;
                                                      _amount = _amount -
                                                          widget.amount;
                                                    } else if (_quantity == 2) {
                                                      _quantity = _quantity - 1;
                                                      _amount = _amount -
                                                          widget.amount;
                                                    }

                                                    onPressed('null');
                                                  }
                                                },
                                                splashColor: Colors.white70,
                                              ),
                                              height: 35,
                                            ),
                                            color: Colors.purple,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                topLeft: Radius.circular(5)),
                                          ),
                                          Spacer(),
                                          Container(
                                            child: AutoSizeText(
                                              '${quantityFormat(_quantity, _unit)}',
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                            ),
                                            alignment: Alignment.center,
                                            height: 35,
                                            width: 40,
                                          ),
                                          Spacer(),
                                          Material(
                                            color: Colors.purple,
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(5),
                                                topRight: Radius.circular(5)),
                                            child: Container(
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                child: Icon(Icons.add,
                                                    size: 32,
                                                    color: Colors.white),
                                                onTap: () {
                                                  var dataByName = Provider.of<
                                                              IsInList>(context,
                                                          listen: false)
                                                      .getDetailsByName(_name);
                                                  _amount = dataByName != null
                                                      ? dataByName['amount']
                                                      : 0;
                                                  _quantity = dataByName != null
                                                      ? dataByName['quantity']
                                                      : 0;
//                                                case if in gram
                                                  if (_quantity == 0 ||
                                                      _quantity == 500) {
                                                    _quantity = _quantity +
                                                        widget.quantity;
                                                    _amount =
                                                        _amount + widget.amount;
                                                  } else if (_quantity ==
                                                      1000) {
                                                    _quantity = _quantity +
                                                        (widget.quantity * 2);
                                                    _amount = _amount +
                                                        (widget.amount * 2);
                                                  }
//                                                  case if in kg
                                                  if (_quantity == 0) {
                                                    _quantity = _quantity +
                                                        widget.quantity;
                                                    _amount =
                                                        _amount + widget.amount;
                                                  } else if (_quantity == 1) {
                                                    _quantity = _quantity +
                                                        (widget.quantity);
                                                    _amount = _amount +
                                                        (widget.amount);
                                                  }
                                                  onPressed('null');
                                                  setState(() {});
                                                },
                                                splashColor: Colors.white70,
                                              ),
                                              height: 35,
                                            ),
                                          ),
                                        ]),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Colors.blueGrey
                                                  .withOpacity(0.5)),
                                        ))
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
                                  if (_details['name'] == _name) {
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
                                        child: InkWell(
                                          onTap: () {
                                            onPressed('add');
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  child: Text(
                                                    'ADD',
                                                    style: TextStyle(
                                                        color: Colors.purple,
                                                        fontWeight:
                                                            FontWeight.w600),
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
            widget.available == false
                ? GestureDetector(
                    child: Container(
                      height: double.infinity,
                      color: Colors.grey.withOpacity(0.25),
                    ),
                    onTap: () {
                      widget.scaffoldKey.currentState.showSnackBar(
                        new SnackBar(
                          duration: Duration(milliseconds: 1500),
                          backgroundColor: Colors.grey.shade800,
                          content: new Text(
                              'This product is not available right now !',
                              style: TextStyle(color: Colors.white)),
                        ),
                      );
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
