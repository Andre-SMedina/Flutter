import 'package:alura/apps/app1/tarefas/arguments.dart';
import 'package:alura/apps/app1/tarefas/form_screen.dart';
import 'package:alura/apps/app1/tarefas/task_inherited.dart';
import 'package:flutter/material.dart';

class TarefasInherited extends StatefulWidget {
  const TarefasInherited({super.key});

  @override
  State<TarefasInherited> createState() => _TarefasInherited();
}

class _TarefasInherited extends State<TarefasInherited> {
  // This widget is the root of your application.
  double show = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          IconButton(
              color: const Color.fromARGB(255, 250, 198, 28),
              onPressed: () {
                setState(() {
                  show = (show == 1) ? 0 : 1;
                });
              },
              icon: (show == 1)
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off)),
        ],
        leading: const Icon(
          Icons.task,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.blue,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tarefas',
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 160,
                  child: LinearProgressIndicator(
                    color: Colors.blue[900],
                    value: 0.9,
                  ),
                ),
                const Text(
                  'Level: 3.00',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
      body: AnimatedOpacity(
        opacity: show,
        duration: const Duration(milliseconds: 600),
        // ignore: prefer_const_literals_to_create_immutables
        child: ListView(
            padding: const EdgeInsets.only(bottom: 70),
            children: TaskInherited.of(context)!.taskList),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, FormScreen.routeName,
                arguments: Arguments(taskContext: context));
          },
          child: const Icon(Icons.add)),
    );
  }
}
