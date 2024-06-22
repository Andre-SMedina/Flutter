import 'package:alura/apps/app1/tarefas/task_cards.dart';
import 'package:flutter/material.dart';

class Arguments {
  final List<TaskCards> taskList;
  final BuildContext taskContext;

  Arguments({required this.taskContext, required this.taskList});
}
