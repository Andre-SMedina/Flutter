import 'package:flutter/material.dart';

class HomeFields extends StatelessWidget {
  final String text;
  const HomeFields({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          labelText: text,
        ),
      ),
    );
  }
}
