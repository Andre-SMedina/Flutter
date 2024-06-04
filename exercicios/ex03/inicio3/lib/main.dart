import 'package:flutter/material.dart';
import 'package:inicio3/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gym App',
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
