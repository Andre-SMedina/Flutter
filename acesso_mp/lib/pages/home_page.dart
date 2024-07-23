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
    "João Carlos Silva, 123.456.789-00, 12.345.678-9, (11) 91234-5678, Engenheiro, Maria Oliveira",
    "Ana Maria Souza, 987.654.321-00, 98.765.432-1, (21) 98765-4321, Médica, Carlos Mendes",
    "Pedro Henrique Almeida, 111.222.333-44, 11.222.333-4, (31) 99876-5432, Advogado, Fernanda Castro",
    "Lucas Gabriel Costa, 555.666.777-88, 55.666.777-8, (41) 98765-0987, Professor, André Lima",
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
