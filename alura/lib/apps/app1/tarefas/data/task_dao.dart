import 'dart:async';

import 'package:alura/apps/app1/tarefas/data/database.dart';
import 'package:alura/apps/app1/tarefas/task_cards.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql =
      'CREATE TABLE $_tablename($_name TEXT, $_difficulty INTEGER, $_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  Future save(TaskCards tarefa) async {
    print('Iniciando o save: ');

    final Database db = await getDatabase();
    var ifTaskExists = await find(tarefa.task);

    if (ifTaskExists.isEmpty) {
      print('A tarefa não existia');

      return await db.insert(_tablename, values);
    } else {
      print('A tarefa já existe');

      await db.update(_tablename, values,
          where: '$_name = ?', whereArgs: [tarefa.task]);
    }
  }

  Future<List<TaskCards>> findAll() async {
    print('Acessando o findAll');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablename);
    print(result);

    return toList(result);
  }

  Future<List<TaskCards>> find(String nameTask) async {
    print('Acessando find');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nameTask],
    );

    print('Tarefa encontrada: ${toList(result)}');

    return toList(result);
  }

  Future delete(String taskName) async {}

  List<TaskCards> toList(List<Map<String, dynamic>> listMapTasks) {
    print('Convertendo toList...');
    final List<TaskCards> tasks = [];

    for (Map<String, dynamic> linha in listMapTasks) {
      final TaskCards task = TaskCards(
          task: linha[_name],
          urlImage: linha[_image],
          difficulty: linha[_difficulty]);
      tasks.add(task);
    }

    print(tasks);

    return tasks;
  }

  Map<String, dynamic> toMap(TaskCards tarefa) {
    print('Convertendo tarefa em Map');

    final Map<String, dynamic> mapTasks = Map();

    mapTasks['task'] = tarefa.task;
    mapTasks['urlImage'] = tarefa.urlImage;
    mapTasks['difficulty'] = tarefa.difficulty;
  }
}
