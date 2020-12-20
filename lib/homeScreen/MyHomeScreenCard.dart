import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String image;
  final String title;
  final String imageType;
  MyCard({this.image, this.title, this.imageType});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      child: Container(
        height: MediaQuery.of(context).size.height / 5.7,
        width: MediaQuery.of(context).size.width / 2 - 24,
//          width: double.infinity,
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 45,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black12]),
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
            image: imageType == 'asset'
                ? AssetImage('$image')
                : NetworkImage('$image'),
          ),
        ),
      ),
    );
  }
}
