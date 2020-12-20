import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_needs/screens/CartPage/cartPage.dart';
import 'package:daily_needs/screens/grocery/textFieldDecoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../common/cartBadge.dart';
import '../../common/theme.dart';

import 'grocryItems/categoryItems.dart';

class GroceryHomeScreen extends StatefulWidget {
  Map groceryDetails;
  GroceryHomeScreen({this.groceryDetails});
  @override
  _GroceryHomeScreenState createState() => _GroceryHomeScreenState();
}

TextEditingController _typeAheadController = TextEditingController();
SuggestionsBoxController _suggestionsBoxController = SuggestionsBoxController();
FocusNode _focus = new FocusNode();

class _GroceryHomeScreenState extends State<GroceryHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return widget.groceryDetails != null
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Container(
                  height: 140,
                  color: primaryColor,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        children: <Widget>[
                          Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              SizedBox(width: 25),
                              Text(
                                'Grocery',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Spacer(),
                              CartBadge(),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            height: 45,
                            child: TypeAheadField(
//                      hideOnEmpty: true,
                                suggestionsBoxController:
                                    _suggestionsBoxController,
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: _typeAheadController,
                                  focusNode: _focus,
                                  autofocus: false,
                                  textAlign: TextAlign.start,
//                          style: TextStyle(color: Colors.black),
                                  decoration: textFieldDecoration.copyWith(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Colors.purple.withOpacity(0.8),
                                            width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.all(0),
                                    hintText: 'Search products',
                                    hintMaxLines: 1,
                                    hintStyle: TextStyle(height: .5),
                                  ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  List<Map> suggestionList = getSuggestions(
                                      pattern, widget.groceryDetails);
                                  return suggestionList;
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
//                          leading: Icon(Icons.collections_bookmark),
                                    title: Text(suggestion['display']),
//                    subtitle: Text('\$${suggestion['price']}'),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  if (suggestion['route'] == 'category') {
                                    Map catgeoryMap =
                                        widget.groceryDetails['categories']
                                            [suggestion['categoryIndex']];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GroceryItems(
                                                  itemDetails: catgeoryMap,
                                                  tabIndex:
                                                      suggestion['tabIndex'],
                                                  title: catgeoryMap['name'],
                                                  ad: catgeoryMap['ads'],
                                                  searched: true,
                                                  searchedIndex: 0,
                                                )));
                                  }
                                  if (suggestion['route'] == 'items') {
                                    Map catgeoryMap =
                                        widget.groceryDetails['categories']
                                            [suggestion['categoryIndex']];
                                    print(suggestion['searchedIndex']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GroceryItems(
                                                  itemDetails: catgeoryMap,
                                                  tabIndex:
                                                      suggestion['tabIndex'],
                                                  title: catgeoryMap['name'],
                                                  ad: catgeoryMap['ads'],
                                                  searched: true,
                                                  searchedIndex: suggestion[
                                                      'searchedIndex'],
                                                )));
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
//app bar above
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 20, left: 15, bottom: 5),
//            alignment: Alignment.center,
                        child: Text(
                          'Available Categories',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 11000),
                        child: Container(
                          color: Colors.grey.withOpacity(0.05),
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  widget.groceryDetails['categories'].length,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 6),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: (size.width / 3 / 160),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                Map catgeoryMap =
                                    widget.groceryDetails['categories'][index];
                                return Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GroceryItems(
                                                      itemDetails: catgeoryMap,
                                                      title:
                                                          catgeoryMap['name'],
                                                      ad: catgeoryMap['ads'],
                                                      available: catgeoryMap[
                                                          'available'])));
                                    },
                                    child: Material(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      elevation: 6,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(height: 5),
                                          catgeoryMap['imageType'] == 'online'
                                              ? CachedNetworkImage(
                                                  height: 85,
                                                  imageUrl:
                                                      catgeoryMap['image'],
                                                  placeholder: (context, url) =>
                                                      SpinKitThreeBounce(
                                                        color: Colors.grey,
                                                        size: 20.0,
                                                      ))
                                              : Image(
                                                  image: AssetImage(
                                                      catgeoryMap['image']),
                                                  height: 85,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                ),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            child: Text(
                                              '${catgeoryMap['name']}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            body: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    child: Image.asset('assets/404.png'),
                  ),
                  SizedBox(height: 10),
                  Text('Groceries is not available at this time'),
                  SizedBox(height: 50),
                ],
              ),
            ),
          );
  }
}

List<Map> getSuggestions(String searchWordAllCase, Map groceryDetails) {
  final alphanumeric = RegExp('${searchWordAllCase.toLowerCase()}');
  List<Map> _result = [];
  Map toAddMap = {'route': 'category', 'display': 'category'};
  List categoriesList = groceryDetails['categories'];
  int categoryIndex = 0;
  for (Map categoryMap in categoriesList) {
    List nameList = categoryMap['category'];
    if (nameList != null) {
      int tabIndex = 0;
      for (String name in nameList) {
        bool a = alphanumeric.hasMatch(name.toLowerCase());
        if (a == true) {
          toAddMap = {
            'route': 'category',
            'categoryIndex': categoryIndex,
            'tabIndex': tabIndex,
            'display': '$name'
          };
          _result.add(toAddMap);
        }
        int index = 0;
        for (Map itemsMap in categoryMap['$name']) {
          String itemName = itemsMap['name'];
          bool a = alphanumeric.hasMatch(itemName.toLowerCase());
          if (a == true) {
            toAddMap = {
              'route': 'items',
              'searched': true,
              'searchedIndex': index,
              'categoryIndex': categoryIndex,
              'tabIndex': tabIndex,
              'display': '$itemName'
            };
            _result.add(toAddMap);
          }
          index++;
        }
        tabIndex++;
      }
    }
    categoryIndex++;
  }
  return _result;
}
