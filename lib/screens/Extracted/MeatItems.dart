import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_needs/functions/quantityFormat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    Key key,
    @required this.cartItems,
  }) : super(key: key);

  final List cartItems;

  @override
  Widget build(BuildContext context) {
    List<Widget> columChildren = addColumnChild(cartItems);
    return AnimationLimiter(
        child: Column(
      children: columChildren,
    )
//      ListView.builder(
//        shrinkWrap: true,
//        physics: const NeverScrollableScrollPhysics(),
//        padding: EdgeInsets.all(0),
//        itemCount: cartItems.length,
//        itemBuilder: (BuildContext context, int index) {
//          return AnimationConfiguration.staggeredList(
//            delay: Duration(milliseconds: 50),
//            position: index,
//            duration: const Duration(milliseconds: 400),
//            child: ScaleAnimation(
//              child: Container(
//                padding: const EdgeInsets.all(8.0),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    Container(
//                        height: 50,
//                        child: Row(
//                          children: <Widget>[
////                        Image.asset('${cartItems[index]['image']}'),
//                            SizedBox(width: 8),
//                            Expanded(
//                                child: Container(
//                                    height: double.infinity,
//                                    child: Column(
//                                      children: <Widget>[
//                                        SizedBox(
//                                          child: AutoSizeText(
//                                            '${cartItems[index]['name']}'
//                                                .split(':')[0],
//                                            maxLines: 1,
//                                            minFontSize: 13,
//                                            textAlign: TextAlign.left,
//                                          ),
//                                          width: double.infinity,
//                                        ),
//                                        SizedBox(height: 6),
//                                        Container(
//                                          alignment: Alignment.topLeft,
//                                          child: Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.spaceBetween,
//                                            children: <Widget>[
//                                              Text(
//                                                  '${quantityFormat(cartItems[index]['quantity'], cartItems[index]['unit'])}',
//                                                  style: TextStyle(
//                                                      color: Colors.black,
//                                                      fontSize: 14,
//                                                      fontWeight:
//                                                          FontWeight.w600)),
//                                              Text(
//                                                '₹${cartItems[index]['amount']}',
//                                                style: TextStyle(
//                                                    fontWeight:
//                                                        FontWeight.w600),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                      ],
//                                    ))),
//                            SizedBox(width: 12),
//                          ],
//                        )),
//                  ],
//                ),
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    border: Border(
//                      bottom: BorderSide(
//                          width: 0.5, color: Colors.grey.withOpacity(0.5)),
//                    )),
//              ),
//            ),
//          );
//        },
//      ),
        );
  }
}

List<Widget> addColumnChild(List cartItems) {
  List<Widget> toReturnColumn = [];
  for (int index = 0; index <= cartItems.length - 1; index++) {
    Widget toAdd = AnimationConfiguration.staggeredList(
      delay: Duration(milliseconds: 50),
      position: index,
      duration: const Duration(milliseconds: 400),
      child: ScaleAnimation(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
//                        Image.asset('${cartItems[index]['image']}'),
                      SizedBox(width: 8),
                      Expanded(
                          child: Container(
                              height: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: AutoSizeText(
                                      '${cartItems[index]['name']}'
                                          .split(':')[0],
                                      maxLines: 1,
                                      minFontSize: 13,
                                      textAlign: TextAlign.left,
                                    ),
                                    width: double.infinity,
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                            '${quantityFormat(cartItems[index]['quantity'], cartItems[index]['unit'])}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                          '₹${cartItems[index]['amount']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ))),
                      SizedBox(width: 12),
                    ],
                  )),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom:
                    BorderSide(width: 0.5, color: Colors.grey.withOpacity(0.5)),
              )),
        ),
      ),
    );
    toReturnColumn.add(toAdd);
  }
  return toReturnColumn;
}
