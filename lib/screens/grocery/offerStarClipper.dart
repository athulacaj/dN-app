import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyStarClipper extends CustomClipper<Path> {
//  MyStarClipper(this.numberOfPoints);

  // The number of points of the star
  final int numberOfPoints = 15;

  @override
  Path getClip(Size size) {
    double width = size.width;

    double halfWidth = width / 2;

    double bigRadius = halfWidth;

    double radius = halfWidth / 1.25;

    double degreesPerStep = _degToRad(360 / numberOfPoints);

    double halfDegreesPerStep = degreesPerStep / 2;

    var path = Path();

    double max = 2 * math.pi;
    path.moveTo(width, halfWidth);

    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(halfWidth + bigRadius * math.cos(step),
          halfWidth + bigRadius * math.sin(step));
      path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  num _degToRad(num deg) => deg * (math.pi / 180.0);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    MyStarClipper oldie = oldClipper as MyStarClipper;
    return numberOfPoints != oldie.numberOfPoints;
  }
}
