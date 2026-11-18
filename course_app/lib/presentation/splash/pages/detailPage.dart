import 'package:flutter/cupertino.dart';

import '../course.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.course,
    required this.onUpdate,
    required this.onDelete,
    required this.profileName,
    required this.onSwitchTab});

  final Course course;
  final ValueChanged<Course> onUpdate;
  final VoidCallback onDelete;
  final String profileName;
  final ValueChanged<int> onSwitchTab;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
