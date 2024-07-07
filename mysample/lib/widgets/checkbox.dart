import 'package:flutter/material.dart';

class MyCheckbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Seleção de Checkbox Único'),
        ),
        body: Center(
          child: CheckboxGroup(),
        ),
      ),
    );
  }
}

class CheckboxGroup extends StatefulWidget {
  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Opção 1'),
          value: 'Option 1',
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Opção 2'),
          value: 'Option 2',
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Opção 3'),
          value: 'Option 3',
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Opção 4'),
          value: 'Option 4',
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value!;
            });
          },
        ),
      ],
    );
  }
}
