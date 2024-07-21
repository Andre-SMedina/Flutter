import 'package:acesso_mp/models/model_home_fields.dart';
import 'package:acesso_mp/models/model_visitors.dart';
import 'package:acesso_mp/services/database.dart';
import 'package:acesso_mp/widgets/my_dropdown.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Database db = Database();

  @override
  Widget build(BuildContext context) {
    // TextEditingController searchController = TextEditingController();

    ModelHomeFields nameField = ModelHomeFields(text: 'Nome');
    ModelHomeFields cpfField = ModelHomeFields(text: 'CPF');
    ModelHomeFields rgField = ModelHomeFields(text: 'RG');
    ModelHomeFields phoneField = ModelHomeFields(text: 'Telefone');
    ModelHomeFields jobField = ModelHomeFields(text: 'Profissão');
    ModelHomeFields whoVisitField = ModelHomeFields(text: 'Quem Visitar');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Controle de Visitantes'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: const MyDropdown(),
                // child: TextField(
                //   controller: searchController,
                //   autofocus: true,
                //   decoration: const InputDecoration(
                //     labelText: 'Nome',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
              ),
              const SizedBox(height: 16),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       //!Fazer verificações******************************
              //       db.get(searchController.text).then((onValue) {
              //         if (onValue != null) {
              //           nameField.loadData(onValue.name);
              //           cpfField.loadData(onValue.cpf);
              //           rgField.loadData(onValue.rg);
              //           phoneField.loadData(onValue.phone);
              //           jobField.loadData(onValue.job);
              //           whoVisitField.loadData(onValue.whoVisit);
              //         }
              //       });
              //     },
              //     child: const Text('Buscar Visitante'),
              //   ),
              // ),
              const SizedBox(
                height: 60,
                child: Divider(),
              ),
              Text(
                'Informações do Visitante',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 26),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        child: Column(
                          children: [
                            nameField,
                            cpfField,
                            rgField,
                            phoneField,
                            jobField,
                            whoVisitField,
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  db.register(ModelVisitors(
                                      name: nameField.fieldController.text,
                                      cpf: cpfField.fieldController.text,
                                      rg: rgField.fieldController.text,
                                      phone: phoneField.fieldController.text,
                                      job: jobField.fieldController.text,
                                      whoVisit:
                                          whoVisitField.fieldController.text));
                                },
                                child: const Text('Cadastrar'))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 360,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text('Imagem'),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Capturar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
