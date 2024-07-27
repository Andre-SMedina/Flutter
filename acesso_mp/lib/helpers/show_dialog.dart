import 'package:flutter/material.dart';

Future<void> showErrorDialog(
    BuildContext context, String titleMsg, String message) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titleMsg),
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
