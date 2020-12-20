import 'package:flutter/material.dart';

InputDecoration textFieldDecoration = InputDecoration(
    border:
        new OutlineInputBorder(borderSide: new BorderSide(color: Colors.teal)),
//  hintText: 'Search for test',
    prefixIcon: Icon(Icons.search),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purple.withOpacity(0.8), width: 1.0),
    ));
