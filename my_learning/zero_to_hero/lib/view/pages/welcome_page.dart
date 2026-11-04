import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zero_to_hero/view/pages/login_page.dart';
import 'package:zero_to_hero/view/widget_tree.dart';
import 'package:zero_to_hero/widgets/hero_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: Lottie.asset('assets/lottie/rio.json'),
                  ),
                  FittedBox(
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        letterSpacing: 50.0,
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage(title: "Register");
                          },
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: Size(double.infinity, 40.0),
                    ),
                    child: Text("Get Started"),
                  ),
                  SizedBox(height: 10,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage(title: "Login",);
                          },
                        ),
                      );
                    },
                    child: Text("Login"),
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 40)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
