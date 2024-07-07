import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldExampleApp extends StatelessWidget {
  const TextFormFieldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TextFormFieldExample(),
    );
  }
}

class TextFormFieldExample extends StatefulWidget {
  const TextFormFieldExample({super.key});

  @override
  State<TextFormFieldExample> createState() => _TextFormFieldExampleState();
}

class _TextFormFieldExampleState extends State<TextFormFieldExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 200,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(label: Text('Apenas números')),
              inputFormatters: [
                //permite apenas números
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ),
      ),
    );
  }
}
