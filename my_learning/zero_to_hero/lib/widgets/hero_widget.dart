import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: "hero1",
          child: AspectRatio(
            aspectRatio: 1920 / 1080,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                child: Image.asset("assets/1.jpg", fit: BoxFit.cover),
                width: 600,
              ),
            ),
          ),
        ),
        FittedBox(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              color: Colors.white60,
              letterSpacing: 50,
            ),
          ),
        ),
      ],
    );
  }
}
