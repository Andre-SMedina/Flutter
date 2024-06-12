import 'package:flutter/material.dart';

class MyElevatedBtn extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const MyElevatedBtn(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        child: Text(
            style: const TextStyle(fontSize: 16, color: Colors.white), title));
  }
}
