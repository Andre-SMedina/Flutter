// import 'dart:convert';
import 'dart:convert';

import 'package:acesso_mp/helpers/show_dialog.dart';
import 'package:acesso_mp/main.dart';
import 'package:acesso_mp/models/model_home_fields.dart';
import 'package:acesso_mp/models/model_visitors.dart';
import 'package:acesso_mp/services/convert.dart';
import 'package:acesso_mp/services/database.dart';
import 'package:acesso_mp/widgets/camera.dart';
import 'package:acesso_mp/widgets/my_dropdown.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Future<List<String>> getDataVisitor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String img = '';

    if (prefs.getString('capturedImage') != null) {
      widget.image = prefs.getString('capturedImage')!;
      img = prefs.getString('capturedImage')!;
    } else {
      prefs.setString('capturedImage', '');
    }

    return [
      widget.nameField.fieldController.text,
      widget.cpfField.fieldController.text,
      widget.rgField.fieldController.text,
      widget.phoneField.fieldController.text,
      widget.jobField.fieldController.text,
      widget.whoVisitField.fieldController.text,
      img,
    ];
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
    widget.nameField.loadData(Convert.firstUpper(visitor[0]));
    widget.cpfField.loadData(visitor[1]);
    widget.rgField.loadData(visitor[2]);
    widget.phoneField.loadData(visitor[3]);
    widget.jobField.loadData(visitor[4]);
    widget.whoVisitField.loadData(visitor[5]);
  }

  void authorized() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dates = prefs.getStringList('managementDate');
    if (prefs.getString('visitor') != null) {
      visitor = prefs.getString('visitor')!.split(',');
    }

    // List<String> newDate = dates.map((e) {
    //   if (e == visitor[1]) {
    //     String dateNow =
    //         DateFormat('dd/MM/yyy HH:mm:ss').format(DateTime.now());

    //   }
    // });
  }

  void clearFields() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('capturedImage', '');
    loadImage = true;
    widget.image = '';
    setState(() {});
    widget.nameField.clearData();
    widget.cpfField.clearData();
    widget.rgField.clearData();
    widget.phoneField.clearData();
    widget.jobField.clearData();
    widget.whoVisitField.clearData();
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
                                        getDataVisitor().then((e) {
                                          // if (e[6] != '') {
                                          if (true) {
                                            db
                                                .register(ModelVisitors(
                                              name: e[0],
                                              cpf: e[1],
                                              rg: e[2],
                                              phone: e[3],
                                              job: e[4],
                                              whoVisit: e[5],
                                              image: e[6],
                                            ))
                                                .then((v) {
                                              if (v) {
                                                showDialogMsg(context,
                                                    'Pessoa já cadastrada!');
                                              } else {
                                                showDialogMsg(context,
                                                    'Cadastro realizado com sucesso!');
                                                clearFields();
                                              }
                                            });
                                          } else {
                                            showDialogMsg(context,
                                                'Imagem não capturada!');
                                          }
                                        });
                                      }
                                    },
                                    child: const Text('Novo Cadastro')),
                                ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        getDataVisitor().then((e) {
                                          if (e[6] != '') {
                                            db
                                                .update(ModelVisitors(
                                              name: e[0],
                                              cpf: e[1],
                                              rg: e[2],
                                              phone: e[3],
                                              job: e[4],
                                              whoVisit: e[5],
                                              image: e[6],
                                            ))
                                                .then((v) {
                                              if (v) {
                                                showDialogMsg(context,
                                                    'Registro atualizado!');
                                                clearFields();
                                              } else {
                                                showDialogMsg(context,
                                                    'Registro não encontrado!');
                                              }
                                            });
                                          } else {
                                            showDialogMsg(context,
                                                'Imagem não capturada!');
                                          }
                                        });
                                      }
                                    },
                                    child: const Text('Atualizar')),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 254, 3, 3)),
                                  onPressed: () {
                                    clearFields();
                                  },
                                  child: const Text(
                                    'Limpar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 10, 1, 194)),
                                    onPressed: () {},
                                    child: const Text(
                                      'Histórico',
                                      style: TextStyle(color: Colors.white),
                                    ))
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
                                            child: (widget.image == '')
                                                ? const Icon(
                                                    Icons
                                                        .image_not_supported_outlined,
                                                    size: 200,
                                                  )
                                                : Image.memory(
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
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('Autorizar'))
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
