import 'package:daily_needs/screens/CartPage/cartPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class ViewCartBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<IsInList>(builder: (context, isInList, child) {
      var _allDetailsList = isInList.allDetails ?? [];
      var totalAmount = isInList.totalAmount ?? 0;
      return Material(
        child: InkWell(
          onTap: () async {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
              return CartPage();
            }, transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
//              var begin = Offset(0.0, 1.0);
//              var end = Offset(0.0, 0.0);
//              var tween = Tween(begin: begin, end: end);
//              var offsetAnimation = animation.drive(tween);
              return FadeTransition(
                opacity: animation,
//                position: offsetAnimation,
                child: child,
              );
            }));
          },
          child: AnimatedContainer(
              color: Colors.purple[400],
              duration: Duration(milliseconds: 200),
              height: _allDetailsList.length < 1 ? 0 : 48,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 12),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '₹ $totalAmount',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${_allDetailsList.length} ${_allDetailsList.length >= 2 ? 'ITEMS' : 'ITEM'} ',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    'VIEW CART',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                  SizedBox(width: 12),
                ],
              )),
          splashColor: Colors.white70,
        ),
      );
    });
  }
}
