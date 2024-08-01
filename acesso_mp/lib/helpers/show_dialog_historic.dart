import 'package:flutter/material.dart';

Future<void> showDialogHistoric(
    BuildContext context, List<String> visitor) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Center(child: Text('Histórico de visitas')),
        content: ListView.builder(
            itemCount: visitor.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('testando'),
              );
            }),
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
