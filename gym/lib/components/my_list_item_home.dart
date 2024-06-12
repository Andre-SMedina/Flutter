import 'package:flutter/material.dart';
import 'package:gym/services/exercice_service.dart';

import '../models/exercice_model.dart';
import 'add_edit-exerc_modal.dart';
import '../pages/exercice_page.dart';

class MyListItemHome extends StatelessWidget {
  final ExerciceModel exerciceModel;
  final ExerciceService service;
  const MyListItemHome(
      {super.key, required this.exerciceModel, required this.service});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExercicePage(
                exerciceModel: exerciceModel,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  color: Colors.black.withAlpha(100),
                  spreadRadius: 1,
                  offset: const Offset(1, 1))
            ],
            borderRadius: BorderRadius.circular(16)),
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              //azul escuro da parte inferior à direita
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                height: 30,
                width: 150,
                child: Center(
                  child: Text(
                    exerciceModel.treino,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          exerciceModel.nome,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        //utilizado para resolver o problema de overflow na horizontal
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              //passando o 'exerciceModel', vai carregar os campos pra editar o exercício
                              onPressed: () {
                                showAddEditExerciceModal(context,
                                    exercice: exerciceModel);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                SnackBar snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'Deseja remover ${exerciceModel.nome}?'),
                                  action: SnackBarAction(
                                    textColor: Colors.yellow,
                                    label: 'REMOVER',
                                    onPressed: () {
                                      service.delExercice(exerciceModel.id);
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              icon: const Icon(color: Colors.red, Icons.delete))
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          exerciceModel.comoFazer,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

    // ListTile(
    //   title: Text(exerciceModel.nome),
    //   subtitle: Text(exerciceModel.treino),
    //   //'trailing' mostra um widget(geralmente icone) do lado direito do 'title'
    //   trailing: Row(
    //     //utilizado para resolver o problema de overflow na horizontal
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       IconButton(
    //           //passando o 'exerciceModel', vai carregar os campos pra editar o exercício
    //           onPressed: () {
    //             mostrarModalInicio(context, exercice: exerciceModel);
    //           },
    //           icon: const Icon(Icons.edit)),
    //       IconButton(
    //           onPressed: () {
    //             SnackBar snackBar = SnackBar(
    //               backgroundColor: Colors.red,
    //               content: Text('Deseja remover ${exerciceModel.nome}?'),
    //               action: SnackBarAction(
    //                 textColor: Colors.yellow,
    //                 label: 'REMOVER',
    //                 onPressed: () {
    //                   service.delExercice(exerciceModel.id);
    //                 },
    //               ),
    //             );
    //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //           },
    //           icon: const Icon(color: Colors.red, Icons.delete))
    //     ],
    //   ),
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => ExercicePage(
    //                   exerciceModel: exerciceModel,
    //                 )));
    //   },
    // );
  }
}
