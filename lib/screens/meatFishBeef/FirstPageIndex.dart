import 'package:daily_needs/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../provider.dart';
import 'FishEXception/dart/FishDetailsGeneralPage.dart';
import 'itemDetailsGeneralPage.dart';

var _details;
TabController _tabController;
List<Widget> _nameListWidget = [];
List<Widget> tabBarViewChildren = [];
bool _showSpinner = false;

class ItemDetailsScreen extends StatefulWidget {
  final String title;
  final brain;
  ItemDetailsScreen({this.title, this.brain});
  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _nameListWidget = [];
    tabBarViewChildren = [];
    _details = widget.brain['allInfo']['${widget.title}'];
    int _tabIndex = findIndex(widget.brain['menuItems'], widget.title);
    _nameListWidget = getList(widget.brain['menuItems']);
    _tabController =
        TabController(length: widget.brain['menuItems'].length, vsync: this);
    _tabController.index = _tabIndex;
    setState(() {});
  }

  List getList(List listMap) {
    List<Widget> nameListWidget = [];
    for (Map menuMap in listMap) {
      SizedBox toAdd = SizedBox(
        height: 25,
        child: Text('${menuMap['title']}', style: KTabTextStyle),
      );
      nameListWidget.add(toAdd);
      if (menuMap['title'] == 'Seafood') {
        Widget page = FishDetailsGeneralPage(
            details: widget.brain['allInfo']['${menuMap['title']}']);
        tabBarViewChildren.add(page);
      } else {
        ItemDetailsGeneralPage page = ItemDetailsGeneralPage(
            details: widget.brain['allInfo']['${menuMap['title']}']);
        tabBarViewChildren.add(page);
      }
    }
    return nameListWidget;
  }

  int findIndex(List listMap, String item) {
    List list = [];
    for (Map menuMap in listMap) {
      list.add(menuMap['title']);
    }
    return list.indexWhere((note) => note.startsWith(item));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: RefreshProgressIndicator(),
      inAsyncCall: _showSpinner,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white.withOpacity(0.95),
        body: Stack(
          children: <Widget>[
            Container(height: 50, color: Colors.purple),
            SafeArea(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  width: 30,
                                  height: 35,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black87.withOpacity(0.65),
                                    size: 25,
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 7),
                                height: 50,
                                width: double.infinity,
                                color: Colors.white,
                                child: TabBar(
                                  isScrollable: true,
                                  labelColor: Colors.black,
                                  unselectedLabelColor:
                                      Colors.grey.withOpacity(0.9),
                                  indicatorPadding: EdgeInsets.only(top: 15),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  controller: _tabController,
                                  onTap: (index) async {
                                    _showSpinner = true;
                                    setState(() {});
                                    await Future.delayed(
                                        Duration(milliseconds: 700));
                                    _showSpinner = false;
                                    _tabController.index = index;
                                    setState(() {});
                                  },
                                  indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                        width: 3.0,
                                        color: Colors.purple[400],
                                      ),
                                      insets: EdgeInsets.symmetric(
                                          horizontal: 16.0)),
                                  tabs: _nameListWidget,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: tabBarViewChildren,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
}
