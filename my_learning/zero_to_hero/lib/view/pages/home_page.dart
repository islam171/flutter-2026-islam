import 'package:flutter/material.dart';
import 'package:zero_to_hero/data/constant.dart';
import 'package:zero_to_hero/instance/lessons.dart';
import 'package:zero_to_hero/widgets/container_widget.dart';
import 'package:zero_to_hero/widgets/hero_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    List<Lesson> list = [
      Lesson(title: "title 1", desc: 'desc1', subject: 'subject1'),
      Lesson(title: "title 1", desc: 'desc1', subject: 'subject1'),
      Lesson(title: "title 1", desc: 'desc1', subject: 'subject1'),
      Lesson(title: "title 1", desc: 'desc1', subject: 'subject1'),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            HeroWidget(title: ""),
            ...List.generate(list.length, (index) {
              return ContainerWidget(item: list.elementAt(index)
              );
            }),
          ],
        ),
      ),
    );
  }
}

class Item{

  Item({required this.description, required this.title});

  final String title;
  final String description;
}

