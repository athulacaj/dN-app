import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/ViewCart_BottomNavBar.dart';
import '../../provider.dart';
import 'ItemCut.dart';

var _details;
var _itemdetails;
List<String> _cartItemsList = [];
bool isInList = false;
String _whichSubcateogry;
//bool _isAnyContent;
bool _showSpinner = false;

class ItemDetailsGeneralPage extends StatefulWidget {
  ItemDetailsGeneralPage({this.details});
  final details;
  @override
  _ItemDetailsGeneralPageState createState() => _ItemDetailsGeneralPageState();
}

class _ItemDetailsGeneralPageState extends State<ItemDetailsGeneralPage> {
  @override
  void initState() {
    super.initState();
    _showSpinner = false;
    _details = widget.details;
    _whichSubcateogry =
        _details['subCategory'] != null ? _details['subCategory'][0] : null;
//    showSpinnerFunction();
  }

  List isAnyContent(List items, String category) {
    bool toReturn = false;
    List itemsSorted = [];
    for (var item in items) {
      if (item['category'] == category) {
        itemsSorted.add(item);
      } else {}
    }
    return itemsSorted;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
    _cartItemsList = [];
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: RefreshProgressIndicator(),
      child: Column(
        children: <Widget>[
          SizedBox(height: 6),
          _details['subCategory'] != null
              ? Container(
                  height: _whichSubcateogry != null ? 30 : 0,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: _details['subCategory'] != null
                        ? _details['subCategory'].length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      var subCategory = _details['subCategory'][index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: FlatButton(
                          color: _whichSubcateogry == subCategory
                              ? Colors.purple.shade300
                              : Colors.white,
                          onPressed: () {
                            _whichSubcateogry = subCategory;
                            _itemdetails = isAnyContent(
                                widget.details['items'], _whichSubcateogry);
                            setState(() {});
                          },
                          child: Text(
                            '$subCategory',
                            style: TextStyle(
                              color: _whichSubcateogry == subCategory
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          SizedBox(height: 6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: _itemdetails.length > 0
                  ? AnimationLimiter(
                      child: GridView.count(
                        childAspectRatio: ((size.width / 2) / 240),
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
//                        itemCount: _itemdetails.length,

                        children:
                            List.generate(_itemdetails.length, (int index) {
                          Map items = _itemdetails[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            delay: Duration(milliseconds: 200),
                            duration: const Duration(milliseconds: 700),
                            columnCount: _itemdetails.length,
                            child: FadeInAnimation(
                              child: TypeOfCut(
                                image: '${items['image']}',
                                tag: items['tag'],
                                imageType: '${items['imageType']}',
                                title: '${items['name']}',
                                amount: items['amount'],
                                quantity: items['quantity'],
                                shopName: items['shopName'],
                                unit: '${items['unit']}',
                                available: '${items['available']}',
                                index: index,
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  : Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 150,
                            child: Image.asset('assets/404.png'),
                          ),
                          SizedBox(height: 10),
                          Text(
                              '$_whichSubcateogry is not available at this time'),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
            ),
          ),
          SizedBox(
            child: ViewCartBottomNavigationBar(),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}
