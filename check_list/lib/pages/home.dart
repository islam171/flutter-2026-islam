import "package:check_list/item.dart";
import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _userTodo = "";

  List todoList = [
  ];

  @override
  void initState() {
    super.initState();


  }

  void checkTheBox(int index) {
    setState(() {
      todoList[index]['done'] = !todoList[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("ToDo list"), centerTitle: true),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Item(
            title: todoList[index]['text'],
            onDelete: () {
              setState(() {
                todoList.removeAt(index);
              });
            },
            done: todoList[index]['done'],
            check: (){
              checkTheBox(index);
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add todo"),
                content: TextField(
                  onChanged: (String value) {
                    _userTodo = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todoList.add({"text":_userTodo, "done": false});
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
