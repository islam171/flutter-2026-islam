import 'package:flutter/material.dart';
import 'package:my_learning/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;


  const DialogBox({super.key, required this.controller, required this.onCancel, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add some todo",
              ),
            ),
            const SizedBox(height: 20,),
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(text: "Cancel", onPressed: onCancel),
                MyButton(text: "Save", onPressed: onSave),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
