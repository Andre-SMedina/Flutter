import 'package:alura/apps/app1/tarefas/task_cards.dart';
import 'package:flutter/material.dart';

class Tarefas extends StatefulWidget {
  const Tarefas({super.key});

  @override
  State<Tarefas> createState() => _Desafio1State();
}

class _Desafio1State extends State<Tarefas> {
  // This widget is the root of your application.
  double show = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                  color: Color.fromARGB(255, 250, 198, 28),
                  onPressed: () {
                    setState(() {
                      show = (show == 1) ? 0 : 1;
                    });
                  },
                  icon: (show == 1)
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off)),
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
          child: ListView(
            children: const [
              TaskCards(
                  urlImage: 'assets/images/flutter.png',
                  task: 'Aprender Flutter ajsd lkj akj dhlaksj '),
              TaskCards(
                  urlImage: 'assets/images/dart.png', task: 'Aprender Dart'),
              TaskCards(
                  urlImage: 'assets/images/java.png', task: 'Aprender java'),
              TaskCards(
                  urlImage: 'assets/images/flutter.png',
                  task: 'Aprender Flutter'),
              TaskCards(
                  urlImage: 'assets/images/dart.png', task: 'Aprender Dart'),
              TaskCards(
                  urlImage: 'assets/images/java.png', task: 'Aprender java'),
              TaskCards(
                  urlImage: 'assets/images/flutter.png',
                  task: 'Aprender Flutter'),
              TaskCards(
                  urlImage: 'assets/images/dart.png', task: 'Aprender Dart'),
              TaskCards(
                  urlImage: 'assets/images/java.png', task: 'Aprender java'),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add)),
      ),
    );
  }
}
