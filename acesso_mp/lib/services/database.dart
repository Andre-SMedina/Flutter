import 'package:acesso_mp/models/model_visitors.dart';
import 'package:acesso_mp/services/convert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Future<void> register(ModelVisitors data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> list = prefs.getStringList('visitors') ?? [];
    bool ifContain = false;

    List<String> newList = list.map((elem) {
      List<String> elemList = elem.split(',');

      if (elemList[0] == data.name) {
        ifContain = true;

        return Convert.forString(data);
      }

      return elem;
    }).toList();

    if (!ifContain) {
      String visitor = Convert.forString(data);
      list.add(visitor);

      await prefs.setStringList('visitors', list);
    } else {
      await prefs.setStringList('visitors', newList);
    }
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
