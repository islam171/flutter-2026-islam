import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController myController = TextEditingController();
  String greetingMessage = "";

  void greetUser() {
    setState(() {
    greetingMessage = myController.text;

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(greetingMessage),
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "task",
                ),
              ),
              ElevatedButton(onPressed: greetUser, child: Text("Tap")),
            ],
          ),
        ),
      ),
    );
  }
}
