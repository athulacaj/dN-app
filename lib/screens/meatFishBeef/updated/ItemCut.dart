import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_needs/constants/constants.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:daily_needs/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _showSpinner;

class TypeOfCut extends StatefulWidget {
  final String image;
  final String title;
  final amount;
  final available;
  final int quantity;
  final String unit;
  final int index;
  final String tag;
  final scaffoldKey;
  final String imageType;
  TypeOfCut(
      {this.image,
      this.title,
      this.amount,
      this.index,
      this.available,
      this.quantity,
      this.imageType,
      @required this.scaffoldKey,
      @required this.tag,
      this.unit});

  @override
  _TypeOfCutState createState() => _TypeOfCutState();
}

class _TypeOfCutState extends State<TypeOfCut> {
  var _quantity = 0;
  var _amount = 0;
//  var _image;
//  var _name;
//  var index;
//  var _unit;
  List<String> _cartItemsList = [];
  AnimationController rotationController;
  @override
  void initState() {
    super.initState();

    _showSpinner = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressed(String whatButton) async {
    Map individualItem = {
      'name': '${widget.title}',
      'image': '${widget.image}',
      'amount': _amount,
      'quantity': _quantity,
      'baseAmount': widget.amount,
      'imageType': widget.imageType,
      'unit': widget.unit,
      'baseQuantity': widget.quantity
    };
    if (_quantity > 0) {
      var isInListMap = {'${widget.title}': true};
      Provider.of<IsInList>(widget.scaffoldKey.currentContext, listen: false)
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
          'name': '${widget.title}',
          'image': '${widget.image}',
          'imageType': widget.imageType,
          'amount': _amount,
          'unit': widget.unit,
          'quantity': _quantity,
          'baseAmount': widget.amount,
          'baseQuantity': widget.quantity
        };
        Provider.of<IsInList>(widget.scaffoldKey.currentContext, listen: false)
            .addAllDetails(individualItem, context);
      } else {
        Provider.of<IsInList>(widget.scaffoldKey.currentContext, listen: false)
            .removeByName(widget.title);
      }
    }
  }

  void getProviderData() async {
    await Future.delayed(Duration(milliseconds: 100));
    var dataByName =
        Provider.of<IsInList>(widget.scaffoldKey.currentContext, listen: false)
            .getDetailsByName(widget.title);
    _amount = dataByName != null ? dataByName['amount'] : 0;
    _quantity = dataByName != null ? dataByName['quantity'] : 0;
  }

  @override
  Widget build(BuildContext context) {
    _amount = widget.amount;
    _quantity = widget.quantity;
    String _tag = widget.tag ?? '';
    getProviderData();
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8, top: 12),
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 230,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width / 2,
                          child: widget.imageType == 'offline'
                              ? Image.asset(
                                  widget.image,
                                  fit: BoxFit.fill,
                                )
                              : CachedNetworkImage(
                                  imageUrl: '${widget.image}',
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      SpinKitThreeBounce(
                                    color: Colors.grey,
                                    size: 25.0,
                                  ),
                                ),
                        ),
                        _tag != ''
                            ? Container(
                                color: Colors.deepPurpleAccent.withOpacity(0.8),
                                width: 60,
                                height: 25,
                                alignment: Alignment.center,
                                child: Text(
                                  _tag ?? '',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '${widget.title}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black, Colors.black12]),
                          )),
                    ),
                  ],
                ),
                Spacer(),
                widget.available != 'notAvailable'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            '₹ ${widget.amount} /${widget.quantity} ${widget.unit}',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 10),
                Consumer<IsInList>(
                  builder: (context, isInList, child) {
                    var _detail;
                    var _allDetails = isInList.allDetails ?? [];
                    for (var _details in _allDetails) {
                      if (_details['name'] == widget.title) {
                        _detail = true;
                        break;
                      } else {
                        _detail = false;
                      }
                    }
                    getProviderData();
                    return _detail == true
                        ? Container(
//                        padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              width: 130,
                              child: Row(children: <Widget>[
                                Material(
                                  child: Container(
                                    height: 35,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(11),
                                      child: Icon(Icons.remove,
                                          size: 35, color: Colors.white),
                                      onTap: () {
                                        if (_quantity != 0) {
                                          _quantity =
                                              _quantity - widget.quantity;
                                          _amount = _amount - widget.amount;

                                          onPressed('null');
                                        }
                                      },
                                      splashColor: Colors.white70,
                                    ),
                                  ),
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      topLeft: Radius.circular(5)),
                                ),
                                Spacer(),
                                Text(
                                    '${quantityFormat(_quantity, widget.unit)}',
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600)),
                                Spacer(),
                                Material(
                                  child: Container(
                                    height: 35,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(11),
                                      child: Icon(Icons.add,
                                          size: 35, color: Colors.white),
                                      onTap: () {
                                        _quantity = _quantity + widget.quantity;
                                        _amount = _amount + widget.amount;
                                        onPressed('null');
                                      },
                                      splashColor: Colors.white70,
                                    ),
                                    decoration: contaionerButtonDecoration,
                                  ),
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                              ]),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  border: Border.all(
                                      width: 0.5,
                                      color: Colors.blueGrey.withOpacity(0.5))),
                            ),
                          )
                        : Container();
                  },
                ),
                widget.available != 'notAvailable'
                    ? Consumer<IsInList>(builder: (context, isInList, child) {
                        var _detail;
                        var _allDetails = isInList.allDetails ?? [];
                        for (var _details in _allDetails) {
                          if (_details['name'] == widget.title) {
                            _detail = true;
                            break;
                          } else {
                            _detail = false;
                          }
                        }
                        return AnimatedContainer(
                          height: _detail == true ? 0 : 42,
                          duration: Duration(milliseconds: 80),
                          child: Padding(
                            padding: _detail == true
                                ? EdgeInsets.all(0)
                                : EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            child: GestureDetector(
                              onTap: () {
                                onPressed('add');
                              },
                              child: _detail == true
                                  ? null
                                  : Container(
                                      width: 90,
                                      height: 40,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.purple),
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
                            ),
                          ),
                        );
                      })
                    : Container(
                        height: 42,
                        alignment: Alignment.center,
                      ),
                Spacer(),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 8, top: 12),
            child: Container(
              color: Colors.grey.withOpacity(0.4),
              height: widget.available == 'notAvailable' ? 230 : 0,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Text(
                    'NOT AVAILABLE',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 42),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
