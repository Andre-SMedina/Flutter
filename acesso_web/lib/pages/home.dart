import 'package:flutter/material.dart';
import 'package:acesso_web/styles/texts.dart';
import 'package:acesso_web/widgets/input_decorations.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cpf = TextEditingController();

  final TextEditingController _rg = TextEditingController();

  List<String> users = [
    'Paulo Céser Faria',
    'Maria Vitória das Neves',
    'Carla Aparecida dos Santos',
    'Carlos Carneiro Júnior'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recepção',
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: const Center(
            child: Text(
              'Controlole de acesso às dependências do Ministério Público',
              style: TextStyle(color: Colors.white),
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
                  color: const Color.fromARGB(255, 1, 72, 131)),
              padding: const EdgeInsets.all(20),
              // color: const Color.fromARGB(255, 1, 72, 131),
              child: Column(
                children: [
                  Text(
                    'Identificação do visitante',
                    style: Texts.title,
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
                          onChanged: (value) {},
                          controller: _cpf,
                          decoration: myInputDecoration('CPF'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _rg,
                          decoration: myInputDecoration('RG'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _cpf.text = '';
                              _rg.text = '';
                            },
                            child: const Text('Limpar')),
                      ],
                    ),
                  ),
                  const TextField(
                    // readOnly: true,
                    expands: false,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
