import 'package:course_app/components/CourseTile.dart';
import 'package:course_app/components/input.dart';
import 'package:course_app/course.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.courses});

  final List<Course> courses;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();


 List<Course> get filteredCourses{
   final query = searchController.text.trim().toLowerCase();
   return widget.courses.where((item) {
     final matchesSearch = query.isEmpty || item.title.toLowerCase().contains(query);
         return matchesSearch;
   }).toList();
 }

  @override
  Widget build(BuildContext context) {
   final filtered = filteredCourses;


    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Input(searchController: searchController),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                Course course = filtered[index];
                return CourseTile(course: course, onTap: (){},onFavorite: (){},);
              },
            ),
          ),
        ],
      ),
    );
  }
}
