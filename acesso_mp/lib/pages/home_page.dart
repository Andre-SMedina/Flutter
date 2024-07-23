import 'package:acesso_mp/main.dart';
import 'package:acesso_mp/models/model_home_fields.dart';
import 'package:acesso_mp/models/model_visitors.dart';
import 'package:acesso_mp/services/database.dart';
import 'package:acesso_mp/widgets/camera.dart';
import 'package:acesso_mp/widgets/my_dropdown.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const HomePage({super.key, required this.cameras});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Database db = Database();
  final List<String> cadVisitors = [
    'Andre Luis Silva Medina, 111, 111, 111, gari, xuxa',
    'Maria Madalena Silva, 222, 222, 222, vendedora, pablo',
    'Carlos Eduardo Moreno, 333, 333, 333, gerente, tati',
    'Jorge Silva Nogueira, 444, 444, 444, garçom, jonas',
    'Maria do Rosario, 555, 555, 555, doméstica, fabricio',
    'Augusto Carlos de Abreu, 666, 666, 666, eletricista, fernando'
  ];

  void initLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('visitors', cadVisitors);
  }

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: MyDropdown(
                    name: nameField,
                    cpf: cpfField,
                    rg: rgField,
                    phone: phoneField,
                    job: jobField,
                    whoVisit: whoVisitField),
              ),
              const SizedBox(height: 16),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      db.register(ModelVisitors(
                                          name: nameField.fieldController.text,
                                          cpf: cpfField.fieldController.text,
                                          rg: rgField.fieldController.text,
                                          phone:
                                              phoneField.fieldController.text,
                                          job: jobField.fieldController.text,
                                          whoVisit: whoVisitField
                                              .fieldController.text));
                                    },
                                    child: const Text('Cadastrar')),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[300]),
                                  onPressed: () {
                                    nameField.clearData();
                                    cpfField.clearData();
                                    rgField.clearData();
                                    phoneField.clearData();
                                    jobField.clearData();
                                    whoVisitField.clearData();
                                  },
                                  child: Text(
                                    'Limpar',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 350,
                              width: 320,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: CameraApp(
                                  context: context,
                                  cameras: cameras,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
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
