import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common/ViewCart_BottomNavBar.dart';
import 'fruitsContainer.dart';

var _details;
var _itemdetails;
List<String> _cartItemsList = [];
bool isInList = false;
String _whichSubcateogry;
//bool _isAnyContent;
bool _showSpinner = true;
String _shopName;

class FruitItems extends StatefulWidget {
  final String shopName;
  FruitItems({this.details, this.shopName});
  final details;
  @override
  _FruitItemsState createState() => _FruitItemsState();
}

class _FruitItemsState extends State<FruitItems> {
  @override
  void initState() {
    _details = widget.details;
    _shopName = widget.shopName;
    _whichSubcateogry =
        _details['subCategory'] != null ? _details['subCategory'][0] : null;
//    showSpinnerFunction();
    _showSpinner = false;
    super.initState();
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

//  void showSpinnerFunction() {
//    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
//    String url = _itemdetails[_itemdetails.length - 1]['image'];
//    var _image = NetworkImage("$url");
//    _image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
//      (info, call) {
//        setState(() {
//          _showSpinner = false;
//        });
//      },
//    ));
//  }

  @override
  Widget build(BuildContext context) {
    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
    _cartItemsList = [];
    return Container(
      color: Color(0xffF7F3F4),
      child: Column(
        children: <Widget>[
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
            child: _itemdetails.length > 0
                ? ListView(
                    padding:
                        EdgeInsets.only(left: 10, bottom: 10, top: 5, right: 0),
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buildFruits(_itemdetails, widget.shopName),
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
          ),
          SizedBox(
            child: ViewCartBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}

List fruitsList = [];
buildFruits(List _itemdetails, String shopName) {
  String colorString = Colors.yellow.toString();
  List<Widget> toReturnRow = [];
  List<Widget> column1Children = [];
  List<Widget> column2Children = [];
  Column toAddColumn1 = Column(children: column1Children);
  Widget toAddColumn2 = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 35),
      Column(children: column2Children),
    ],
  );
  for (int index = 0; index <= _itemdetails.length - 1; index++) {
    List items = _itemdetails;

    if (index.isEven) {
      Widget toAdd = FruitsContainer1(
          image: '${items[index]['image']}',
          title: '${items[index]['name']}',
          amount: items[index]['amount'],
          quantity: items[index]['quantity'],
          unit: '${items[index]['unit']}',
          shopName: shopName,
          colorString: items[index]['color'],
          imageType: items[index]['imageType']);
      column1Children.add(toAdd);
    }
    if (index.isOdd) {
      Widget toAdd = Column(
        children: <Widget>[
          FruitsContainer1(
              image: '${items[index]['image']}',
              title: '${items[index]['name']}',
              amount: items[index]['amount'],
              quantity: items[index]['quantity'],
              unit: '${items[index]['unit']}',
              shopName: shopName,
              colorString: items[index]['color'],
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
