import 'package:flutter/material.dart';
import 'library_screen.dart';
import 'book.dart';

void main() {
  // Вывод отладочной информации из Level 1 перед запуском runApp
  debugPrint('${totalPages(seed)} pages, ${unread(seed).length} unread');
  debugPrint(Book.fromMap({'title': 'X', 'author': 'Y', 'pages': 10}).toString());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    home: const LibraryScreen(),
  );
}