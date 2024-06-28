import 'package:alura/apps/app1/tarefas/form_screen.dart';
import 'package:alura/apps/app1/tarefas/task_inherited.dart';
import 'package:alura/apps/app1/tarefas_sql.dart';
import 'package:flutter/material.dart';

class InitTasks extends StatefulWidget {
  const InitTasks({super.key});

  @override
  State<InitTasks> createState() => _InitTasksState();
}

class _InitTasksState extends State<InitTasks> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      home: TaskInherited(child: const TarefasSql()),
      routes: {
        FormScreen.routeName: (context) => const FormScreen(),
        TarefasSql.routeName: (context) => const TarefasSql()
      },
    );
  }
}
