import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/_comum/inicio_modal.dart';
import 'package:gym/models/exercice_model.dart';
import 'package:gym/pages/exercice_page.dart';
import 'package:gym/services/auth_service.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ExerciceModel> exerciceList = [
    ExerciceModel(
        id: 'EX01',
        nome: 'Puxada Alta Pronada',
        treino: 'Treino A',
        comoFazer: 'Puxa'),
    ExerciceModel(
        id: 'EX01',
        nome: 'Remada Supinada',
        treino: 'Treino A',
        comoFazer: 'Puxa'),
    ExerciceModel(
        id: 'EX01',
        nome: 'Puxada Alta Pronada',
        treino: 'Treino A',
        comoFazer: 'Puxa'),
    ExerciceModel(
        id: 'EX01',
        nome: 'Remada Supinada',
        treino: 'Treino A',
        comoFazer: 'Puxa'),
    ExerciceModel(
        id: 'EX01',
        nome: 'Puxada Alta Pronada',
        treino: 'Treino A',
        comoFazer: 'Puxa'),
    ExerciceModel(
        id: 'EX02',
        nome: 'Treino com Halteres',
        treino: 'Treino C',
        comoFazer: 'Empurra pra cima')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            //o 'widget' serve para utilizar as propriedades da classe que está sendo extendida por essa classe
            accountName: Text((widget.user.displayName != null)
                ? widget.user.displayName!
                : ''),
            accountEmail: Text(widget.user.email!),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/perfil.jpg"),
            ),
          ),
          const ListTile(
            title: Text('Novas academias'),
            leading: Icon(Icons.business_outlined),
            //dense diminue o tamanho do texto
            dense: true,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Deslogar'),
            onTap: () {
              AuthService().logout();
            },
          )
        ],
      )),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Meus Exercícios'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          mostrarModalInicio(context);
        },
      ),
      body: ListView(
        children: List.generate(exerciceList.length, (index) {
          ExerciceModel exerciceModel = exerciceList[index];
          return ListTile(
            title: Text(exerciceModel.nome),
            subtitle: Text(exerciceModel.treino),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExercicePage(
                            exerciceModel: exerciceModel,
                          )));
            },
          );
        }),
      ),
    );
  }
}
