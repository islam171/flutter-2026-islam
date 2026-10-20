import 'course.dart';

final List<Course> coursesData = [
  Course(
    title: "Math",
    category: Category.unt,
    create_at: DateTime.now(),
    limit: 10,
    mode: false,
    topics: ["numbers", 'operations'],
  ),
  Course(
    title: "History of Kazakhstan",
    category: Category.unt,
    create_at: DateTime.now(),
    limit: 10,
    mode: false,
    topics: ["Сақтар", 'Түрік қағанаты'],
  ),
  Course(
    title: "Python fundamentals",
    category: Category.programming,
    create_at: DateTime.now(),
    limit: 10,
    mode: false,
    topics: ['Loops', 'Variables'],
  ),
];
