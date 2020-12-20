import 'package:flutter/material.dart';

import 'ByItems/byItems.dart';
import 'cakeEception/cakeItems.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class IndividualShop extends StatefulWidget {
  final String shopName;
  final Map details;
  final String itemName;
  IndividualShop({this.shopName, this.details, @required this.itemName});
  @override
  _IndividualShopState createState() => _IndividualShopState();
}

class _IndividualShopState extends State<IndividualShop> {
  @override
  Widget build(BuildContext context) {
    print(widget.details);
    return Scaffold(
      key: _scaffoldKey,
//      appBar: AppBar(
//        title: Text('${widget.shopName}'),
//      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: widget.itemName == 'Bakery'
                ? CakeByItems(
                    details: widget.details,
                    shopName: widget.shopName,
                    fromWhere: 'shop',
                    scaffoldKey: _scaffoldKey,
                  )
                : ByItems(
                    details: widget.details,
                    shopName: widget.shopName,
                    scaffoldKey: _scaffoldKey,
                    fromWhere: 'shop',
                  ),
          ),
        ],
      ),
    );
  }
}
