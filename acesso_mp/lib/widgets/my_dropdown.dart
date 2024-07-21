import 'package:acesso_mp/models/model_home_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDropdown extends StatefulWidget {
  final ModelHomeFields name;
  final ModelHomeFields cpf;
  final ModelHomeFields rg;
  final ModelHomeFields phone;
  final ModelHomeFields job;
  final ModelHomeFields whoVisit;
  const MyDropdown(
      {super.key,
      required this.name,
      required this.cpf,
      required this.rg,
      required this.phone,
      required this.job,
      required this.whoVisit});

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
    List<String> visitedItems = prefs.getStringList('visited') ?? [];
    filterList = items.where((item) {
      return item.toLowerCase().contains(query.toLowerCase());
    }).toList();
    visitedList = visitedItems.where((item) {
      return item.toLowerCase().contains(query.toLowerCase());
    }).toList();

    List<String> listDropdown = filterList.map((item) {
      return item.split(',')[0];
    }).toList();

    return listDropdown;
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
          var dataVisitor = filterList.firstWhere((item) {
            return item.contains(suggestion);
          }).split(',');
          var dataVisited = visitedList.firstWhere((item) {
            return item.contains(suggestion);
          }).split(',');

          // print(dataVisitor[0]);
          widget.name.loadData(dataVisitor[0]);
          widget.cpf.loadData(dataVisitor[1]);
          widget.rg.loadData(dataVisitor[2]);
          widget.phone.loadData(dataVisitor[3]);
          widget.job.loadData(dataVisitor[4]);
          widget.whoVisit.loadData(dataVisited[1]);
        },
      ),
    );
  }
}
