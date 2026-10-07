import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.title,
    required this.onDelete,
    required this.done,
    required this.check,
  });

  final String title;
  final VoidCallback onDelete;
  final bool done;
  final VoidCallback check;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(title),
      child: Card(
        child: ListTile(
          title: Text(title, style: done ? TextStyle(decoration: TextDecoration.lineThrough) : TextStyle()),
          trailing: IconButton(
            onPressed: () {
              check();
            },
            icon: Icon(
              done ? Icons.check_box : Icons.check_box_outline_blank_outlined,
              color: Colors.lightBlue,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        // if(direction == DismissDirection.startToEnd){}
        onDelete();
      },
    );
  }
}
