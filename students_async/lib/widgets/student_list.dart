import 'package:flutter/material.dart';
import 'package:students_async/fake_api.dart';

class StudentList extends StatelessWidget {
  const StudentList({
    super.key,
    required this._students,
    required this.compact,
  });

  final List<Student> _students;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _students.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("${_students[index].name}"),
          subtitle: Text("${_students[index].group}"),
          trailing: Text("${_students[index].gpa ?? 0}", style: TextStyle(fontSize: 20),),

        );
      },
    );
  }
}
