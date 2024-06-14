import 'package:acesso_web/styles/colors.dart';
import 'package:acesso_web/widgets/list_users_layout.dart';
import 'package:acesso_web/widgets/register_layout.dart';
import 'package:flutter/material.dart';
import 'package:acesso_web/styles/my_texts.dart';
import 'package:acesso_web/widgets/input_decorations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nome = TextEditingController();

  final TextEditingController _cpf = TextEditingController();

  List<Map<String, dynamic>> listUsers = [
    {'nome': 'Paulo César Faria', 'profissao': 'Médico'},
    {'nome': 'Maria Vitória das Neves', 'profissao': 'Advogado'},
    {"nome": 'Carla Aparecida dos Santos', 'profissao': 'Desempregado'},
    {"nome": 'Carlos Carneiro Júnior', 'profissao': 'Contador'},
    {"nome": 'Pedro Rangel Moreira', 'profissao': 'Vendedor de carros'},
    {"nome": 'João Carlos Costa e Silva', 'profissao': 'Padeiro'}
  ];
  List<Map<String, dynamic>> showListUsers = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recepção',
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 47, 145),
          title: const Center(
            child: Text(
              'Controle de acesso às dependências do Ministério Público',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 214, 200, 5)),
            ),
          ),
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.azulEscuro),
              padding: const EdgeInsets.all(20),
              // color: const Color.fromARGB(255, 1, 72, 131),
              child: Column(
                children: [
                  Text(
                    'Identificação do visitante',
                    style: MyTexts.title,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          autofocus: true,
                          onChanged: (value) {
                            showListUsers = [];
                            for (var element in listUsers) {
                              if (_nome.text.length > 2 &&
                                  element['nome']
                                      .toString()
                                      .toUpperCase()
                                      .contains(_nome.text.toUpperCase())) {
                                setState(() {
                                  showListUsers.add(element);
                                });
                              }
                              if (_nome.text.length < 3) {
                                setState(() {
                                  showListUsers = [];
                                });
                              }
                            }
                          },
                          controller: _nome,
                          decoration: myInputDecoration('Nome'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              _cpf.text = '';
                              _nome.text = '';
                              setState(() {
                                showListUsers = [];
                              });
                            },
                            child: const Text(
                              'Limpar',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                  ListUsers(listUsers: showListUsers),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.white,
                        color: const Color.fromARGB(255, 2, 146, 182),
                        border: Border.all(color: Colors.black)),
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 35),
                          child: Text(
                            'Cadastro de Visitantes',
                            style: MyTexts.title,
                          ),
                        ),
                        RegisterLayout()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
