import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({super.key, required this.v});

  final VoidCallbackAction v;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.lightBlue,
      onPressed: () {
        v;
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
