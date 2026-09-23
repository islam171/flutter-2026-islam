import "package:flutter/material.dart";
import "package:profile_sscreen/info_row.dart";

import "data.dart";

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.name, required this.university});

  final String name;
  final String university;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/avatar.jpg"),
              radius: 70,
            ),
            Text(name),
            Text(university),
            for(var fact in facts)
              InfoRow(label: fact.label, value: fact.value)
          ],
        ))
    );
  }
}
