import 'package:daily_needs/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'byshop.dart';
import 'ByItems/byItems.dart';
import 'cakeEception/cakeItems.dart';

TabController _tabController;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class CakesIceCreams extends StatefulWidget {
  final String title;
  final Map allDetails;
  CakesIceCreams({this.title, this.allDetails});
  @override
  _CakesIceCreamsState createState() => _CakesIceCreamsState();
}

class _CakesIceCreamsState extends State<CakesIceCreams>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    print(widget.allDetails);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Cakes & Ice Cream')),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 12, bottom: 3),
            alignment: Alignment.topLeft,
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorPadding: EdgeInsets.only(top: 15),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.0,
                    color: Colors.purple,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 10.0)),
              tabs: [
                SizedBox(
                  height: 25,
                  child: Text('Cakes', style: KTabTextStyle),
                ),
                SizedBox(
                  height: 25,
                  child: Text('Ice - Creams', style: KTabTextStyle),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ByShop(
                itemName: 'Bakery',
                // bakery bcz old version check if(name == bakery) go to cake exception page
                details: widget.allDetails['Cakes'],
              ),
              ByShop(
                itemName: 'IceCreams',
                details: widget.allDetails['IceCream'],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
