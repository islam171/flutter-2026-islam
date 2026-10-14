import 'package:flutter/material.dart';
import 'package:screens_lead/routes.dart';
import 'package:screens_lead/students.dart';

import 'detail_screen.dart';
import 'edti_screen.dart';
import 'students_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    initialRoute: Routes.students,
    routes: {Routes.students: (_) => const StudentsScreen()},
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case Routes.student:
          final s = settings.arguments as Student;
          return MaterialPageRoute(builder: (_) => DetailScreen(student: s));
        case Routes.edit:
          final s = settings.arguments as Student;
          return MaterialPageRoute<String>(builder: (_) => EditScreen(student: s));
      }

      return null;
    },
  );
}
