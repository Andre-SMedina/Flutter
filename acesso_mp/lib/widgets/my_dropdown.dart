import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key});

  @override
  MyDropdownState createState() => MyDropdownState();
}

class MyDropdownState extends State<MyDropdown> {
  TextEditingController searchController = TextEditingController();
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
      child: TypeAheadField(
        controller: searchController,
        emptyBuilder: (context) => const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Nenhum resultado encontrado'),
        ),
        builder: (context, controller, focusNode) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Pesquisar'),
          );
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        suggestionsCallback: (search) {
          return _getSuggestions(search);
        },
        onSelected: (suggestion) {
          searchController.text = suggestion;
        },
      ),
    );
  }
}
