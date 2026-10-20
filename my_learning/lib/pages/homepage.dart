import 'package:flutter/material.dart';
import 'package:my_learning/util/dialog_box.dart';
import 'package:my_learning/util/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final _controller = TextEditingController();

  void saveNewTask(){
    Navigator.of(context).pop();
    setState(() {
      toDoList.add([_controller.text, false]);
    });
  }

  List toDoList = [
    ["go to Shop", false],
    ["go to Gym", false],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void addToDo() {
    showDialog(context: context, builder: (context){
      return DialogBox(controller: _controller, onCancel: () => Navigator.of(context).pop(), onSave: saveNewTask,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO"),
        elevation: 0,
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) => TodoTile(
          taskName: toDoList[index][0],
          completed: toDoList[index][1],
          onChanged: (value) => checkBoxChanged(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: addToDo, child: Icon(Icons.add)),
    );
  }
}
