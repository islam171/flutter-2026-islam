import "package:flutter/material.dart";
import "package:profile_sscreen/profile_header.dart";

void main() => runApp(MaterialApp(
  home: HomePage(),
));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My profile")
      ),
      body: ProfileHeader(name: "Islam", university: "KBTU"),
    );
  }
}
