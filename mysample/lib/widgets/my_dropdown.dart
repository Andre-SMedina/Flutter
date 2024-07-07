import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class MyDropdown extends StatelessWidget {
  const MyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dropdown com Pesquisa'),
        ),
        body: const Center(
          child: DropdownWithSearch(),
        ),
      ),
    );
  }
}

class DropdownWithSearch extends StatefulWidget {
  const DropdownWithSearch({super.key});

  @override
  _DropdownWithSearchState createState() => _DropdownWithSearchState();
}

class _DropdownWithSearchState extends State<DropdownWithSearch> {
  final TextEditingController _typeAheadController = TextEditingController();
  final List<String> _items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grape',
    'Lemon',
    'Mango',
    'Nectarine',
    'Banani',
    'Banano',
  ];

  List<String> _getSuggestions(String query) {
    if (query.length < 3) {
      return [];
    }

    return _items.where((item) {
      return item.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: _typeAheadController,
          decoration: const InputDecoration(
            labelText: 'Pesquisar',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: (pattern) {
          return _getSuggestions(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSuggestionSelected: (suggestion) {
          _typeAheadController.text = suggestion;
        },
        noItemsFoundBuilder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Nenhum item encontrado',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 18.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
