import 'package:flutter/material.dart';
import 'package:gym/_comum/minhas_cores.dart';
import 'package:gym/components/my_input_decoration.dart';

Widget myTextExercicesModal(
    {required String texto,
    required TextEditingController textController,
    String obs = ''}) {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0),
    child: Column(
      children: [
        TextFormField(
          controller: textController,
          decoration: myInputDecoration(texto),
        ),
        Text(obs,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: MinhasCores.azulExerciceModal,
                fontSize: 12,
                fontWeight: FontWeight.bold))
      ],
    ),
  );
}
