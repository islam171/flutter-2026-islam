import 'package:flutter/material.dart';

class Badge1 extends StatelessWidget {
  const Badge1({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -2,
      bottom: -2,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.error,
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
            width: 2,
          ),
        ),
        child: Text(text, style: TextStyle(color: Theme.of(context).colorScheme.onError, fontSize: 11), textAlign: TextAlign.center),
      ),
    );
  }
}
