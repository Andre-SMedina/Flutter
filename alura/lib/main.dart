// import 'package:alura/desafios/desafio1/desafio1.dart';
import 'package:alura/apps/navigation/route_generator.dart';
// import 'package:alura/apps/restaurante_app/screens/home.dart' as restaurante;
import 'package:flutter/material.dart';

void main() {
  // runApp(const MaterialApp(home: restaurante.Home()));
  runApp(const MaterialApp(
    initialRoute: 'home',
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
