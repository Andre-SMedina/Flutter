import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String message) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('A plicação apresentou um erro!'),
        content: Text(message),
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
