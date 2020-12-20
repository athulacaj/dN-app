import 'file:///C:/Users/attaramackal/AndroidStudioProjects/daily_needs/lib/common/ViewCart_BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'ItemCut.dart';

var _details;
var _itemdetails;
List<String> _cartItemsList = [];
bool isInList = false;
String _whichSubcateogry;
//bool _isAnyContent;
bool _showSpinner = false;
bool _loaded = false;

class ItemDetailsGeneralPage extends StatefulWidget {
  ItemDetailsGeneralPage({this.details, @required this.scaffoldKey});
  final details;
  final scaffoldKey;
  @override
  _ItemDetailsGeneralPageState createState() => _ItemDetailsGeneralPageState();
}

class _ItemDetailsGeneralPageState extends State<ItemDetailsGeneralPage> {
  @override
  void initState() {
    _showSpinner = false;
    _loaded = true;
    _details = widget.details;
    _whichSubcateogry =
        _details['subCategory'] != null ? _details['subCategory'][0] : null;
//    showSpinnerFunction();
    print('called init state');
  }

  isLoaded() async {
//    await Future.delayed()
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
    _loaded = false;
    print('called dispose in itemDETAILS');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
    _cartItemsList = [];
    return Column(
      children: <Widget>[
        SizedBox(height: 4),
        _details['subCategory'] != null
            ? Container(
                height: _whichSubcateogry != null ? 30 : 0,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: _details['subCategory'] != null
                      ? _details['subCategory'].length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    var subCategory = _details['subCategory'][index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
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
        SizedBox(height: 4),
        buildTypeOfCut(widget.scaffoldKey, _loaded),
        SizedBox(
          child: ViewCartBottomNavigationBar(),
        ),
      ],
    );
  }
}

Widget buildTypeOfCut(var key, bool init) {
  return init == true
      ? Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2, right: 10),
            child: _itemdetails.length > 0
                ? AnimationLimiter(
                    child: GridView.count(
                      childAspectRatio: .65,
                      crossAxisCount: 2,
                      children: List.generate(_itemdetails.length, (int index) {
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
                              unit: '${items['unit']}',
                              available: '${items['available']}',
                              index: index,
                              scaffoldKey: key,
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
        )
      : Container();
}
