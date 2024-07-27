// import 'dart:convert';
import 'dart:convert';

import 'package:acesso_mp/helpers/show_dialog.dart';
import 'package:acesso_mp/main.dart';
import 'package:acesso_mp/models/model_home_fields.dart';
import 'package:acesso_mp/services/database.dart';
import 'package:acesso_mp/widgets/camera.dart';
import 'package:acesso_mp/widgets/my_dropdown.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  HomePage({super.key, required this.cameras});

  ModelHomeFields nameField = ModelHomeFields(
    text: 'Nome',
    validadtor: 'name',
  );
  ModelHomeFields cpfField = ModelHomeFields(
    text: 'CPF',
    validadtor: 'cpf',
  );
  ModelHomeFields rgField = ModelHomeFields(
    text: 'RG',
    validadtor: 'rg',
  );
  ModelHomeFields phoneField = ModelHomeFields(
    text: 'Telefone',
    validadtor: 'phone',
  );
  ModelHomeFields jobField = ModelHomeFields(
    text: 'Profissão',
    validadtor: 'job',
  );
  ModelHomeFields whoVisitField = ModelHomeFields(
    text: 'Quem Visitar',
    validadtor: 'who',
  );
  String image = '';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Database db = Database();
  List<String> visitor = [];
  bool loadImage = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<String> getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('capturedImage') != null) {
      widget.image = prefs.getString('capturedImage')!;
    }
    return prefs.getString('capturedImage')!;
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('visitor') != null) {
      visitor = prefs.getString('visitor')!.split(',');
    }
    //linha necessária quando for atualizar os dados, pois o getImage pega do capturedImage
    prefs.setString('capturedImage', visitor[6]);

    loadImage = true;
    widget.image = visitor[6];
    setState(() {});
    widget.nameField.loadData(visitor[0]);
    widget.cpfField.loadData(visitor[1]);
    widget.rgField.loadData(visitor[2]);
    widget.phoneField.loadData(visitor[3]);
    widget.jobField.loadData(visitor[4]);
    widget.whoVisitField.loadData(visitor[5]);
  }

  @override
  Widget build(BuildContext context) {
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
                  loadData: () {
                    loadData();
                  },
                ),
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
                        key: _formKey,
                        child: Column(
                          children: [
                            widget.nameField,
                            widget.cpfField,
                            widget.rgField,
                            widget.phoneField,
                            widget.jobField,
                            widget.whoVisitField,
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Formulário válido
                                        showErrorDialog(
                                            context,
                                            'Cadastro realizado com sucesso!',
                                            '');
                                      }
                                      // getImage().then((e) {
                                      //   db.register(ModelVisitors(
                                      //     name: widget
                                      //         .nameField.fieldController.text,
                                      //     cpf: widget
                                      //         .cpfField.fieldController.text,
                                      //     rg: widget
                                      //         .rgField.fieldController.text,
                                      //     phone: widget
                                      //         .phoneField.fieldController.text,
                                      //     job: widget
                                      //         .jobField.fieldController.text,
                                      //     whoVisit: widget.whoVisitField
                                      //         .fieldController.text,
                                      //     image: e,
                                      //   ));
                                      //   setState(() {});
                                      // });
                                    },
                                    child: const Text('Cadastrar')),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[300]),
                                  onPressed: () {
                                    setState(() {
                                      loadImage = false;
                                    });
                                    widget.nameField.clearData();
                                    widget.cpfField.clearData();
                                    widget.rgField.clearData();
                                    widget.phoneField.clearData();
                                    widget.jobField.clearData();
                                    widget.whoVisitField.clearData();
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
                                child: (loadImage)
                                    ? Column(
                                        children: [
                                          Expanded(
                                            child: Image.memory(
                                              base64Decode(widget.image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    loadImage = false;
                                                  });
                                                },
                                                child: const Text('Capturar')),
                                          )
                                        ],
                                      )
                                    : CameraApp(
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
