import 'package:flutter/material.dart';

mySnacbar(
    {required BuildContext context,
    required String texto,
    bool isErro = true}) {
  SnackBar snackbar = SnackBar(
    content: Text(texto),
    backgroundColor:
        (isErro) ? Colors.red : const Color.fromARGB(255, 33, 37, 243),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    action: SnackBarAction(
        textColor: Colors.white,
        label: "dispensar",
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
