import 'package:flutter/material.dart';
import 'package:my_learning/pages/homepage.dart';
import 'package:my_learning/pages/todo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      theme: ThemeData(primarySwatch: Colors.yellow, primaryColor: Colors.yellow)

    );
  }
}
