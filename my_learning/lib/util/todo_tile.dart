import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool completed;
  Function(bool?)? onChanged;

  TodoTile({
    super.key,
    required this.taskName,
    required this.completed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:20, right: 20, top: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(this.taskName, style: TextStyle(decoration: this.completed ? TextDecoration.lineThrough : TextDecoration.none),),
            Checkbox(value: this.completed, onChanged: this.onChanged),
          ],
        ),
      ),
    );
  }
}
