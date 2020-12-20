import 'package:daily_needs/common/ViewCart_BottomNavBar.dart';
import 'package:daily_needs/common/cartBadge.dart';
import 'package:daily_needs/constants/constants.dart';
import 'package:daily_needs/screens/CartPage/cartPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'individualItems.dart';

ScrollController _scrollController;
bool _showSearchIndication = false;
bool _loaded = false;
bool _hasItems = false;

class GroceryItems extends StatefulWidget {
  final Map itemDetails;
  final String title;
  final int searchedIndex;
  final int tabIndex;
  final bool searched;
  final List ad;
  final bool available;
  GroceryItems(
      {this.itemDetails,
      this.title,
      this.searched,
      @required this.ad,
      this.searchedIndex,
      this.available,
      this.tabIndex});
  @override
  _GroceryItemsState createState() => _GroceryItemsState();
}

TabController _tabController;
bool _showSpinner = false;

class _GroceryItemsState extends State<GroceryItems>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _loaded = true;
    try {
      if (widget.itemDetails != null) {
        _hasItems = true;
        _tabController = TabController(
            length: widget.itemDetails['category'].length, vsync: this);
      } else {
        _hasItems = false;
//      _tabController = TabController(
//          length: widget.itemDetails['category'].length, vsync: this);
      }
    } catch (e) {
      _hasItems = false;
    }

    _scrollController = new ScrollController();
    if (widget.searched == true) {
      _showSearchIndication = true;
      _tabController.index = widget.tabIndex;
      scrollToIndex(widget.searchedIndex);
    }
    super.initState();
  }

  List<Widget> generateTabs() {
    List<Widget> toReturn = [];
    for (var category in widget.itemDetails['category']) {
      Widget toadd =
          SizedBox(height: 25, child: Text('$category', style: KTabTextStyle));
      toReturn.add(toadd);
    }
    return toReturn;
  }

  void scrollToIndex(int index) async {
    int i = index == 0
        ? index
        : index == 1
            ? index - 1
            : index.isEven
                ? index - 1
                : index - 2;
    await Future.delayed(Duration(milliseconds: 300));
    _scrollController.animateTo(
      (380.0 * i),
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _loaded = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List categoryList = widget.itemDetails['category'];
    var size = MediaQuery.of(context).size;
    List _category = widget.itemDetails['category'];
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      key: _scaffoldKey,
      body: _hasItems == true
          ? SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(height: 50, color: Colors.purple),
                  Column(
                    children: <Widget>[
                      Container(
                        color: Colors.purple,
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  width: 30,
                                  height: 35,
                                  color: Colors.purple,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                height: 50,
                                width: double.infinity,
                                color: Colors.purple,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                            ),
                            CartBadge(),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 7),
                        height: 50,
                        width: double.infinity,
                        color: Colors.purple,
                        child: TabBar(
                          isScrollable: true,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white,
                          indicatorColor: Colors.white,
                          indicatorPadding: EdgeInsets.only(top: 15),
                          indicatorSize: TabBarIndicatorSize.tab,
                          controller: _tabController,
                          onTap: (index) async {
//                      _showSpinner = true;
//                      setState(() {});
//                      await Future.delayed(Duration(milliseconds: 700));
//                      _showSpinner = false;
                            _tabController.index = index;
                            setState(() {});
                          },
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 3.0,
                                color: Colors.white,
                              ),
                              insets: EdgeInsets.symmetric(horizontal: 10.0)),
                          tabs: generateTabs(),
                        ),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: ListView(
                          controller: _scrollController,
                          padding: EdgeInsets.all(0),
                          children: [
                            widget.ad.length > _tabController.index
                                ? Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    height: 100,
                                    width: double.infinity,
                                    child: Image.network(
                                      widget.ad[_tabController.index],
                                      fit: BoxFit.fitWidth,
                                    ))
                                : Container(),
                            SizedBox(height: 8),
                            _loaded == true
                                ? ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxHeight: 10000),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: AnimationLimiter(
                                        child: GridView.count(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 0,
                                          crossAxisSpacing: 0,
                                          childAspectRatio:
                                              ((size.width / 2) / 280),
                                          children: List.generate(
                                            widget
                                                .itemDetails[_category[
                                                    _tabController.index]]
                                                .length,
                                            (int index) {
                                              Map items = widget.itemDetails[
                                                  _category[_tabController
                                                      .index]][index];
                                              return AnimationConfiguration
                                                  .staggeredGrid(
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 100),
                                                columnCount: widget
                                                    .itemDetails[_category[
                                                        _tabController.index]]
                                                    .length,
                                                child: ScaleAnimation(
                                                  child: FadeInAnimation(
                                                    child: _showSearchIndication ==
                                                                true &&
                                                            index ==
                                                                widget
                                                                    .searchedIndex
                                                        ? IndividualItem(
                                                            image:
                                                                '${items['image']}',
                                                            tag: items['tag'],
                                                            imageType:
                                                                '${items['imageType']}',
                                                            title:
                                                                '${items['name']}',
                                                            amount:
                                                                items['amount'],
                                                            quantity: items[
                                                                'quantity'],
                                                            unit:
                                                                '${items['unit']}',
                                                            available:
                                                                '${items['available']}',
                                                            index: index,
                                                            mrp: items['mrp'],
                                                            selectedThis: true,
                                                            scaffoldkey:
                                                                _scaffoldKey,
                                                          )
                                                        : IndividualItem(
                                                            image:
                                                                '${items['image']}',
                                                            tag: items['tag'],
                                                            imageType:
                                                                '${items['imageType']}',
                                                            title:
                                                                '${items['name']}',
                                                            amount:
                                                                items['amount'],
                                                            mrp: items['mrp'],
                                                            quantity: items[
                                                                'quantity'],
                                                            unit:
                                                                '${items['unit']}',
                                                            available:
                                                                '${items['available']}',
                                                            index: index,
                                                            scaffoldkey:
                                                                _scaffoldKey,
                                                          ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: ViewCartBottomNavigationBar(),
                      ),
                    ],
                  ),
                  _showSearchIndication
                      ? GestureDetector(
                          onTap: () {
                            _showSearchIndication = false;
                            setState(() {});
                          },
                          onHorizontalDragStart: (details) {
                            _showSearchIndication = false;
                            setState(() {});
                          },
                          onVerticalDragStart: (details) {
                            _showSearchIndication = false;
                            setState(() {});
                          },
                          child: Container(
                              height: double.infinity,
                              color: Colors.transparent,
                              width: double.infinity))
                      : Container()
                ],
              ),
            )
          : Container(
              child: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/404.png'),
                ),
              ),
            ),
    );
  }
}
