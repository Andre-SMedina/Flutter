import 'package:alura/apps/app1/tarefas/task_cards.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required super.child});

  List<TaskCards> taskList = [
    TaskCards(
        dificulty: 2,
        urlImage: 'assets/images/flutter.png',
        task: 'Aprender Flutter todos os dias'),
    TaskCards(
        dificulty: 1,
        urlImage: 'assets/images/dart.png',
        task: 'Aprender Dart'),
    TaskCards(
        dificulty: 3,
        urlImage: 'assets/images/java.png',
        task: 'Aprender java'),
    TaskCards(
        dificulty: 4,
        urlImage: 'assets/images/flutter.png',
        task: 'Aprender Flutter'),
    TaskCards(
        dificulty: 5,
        urlImage: 'assets/images/flutter.png',
        task: 'Aprender Flutter'),
    TaskCards(
        dificulty: 1,
        urlImage: 'assets/images/flutter.png',
        task: 'Aprender Flutter'),
    TaskCards(
        dificulty: 2,
        urlImage: 'assets/images/flutter.png',
        task: 'Aprender Flutter'),
    TaskCards(
        dificulty: 2,
        urlImage: 'assets/images/person.jpg',
        task: 'Aprender inglês'),
  ];

  void newTask(int dificulty, String task, String urlImage) {
    taskList
        .add(TaskCards(dificulty: dificulty, task: task, urlImage: urlImage));
  }

  static TaskInherited? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  static TaskInherited? of(BuildContext context) {
    final TaskInherited? result = maybeOf(context);
    assert(result != null, 'No TaskInherited found in context');
    return result;
  }

  @override
  bool updateShouldNotify(covariant TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
