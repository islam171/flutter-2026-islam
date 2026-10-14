import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("ToDo list"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Main Screen", style: TextStyle(color: Colors.green)),
          ElevatedButton(onPressed: (){
            Navigator.pushReplacementNamed(context, "/todo");
          }, child: Text("Next"))
        ]
      )
    );
  }
}
