import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/inicio_modal.dart';
import 'package:gym/models/exercice_model.dart';
import 'package:gym/services/auth_service.dart';
import 'package:gym/services/exercice_service.dart';
import 'package:gym/components/my_list_item_home.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ExerciceService service = ExerciceService();
  bool isDecrescente = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[300],
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
          // backgroundColor: Colors.blue,
          title: const Text('Meus Exercícios'),
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    isDecrescente = !isDecrescente;
                  });
                },
                icon: const Icon(Icons.sort_by_alpha_rounded))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            //passando apenas o 'context' sem 'exerciceModel' faz carregar apenas o campos para adicionar um novo exercício
            mostrarModalInicio(context);
          },
        ),
        //
        body: StreamBuilder(
          stream: service.connectStreamExercices(isDecrescente),
          //snapshot são as informações do usuário guardadas na memória do celular que está com o login ativo
          builder: (context, snapshot) {
            //condicional para mostrar o loading enquanto está buscando os dados no servidor para mostar os exercícios no body
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              //condicional para verificar se tem álgum exercício cadastrado
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.docs.isNotEmpty) {
                List<ExerciceModel> exerciceList = [];

                for (var doc in snapshot.data!.docs) {
                  exerciceList.add(ExerciceModel.fromMap(doc.data()));
                }

                return ListView(
                  padding: const EdgeInsets.only(top: 20),
                  children: List.generate(exerciceList.length, (index) {
                    ExerciceModel exerciceModel = exerciceList[index];
                    return MyListItemHome(
                        exerciceModel: exerciceModel, service: service);
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
