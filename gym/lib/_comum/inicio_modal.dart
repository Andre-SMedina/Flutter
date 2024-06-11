import 'package:flutter/material.dart';
import 'package:gym/models/exercice_model.dart';
import 'package:gym/models/sentimento_model.dart';
import 'package:gym/services/exercice_service.dart';
import 'package:gym/widgets/my_input_decoration.dart';
import 'package:uuid/uuid.dart';

mostrarModalInicio(BuildContext context, {ExerciceModel? exercice}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        //passando o 'exerciceModel' para posterior verificação se é null
        return ExerciceModal(
          exerciceModel: exercice,
        );
      },
      backgroundColor: const Color.fromARGB(255, 74, 164, 238),
      //"isDismissible" define se vai ou não fechar ao clicar fora
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))));
}

class ExerciceModal extends StatefulWidget {
  final ExerciceModel? exerciceModel;
  const ExerciceModal({super.key, this.exerciceModel});

  @override
  State<ExerciceModal> createState() => _ExerciceModalState();
}

class _ExerciceModalState extends State<ExerciceModal> {
  final TextEditingController _nomeCtrl = TextEditingController();
  final TextEditingController _treinoCtrl = TextEditingController();
  final TextEditingController _anotacoesCtrl = TextEditingController();
  final TextEditingController _sentindoCtrl = TextEditingController();

  bool isCarregando = false;

  final ExerciceService _exerciceService = ExerciceService();

  @override
  void initState() {
    //atribui os valores passados de 'exerciceModel' caso não sejam null
    if (widget.exerciceModel != null) {
      _nomeCtrl.text = widget.exerciceModel!.nome;
      _treinoCtrl.text = widget.exerciceModel!.treino;
      _anotacoesCtrl.text = widget.exerciceModel!.comoFazer;
    }
    super.initState();
  }

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
                    Flexible(
                      child: Text(
                        (widget.exerciceModel != null)
                            ? 'Editar ${widget.exerciceModel!.nome}'
                            : 'Adicionar exercício',
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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
                    const Text(
                      'Use o mesmo nome para exercícios que pertencem ao mesmo treino',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    myTextForm('Anotações', _anotacoesCtrl),
                    Visibility(
                      visible: (widget.exerciceModel == null),
                      child: Column(
                        children: [
                          myTextForm('O que está sentindo?', _sentindoCtrl),
                          const Text(
                            'Preenchimento do sentimento é opcional',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    )
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
                  : Text(
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      (widget.exerciceModel != null)
                          ? 'Salvar alterações'
                          : 'Criar exercício',
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myTextForm(String texto, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
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
    String data =
        '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}';

    ExerciceModel exercicio = ExerciceModel(
        id: (widget.exerciceModel != null)
            ? widget.exerciceModel!.id
            : const Uuid().v1(),
        nome: nome,
        treino: treino,
        comoFazer: anotacoes);

    _exerciceService.addExercice(exercicio).then((value) {
      if (sentindo != '') {
        SentimentoModel sentimento = SentimentoModel(
            id: const Uuid().v1(), sentindo: sentindo, data: data);
        _exerciceService.addEmotion(exercicio.id, sentimento).then((onValue) {
          setState(() {
            isCarregando = false;
          });
          Navigator.pop(context);
        });
      } else {
        Navigator.pop(context);
      }
    });
  }
}
