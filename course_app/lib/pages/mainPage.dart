import 'package:course_app/course.dart';
import 'package:course_app/data.dart';
import 'package:course_app/pages/my_courses.dart';
import 'package:course_app/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;

  late List<Course> courses = List.empty();
  late List pages = [HomePage(courses: courses,), ProfilePage(),  MyCourses()];

  void navigatePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.courses = coursesData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Course")),
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "My courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: pageIndex,
        onTap: navigatePage,
      ),
    );
  }
}
