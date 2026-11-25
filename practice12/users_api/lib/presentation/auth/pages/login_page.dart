import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_api/features/auth/auth_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _loginText(),
            SizedBox(height: 20),
            _emailField(context),
            SizedBox(height: 20),
            _passwordField(context),
            SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              context.read<AuthModel>().login("hello", "fdsf");
            }, child: Text("Login"))
          ],
        ),
      ),
    );
  }
}


Widget _loginText() {
  return const Text(
    "Login",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    textAlign: TextAlign.center,
  );
}

Widget _fullNameField(BuildContext context) {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Full Name',
      labelText: "Full Name",
      prefixText: "",
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

Widget _emailField(BuildContext context) {
  return TextField(
    decoration: InputDecoration(labelText: 'Email')
        .applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

Widget _passwordField(BuildContext context) {
  return TextField(
    decoration: InputDecoration(labelText: 'Password')
        .applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}