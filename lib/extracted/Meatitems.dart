import 'package:daily_needs/screens/meatFishBeef/FirstPageIndex.dart';
import 'package:flutter/material.dart';

class MeatContainer extends StatelessWidget {
  final String image;
  final String title;
  final String imageType;
  final Map brain;
  final scaffoldKey;
  MeatContainer(
      {this.image,
      this.title,
      this.imageType,
      this.brain,
      @required this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return ItemDetailsScreen(
            title: '$title',
            brain: brain,
          );
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset(0.0, 0.0);
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: Container(
//          height: 110,
          width: MediaQuery.of(context).size.width / 2 - 20,
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 25,
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.black26]),
              ),
              child: Text(
                '$title',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              )),
          decoration: BoxDecoration(
//                      borderRadius: BorderRadius.all(Radius.circular(12)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageType == 'offline'
                  ? AssetImage('$image')
                  : NetworkImage('$image'),
            ),
          ),
        ),
      ),
    );
  }
}
