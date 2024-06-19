// import 'package:alura/desafios/desafio1/desafio1.dart';
// import 'package:alura/apps/navigation/route_generator.dart';
// import 'package:alura/apps/restaurante_app/screens/home.dart' as restaurante;
import 'package:alura/apps/navigation/favorites_navigation.dart';
import 'package:alura/apps/navigation/home_navigation.dart';
import 'package:alura/apps/navigation/page2.dart';
import 'package:flutter/material.dart';

void main() {
  // runApp(const MaterialApp(home: restaurante.Home()));
  runApp(const MyApp(
      // initialRoute: 'home',
      // onGenerateRoute: RouteGenerator.generateRoute,
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotas',
      initialRoute: '/',
      home: const HomeNavigation(),
      routes: {Page2.routeName: (context) => Page2()},
    );
  }
}
