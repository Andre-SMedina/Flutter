import 'package:gym/_comum/minhas_cores.dart';
// import 'package:gym/components/add_edit_exerc_modal.dart';
import 'package:gym/components/add_edit_sentimento_dialog.dart';
import 'package:gym/models/sentimento_model.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/my_elevated_btn.dart';
import 'package:gym/services/sentimento_service.dart';
import '../models/exercice_model.dart';

class ExercicePage extends StatelessWidget {
  final ExerciceModel exerciceModel;
  ExercicePage({super.key, required this.exerciceModel});

  final SentimentoService _sentimentoService = SentimentoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
        toolbarHeight: 72,
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: MinhasCores.azulEscuro,
        title: Column(
          children: [
            Text(
              exerciceModel.nome,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              exerciceModel.treino,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showAddEditSentimentoDiaolg(context, idExercice: exerciceModel.id);
        },
        child: const Icon(color: Colors.white, Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          //TODO: Altura da tela
          height: MediaQuery.of(context).size.height - 110,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.white),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyElevatedBtn(title: 'Enviar Foto', onPressed: () {}),
                    MyElevatedBtn(title: 'Tirar Foto', onPressed: () {})
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Como fazer?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(exerciceModel.comoFazer),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              const Text('Como estou me sentindo?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              StreamBuilder(
                stream: _sentimentoService.connectStream(
                    idExercice: exerciceModel.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      final List<SentimentoModel> listaSentimentos = [];

                      for (var doc in snapshot.data!.docs) {
                        listaSentimentos
                            .add(SentimentoModel.fromMap(doc.data()));
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children:
                            List.generate(listaSentimentos.length, (index) {
                          SentimentoModel sentimentoAgora =
                              listaSentimentos[index];
                          //ListTile cria uma formatção de lista
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(sentimentoAgora.sentindo),
                            subtitle: Text(sentimentoAgora.data),
                            leading: const Icon(Icons.double_arrow),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showAddEditSentimentoDiaolg(context,
                                          idExercice: exerciceModel.id,
                                          sentimentoModel: sentimentoAgora);
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                  color: Colors.red,
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _sentimentoService.removeSentimento(
                                        exerciceId: exerciceModel.id,
                                        sentimentoId: sentimentoAgora.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    } else {
                      return const Text(
                          'Sem nenhuma anotação de sentimento ainda!');
                    }
                  }
                },
              )
              //TODO: Como percorrer uma lista
            ],
          ),
        ),
      ),
    );
  }
}
