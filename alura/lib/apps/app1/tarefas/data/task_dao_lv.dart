import 'dart:async';

import 'package:alura/apps/app1/tarefas/data/database.dart';
import 'package:alura/apps/app1/tarefas/task_cards.dart';
import 'package:sqflite/sqflite.dart';

class TaskDaoLv {
  static const String tableSql =
      'CREATE TABLE $_tableName($_taskName TEXT, $_lv DOUBLE)';

  static const String _tableName = 'lvTable';
  static const String _taskName = 'task';
  static const String _lv = 'lv';

  static Future save(String task, double lv) async {
    final Database db = await getDatabaseLv();
    var ifTaskExists = await find(task);
    Map<String, dynamic> taskMap = toMap(task, lv);

    if (ifTaskExists.isEmpty) {
      return await db.insert(_tableName, taskMap);
    } else {
      await db.update(_tableName, taskMap,
          where: '$_taskName = ?', whereArgs: [task]);
    }
  }

  static Future<List> findAll() async {
    final Database db = await getDatabaseLv();
    final List result = await db.query(_tableName);

    print(result);

    return toList(result);
  }

  static Future<List> find(String nameTask) async {
    final Database db = await getDatabaseLv();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_taskName = ?',
      whereArgs: [nameTask],
    );

    return toList(result);
  }

  static Future delete(String taskName) async {
    Database db = await getDatabaseLv();

    db.delete(
      _tableName,
      where: '$_taskName = ?',
      whereArgs: [taskName],
    );
  }

  static List toList(List listMapTasks) {
    final List tasks = [];

    for (Map<String, dynamic> linha in listMapTasks) {
      final Map task = {"task": linha[_taskName], "lv": linha[_lv]};
      tasks.add(task);
    }
    return tasks;
  }

  static Map<String, dynamic> toMap(String tarefa, double lv) {
    final Map<String, dynamic> mapTasks = {};

    mapTasks[_taskName] = tarefa;
    mapTasks[_lv] = lv;

    return mapTasks;
  }
}
