import 'package:alura/apps/app1/tarefas/data/task_dao.dart';
import 'package:alura/apps/app1/tarefas/data/task_dao_lv.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  //local onde será salvo o arquivo task.db
  final String path = join(await getDatabasesPath(), 'task.db');
  // await deleteDatabase(path);

  //tenta abrir o banco, se ele não existir, será criado.
  return openDatabase(path, onCreate: (db, version) {
    db.execute(TaskDao.tableSql);
  }, version: 1);
}

Future<Database> getDatabaseLv() async {
  //local onde será salvo o arquivo task.db
  final String path = join(await getDatabasesPath(), 'tasklv.db');

  //tenta abrir o banco, se ele não existir, será criado.
  return openDatabase(path, onCreate: (db, version) {
    db.execute(TaskDaoLv.tableSql);
  }, version: 1);
}
