import 'package:flutter/material.dart';

import 'game.dart';
import 'week02/models.dart';
import 'week02/class.dart';
import 'week02/catalogue.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
          appBar: AppBar(
              title: Text("App"),
              centerTtile: true
          ),
          body: Text(
            "Hello app",
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontFamily: 'Arial',
            ),
          ),
        )
    );
  }
}
