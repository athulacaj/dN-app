import 'package:daily_needs/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'byshop.dart';
import 'ByItems/byItems.dart';
import 'cakeEception/cakeItems.dart';

TabController _tabController;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class FruitsVegetablesIndex extends StatefulWidget {
  final String title;
  final Map allDetails;
  FruitsVegetablesIndex({this.title, this.allDetails});
  @override
  _FruitsVegetablesIndexState createState() => _FruitsVegetablesIndexState();
}

class _FruitsVegetablesIndexState extends State<FruitsVegetablesIndex>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('${widget.title}')),
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
                  child: Text('By shop', style: KTabTextStyle),
                ),
                // SizedBox(
                //   height: 25,
                //   child: Text('By items', style: KTabTextStyle),
                // ),
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
                itemName: widget.title,
                details: widget.allDetails['${widget.title}'],
              ),
              // widget.title == 'Bakery'
              //     ? CakeByItems(
              //         details: widget.allDetails['${widget.title}'],
              //         scaffoldKey: _scaffoldKey,
              //       )
              //     : ByItems(
              //         details: widget.allDetails['${widget.title}'],
              //         scaffoldKey: _scaffoldKey,
              //       ),
            ],
          )),
        ],
      ),
    );
  }
}
