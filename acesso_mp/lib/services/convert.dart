import 'package:acesso_mp/models/model_visitors.dart';

class Convert {
  static String forString(ModelVisitors list) {
    return '${list.name}, ${list.cpf}, ${list.rg}, ${list.phone}, ${list.job}';
  }

  static List<ModelVisitors> forModel(List<String> list) {
    List<ModelVisitors> listVisitors = [];

    for (String entry in list) {
      List<String> listSplit = entry.split(',');

      listVisitors.add(ModelVisitors(
          name: listSplit[0],
          cpf: listSplit[1],
          rg: listSplit[2],
          phone: listSplit[3],
          job: listSplit[4],
          whoVisit: listSplit[5]));
    }

    return listVisitors;
  }
}
