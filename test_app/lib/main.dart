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

// R11 & R22: Dynamic theme management without external packages
class _CourseHubAppState extends State<CourseHubApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  ThemeMode get themeMode => _themeMode;

  @override
  void setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Hub',
      debugShowCheckedModeBanner: false,
      // R22: ColorScheme.fromSeed for light and dark themes
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
      initialRoute: Routes.shell,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}