import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({super.key, required this._taps, required this.increment, required this.decrement});

  final int _taps;
  final VoidCallback? increment;
  final VoidCallback decrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: decrement,
          child: Text("-"),
        ),
        Padding(padding: EdgeInsets.all(16.0),child:  Text(_taps.toString())),
        FilledButton(
          onPressed: increment,
          child: Text("+"),
        ),
      ],
    );
  }
}

