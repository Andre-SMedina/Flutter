import 'package:acesso_mp/helpers/show_dialog_msg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageData {
  static void authorized(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? checked = prefs.getString('visitor');
    if (checked != null && checked != '') {
      List<String> visitor = prefs.getString('visitor')!.split(',');

      List<String> dates = prefs.getStringList('managementDate') ?? [];

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

      showDialogMsg(context, 'Autorização registrada!');
    }
  }
}
