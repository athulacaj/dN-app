import 'package:daily_needs/screens/Restaurants/ByItems/byItems.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class IndividualShop extends StatefulWidget {
  final String shopName;
  final Map details;
  final String itemName;
  final bool isClosed;
  IndividualShop(
      {this.shopName,
      this.details,
      @required this.itemName,
      @required this.isClosed});
  @override
  _IndividualShopState createState() => _IndividualShopState();
}

class _IndividualShopState extends State<IndividualShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//      appBar: AppBar(
//        title: Text('${widget.shopName}'),
//      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: RestaurantByItems(
              details: new Map.from(widget.details),
              shopName: widget.shopName,
              scaffoldKey: _scaffoldKey,
              fromWhere: 'shop',
              isClosed: widget.isClosed,
            ),
          ),
        ],
      ),
    );
  }
}
