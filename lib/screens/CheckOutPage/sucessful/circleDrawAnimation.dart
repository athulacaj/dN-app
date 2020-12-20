import 'dart:math';

import 'package:flutter/material.dart';

class CircleDraw extends StatefulWidget {
  @override
  _CircleDrawState createState() => _CircleDrawState();
}

class _CircleDrawState extends State<CircleDraw>
    with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> _animation;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    delayFunction();
  }

  void delayFunction() async {
    await Future.delayed(Duration(milliseconds: 50));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CustomPaint(
            painter: CirclePainter(fraction: _fraction),
            child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 100),
                duration: Duration(milliseconds: 1200),
                curve: Curves.fastOutSlowIn,
                builder: (BuildContext context, double size, Widget child) {
                  return Icon(
                    Icons.check,
                    color: Colors.white,
                    size: size,
                  );
                }),
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final double fraction;
  var _circlePaint;

  CirclePainter({this.fraction}) {
    _circlePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset(0.0, 0.0) & size;

    canvas.drawArc(rect, -pi / 2, pi * 2 * fraction, false, _circlePaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
