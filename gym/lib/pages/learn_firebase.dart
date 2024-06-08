import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LearnFirebase extends StatefulWidget {
  const LearnFirebase({super.key});

  @override
  State<LearnFirebase> createState() => _LearnFirebaseState();
}

class _LearnFirebaseState extends State<LearnFirebase> {
  List<String> listStrings = <String>['Nenhum elemento carregado!'];
  Uri url =
      Uri.https("gym-app-53a03-default-rtdb.firebaseio.com", "/words.json");
  TextEditingController inputText = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: (_isLoading)
              ? const CircularProgressIndicator()
              : RefreshIndicator(
                  onRefresh: () => _getListBack(),
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: inputText,
                        decoration: const InputDecoration(
                            labelText: "Insira uma palavra aqui"),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () => _addStringToBack(),
                          child: const Text(
                              style: TextStyle(color: Colors.white),
                              "Gravar no Firebase")),
                      for (String s in listStrings)
                        Text(textAlign: TextAlign.center, s)
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _getListBack() {
    return http.get(url).then((response) {
      Map<String, dynamic> map = jsonDecode(response.body);
      listStrings = [];
      map.forEach((key, value) {
        setState(() {
          listStrings.add(map[key]["word"]);
        });
      });
    });
  }

  void _addStringToBack() {
    setState(() {
      _isLoading = true;
    });
    http
        .post(
      url,
      body: jsonEncode(
        {"word": inputText.text},
      ),
    )
        .then((value) {
      _getListBack().then((value) {
        setState(() {
          _isLoading = false;
        });
        inputText.text = '';

        final snackbar =
            SnackBar(content: Text('Palavra registrada com sucesso!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    });
  }
}
