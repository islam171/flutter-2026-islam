import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/shell_screen.dart';

void main() {
  runApp(const CourseHubApp());
}

class CourseHubApp extends StatefulWidget {
  const CourseHubApp({super.key});

  @override
  State<CourseHubApp> createState() => _CourseHubAppState();
}

class _CourseHubAppState extends State<CourseHubApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Hub',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _themeMode,
      home: ShellScreen(
        themeMode: _themeMode,
        onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
      ),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}