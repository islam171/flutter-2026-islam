import 'package:course_app/course.dart';
import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onTap, required this.onFavorite});

  final Course course;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(color: Colors.red[400], borderRadius: BorderRadius.circular(5)),
                child: Center(child: Text(course.category.name, style: TextStyle(color: Colors.white),)),

              ),
            ],
          ),
        ],
      ),
    );
  }
}
