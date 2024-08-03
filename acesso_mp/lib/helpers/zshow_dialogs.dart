import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZshowDialogs {
  static Future<void> historic(
      BuildContext context, List<String> visitor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? checked = prefs.getString('visitor');

    if (checked != null && checked != '') {
      List<String> listHistoric = prefs.getStringList('managementDate') ?? [];
      var visitorHistoric = listHistoric
          .where((e) {
            return e.contains(visitor[1]);
          })
          .toList()[0]
          .split(',');

      visitorHistoric.removeAt(0);

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Histórico de visitas')),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap:
                      true, // Permite que a lista ocupe o espaço mínimo necessário
                  itemCount:
                      visitorHistoric.length, // Número de elementos na lista
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(
                          Icons.arrow_back), // Ícone opcional para cada item
                      title: Text(
                          'Registro de entrada: ${visitorHistoric[index]}'),
                    );
                  },
                ),
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    }
  }

  static Future<void> alert(BuildContext context, String titleMsg) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titleMsg),
          actions: [
            Center(
              child: ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
