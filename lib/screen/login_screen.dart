import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Center(
          child: Container(
            height: 30,
            width: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Start or join a meeting',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 38),
            child: Image.asset('assets/images/onboarding.jpg')),
        CustomButton(
          text: "Google Sign In",
          onPressed: () async {
            bool res = await _authMethods.signInWithGoogle(context);
            if (res) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
        ),
      ]),
    );
  }
}
