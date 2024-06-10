import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/_comum/inicio_modal.dart';
import 'package:gym/models/exercice_model.dart';
import 'package:gym/pages/exercice_page.dart';
import 'package:gym/services/auth_service.dart';
import 'package:gym/services/exercice_service.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ExerciceService service = ExerciceService();

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
        //
        body: StreamBuilder(
          stream: service.connectStreamExercices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.docs.isNotEmpty) {
                List<ExerciceModel> exerciceList = [];

                for (var doc in snapshot.data!.docs) {
                  exerciceList.add(ExerciceModel.fromMap(doc.data()));
                }

                return ListView(
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
                );
              } else {
                return const Center(
                  child: Text('Nenhum exercício ainda. Vamos adicionar!'),
                );
              }
            }
          },
        ));
  }
}
