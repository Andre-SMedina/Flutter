// import 'package:acesso_mp/models/model_home_fields.dart';
import 'package:acesso_mp/services/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDropdown extends StatefulWidget {
  final VoidCallback loadData;
  const MyDropdown({
    super.key,
    required this.loadData,
  });

  @override
  MyDropdownState createState() => MyDropdownState();
}

class MyDropdownState extends State<MyDropdown> {
  TextEditingController searchController = TextEditingController();
  List<String> filterList = [];
  List<String> visitedList = [];

  Future<List<String>> _getSuggestions(String query) async {
    if (query.length < 3) {
      return [];
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('visitors') ?? [];
    filterList = items.where((item) {
      // remove o nome do visitado para não entrar na pesquisa quando digitar
      String outVisited = item.split(',').sublist(0, 5).join(',');
      //remove os acentos das palavras para pesquisa
      outVisited = Convert.removeAccent(outVisited);
      return outVisited.contains(Convert.removeAccent(query.toLowerCase()));
    }).toList();

    List<String> listDropdown = filterList.map((item) {
      return Convert.firstUpper(item.split(',')[0]);
    }).toList();

    return listDropdown;
  }

  void foundVisitor(String suggestion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataVisitor = filterList.firstWhere((item) {
      return item.contains(suggestion.toLowerCase());
    });
    prefs.setString('visitor', dataVisitor);
    searchController.text = '';
    widget.loadData();
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
          foundVisitor(suggestion);
        },
      ),
    );
  }
}
