import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageData {
  static void authorized(List<String> visitor) async {
    if (visitor.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> dates = prefs.getStringList('managementDate') ?? [];
      if (prefs.getString('visitor') != null) {
        visitor = prefs.getString('visitor')!.split(',');
      }

      List<String> newDate = dates.map((e) {
        List<String> listDate = e.split(',');

        if (listDate[0] == visitor[1]) {
          String dateNow =
              DateFormat('dd/MM/yyy HH:mm:ss').format(DateTime.now());
          listDate.add(dateNow);
          return listDate.join(',');
        }
        return e;
      }).toList();

      prefs.setStringList('managementDate', newDate);
    }
  }
}
