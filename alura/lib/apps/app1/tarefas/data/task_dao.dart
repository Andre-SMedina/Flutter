import 'dart:async';

import 'package:alura/apps/app1/tarefas/data/database.dart';
import 'package:alura/apps/app1/tarefas/task_cards.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql =
      'CREATE TABLE $_tableName($_taskName TEXT, $_difficulty INTEGER, $_image TEXT)';

  static const String _tableName = 'taskTable';
  static const String _taskName = 'task';
  static const String _difficulty = 'difficulty';
  static const String _image = 'urlImage';

  static Future save(Task tarefa) async {
    final Database db = await getDatabase();
    var ifTaskExists = await find(tarefa.task);
    Map<String, dynamic> taskMap = toMap(tarefa);

    if (ifTaskExists.isEmpty) {
      return await db.insert(_tableName, taskMap);
    } else {
      await db.update(_tableName, taskMap,
          where: '$_taskName = ?', whereArgs: [tarefa.task]);
    }
  }

  static Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    return toList(result);
  }

  static Future<List<Task>> find(String nameTask) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_taskName = ?',
      whereArgs: [nameTask],
    );

    return toList(result);
  }

  static Future delete(String taskName) async {
    Database db = await getDatabase();

    db.delete(
      _tableName,
      where: '$_taskName = ?',
      whereArgs: [taskName],
    );
  }

  static List<Task> toList(List<Map<String, dynamic>> listMapTasks) {
    final List<Task> tasks = [];

    for (Map<String, dynamic> linha in listMapTasks) {
      final Task task = Task(
          task: linha[_taskName],
          urlImage: linha[_image],
          difficulty: linha[_difficulty]);
      tasks.add(task);
    }

    return tasks;
  }

  static Map<String, dynamic> toMap(Task tarefa) {
    final Map<String, dynamic> mapTasks = Map();

    mapTasks[_taskName] = tarefa.task;
    mapTasks[_image] = tarefa.urlImage;
    mapTasks[_difficulty] = tarefa.difficulty;

    return mapTasks;
  }
}
