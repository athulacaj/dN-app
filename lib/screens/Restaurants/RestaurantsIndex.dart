import 'package:daily_needs/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'byshop.dart';

TabController _tabController;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RestaurantsIndex extends StatefulWidget {
  final String title;
  final Map allDetails;
  RestaurantsIndex({this.title, this.allDetails});
  @override
  _RestaurantsIndexState createState() => _RestaurantsIndexState();
}

class _RestaurantsIndexState extends State<RestaurantsIndex>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('${widget.title}')),
      body: Column(
        children: <Widget>[
          SizedBox(height: 6),
          Expanded(
            child: RestaurantByShop(
              itemName: widget.title,
              details: widget.allDetails,
            ),
          ),
        ],
      ),
    );
  }
}
