// import 'dart:convert';
import 'dart:convert';

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
  HomePage({super.key, required this.cameras});

  ModelHomeFields nameField = ModelHomeFields(text: 'Nome');
  ModelHomeFields cpfField = ModelHomeFields(text: 'CPF');
  ModelHomeFields rgField = ModelHomeFields(text: 'RG');
  ModelHomeFields phoneField = ModelHomeFields(text: 'Telefone');
  ModelHomeFields jobField = ModelHomeFields(text: 'Profissão');
  ModelHomeFields whoVisitField = ModelHomeFields(text: 'Quem Visitar');
  String image = 'errouuuu';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Database db = Database();
  final List<String> cadVisitors = [
    "João Carlos Silva, 123.456.789-00, 12.345.678-9, (11) 91234-5678, Engenheiro, Maria Oliveira",
    "Ana Maria Souza, 987.654.321-00, 98.765.432-1, (21) 98765-4321, Médica, Carlos Mendes",
    "Pedro Henrique Almeida, 111.222.333-44, 11.222.333-4, (31) 99876-5432, Advogado, Fernanda Castro",
    "Lucas Gabriel Costa, 555.666.777-88, 55.666.777-8, (41) 98765-0987, Professor, André Lima, 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",
    "Mariana Fernanda Ramos, 999.888.777-66, 99.888.777-6, (51) 91234-9876, Designer, Juliana Lopes",
    "Felipe Augusto Nascimento, 333.444.555-66, 33.444.555-6, (61) 99654-3210, Arquiteto, Lucas Ferreira",
    "Bruna Carolina Martins, 777.888.999-00, 77.888.999-0, (71) 98765-6543, Jornalista, Rafael Vieira",
    "Gabriel Otávio Oliveira, 222.333.444-55, 22.333.444-5, (81) 99887-7654, Psicólogo, Camila Santos",
    "Júlia Helena Ferreira, 666.555.444-33, 66.555.444-3, (91) 97654-3210, Enfermeira, Eduardo Silva",
    "Thiago Rafael Rocha, 111.999.888-77, 11.999.888-7, (31) 98765-4321, Analista, Roberta Correia",
    "Ricardo Luís Mendes, 234.567.890-11, 23.456.789-0, (12) 92345-6789, Engenheiro, Ana Maria Souza",
    "Laura Beatriz Costa, 876.543.210-11, 87.654.321-0, (22) 99876-5432, Médica, Pedro Henrique Almeida",
    "Marcelo Henrique Pereira, 222.333.444-55, 22.333.444-5, (32) 90987-6543, Advogado, Lucas Gabriel Costa",
    "Vanessa Cristina Oliveira, 666.777.888-99, 66.777.888-9, (42) 98765-0123, Professor, Mariana Fernanda Ramos",
    "Juliana Fernanda Castro, 888.777.666-55, 88.777.666-5, (52) 91234-8765, Designer, Felipe Augusto Nascimento",
    "André Luís Lima, 444.555.666-77, 44.555.666-7, (62) 99654-2109, Arquiteto, Bruna Carolina Martins",
    "Camila Sofia Mendes, 888.999.000-11, 88.999.000-1, (72) 98765-5432, Jornalista, Gabriel Otávio Oliveira",
    "Eduardo Daniel Ferreira, 333.444.555-66, 33.444.555-6, (82) 99887-6543, Psicólogo, Júlia Helena Ferreira",
    "Roberta Letícia Silva, 555.444.333-22, 55.444.333-2, (92) 97654-2109, Enfermeira, Thiago Rafael Rocha",
    "Rafael Leonardo Correia, 222.111.000-99, 22.111.000-9, (32) 98765-3210, Analista, Ricardo Luís Mendes",
    "Gustavo Matheus Silva, 345.678.901-22, 34.567.890-1, (13) 93456-7890, Engenheiro, Laura Beatriz Costa",
    "Fernanda Adriana Lopes, 765.432.109-22, 76.543.210-1, (23) 99876-5432, Médica, Marcelo Henrique Pereira",
    "Bruno Vinícius Oliveira, 333.444.555-66, 33.444.555-6, (33) 90987-6543, Advogado, Vanessa Cristina Oliveira",
    "Luana Michele Ribeiro, 777.888.999-00, 77.888.999-0, (43) 98765-0123, Professor, Juliana Fernanda Castro",
    "Daniel Marcos Alves, 777.666.555-44, 77.666.555-4, (53) 91234-7654, Designer, André Luís Lima",
    "Carla Letícia Martins, 555.666.777-88, 55.666.777-8, (63) 99654-1098, Arquiteto, Camila Sofia Mendes",
    "Rodrigo Otávio Correia, 888.999.000-22, 88.999.000-2, (73) 98765-4321, Jornalista, Gabriel Otávio Oliveira",
    "Aline Mariana Santos, 333.555.666-77, 33.555.666-7, (83) 99887-6543, Psicóloga, Júlia Helena Ferreira",
    "Fábio Daniel Mendes, 444.222.111-11, 44.222.111-1, (93) 97654-2109, Enfermeiro, Eduardo Daniel Ferreira",
    "Lívia Mariana Lima, 222.000.111-88, 22.000.111-8, (33) 98765-2109, Analista, Roberta Letícia Silva",
    "Mateus Gabriel Castro, 567.890.123-33, 56.789.012-3, (14) 94567-8901, Engenheiro, Rafael Leonardo Correia",
    "Patrícia Beatriz Lopes, 654.321.098-44, 65.432.109-8, (24) 99876-5432, Médica, Gustavo Matheus Silva",
    "Renato Otávio Silva, 333.444.555-77, 33.444.555-7, (34) 90987-6543, Advogado, Fernanda Adriana Lopes",
    "Tatiana Cristina Pereira, 888.777.666-22, 88.777.666-2, (44) 98765-0123, Professor, Bruno Vinícius Oliveira",
    "Sérgio Luís Oliveira, 555.666.777-99, 55.666.777-9, (54) 91234-6543, Designer, Luana Michele Ribeiro",
    "Letícia Carla Nascimento, 777.888.000-11, 77.888.000-1, (64) 99654-0987, Arquiteta, Daniel Marcos Alves",
    "Guilherme Augusto Silva, 999.000.111-33, 99.000.111-3, (74) 98765-3210, Jornalista, Carla Letícia Martins",
    "Nathalia Fernanda Costa, 444.555.666-88, 44.555.666-8, (84) 99876-4321, Psicóloga, Rodrigo Otávio Correia",
    "Brenda Sofia Souza, 222.333.444-99, 22.333.444-9, (94) 97654-0987, Enfermeira, Aline Mariana Santos",
    "Vinícius Ricardo Silva, 567.890.123-44, 56.789.012-4, (15) 95678-9012, Engenheiro, Fábio Daniel Mendes",
    "Karla Gabriela Lopes, 543.210.987-55, 54.321.098-7, (25) 99876-5432, Médica, Lívia Mariana Lima",
    "Leonardo Carlos Almeida, 777.666.555-66, 77.666.555-6, (35) 90987-6543, Advogado, Mateus Gabriel Castro",
    "Paula Helena Ribeiro, 888.555.444-22, 88.555.444-2, (45) 98765-0123, Professor, Patrícia Beatriz Lopes",
    "Marcos Antônio Nascimento, 666.777.888-00, 66.777.888-0, (55) 91234-5432, Designer, Renato Otávio Silva",
    "Sara Juliana Martins, 555.444.333-33, 55.444.333-3, (65) 99654-9876, Arquiteta, Tatiana Cristina Pereira",
    "Juliano Paulo Mendes, 333.222.111-11, 33.222.111-1, (75) 98765-2109, Jornalista, Sérgio Luís Oliveira"
  ];
  List<String> visitor = [];
  bool loadImage = false;

  void initLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('visitors', cadVisitors);
  }

  void getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('capturedImage') != null) {
      widget.image = prefs.getString('capturedImage')!;
    }
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('visitor') != null) {
      visitor = prefs.getString('visitor')!.split(',');
    }

    // print(visitor[6]);
    loadImage = !loadImage;
    widget.image = visitor[6];
    print(widget.image);
    setState(() {});
    widget.nameField.loadData(visitor[0]);
    widget.cpfField.loadData(visitor[1]);
    widget.rgField.loadData(visitor[2]);
    widget.phoneField.loadData(visitor[3]);
    widget.jobField.loadData(visitor[4]);
    widget.whoVisitField.loadData(visitor[5]);
  }

  @override
  void initState() {
    initLoad();
    super.initState();
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
                    // getImage();
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
                                      getImage();
                                      db.register(ModelVisitors(
                                        name: widget
                                            .nameField.fieldController.text,
                                        cpf: widget
                                            .cpfField.fieldController.text,
                                        rg: widget.rgField.fieldController.text,
                                        phone: widget
                                            .phoneField.fieldController.text,
                                        job: widget
                                            .jobField.fieldController.text,
                                        whoVisit: widget
                                            .whoVisitField.fieldController.text,
                                        image: widget.image,
                                      ));
                                    },
                                    child: const Text('Cadastrar')),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[300]),
                                  onPressed: () {
                                    loadImage = !loadImage;
                                    setState(() {});
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
                              // child: Image.memory(base64Decode('')),
                              child: Center(
                                child: (loadImage)
                                    ? Image.memory(base64Decode(widget.image))
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
