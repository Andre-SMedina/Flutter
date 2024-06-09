import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            "assets/images/halter.png",
            height: 128,
          ),
          const Text(
            textAlign: TextAlign.center,
            'GymApp',
            style: TextStyle(
                fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
