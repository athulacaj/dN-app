import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../../../common/ViewCart_BottomNavBar.dart';
import 'fishCut.dart';

var _details;
var _itemdetails;
List<String> _cartItemsList = [];
bool isInList = false;
String _whichSubcateogry;
//bool _isAnyContent;
bool _showSpinner = false;

class FishDetailsGeneralPage extends StatefulWidget {
  FishDetailsGeneralPage({this.details});
  final details;
  @override
  _FishDetailsGeneralPageState createState() => _FishDetailsGeneralPageState();
}

class _FishDetailsGeneralPageState extends State<FishDetailsGeneralPage> {
  @override
  void initState() {
    _showSpinner = false;
    _details = widget.details;
    _whichSubcateogry =
        _details['subCategory'] != null ? _details['subCategory'][0] : null;
//    showSpinnerFunction();
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

  void showSpinnerFunction() {
    setState(() {
      _showSpinner = true;
    });
    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
    if (_itemdetails.length > 0) {
      String url = _itemdetails[0]['image'];
      var _image = NetworkImage("$url");
      _image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
        (info, call) {
          setState(() {
            _showSpinner = false;
          });
        },
      ));
    } else {
      setState(() {
        _showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
    _cartItemsList = [];
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: RefreshProgressIndicator(),
      child: Column(
        children: <Widget>[
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
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: FlatButton(
                    color: _whichSubcateogry == subCategory
                        ? Colors.purple.shade300
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
          SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 8),
              child: _itemdetails.length > 0
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: AnimationLimiter(
                            child: ListView.builder(
                              itemCount: _itemdetails.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map items = _itemdetails[index];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: Duration(milliseconds: 100),
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 100.0,
                                    child: FishCut(
                                      image: '${items['image']}',
                                      title: '${items['name']}',
                                      malayalam: '${items['m']}',
                                      amount: items['amount'],
                                      quantity: items['quantity'],
                                      unit: '${items['unit']}',
                                      index: index,
                                      types: items['types'],
                                      imageType: items['imageType'],
                                      available: '${items['available']}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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
