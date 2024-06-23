import 'package:alura/apps/app1/tarefas.dart';
import 'package:alura/apps/app1/tarefas/form_screen.dart';
import 'package:alura/apps/app1/tarefas/task_inherited.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  // runApp(const MaterialApp(home: restaurante.Home()));
  // initialRoute: 'home',
  // onGenerateRoute: RouteGenerator.generateRoute,
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      home: TaskInherited(child: Tarefas()),
      routes: {FormScreen.routeName: (context) => const FormScreen()},
    );
  }
}
