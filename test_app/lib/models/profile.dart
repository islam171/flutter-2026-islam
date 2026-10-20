import 'package:flutter/material.dart';

@immutable
class Profile {
  const Profile({
    required this.name,
    required this.group,
  });

  final String name;
  final String group;

  // R3: Profile.empty() named constructor
  Profile.empty()
      : name = 'Student',
        group = 'CS-201';

  Profile copyWith({
    String? name,
    String? group,
  }) {
    return Profile(
      name: name ?? this.name,
      group: group ?? this.group,
    );
  }
}