import 'package:flutter/material.dart';
// import 'package:Gym/screens/cadastro_screen.dart';
import 'package:Gym/pages/login/login_page.dart';

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
      home: LoginPage(),
      // home: CadastroPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
