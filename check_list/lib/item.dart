import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.title,
    required this.onDelete,
    required this.done,
    required this.check,
    required this.onTap
  });

  final String title;
  final VoidCallback onDelete;
  final bool done;
  final VoidCallback check;
  final VoidCallback onTap;

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
          onTap: onTap,
        ),
      ),
      onDismissed: (direction) {
        // if(direction == DismissDirection.startToEnd){}
        onDelete();
      },
    );
  }
}
