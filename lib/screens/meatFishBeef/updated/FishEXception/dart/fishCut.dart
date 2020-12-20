import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_needs/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool _showSpinner;
//int _selectedTypeIndex = -1;
//String _title;
//int _varyingAmount;
//int _itemAmount;
//List types = [];
//String _imageType;
bool isRefresh;

// ignore: must_be_immutable
class FishCut extends StatefulWidget {
  final String image;
  final String title;
  final int amount;
  final int quantity;
  final String unit;
  final int index;
  final String shopName;
  final List types;
  final String imageType;
  final String available;
  final String malayalam;
  final scaffoldKey;
  FishCut(
      {this.image,
      this.title,
      this.amount,
      this.index,
      this.quantity,
      this.shopName,
      this.types,
      this.imageType,
      this.unit,
      this.malayalam,
      @required this.scaffoldKey,
      @required this.available});

  @override
  _FishCutState createState() => _FishCutState();
}

class _FishCutState extends State<FishCut> {
  var _quantity = 0;
  String _unit;
  var _image;
  int _selectedTypeIndex = -1;
  String _title;
  String malayalam;
  String _available;
  int _varyingAmount;
  int _itemAmount;
  List types = [];
  String _imageType;
  String _shopName;
  List<String> _cartItemsList = [];
  AnimationController rotationController;
  void _onpress;
  @override
  void initState() {
    _selectedTypeIndex = -1;
    _showSpinner = true;
    isRefresh = true;
//    _name = widget.title;
    _image = widget.image;
    _varyingAmount = widget.amount;
    _quantity = widget.quantity;
//    index = widget.index;
    _unit = 'Pkt';
    _shopName = widget.shopName;
    malayalam = widget.malayalam;
    checkIsThereAnyTypes();
    getProviderData();
    super.initState();
  }

  void onPressed(String whatButton) async {
    Map individualItem = {
      'name': '$_title',
      'image': '${widget.image}',
      'amount': _varyingAmount,
      'quantity': _quantity,
      'baseAmount': _itemAmount,
      'unit': _unit,
      'imageType': _imageType,
      'baseQuantity': widget.quantity
    };
    if (_quantity > 0) {
      var isInListMap = {'$_title': true};
      Provider.of<IsInList>(widget.scaffoldKey.currentContext, listen: false)
          .addAllDetails(individualItem, context);

      final localData = await SharedPreferences.getInstance();
      if (whatButton == 'add') {}
    } else {
      if (whatButton == 'add') {
//        _varyingAmount = _itemAmount;
        _quantity = widget.quantity;
        Map individualItem = {
          'name': '$_title',
          'image': '${widget.image}',
          'amount': _itemAmount,
          'unit': _unit,
          'quantity': _quantity,
          'baseAmount': _itemAmount,
          'imageType': _imageType,
          'baseQuantity': widget.quantity
        };
        Provider.of<IsInList>(widget.scaffoldKey.currentContext, listen: false)
            .addAllDetails(individualItem, context);
      } else {
        Provider.of<IsInList>(widget.scaffoldKey.currentContext, listen: false)
            .removeByName(_title);
      }
    }
  }

  void checkIsThereAnyTypes() {
    List types = widget.types ?? [];
    if (types.length > 0) {
      if (_selectedTypeIndex == -1) {
        _title = widget.title;
        _available = widget.available;
        _itemAmount = null;
        _image = widget.image;
        _imageType = widget.imageType;
        _quantity = widget.quantity;
        _unit = widget.unit;
      } else {
        _itemAmount = widget.types[_selectedTypeIndex]['amount'];
        _title =
            '${widget.title} - ${widget.types[_selectedTypeIndex]['type']}';
        _available = '${widget.types[_selectedTypeIndex]['available']}';
        _image = widget.types[_selectedTypeIndex]['image'];
        _imageType = widget.types[_selectedTypeIndex]['imageType'];
        _unit = widget.types[_selectedTypeIndex]['unit'];
        _quantity = widget.types[_selectedTypeIndex]['amount'];
      }
    } else {
      _title = widget.title;
      _available = widget.available;
      _itemAmount = widget.amount;
      _image = widget.image;
      _imageType = widget.imageType;
    }
  }

  Future getProviderData() async {
    await Future.delayed(Duration(milliseconds: 10));
    var dataByName =
        Provider.of<IsInList>(widget.scaffoldKey.currentContext, listen: false)
            .getDetailsByName(_title);
    _varyingAmount = dataByName != null ? dataByName['amount'] : 0;
    _quantity = dataByName != null ? dataByName['quantity'] : 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    types = widget.types ?? [];
    _title = widget.title;

    checkIsThereAnyTypes();
    getProviderData();
    return buildBody();
  }

  buildBody() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.only(bottom: 8),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              //top
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: 100,
                      height: 80,
                      child: _imageType == 'offline'
                          ? Image.asset(
                              '$_image',
                              fit: BoxFit.fill,
                            )
                          : CachedNetworkImage(
                              imageUrl: '$_image',
                              fit: BoxFit.fill,
                              placeholder: (context, url) => SpinKitThreeBounce(
                                color: Colors.grey,
                                size: 20.0,
                              ),
                            )),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 4),
                            Expanded(
                              child: AutoSizeText(
                                '$_title',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        AutoSizeText(
                          ' $malayalam',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black),
                          maxLines: 1,
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 4),
                            _available != 'notAvailable'
                                ? Text(
                                    types.length > 0 && _selectedTypeIndex == -1
                                        ? ''
                                        : '₹ $_itemAmount ',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.5),
                                  )
                                : Container(
                                    height: 15,
                                  ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 4),
                            _available != 'notAvailable'
                                ? Text(
                                    types.length > 0 && _selectedTypeIndex == -1
                                        ? ''
                                        : '1 pkt',
//                                          : '${_quantity} ${_unit}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13.5),
                                  )
                                : Container(),
                            Spacer(),
                            Consumer<IsInList>(
                              builder: (context, isInList, child) {
                                var _detail;
                                var _allDetails = isInList.allDetails ?? [];
                                for (var _details in _allDetails) {
                                  if (_details['name'] == _title) {
                                    _detail = true;
                                    break;
                                  } else {
                                    _detail = false;
                                  }
                                }
                                getProviderData();
                                return _detail == true
                                    ? Container(
                                        width: 130,
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
                                                  if (_quantity != 0) {
                                                    _quantity = _quantity -
                                                        widget.quantity;
                                                    _varyingAmount =
                                                        _varyingAmount -
                                                            _itemAmount;

                                                    onPressed('null');
                                                  }
                                                },
                                                splashColor: Colors.white70,
                                              ),
                                              width: 40,
                                              height: 35,
                                            ),
                                            color: Colors.purple,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                topLeft: Radius.circular(5)),
                                          ),
                                          Spacer(),
                                          AutoSizeText(
                                            '${quantityFormat(_quantity, _unit)}',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                          ),
                                          Spacer(),
                                          Material(
                                            child: Container(
                                              width: 40,
                                              height: 35,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                child: Icon(Icons.add,
                                                    size: 32,
                                                    color: Colors.white),
                                                onTap: () {
                                                  _quantity = _quantity +
                                                      widget.quantity;
                                                  _varyingAmount =
                                                      _varyingAmount +
                                                          _itemAmount;
                                                  onPressed('null');
                                                },
                                                splashColor: Colors.white70,
                                              ),
                                            ),
                                            color: Colors.purple,
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(5),
                                                topRight: Radius.circular(5)),
                                          ),
                                        ]),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                            border: Border.all(
                                                width: 0.5,
                                                color: Colors.blueGrey
                                                    .withOpacity(0.5))),
                                      )
                                    : Container();
                              },
                            ),
                            _available != 'notAvailable'
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Consumer<IsInList>(
                                        builder: (context, isInList, child) {
                                      var _detail;
                                      var _allDetails =
                                          isInList.allDetails ?? [];
                                      for (var _details in _allDetails) {
                                        if (_details['name'] == _title) {
                                          _detail = true;
                                          break;
                                        } else {
                                          _detail = false;
                                        }
                                      }
                                      return AnimatedContainer(
                                        duration: Duration(milliseconds: 10),
                                        width: _detail == true ? 0 : 55,
                                        child: AnimatedContainer(
                                          height: _detail == true ? 0 : 40,
                                          duration: Duration(milliseconds: 80),
                                          child: Padding(
                                            padding: _detail == true
                                                ? EdgeInsets.all(0)
                                                : EdgeInsets.all(0),
                                            child: Material(
                                              child: InkWell(
                                                onTap: () {
                                                  if (types.length > 0 &&
                                                      _selectedTypeIndex ==
                                                          -1) {
                                                    Fluttertoast.showToast(
                                                        msg: "Select a Packet",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1);
                                                  } else {
                                                    onPressed('add');
                                                  }
                                                },
                                                child: _detail == true
                                                    ? null
                                                    : Container(
                                                        width: double.infinity,
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .purple),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                        ),
                                                        child: Text(
                                                          'ADD',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.purple,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                splashColor:
                                                    Colors.purpleAccent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  )
                                : Container(
                                    height: 40,
                                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
              //cut items
              types.length > 0
                  ? Container(
                      height: 40,
                      padding: EdgeInsets.only(top: 5),
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: types.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: GestureDetector(
                              child: Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                elevation: 4,
                                color: _selectedTypeIndex == index
                                    ? Colors.blueAccent
                                    : Colors.white,
                                child: Container(
                                  width: 75,
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    types[index]['type']
                                        .toString()
                                        .substring(1),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _selectedTypeIndex == index
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ),
                              onTap: () {
                                _selectedTypeIndex = index;
                                checkIsThereAnyTypes();
                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.0,
                        ),
                      )),
                    )
                  : Container(),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 7),
          child: Container(
            height: _available == 'notAvailable' ? 120 : 0,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Text(
                    'NOT AVAILABLE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
//class FishCuts extends StatelessWidget {
//  final String image;
//  final String title;
//  final int amount;
//  final int quantity;
//  final String unit;
//  final int index;
//  final String shopName;
//  final List typesList;
//  final String imageType;
//  FishCuts(
//      {this.image,
//      this.title,
//      this.amount,
//      this.index,
//      this.quantity,
//      this.shopName,
//      this.typesList,
//      this.imageType,
//      this.unit});
//
//  int _selectedTypeIndex = -1;
//  String _title;
//  int _varyingAmount;
//  int _itemAmount;
//  List types = [];
//  String _imageType;
//  var _quantity;
//  String _image;
//
//  void onPressed(String whatButton) async {
//    Map individualItem = {
//      'name': '$_title',
//      'image': '$image',
//      'amount': _varyingAmount,
//      'quantity': _quantity,
//      'baseAmount': _itemAmount,
//      'unit': unit,
//      'baseQuantity': quantity
//    };
//    if (_quantity > 0) {
//      var isInListMap = {'$_title': true};
//      Provider.of<IsInList>(scaffoldKey.currentContext, listen: false)
//          .addAllDetails(individualItem);
//
//      final localData = await SharedPreferences.getInstance();
//      if (whatButton == 'add') {}
//    } else {
//      if (whatButton == 'add') {
////        _varyingAmount = _itemAmount;
//        _quantity = quantity;
//        Map individualItem = {
//          'name': '$_title',
//          'image': '$image',
//          'amount': _itemAmount,
//          'unit': unit,
//          'quantity': _quantity,
//          'baseAmount': _varyingAmount,
//          'baseQuantity': quantity
//        };
//        Provider.of<IsInList>(scaffoldKey.currentContext, listen: false)
//            .addAllDetails(individualItem);
//      } else {
//        Provider.of<IsInList>(scaffoldKey.currentContext, listen: false)
//            .removeByName(_title);
//      }
//    }
//  }
//
//  void checkIsThereAnyTypes() {
//    List types = typesList ?? [];
//    if (types.length > 0) {
//      if (_selectedTypeIndex == -1) {
//        _title = title;
//        _itemAmount = null;
//        _image = image;
//        _imageType = imageType;
//      } else {
//        _itemAmount = types[_selectedTypeIndex]['amount'];
//        _title = '$title - ${types[_selectedTypeIndex]['type']}';
//        _image = types[_selectedTypeIndex]['image'];
//        _imageType = types[_selectedTypeIndex]['imageType'];
//      }
//    } else {
//      _title = title;
//      _itemAmount = amount;
//      _image = image;
//      _imageType = imageType;
//    }
//  }
//
//  Future getProviderData() async {
//    await Future.delayed(Duration(milliseconds: 100));
//    var dataByName =
//        Provider.of<IsInList>(scaffoldKey.currentContext, listen: false)
//            .getDetailsByName(_title);
//    _varyingAmount = dataByName != null ? dataByName['amount'] : 0;
//    _quantity = dataByName != null ? dataByName['quantity'] : 0;
//    if (isRefresh == true) {}
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    types = typesList ?? [];
//    _title = title;
//    checkIsThereAnyTypes();
//    getProviderData();
//    return Padding(
//      padding: EdgeInsets.only(left: 6),
//      child: Container(
//        padding: EdgeInsets.all(6),
//        width: MediaQuery.of(context).size.width,
//        child: Column(
//          children: <Widget>[
//            //top
//            Row(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Container(
//                    width: 100,
//                    height: 100,
//                    child: _imageType == 'offline'
//                        ? Image.asset(
//                            '$_image',
//                            fit: BoxFit.fill,
//                          )
//                        : CachedNetworkImage(
//                            imageUrl: '$_image',
//                            fit: BoxFit.fill,
//                            placeholder: (context, url) => SpinKitThreeBounce(
//                              color: Colors.grey,
//                              size: 20.0,
//                            ),
//                          )),
//                SizedBox(width: 12),
//                Expanded(
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Row(
//                        children: <Widget>[
//                          SizedBox(width: 4),
//                          Expanded(
//                            child: AutoSizeText(
//                              '$_title ',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.w400,
//                                  fontSize: 16,
//                                  color: Colors.black),
//                              maxLines: 3,
//                            ),
//                          ),
//                        ],
//                      ),
//                      SizedBox(height: 10),
//                      Row(
//                        children: <Widget>[
//                          SizedBox(width: 4),
//                          Text(
//                            types.length > 0 && _selectedTypeIndex == -1
//                                ? ''
//                                : '₹ $_itemAmount ',
//                            textAlign: TextAlign.start,
//                            style: TextStyle(
//                                fontWeight: FontWeight.w500, fontSize: 14.5),
//                          ),
//                        ],
//                      ),
//                      SizedBox(height: 5),
//                      Row(
//                        children: <Widget>[
//                          SizedBox(width: 4),
//                          Text(
//                            types.length > 0 && _selectedTypeIndex == -1
//                                ? ''
//                                : '${quantity} ${unit}',
//                            textAlign: TextAlign.start,
//                            style: TextStyle(
//                                fontWeight: FontWeight.w300, fontSize: 13.5),
//                          ),
//                        ],
//                      )
//                    ],
//                  ),
//                ),
//                SizedBox(width: 5),
//                Consumer<IsInList>(
//                  builder: (context, isInList, child) {
//                    var _detail;
//                    var _allDetails = isInList.allDetails ?? [];
//                    for (var _details in _allDetails) {
//                      if (_details['name'] == _title) {
//                        _detail = true;
//                        break;
//                      } else {
//                        _detail = false;
//                      }
//                    }
//                    getProviderData();
//                    return _detail == true
//                        ? Container(
//                            height: 100,
//                            child: Column(children: <Widget>[
//                              Material(
//                                child: Container(
//                                  child: InkWell(
//                                    child: Icon(Icons.add,
//                                        size: 32, color: Colors.purple),
//                                    onTap: () {
//                                      _quantity = _quantity + quantity;
//                                      _varyingAmount =
//                                          _varyingAmount + _itemAmount;
//                                      onPressed('null');
//                                    },
//                                    splashColor: Colors.purpleAccent,
//                                  ),
//                                  padding: EdgeInsets.all(1),
//                                  decoration: contaionerButtonDecoration,
//                                ),
//                              ),
//                              Spacer(),
//                              Text('${quantityFormat(_quantity, unit)}',
//                                  style: TextStyle(
//                                      color: Colors.purple,
//                                      fontSize: 16,
//                                      fontWeight: FontWeight.w600)),
//                              Spacer(),
//                              Material(
//                                child: Container(
//                                  child: InkWell(
//                                    child: Icon(Icons.remove,
//                                        size: 32, color: Colors.purple),
//                                    onTap: () {
//                                      if (_quantity != 0) {
//                                        _quantity = _quantity - quantity;
//                                        _varyingAmount =
//                                            _varyingAmount - _itemAmount;
//
//                                        onPressed('null');
//                                      }
//                                    },
//                                    splashColor: Colors.purpleAccent,
//                                  ),
//                                  padding: EdgeInsets.all(1),
//                                  decoration: contaionerButtonDecoration,
//                                ),
//                              ),
//                            ]),
//                          )
//                        : Container();
//                  },
//                ),
//                Container(
//                  alignment: Alignment.center,
//                  child:
//                      Consumer<IsInList>(builder: (context, isInList, child) {
//                    var _detail;
//                    var _allDetails = isInList.allDetails ?? [];
//                    for (var _details in _allDetails) {
//                      if (_details['name'] == _title) {
//                        _detail = true;
//                        break;
//                      } else {
//                        _detail = false;
//                      }
//                    }
//                    return AnimatedContainer(
//                      duration: Duration(milliseconds: 10),
//                      width: _detail == true ? 0 : 55,
//                      child: AnimatedContainer(
//                        height: _detail == true ? 0 : 40,
//                        duration: Duration(milliseconds: 80),
//                        child: Padding(
//                          padding: _detail == true
//                              ? EdgeInsets.all(0)
//                              : EdgeInsets.all(0),
//                          child: Material(
//                            child: InkWell(
//                              onTap: () {
//                                if (types.length > 0 &&
//                                    _selectedTypeIndex == -1) {
//                                  Fluttertoast.showToast(
//                                      msg: "Select type of cut",
//                                      toastLength: Toast.LENGTH_SHORT,
//                                      gravity: ToastGravity.CENTER,
//                                      timeInSecForIosWeb: 1);
//                                } else {
//                                  onPressed('add');
//                                }
//                              },
//                              child: _detail == true
//                                  ? null
//                                  : Container(
//                                      width: double.infinity,
//                                      alignment: Alignment.center,
//                                      padding: EdgeInsets.all(0),
//                                      decoration: BoxDecoration(
//                                        border:
//                                            Border.all(color: Colors.purple),
//                                        borderRadius: BorderRadius.all(
//                                            Radius.circular(4)),
//                                      ),
//                                      child: Text(
//                                        'ADD',
//                                        style: TextStyle(
//                                            color: Colors.purple,
//                                            fontWeight: FontWeight.w600),
//                                      ),
//                                    ),
//                              splashColor: Colors.purpleAccent,
//                            ),
//                          ),
//                        ),
//                      ),
//                    );
//                  }),
//                ),
//              ],
//            ),
//            //cut items
//            types.length > 0
//                ? Container(
//                    height: 40,
//                    padding: EdgeInsets.only(top: 5),
//                    margin: EdgeInsets.only(top: 10, bottom: 5),
//                    child: ListView.builder(
//                      scrollDirection: Axis.horizontal,
//                      itemCount: types.length,
//                      itemBuilder: (context, index) {
//                        return Material(
//                          child: InkWell(
//                            child: Container(
//                              margin: EdgeInsets.only(right: 5),
//                              width: MediaQuery.of(context).size.width / 3.2,
//                              height: 20,
//                              alignment: Alignment.center,
//                              padding: EdgeInsets.all(4),
//                              child: AutoSizeText(
//                                types[index]['type'],
//                                maxLines: 1,
//                                style: TextStyle(
//                                    fontSize: 16,
//                                    color: _selectedTypeIndex == index
//                                        ? Colors.white
//                                        : Colors.black),
//                              ),
//                              decoration: BoxDecoration(
//                                color: _selectedTypeIndex == index
//                                    ? Colors.green
//                                    : Colors.white,
//                                border: Border.all(
//                                    color: Colors.black12.withOpacity(0.3)),
//                                borderRadius: BorderRadius.only(
//                                    bottomLeft: Radius.circular(10),
//                                    bottomRight: Radius.circular(10),
//                                    topRight: Radius.circular(10)),
//                              ),
//                            ),
//                            onTap: () {
//                              _selectedTypeIndex = index;
//                              List types = typesList ?? [];
//                              if (types.length > 0) {
//                                _itemAmount =
//                                    types[_selectedTypeIndex]['amount'];
//                                _title =
//                                    '$title - ${typesList[_selectedTypeIndex]['type']}';
//                                _image =
//                                    '$title - ${typesList[_selectedTypeIndex]['image']}';
//                              }
//                            },
//                          ),
//                        );
//                      },
//                    ),
//                    decoration: BoxDecoration(
//                        border: Border(
//                      top: BorderSide(
//                        color: Colors.grey.withOpacity(0.3),
//                        width: 1.0,
//                      ),
//                    )),
//                  )
//                : Container(),
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
