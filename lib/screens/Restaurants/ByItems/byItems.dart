import 'dart:convert';
import 'package:daily_needs/common/cartBadge.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:daily_needs/screens/vegitablesFruitsPage/ByItems/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../../../common/ViewCart_BottomNavBar.dart';
import '../../../searchProvider.dart';
import 'buildFruits.dart';

var _details;
List _itemdetails;
List<String> _cartItemsList = [];
bool isInList = false;
String _whichSubcateogry;
String _lastSubCategory;
//bool _isAnyContent;
bool _showSpinner = true;
String _shopName;
bool _showSearch = false;
bool _showAllItems = true;
bool _isInitStateCalled = false;

class RestaurantByItems extends StatefulWidget {
  final String shopName;
  final scaffoldKey;
  final fromWhere;
  final bool isClosed;
  RestaurantByItems(
      {this.details,
      this.shopName,
      @required this.scaffoldKey,
      @required this.isClosed,
      this.fromWhere});
  final details;
  @override
  _ByItemsState createState() => _ByItemsState();
}

TextEditingController _typeAheadController = TextEditingController();
SuggestionsBoxController _suggestionsBoxController = SuggestionsBoxController();
FocusNode _focus = new FocusNode();

class _ByItemsState extends State<RestaurantByItems>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchWordController = TextEditingController();
  AnimationController _iconAnimationController;
  GlobalKey<ScaffoldState> _key;
  @override
  @override
  void initState() {
    _isInitStateCalled = true;
    _showSearch = false;
    initFunctions();
    super.initState();
  }

  void initFunctions() {
    _key = widget.scaffoldKey;
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 200),
    );
    _details = widget.details;
    _shopName = widget.shopName;
    _whichSubcateogry =
        _details['subCategory'] != null ? _details['subCategory'][0] : null;
//    showSpinnerFunction();
    _showSpinner = false;
//    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
    _itemdetails = widget.details['items'];
    manageSearchFunction();
  }

  void manageSearchFunction() async {
    // adding all items to search items
    await Future.delayed(Duration(milliseconds: 200));
    Provider.of<SearchProvider>(_key.currentContext, listen: false)
        .initSearchResults(_itemdetails);
  }

  void dispose() {
    // Clean up the controller when the Widget is disposed
    _searchWordController.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  List isAnyContent(List items, String category) {
    bool toReturn = false;
    List itemsSorted = [];
    if (category.toLowerCase() == 'all') {
      return items;
    }
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

//    _itemdetails =
//        Provider.of<SearchProvider>(context, listen: false).searchResults;

    _cartItemsList = [];
    return Consumer<SearchProvider>(
      builder: (context, value, Widget child) {
        if (_isInitStateCalled == false && _showSearch == true) {
          _itemdetails = value.searchResults;
        }
        _isInitStateCalled = false;
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
                          height: 85,
                          width: double.infinity,
                          color: Colors.purple,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 2),
//                              Icon(Icons.ellips),
                                  AnimatedIconButton(
                                    animationController:
                                        _iconAnimationController,
                                    size: 25,
                                    onPressed: () {
                                      if (_showSearch == true) {
                                        _suggestionsBoxController.close();
                                        Provider.of<SearchProvider>(
                                                _key.currentContext,
                                                listen: false)
                                            .revertResult();
                                        _iconAnimationController.reverse();
                                        _showSearch = false;
                                        _whichSubcateogry = _lastSubCategory;
                                        setState(() {});
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                    endIcon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    startIcon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: _showSearch == true ? 0 : 10),
                                  _showSearch == false
                                      ? Text(
                                          widget.shopName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : Container(),
                                  Spacer(),
                                  AnimatedContainer(
                                    height: 40,
//                                margin: EdgeInsets.only(left: 4, right: 6),
                                    width: _showSearch == true
                                        ? MediaQuery.of(context).size.width - 65
                                        : 0,
                                    duration: Duration(milliseconds: 550),
                                    child: _showSearch == true
                                        ? TypeAheadField(
//                      hideOnEmpty: true,
                                            suggestionsBoxController:
                                                _suggestionsBoxController,
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              controller: _typeAheadController,
                                              focusNode: _focus,
                                              autofocus: true,
                                              textAlign: TextAlign.center,
                                              decoration:
                                                  kautoCompleteTextFieldDecoration
                                                      .copyWith(
                                                suffixIcon: IconButton(
                                                  icon: Icon(Icons.clear_all),
                                                  onPressed: () {
                                                    _typeAheadController
                                                        .clear();
//                                                _suggestionsBoxController
//                                                    .close();
                                                  },
                                                ),
                                              ),
                                            ),
                                            suggestionsCallback:
                                                (pattern) async {
                                              _itemdetails = isAnyContent(
                                                  widget.details['items'],
                                                  _whichSubcateogry);

                                              List suggestionList =
                                                  getSuggestions(
                                                      _itemdetails, pattern);
//                                          Provider.of<SearchProvider>(context,
//                                                  listen: false)
//                                              .getSearchResults(suggestionList);
                                              return suggestionList;
                                            },
                                            itemBuilder: (context, suggestion) {
                                              return ListTile(
                                                leading: Icon(Icons.forward),
                                                title:
                                                    suggestion['available'] ==
                                                            false
                                                        ? Text(
                                                            suggestion['name'],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          )
                                                        : Text(
                                                            suggestion['name'],
                                                          ),
                                              );
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              _whichSubcateogry =
                                                  suggestion['category'];
                                              List toAdd = [suggestion];
                                              Provider.of<SearchProvider>(
                                                      _key.currentContext,
                                                      listen: false)
                                                  .getSearchResults(toAdd);
                                            })
                                        : Container(),
                                  ),
                                  _showSearch == false
                                      ? GestureDetector(
                                          onTap: () {
                                            _iconAnimationController.forward();
                                            _lastSubCategory =
                                                _whichSubcateogry;
                                            _whichSubcateogry = 'all';
                                            _showSearch = true;
                                            setState(() {});
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.purple,
                                            radius: 16,
                                            child: Icon(Icons.search,
                                                color: Colors.white, size: 25),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(width: 8),
                                  _showSearch == true
                                      ? Container()
                                      : CartBadge(),
                                ],
                              ),
                              _showSearch == false
                                  ? Container(
                                      height:
                                          _whichSubcateogry != null ? 30 : 0,
                                      child: ListView.builder(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            _details['subCategory'] != null
                                                ? _details['subCategory'].length
                                                : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var subCategory =
                                              _details['subCategory'][index];
                                          return GestureDetector(
//                                              color: _whichSubcateogry ==
//                                                      subCategory
//                                                  ? Colors.deepPurple
//                                                  : Colors.white,
                                            onTap: () {
                                              setState(() {
                                                _whichSubcateogry = subCategory;
                                                _itemdetails = isAnyContent(
                                                    widget.details['items'],
                                                    _whichSubcateogry);
                                                setState(() {});
                                              });
                                            },
                                            child: Container(
                                              width:
                                                  subCategory.length * 8.5 + 18,
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '$subCategory',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          _whichSubcateogry ==
                                                                  subCategory
                                                              ? Colors.white
                                                              : Colors.white70,
                                                    ),
                                                  ),
                                                  SizedBox(height: 3),
                                                  AnimatedContainer(
                                                    height: 2,
                                                    width: subCategory.length *
                                                            8.5 +
                                                        16,
                                                    color: _whichSubcateogry ==
                                                            subCategory
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    duration: Duration(
                                                        milliseconds: 200),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ))
                      : Container(),
                  SizedBox(height: 4),
                  Expanded(
                    child: _itemdetails.length > 0
                        ? ListView(
                            padding: EdgeInsets.only(
                                left: 8, bottom: 10, top: 5, right: 0),
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  buildFruits(_itemdetails, widget.shopName,
                                      _whichSubcateogry, widget.isClosed),
                                ],
                              )
//                    SizedBox(
//                      height: 270.0 * (_itemdetails.length / 2.floor()),
//                      child: Stack(
//                        children: <Widget>[
//                          Positioned(
//                            top: -20,
//                            left: 0,
//                            child: Row(
//                              children:
//                                  buildFruits(_itemdetails, widget.shopName),
//                            ),
//                          )
//                        ],
//                      ),
//                    )
                            ],
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
                  ), //
                  SizedBox(
                    child: ViewCartBottomNavigationBar(),
                  )
//                  : Container(),
                ],
              ),
              _showSearch == true
                  ? Positioned(
                      bottom: 60,
                      right: 35,
                      child: FloatingActionButton(
                        child: Text('Clear'),
                        onPressed: () {
                          Provider.of<SearchProvider>(_key.currentContext,
                                  listen: false)
                              .revertResult();
                          _iconAnimationController.reverse();

                          _showSearch = false;
                          setState(() {});
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
