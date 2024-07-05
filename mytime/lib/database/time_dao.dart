import 'package:mytime/database/database.dart';
import 'package:sqflite/sqflite.dart';

class TimeDao {
  static const String tableSql =
      'CREATE TABLE $_tableName($_type BOOL, $_oldTimeTxt STRING, $_oldTimeDt STRING, $_timeTotalTxt STRING, $_timeTotalGeral STRING, $_registers STRING, $_historic STRING)';

  static const String _tableName = 'timeTable';
  static const String _type = 'type';
  static const String _oldTimeTxt = 'oldTimeTxt';
  static const String _oldTimeDt = 'oldTimeDt';
  static const String _timeTotalTxt = 'timeTotalTxt';
  static const String _timeTotalGeral = 'timeTotalGeral';
  static const String _registers = 'registers';
  static const String _historic = 'historic';

  static Future save(Map<String, dynamic> mapTime) async {
    final Database db = await getDatabase();
  }
}
