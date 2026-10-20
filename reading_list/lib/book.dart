import 'package:flutter/foundation.dart';

class Book {
  Book({
    required this.title,
    required this.author,
    required this.pages,
    this.year,
    this.read = false,
  });

  final String title;
  final String author;
  final int pages;
  final int? year;
  bool read;

  // Именованный конструктор без использования оператора !
  Book.fromMap(Map<String, dynamic> m)
      : title = m['title'] as String,
        author = m['author'] as String,
        pages = m['pages'] as int,
        year = m['year'] as int?,
        read = m['read'] as bool? ?? false;

  @override
  String toString() {
    // Если год присутствует, выводим его в скобках, иначе скрываем
    final yearString = year != null ? ' ($year)' : '';
    return '$title — $author, $pages pp.$yearString';
  }
}

// Функции для обработки коллекций
int totalPages(List<Book> books) {
  return books.fold(0, (sum, b) => sum + b.pages);
}

List<Book> unread(List<Book> books) {
  return books.where((b) => !b.read).toList();
}

List<String> authors(List<Book> books) {
  return books.map((b) => b.author).toSet().toList();
}