import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({super.key, required this.addList});

  final Function(String) addList;

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  String _userTodo = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add todo"),
      content: TextField(
        onChanged: (String value) {
          _userTodo = value;
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.addList(_userTodo);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
