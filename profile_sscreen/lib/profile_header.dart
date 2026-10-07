import "package:flutter/material.dart";
import "package:profile_sscreen/info_row.dart";

import "data.dart";

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.university,
  });

  final String name;
  final String university;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
                radius: 70,
              ),
              Text(name),
              Text(university),
              for (var fact in facts)
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // padding: EdgeInsets.all(16.0),
                  child: InfoRow(label: fact.label, value: fact.value),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
