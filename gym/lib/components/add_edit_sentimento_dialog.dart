import 'package:flutter/material.dart';
import 'package:gym/components/my_elevated_btn.dart';
import 'package:gym/models/sentimento_model.dart';
import 'package:gym/services/sentimento_service.dart';
import 'package:uuid/uuid.dart';

Future<dynamic> showAddEditSentimentoDiaolg(
  BuildContext context, {
  required String idExercice,
  SentimentoModel? sentimentoModel,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        TextEditingController sentimentoController = TextEditingController();
        String data =
            '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}';

        if (sentimentoModel != null) {
          sentimentoController.text = sentimentoModel.sentindo;
        }

        return AlertDialog(
          title: const Text('Como você está se sentindo?'),
          content: TextFormField(
            controller: sentimentoController,
            decoration: const InputDecoration(
              label: Text('O que está sentindo?'),
            ),
            maxLines: null,
          ),
          actions: [
            MyElevatedBtn(
                title: (sentimentoModel != null)
                    ? 'Editar sentimento'
                    : 'Criar sentimento',
                onPressed: () {
                  SentimentoModel sentimento = SentimentoModel(
                      id: const Uuid().v1(),
                      sentindo: sentimentoController.text,
                      data: data);

                  if (sentimentoModel != null) {
                    sentimento.id = sentimentoModel.id;
                  }
                  SentimentoService().addEmotion(
                    idExercice: idExercice,
                    sentimentoModelo: sentimento,
                  );
                  Navigator.pop(context);
                }),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      });
}
