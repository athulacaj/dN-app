import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_needs/constants/constants.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:daily_needs/provider.dart';
import 'package:daily_needs/screens/grocery/offerStarClipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _showSpinner;
GlobalKey<ScaffoldState> _scaffoldKey;

class IndividualItem extends StatefulWidget {
  final String image;
  bool selectedThis;
  final String title;
  final amount;
  final available;
  final int quantity;
  final String unit;
  final int index;
  final String tag;
  final String imageType;
  final mrp;
  final GlobalKey<ScaffoldState> scaffoldkey;
  IndividualItem(
      {this.image,
      this.title,
      this.selectedThis,
      this.amount,
      this.index,
      this.mrp,
      this.available,
      this.quantity,
      this.imageType,
      @required this.tag,
      this.scaffoldkey,
      this.unit});

  @override
  _IndividualItemState createState() => _IndividualItemState();
}

class _IndividualItemState extends State<IndividualItem>
    with SingleTickerProviderStateMixin {
  var _quantity = 0;
  var _amount = 0;
//  var _image;
//  var _name;
//  var index;
//  var _unit;
  AnimationController _animationController;

  List<String> _cartItemsList = [];
  AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = widget.scaffoldkey;
    _showSpinner = true;

    if (widget.selectedThis == true) {
      _animationController = new AnimationController(
          vsync: this, duration: Duration(milliseconds: 500));
      _animationController.addListener(() => setState(() {}));
      TickerFuture tickerFuture = _animationController.repeat();
      tickerFuture.timeout(Duration(milliseconds: 1100), onTimeout: () {
        _animationController.forward(from: 1);
        _animationController.stop(canceled: true);
      });
    } else {
      _animationController =
          new AnimationController(vsync: this, duration: Duration(seconds: 0));

      _animationController.forward();
    }
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
      Provider.of<IsInList>(_scaffoldKey.currentContext, listen: false)
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
        Provider.of<IsInList>(_scaffoldKey.currentContext, listen: false)
            .addAllDetails(individualItem, context);
      } else {
        Provider.of<IsInList>(_scaffoldKey.currentContext, listen: false)
            .removeByName(widget.title);
      }
    }
  }

  void getProviderData() async {
    await Future.delayed(Duration(milliseconds: 100));
    var dataByName =
        Provider.of<IsInList>(_scaffoldKey.currentContext, listen: false)
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
          padding: EdgeInsets.only(left: 8, top: 0),
          child: FadeTransition(
            opacity: _animationController,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 265,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
//                          height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 2,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              height: 125,
                              child: widget.imageType == 'offline'
                                  ? Image.asset(
                                      widget.image,
                                      fit: BoxFit.fitWidth,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: '${widget.image}',
                                      fit: BoxFit.scaleDown,
                                      placeholder: (context, url) =>
                                          SpinKitThreeBounce(
                                        color: Colors.grey,
                                        size: 25.0,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: AutoSizeText(
                              '${widget.title} ',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              maxFontSize: 18,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black87,
                                    letterSpacing: .5),
                              ),
//                            style: TextStyle(
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                                color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 4),
//                      Text(
//                        '${widget.quantity} ${widget.unit} ',
//                        textAlign: TextAlign.start,
//                      ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                widget.mrp != null ? '₹ ${widget.mrp}/pkt' : '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                '₹ ${widget.amount}/pkt',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
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
                                          borderRadius:
                                              BorderRadius.circular(11),
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
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          child: Icon(Icons.add,
                                              size: 35, color: Colors.white),
                                          onTap: () {
                                            _quantity =
                                                _quantity + widget.quantity;
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
                                          color: Colors.blueGrey
                                              .withOpacity(0.5))),
                                ),
                              )
                            : Container();
                      },
                    ),
                    widget.available != 'notAvailable'
                        ? Consumer<IsInList>(
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
                            return AnimatedContainer(
                              height: _detail == true ? 0 : 42,
                              duration: Duration(milliseconds: 80),
                              child: Padding(
                                padding: _detail == true
                                    ? EdgeInsets.all(0)
                                    : EdgeInsets.only(
                                        left: 8, right: 8, bottom: 8),
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
                                            border: Border.all(
                                                color: Colors.purple),
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
                    SizedBox(height: 2),
                  ],
                ),
                decoration: BoxDecoration(
//                color: Colors.white,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 8, top: 0),
            child: Container(
              color: Colors.grey.withOpacity(0.6),
              height: widget.available == 'notAvailable' ? 265 : 0,
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
        widget.mrp != null
            ? Positioned(
                top: 0,
                left: 8,
                child: ClipPath(
                  clipper: MyStarClipper(),
                  child: Container(
                    height: 42,
                    width: 42,
                    alignment: Alignment.topLeft,
//              width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${offPercentage(widget.mrp, widget.amount)}%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                Text(
                                  'OFF',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      height: .9,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xffB5044C).withOpacity(0.9),
                        gradient: LinearGradient(
                            colors: [Color(0xffd6065b), Colors.red])),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
}

int offPercentage(int mrp, int price) {
  double p = ((mrp - price) * 100.0) / mrp;
  return p.toInt();
}
