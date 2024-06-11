import 'package:flutter/material.dart';
import 'package:gym/services/exercice_service.dart';

import '../models/exercice_model.dart';
import '../_comum/inicio_modal.dart';
import '../pages/exercice_page.dart';

class MyListItemHome extends StatelessWidget {
  final ExerciceModel exerciceModel;
  final ExerciceService service;
  const MyListItemHome(
      {super.key, required this.exerciceModel, required this.service});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exerciceModel.nome),
      subtitle: Text(exerciceModel.treino),
      //'trailing' mostra um widget(geralmente icone) do lado direito do 'title'
      trailing: Row(
        //utilizado para resolver o problema de overflow na horizontal
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              //passando o 'exerciceModel', vai carregar os campos pra editar o exercício
              onPressed: () {
                mostrarModalInicio(context, exercice: exerciceModel);
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                SnackBar snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Deseja remover ${exerciceModel.nome}?'),
                  action: SnackBarAction(
                    textColor: Colors.yellow,
                    label: 'REMOVER',
                    onPressed: () {
                      service.delExercice(exerciceModel.id);
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
  }
}
