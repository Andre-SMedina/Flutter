import 'package:alura/apps/app1/tarefas/arguments.dart';
import 'package:alura/apps/app1/tarefas/form_screen.dart';
import 'package:alura/apps/app1/tarefas/task_cards.dart';
import 'package:alura/apps/app1/tarefas/task_inherited.dart';
import 'package:flutter/material.dart';

class Tarefas extends StatefulWidget {
  Tarefas({super.key});

  final List<TaskCards> taskList = [
    const TaskCards(
        urlImage: 'assets/images/flutter.png',
        task: 'Aprender Flutter todos os dias'),
    const TaskCards(urlImage: 'assets/images/dart.png', task: 'Aprender Dart'),
    const TaskCards(urlImage: 'assets/images/java.png', task: 'Aprender java'),
    const TaskCards(
        urlImage: 'assets/images/flutter.png', task: 'Aprender Flutter'),
    const TaskCards(
        urlImage: 'assets/images/person.jpg', task: 'Aprender inglês'),
  ];

  @override
  State<Tarefas> createState() => _Tarefas();
}

class _Tarefas extends State<Tarefas> {
  // This widget is the root of your application.
  double show = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
                color: const Color.fromARGB(255, 250, 198, 28),
                onPressed: () {
                  setState(() {
                    show = (show == 1) ? 0 : 1;
                  });
                },
                icon: (show == 1)
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
          )
        ],
        leading: const Icon(
          Icons.task,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'Tarefas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: AnimatedOpacity(
        opacity: show,
        duration: const Duration(milliseconds: 600),
        // ignore: prefer_const_literals_to_create_immutables
        child: ListView(children: widget.taskList),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, FormScreen.routeName,
                arguments:
                    Arguments(taskList: widget.taskList, taskContext: context));
          },
          child: const Icon(Icons.add)),
    );
  }
}
