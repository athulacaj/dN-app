import 'package:flutter/material.dart';

class NotAvailablePage extends StatefulWidget {
  final String title;
  NotAvailablePage({this.title});
  @override
  _NotAvailablePageState createState() => _NotAvailablePageState();
}

class _NotAvailablePageState extends State<NotAvailablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/404.png'),
            ),
            SizedBox(height: 6),
            Text(
                "Sorry ${widget.title.toLowerCase()} currently not available "),
          ],
        ),
      ),
    );
  }
}
