import 'package:acesso_mp/models/model_visitors.dart';
import 'package:acesso_mp/services/convert.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Future<bool> register(ModelVisitors data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> list = prefs.getStringList('visitors') ?? [];
    List<String> listManagementDate =
        prefs.getStringList('managementDate') ?? [];

    String dateNow = DateFormat('dd/MM/yyy HH:mm:ss').format(DateTime.now());

    bool found =
        list.any((elem) => elem.split(',')[0] == data.name.toLowerCase());

    if (!found) {
      String visitor = Convert.forString(data);
      String dayOfVisit = '${data.cpf},$dateNow';
      // String cpfLocated =
      //     listManagementDate.firstWhere((e) => e.contains(data.cpf));

      listManagementDate.add(dayOfVisit);
      list.add(visitor);

      await prefs.setStringList('visitors', list);
      await prefs.setStringList('managementDate', listManagementDate);
    }

    return found;
  }

  Future<bool> update(ModelVisitors data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('visitors') ?? [];

    bool found =
        list.any((elem) => Convert.firstUpper(elem.split(',')[0]) == data.name);

    if (found) {
      List<String> newList = list.map((elem) {
        List<String> elemList = elem.split(',');

        if (Convert.firstUpper(elemList[0]) == data.name) {
          return Convert.forString(data);
        }

        return elem;
      }).toList();

      await prefs.setStringList('visitors', newList);
    }

    return found;
  }

  Future<ModelVisitors?> get(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> list = prefs.getStringList('visitors') ?? [];
    List<ModelVisitors> listModels = Convert.forModel(list);
    // print(listModels[0].name);

    for (ModelVisitors entry in listModels) {
      if (entry.name == name) {
        return entry;
      }
    }

    return null;
  }
}
