import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_needs/functions/navigatorFunctions.dart';
import 'package:daily_needs/functions/shopCloseCheck.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../common/ViewCart_BottomNavBar.dart';
import 'individualShopItems.dart';

class ByShop extends StatelessWidget {
  final Map details;
  final String itemName;
  ByShop({this.details, @required this.itemName});
  @override
  Widget build(BuildContext context) {
    List shopMapList = details['shops'];
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: shopMapList.length,
            itemBuilder: (BuildContext context, int index) {
              Map shopMap = shopMapList[index];
              String _image = shopMapList[index]['image'];
              String _imageType = shopMapList[index]['imageType'];
              print(shopMap["products"]);

              return GestureDetector(
                onTap: () {
                  navigatorSlideAnimationFunction(
                      context,
                      IndividualShop(
                        itemName: itemName,
                        shopName: shopMap['name'],
                        details: shopMap,
                        isClosed: isClosed(shopMap['open'], shopMap['close'],
                            shopMap['name'], shopMap['automatic']),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Material(
                    color: Colors.white,
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Row(
                        children: <Widget>[
                          _image == null
                              ? Icon(Icons.shop,
                                  size: MediaQuery.of(context).size.width / 5,
                                  color: Colors.deepPurple)
                              : Container(
                                  width: 70,
                                  height: MediaQuery.of(context).size.width / 5,
                                  child: _imageType != 'offline'
                                      ? CachedNetworkImage(
                                          imageUrl: '$_image',
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              SpinKitThreeBounce(
                                            color: Colors.grey,
                                            size: 20.0,
                                          ),
                                        )
                                      : Image.asset(
                                          '$_image',
                                          fit: BoxFit.fill,
                                        )),
                          SizedBox(width: 10),
                          checkShopClosed(shopMap['open'], shopMap['close'],
                              shopMap['name'], shopMap['automatic'], context),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          child: ViewCartBottomNavigationBar(),
        ),
      ],
    );
  }
}
