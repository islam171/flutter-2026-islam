import "package:check_list/dialog.dart";
import "package:check_list/item.dart";
import "package:check_list/pages/todo_detail_page.dart";
import "package:flutter/material.dart";

class Todo {
  String title;
  String desc;
  bool done;

  Todo(this.title, this.done, this.desc);

  void toggleDone() {
    done = !done;
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List todoList = [];

  @override
  void initState() {
    super.initState();
  }

  void checkTheBox(int index) {
    setState(() {
      todoList[index].done = true;
    });
  }

  void addTodo(String value) {
    setState(() {
      todoList.add(Todo(value, false, ""));
    });
  }

  void delete(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void showD() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialog(addList: addTodo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Item(
            title: todoList[index].title,
            onDelete: () => delete(index),
            done: todoList[index].done,
            check: () => checkTheBox(index),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => DetailScreen(todo: todoList[index])
              )
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: showD,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
