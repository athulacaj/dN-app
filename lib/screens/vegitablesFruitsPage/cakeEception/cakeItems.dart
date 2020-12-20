import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../../common/ViewCart_BottomNavBar.dart';
import 'CakeContainer.dart';

var _details;
var _itemdetails;
List<String> _cartItemsList = [];
bool isInList = false;
String _whichSubcateogry;
//bool _isAnyContent;
bool _showSpinner = true;
String _shopName;
//List _allItems = [];
List filteredMap = [];
bool _showSearch = false;
bool _showAllItems = true;

class CakeByItems extends StatefulWidget {
  final String shopName;
  final scaffoldKey;
  final fromWhere;
  CakeByItems(
      {this.details,
      this.shopName,
      this.fromWhere,
      @required this.scaffoldKey});
  final details;
  @override
  _CakeByItemsState createState() => _CakeByItemsState();
}

class _CakeByItemsState extends State<CakeByItems> {
  final TextEditingController _searchWordController = TextEditingController();
  @override
  @override
  void initState() {
    _showSearch = false;
    initFunctions();

    super.initState();
  }

  void initFunctions() {
    filteredMap = [];
    _details = widget.details;
    _shopName = widget.shopName;
    _whichSubcateogry =
        _details['subCategory'] != null ? _details['subCategory'][0] : null;
//    showSpinnerFunction();
    _showSpinner = false;
    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
    filteredMap = _itemdetails;
  }

  void dispose() {
    // Clean up the controller when the Widget is disposed
    _searchWordController.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
//    initFunctions();
    _details = widget.details;

    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
    _cartItemsList = [];
//    print('length ${filteredMap.length}');
//    print(filteredMap);
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: RefreshProgressIndicator(),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              widget.fromWhere == 'shop'
                  ? SafeArea(
                      child: Container(
                      height: 55,
                      width: double.infinity,
                      color: Colors.purple,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 2),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
//                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: _showSearch == true ? 0 : 10),
                          Text(
                            widget.shopName,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Spacer(),
                          SizedBox(width: 5),
                        ],
                      ),
                    ))
                  : Container(),
              SizedBox(height: 4),
              Container(
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
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FlatButton(
                        color: _whichSubcateogry == subCategory
                            ? Colors.deepPurple
                            : Colors.white,
                        onPressed: () {
                          setState(() {
                            _whichSubcateogry = subCategory;
                            _itemdetails = isAnyContent(
                                widget.details['items'], _whichSubcateogry);
                          });
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: _itemdetails.length > 0
                      ? AnimationLimiter(
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                                left: 6, right: 4, top: 10, bottom: 75),
                            itemCount: _searchWordController.text.length > 0
                                ? filteredMap.length
                                : _itemdetails.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map items = _searchWordController.text.length > 0
                                  ? filteredMap[index]
                                  : _itemdetails[index];
                              return AnimationConfiguration.staggeredList(
                                delay: Duration(milliseconds: 100),
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: 100.0,
                                  child: CakeItemsContainer(
                                      image: '${items['image']}',
                                      title: '${items['name']}',
                                      amount: items['amount'],
                                      quantity: items['quantity'],
                                      unit: '${items['unit']}',
                                      index: index,
                                      available: items['available'],
                                      scaffoldKey: widget.scaffoldKey,
                                      shopName: widget.shopName,
                                      imageType: items['imageType']),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.announcement,
                                size: 60,
                                color: Colors.purple,
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
//
              SizedBox(
                child: ViewCartBottomNavigationBar(),
              )
//                  : Container(),
            ],
          ),
//          _showSearch == false
//          Positioned(
//            bottom: 50,
//            right: 20,
//            child: GestureDetector(
//              child: CircleAvatar(
//                backgroundColor: Colors.purple[600],
//                radius: 25,
//                child: Icon(
//                  CupertinoIcons.search,
//                  size: 25,
//                  color: Colors.white,
//                ),
//              ),
//              onTap: () {
//                filteredMap = _itemdetails;
//                _showSearch = !_showSearch;
//                setState(() {});
//              },
//            ),
//          )
        ],
      ),
    );
  }
}

InputDecoration KautoCompleteTextFieldDecoration = InputDecoration(
  hintText: 'search',
  hintStyle: TextStyle(color: Colors.grey),
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(6.0))),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
);

getSuggestions(List itemsList, String searchWordAllCase) {
  List<String> result = [];
  String searchWord = searchWordAllCase.toLowerCase();
  filteredMap = [];
  if (searchWord != '') {
    filteredMap = [];

    for (Map itemMap in itemsList) {
//    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
      String item = itemMap['name'].toString().toLowerCase();
      final alphanumeric = RegExp('$searchWord');
      bool a = alphanumeric.hasMatch(item);
      if (a == true) {
        filteredMap.add(itemMap);
//        result.add(item);
      }
    }
  }
  if (searchWord == '') {
    _showSearch = false;
  }
}
//  return result;
