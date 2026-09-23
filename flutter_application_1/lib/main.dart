import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(
      home: MainPage(),
    ));

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("My app"),
          centerTitle: true,
          backgroundColor: Colors.green
      ),
      body: SafeArea(
          child: Row(
              children:[
                Column(
                    children: [
                      CircleAvatar(
                          backgroundImage: AssetImage("assets/avatar.png")
                      ),
                      Text("ISLAM KABDEN"),
                    ]
                )]
          )
      ),
    );
  }
}
