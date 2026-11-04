import 'package:flutter/material.dart';
import 'package:zero_to_hero/widgets/hero_widget.dart';

import '../widget_tree.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String confirmedEmail = "123";
  String confirmedPassword = "456";

  void onLoginPressed() {
    if (confirmedEmail == controllerEmail.text &&
        confirmedPassword == controllerPassword.text) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login or password are incorrect"),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, BoxConstraints  constraints) {
                return FractionallySizedBox(
                  widthFactor: width > 500 ? 0.5 : 1.00,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (HeroWidget(title: widget.title)),
                      SizedBox(height: 20),
                      TextField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: 'Email',
                        ),
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: 'Password',
                        ),
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 10),
                      FilledButton(
                        onPressed: () {
                          onLoginPressed();
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: Size(double.infinity, 40.0),
                        ),
                        child: Text(widget.title),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
