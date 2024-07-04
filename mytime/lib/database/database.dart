import 'package:mytime/database/time_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'time.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute(TimeDao.tableSql);
  }, version: 1);
}
