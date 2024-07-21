import 'package:flutter/material.dart';

class ModelHomeFields extends StatelessWidget {
  final String text;
  ModelHomeFields({super.key, required this.text});

  final TextEditingController fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: fieldController,
        decoration: InputDecoration(
          labelText: text,
        ),
      ),
    );
  }

  void loadData(String text) {
    fieldController.text = text;
  }
}
