import 'package:flutter/material.dart';
import 'package:gym/models/exercice_model.dart';
import 'package:gym/services/exercice_service.dart';
import 'package:gym/widgets/my_input_decoration.dart';
import 'package:uuid/uuid.dart';

mostrarModalInicio(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ExerciceModal();
      },
      backgroundColor: Color.fromARGB(255, 74, 164, 238),
      //"isDismissible" define se vai ou não fechar ao clicar fora
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))));
}

class ExerciceModal extends StatefulWidget {
  const ExerciceModal({super.key});

  @override
  State<ExerciceModal> createState() => _ExerciceModalState();
}

class _ExerciceModalState extends State<ExerciceModal> {
  final TextEditingController _nomeCtrl = TextEditingController();
  final TextEditingController _treinoCtrl = TextEditingController();
  final TextEditingController _anotacoesCtrl = TextEditingController();
  final TextEditingController _sentindoCtrl = TextEditingController();

  bool isCarregando = false;

  ExerciceService exerciceService = ExerciceService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              //deixa  coluna no menor tamanho possível
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Adicionar exercício',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
                const Divider(
                  color: Colors.white,
                ),
                Column(
                  children: [
                    myTextForm('Qual o exercício?', _nomeCtrl),
                    myTextForm('Qual treino pertence?', _treinoCtrl),
                    myTextForm('Anotações', _anotacoesCtrl),
                    myTextForm('O que está se sentindo?', _sentindoCtrl)
                  ],
                ),
              ],
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                onPressed: () {
                  enviar();
                },
                child: (isCarregando)
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        'Criar exercício'))
          ],
        ),
      ),
    );
  }

  Widget myTextForm(String texto, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: myInputDecoration(texto),
      ),
    );
  }

  enviar() {
    setState(() {
      isCarregando = true;
    });

    String nome = _nomeCtrl.text;
    String treino = _treinoCtrl.text;
    String anotacoes = _anotacoesCtrl.text;
    String sentindo = _sentindoCtrl.text;

    ExerciceModel exercicio = ExerciceModel(
        id: const Uuid().v1(),
        nome: nome,
        treino: treino,
        comoFazer: anotacoes);
  }
}
