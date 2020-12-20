import 'dart:convert';

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
import 'itemsContainer.dart';

var _details;
List _itemdetails;
List<String> _cartItemsList = [];
bool isInList = false;
String _whichSubcateogry;
//bool _isAnyContent;
bool _showSpinner = true;
String _shopName;
bool _showSearch = false;
bool _showAllItems = true;
bool _isInitStateCalled = false;

class ByItems extends StatefulWidget {
  final String shopName;
  final scaffoldKey;
  final fromWhere;
  ByItems(
      {this.details,
      this.shopName,
      @required this.scaffoldKey,
      this.fromWhere});
  final details;
  @override
  _ByItemsState createState() => _ByItemsState();
}

TextEditingController _typeAheadController = TextEditingController();
SuggestionsBoxController _suggestionsBoxController = SuggestionsBoxController();
FocusNode _focus = new FocusNode();

class _ByItemsState extends State<ByItems> with SingleTickerProviderStateMixin {
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
        if (_isInitStateCalled == false) {
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
                          height: 55,
                          width: double.infinity,
                          color: Colors.purple,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 2),
//                              Icon(Icons.ellips),
                              AnimatedIconButton(
                                animationController: _iconAnimationController,
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
                                          color: Colors.white, fontSize: 18),
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
                                                _typeAheadController.clear();
//                                                _suggestionsBoxController
//                                                    .close();
                                              },
                                            ),
                                          ),
                                        ),
                                        suggestionsCallback: (pattern) async {
                                          _itemdetails = isAnyContent(
                                              widget.details['items'],
                                              _whichSubcateogry);

                                          List suggestionList = getSuggestions(
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
                                                suggestion['available'] == false
                                                    ? Text(
                                                        suggestion['name'],
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      )
                                                    : Text(
                                                        suggestion['name'],
                                                      ),
                                            trailing: Text(
                                              '₹ ${suggestion['amount']} / ${suggestion['quantity']} ${suggestion['unit']}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 13.5),
                                            ),
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {
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
                                        _showSearch = true;
                                        setState(() {});
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 16,
                                        child: Icon(Icons.search,
                                            color: Colors.black, size: 20),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(width: 8),
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
                                itemCount: _itemdetails.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Map items = _itemdetails[index];
                                  return AnimationConfiguration.staggeredList(
                                    delay: Duration(milliseconds: 100),
                                    position: index,
                                    duration: const Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 100.0,
                                      child: ItemsContainer(
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
                                  Text('no items'),
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
