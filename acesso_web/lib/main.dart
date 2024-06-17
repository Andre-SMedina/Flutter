import 'package:flutter/material.dart';
// import 'package:acesso_web/pages/home.dart';

void main() {
  // runApp(const Home());
  runApp(const Teste());
}

teste() {}

List<String> users = ['paulo', 'marcos', 'joao'];

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  List<String> users = ['Carla', 'Joao', 'Pedra'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextField(
              onChanged: search,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                    title: Text(user), onTap: () => print(users[index]));
              },
            ))
          ],
        ),
      ),
    );
  }

  void search(String query) {
    final suggestions = users.where((name) {
      final theName = name.toLowerCase();
      final input = query.toLowerCase();

      return theName.contains(input);
    }).toList();

    setState(() => users = suggestions);
  }
}

class DropdownWidget extends StatefulWidget {
  const DropdownWidget(this.entitiesList, this.callback, this.initialValue,
      {super.key});

  final Function(String) callback;
  final List<String> entitiesList;
  final String initialValue;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String _listSelected = '';
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          dropdownColor: Colors.grey,
          elevation: 0,
          iconSize: 34,
          isExpanded: true,
          icon: const Icon(
            Icons.expand_more_outlined,
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          items: widget.entitiesList.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  // style: AppFonts.bodyPlaceholder,
                ),
              );
            },
          ).toList(),
          // style: AppFonts.bodyPlaceholder,
          onChanged: (newValue) {
            _dropDownItemSelected(newValue!);
            setState(
              () {
                _listSelected = newValue;
              },
            );
          },
          value: isSelected ? _listSelected : widget.initialValue,
        ),
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(
      () {
        _listSelected = novoItem;
        isSelected = true;
        widget.callback(_listSelected);
      },
    );
  }
}
