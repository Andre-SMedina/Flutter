class TimeDao {
  static const String tableSql =
      'CREATE TABLE $_tableName($_toggleBtn BOOL, $_oldTimeTxt STRING, $_oldTimeDt STRING)';

  static const String _tableName = 'timeTable';
  static const String _toggleBtn = 'toggleBtn';
  static const String _oldTimeTxt = 'oldTimeTxt';
  static const String _oldTimeDt = 'oldTimeDt';
}
