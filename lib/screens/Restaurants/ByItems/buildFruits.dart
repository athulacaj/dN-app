import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common/ViewCart_BottomNavBar.dart';
import 'itemsContainer.dart';
import 'dart:convert';

var _details;
List<String> _cartItemsList = [];
bool isInList = false;
String _whichSubcateogry;
//bool _isAnyContent;
bool _showSpinner = true;
String _shopName;

List fruitsList = [];
// buildFruits(List _items, String shopName, String category, bool isClosed) {
//   List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(_items);
//   // print(items);
//   print(items.runtimeType);
//   return Text('hi');
// }

buildFruits(List _items, String shopName, String category, bool isClosed) {
  print(_items);
  String colorString = Colors.yellow.toString();
  List<Widget> toReturnRow = [];
  List<Widget> column1Children = [];
  List<Widget> column2Children = [];
  Column toAddColumn1 = Column(children: column1Children);
  Widget toAddColumn2 = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
//      SizedBox(height: 35),
      Column(children: column2Children),
    ],
  );
  List<Map> items = List<Map>.from(_items);

  // List items = _items;
  for (int index = 0; index <= items.length - 1; index++) {
    if (index.isEven) {
      Widget toAdd = FruitsContainer1(
          image: '${items[index]['image']}',
          isAvailable: items[index]['isAvailable'],
          title: '${items[index]['name']}',
          isVeg: items[index]['isVeg'],
          openHour: items[index]['openHour'],
          desc: '${items[index]['desc']}',
          types: items[index]['types'],
          amount: items[index]['amount'],
          quantity: items[index]['quantity'],
          unit: '${items[index]['unit']}',
          shopName: shopName,
          category: category,
          isClosed: isClosed,
          imageType: items[index]['imageType']);
      column1Children.add(toAdd);
    }
    if (index.isOdd) {
      Widget toAdd = Column(
        children: <Widget>[
          FruitsContainer1(
              isAvailable: items[index]['isAvailable'],
              isClosed: isClosed,
              image: '${items[index]['image']}',
              types: items[index]['types'],
              isVeg: items[index]['isVeg'],
              openHour: items[index]['openHour'],
              desc: '${items[index]['desc']}',
              title: '${items[index]['name']}',
              amount: items[index]['amount'],
              quantity: items[index]['quantity'],
              unit: '${items[index]['unit']}',
              shopName: shopName,
              category: category,
              imageType: items[index]['imageType'])
        ],
      );
      column2Children.add(toAdd);
    }
  }
  toReturnRow = [toAddColumn1, toAddColumn2];
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      toAddColumn1,
      toAddColumn2,
    ],
  );
}
