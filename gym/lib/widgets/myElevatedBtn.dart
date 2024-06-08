import 'package:flutter/material.dart';

class MyElevatedBtn extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const MyElevatedBtn(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(title));
  }
}
