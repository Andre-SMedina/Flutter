import 'package:alura/apps/app1/tarefas/task_cards.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required super.child});

  List<TaskCards> taskList = [
    TaskCards(
        urlImage: 'assets/images/flutter.png',
        task: 'Aprender Flutter todos os dias'),
    TaskCards(urlImage: 'assets/images/dart.png', task: 'Aprender Dart'),
    TaskCards(urlImage: 'assets/images/java.png', task: 'Aprender java'),
    TaskCards(urlImage: 'assets/images/flutter.png', task: 'Aprender Flutter'),
    TaskCards(urlImage: 'assets/images/flutter.png', task: 'Aprender Flutter'),
    TaskCards(urlImage: 'assets/images/flutter.png', task: 'Aprender Flutter'),
    TaskCards(urlImage: 'assets/images/flutter.png', task: 'Aprender Flutter'),
    TaskCards(urlImage: 'assets/images/person.jpg', task: 'Aprender inglês'),
  ];

  void newTask(String task, String urlImage) {
    taskList.add(TaskCards(task: task, urlImage: urlImage));
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
