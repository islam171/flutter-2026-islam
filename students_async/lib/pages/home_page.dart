import 'package:flutter/material.dart';
import 'package:students_async/pages/students_page.dart';
import 'package:students_async/pages/countdown_screen.dart';
import 'package:students_async/pages/students_future_screen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => StudentsPage())),
              child: Text("by hand"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => StudentsFutureScreen())),
              child: Text("FutureBuilder"),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => CountdownScreen())),
              child: Text("CountDown"),
            ),
          ],
        ),
      ),
    );
  }
}
