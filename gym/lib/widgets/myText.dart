import 'package:flutter/material.dart';

class Mytext extends StatelessWidget {
  final String texto;

  const Mytext({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      style: const TextStyle(color: Colors.red),
      texto,
    );
  }
}
