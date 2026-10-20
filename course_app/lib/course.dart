import 'package:flutter/material.dart';

class Course {
  const Course({
    required this.title,
    required this.category,
    required this.create_at,
    required this.limit,
    required this.mode,
    required List<String> topics,
    this.description,
    this.favorite = false,
  }) : _topics = topics;

  final String title;
  final Category category;
  final DateTime create_at;
  final int limit;
  final String? description;
  final bool mode;
  final List<String> _topics;
  final bool favorite;

  List<String> get topics => List.unmodifiable(_topics);

  int get counts => _topics.length;

  bool contains(String name) => title.contains(name);

  Course.empty()
    : title = "",
      category = Category.programming,
      create_at = DateTime.now(),
      limit = 0,
      mode = false,
      _topics = [],
      description = "",
      favorite = false;

  Course copyWith({
    String? title,
    Category? category,
    DateTime? create_at,
    int? limit,
    bool? mode,
    List<String>? topics,
    String? description,
  }) {
    return Course(
      title: title ?? this.title,
      category: category ?? this.category,
      create_at: create_at ?? this.create_at,
      limit: limit ?? this.limit,
      mode: mode ?? this.mode,
      topics: topics ?? this.topics,
      description: description ?? this.description,
    );
  }
}

enum Category {
  programming('Programming', Icons.code),
  design("Design", Icons.brush),
  dataScience("Data science", Icons.analytics),
  business("Business", Icons.business_center),
  language("language", Icons.language),
  unt('unt', Icons.book);

  const Category(this.label, this.icon);

  final String label;
  final IconData icon;

  Color getColor(ColorScheme scheme) {
    return switch (this) {
      Category.programming => scheme.primary,
      Category.design => scheme.secondary,
      Category.dataScience => scheme.tertiary,
      Category.business => scheme.outline,
      Category.language => scheme.error,
      Category.unt => scheme.outlineVariant
    };
  }
}

class Profile {
  const Profile({required this.name, required this.group});

  final String name;
  final String group;

  Profile.empty() : name = "", group = "";

  Profile copyWith({String? name, String? group}) {
    return Profile(name: name ?? this.name, group: group ?? this.group);
  }
}
