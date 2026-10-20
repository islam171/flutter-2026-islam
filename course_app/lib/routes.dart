import 'package:course_app/course.dart';
import 'package:course_app/pages/detailPage.dart';
import 'package:course_app/pages/formPage.dart';
import 'package:course_app/pages/mainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String shell = '/';
  static const String detail = '/detail';
  static const String form = '/form';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case shell:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case detail:
        final args = settings.arguments as DetailScreenArgs;
        return MaterialPageRoute(
          builder: (_) => DetailPage(
            course: args.course,
            onUpdate: args.onUpdate,
            onDelete: args.onDelete,
            profileName: args.profileName,
            onSwitchTab: args.onSwitchTab,
          ),
        );
      case form:
        final course = settings.arguments as Course;
        return MaterialPageRoute<Course>(
          builder: (_) => FormPage(initialItem: course),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: const Center(child: Text("Not Found")),
          ),
        );
    }
  }
}

class DetailScreenArgs {
  DetailScreenArgs({
    required this.course,
    required this.onUpdate,
    required this.onDelete,
    required this.profileName,
    required this.onSwitchTab,
  });

  final Course course;
  final ValueChanged<Course> onUpdate;
  final VoidCallback onDelete;
  final String profileName;
  final ValueChanged<int> onSwitchTab;
}
