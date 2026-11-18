import 'package:course_app/common/widgets/button/basic_app_button.dart';
import 'package:course_app/core/configs/assets/app_image.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImage.intro),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: Image.asset(AppImage.logo),
                      width: 100,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 300,
                    child: Text(
                      "Learn new skills, Build your future",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 21),
                  Text(
                    "Learn new skills, Build your future",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 21),
                  BasicAppButton(
                    onPress: () {},
                    height: 50.0,
                    title: 'Get Started',
                  ),
                ],
              ),
            ),
          ),
          // Container(color: Colors.black.withOpacity(0.15)),
        ],
      ),
    );
  }
}
