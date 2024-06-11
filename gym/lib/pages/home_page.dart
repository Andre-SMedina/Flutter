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
  bool isDecrescente = false;

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
                  children: List.generate(exerciceList.length, (index) {
                    ExerciceModel exerciceModel = exerciceList[index];
                    return ListTile(
                      title: Text(exerciceModel.nome),
                      subtitle: Text(exerciceModel.treino),
                      //'trailing' mostra um widget(geralmente icone) do lado direito do 'title'
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              //passando o 'exerciceModel', vai carregar os campos pra editar o exercício
                              onPressed: () {
                                mostrarModalInicio(context,
                                    exercice: exerciceModel);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                service.delExercice(exerciceModel.id);
                              },
                              icon: const Icon(color: Colors.red, Icons.delete))
                        ],
                      ),
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
