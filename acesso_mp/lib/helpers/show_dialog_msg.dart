import 'package:flutter/material.dart';

Future<void> showDialogMsg(BuildContext context, String titleMsg) async {
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
