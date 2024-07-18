import 'package:acesso_mp/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Acesso MP',
      theme: ThemeData(
          // primarySwatch: Colors.red,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 28),
            backgroundColor: Color.fromARGB(255, 14, 0, 167),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color.fromARGB(255, 14, 0, 167))),
            border: OutlineInputBorder(borderSide: BorderSide()),
          ),
          textTheme: const TextTheme(headlineLarge: TextStyle(fontSize: 20))),
      home: const HomePage(),
    );
  }
}
