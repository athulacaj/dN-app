import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/extracted/Meatitems.dart';
import 'file:///C:/Users/attaramackal/AndroidStudioProjects/daily_needs/lib/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:daily_needs/homeScreen/Carousel.dart';
import '../../common/ViewCart_BottomNavBar.dart';

bool _showSpinner = true;
List _menuItems = [];
FirebaseFirestore _firestore = FirebaseFirestore.instance;
List _ad = [
  'https://firebasestorage.googleapis.com/v0/b/daily-needs-a9c69.appspot.com/o/ads%2Fchicken%2F2.jpg?alt=media&token=1b6d7b1a-3c3f-4772-847d-f4e5157bec60'
];

class MeatPage extends StatefulWidget {
  final Map brain;
  final List meatAds;
  MeatPage({this.brain, this.meatAds});
  @override
  _MeatPageState createState() => _MeatPageState();
}

class _MeatPageState extends State<MeatPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _showSpinner = false;
    _menuItems = widget.brain['menuItems'];
//    showSpinnerFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      progressIndicator: RefreshProgressIndicator(),
      inAsyncCall: _showSpinner,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Poultry, Fish & Meat'),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 30),
            ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 10000),
//                height: getGridLength(_menuItems.length),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _menuItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio:
                          ((size.width / 2) / (size.height / 4.5)),
                    ),
                    itemBuilder: (context, index) {
                      return _menuItems != []
                          ? Container(
                              child: MeatContainer(
                                  title: _menuItems[index]['title'],
                                  image: _menuItems[index]['image'],
                                  imageType: _menuItems[index]['imageType'],
                                  scaffoldKey: _scaffoldKey,
                                  brain: widget.brain),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            )
                          : Container(
                              color: Colors.white,
                            );
                    },
                  ),
                )),
            SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: -20,
                    top: -5,
                    width: MediaQuery.of(context).size.width + 30,
                    child: Container(
                      alignment: Alignment.topLeft,
//                      color: Colors.purple.withOpacity(0.045),
                      width: MediaQuery.of(context).size.width,
                      child: ComplicatedImageDemo(widget.meatAds),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ViewCartBottomNavigationBar(),
      ),
    );
  }
}

double getGridLength(int noOfItems) {
  double a = noOfItems / 2;
  int b = a.round();
  return 133.0 * b;
}
