import 'package:flutter/material.dart';

enum CourseCategory {
  programming('Programming', Icons.code),
  design('Design', Icons.brush),
  dataScience('Data Science', Icons.analytics),
  business('Business', Icons.business_center),
  languages('Languages', Icons.language);

  const CourseCategory(this.label, this.icon);
  final String label;
  final IconData icon;

  Color getColor(ColorScheme scheme) {
    return switch (this) {
      CourseCategory.programming => scheme.primary,
      CourseCategory.design => scheme.secondary,
      CourseCategory.dataScience => scheme.tertiary,
      CourseCategory.business => scheme.outline,
      CourseCategory.languages => scheme.error,
    };
  }
}

@immutable
class Item {
  const Item({
    required this.title,
    required this.category,
    required this.when,
    required this.limit,
    required List<String> names,
    required this.mode,
    this.optionalText,
    this.favourite = false,
  }) : _names = names;

  final String title;
  final CourseCategory category;
  final DateTime when;
  final int limit;
  final List<String> _names;
  final bool mode;
  final String? optionalText;
  final bool favourite;

  List<String> get names => List.unmodifiable(_names);


  int get count => _names.length;
  int get freePlaces => limit - count;
  bool get isFull => count >= limit;
  bool get isPast => when.isBefore(DateTime.now());
  bool contains(String name) => _names.contains(name);

  ({int taken, int free}) get places => (taken: count, free: freePlaces);

  Item.empty()
      : title = '',
        category = CourseCategory.programming,
        when = DateTime.now().add(const Duration(days: 1)),
        limit = 20,
        _names = const [],
        mode = false,
        optionalText = null,
        favourite = false;

  Item copyWith({
    String? title,
    CourseCategory? category,
    DateTime? when,
    int? limit,
    List<String>? names,
    bool? mode,
    String? optionalText,
    bool? favourite,
  }) {
    return Item(
      title: title ?? this.title,
      category: category ?? this.category,
      when: when ?? this.when,
      limit: limit ?? this.limit,
      names: names ?? this._names,
      mode: mode ?? this.mode,
      optionalText: optionalText ?? this.optionalText,
      favourite: favourite ?? this.favourite,
    );
  }
}