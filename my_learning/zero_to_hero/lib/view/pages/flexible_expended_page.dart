import 'package:flutter/material.dart';

class FlexibleExpendedPage extends StatelessWidget {
  const FlexibleExpendedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.teal,
                  height: 50.0,
                  child: Text("hello"),
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.orange,
                  height: 50.0,
                  child: Text("hello"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  color: Colors.orange,
                  height: 50.0,
                  child: Text("hello"),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.teal,
                  height: 50.0,
                  child: Text("hello"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
