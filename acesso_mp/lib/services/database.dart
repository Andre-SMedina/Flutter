import 'package:acesso_mp/models/model_visitors.dart';
import 'package:acesso_mp/services/convert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Future<void> register(ModelVisitors data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // List<String>? list = prefs.getStringList('visitors');
    List<String> list = prefs.getStringList('visitors') ?? [];
    List<String> listVisited = prefs.getStringList('visited') ?? [];
    String visitor = Convert.forString(data);
    list.add(visitor);
    listVisited.add('${data.name}, ${data.whoVisit}');

    await prefs.setStringList('visitors', list);
    await prefs.setStringList('visited', listVisited);
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

    // print(Convert.forModel(list)[1].job);
    // print(list);
    // await prefs.clear();

    // Convert.forMap(list!);
  }
}
