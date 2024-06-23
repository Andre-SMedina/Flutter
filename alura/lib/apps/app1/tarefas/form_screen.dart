import 'package:alura/apps/app1/tarefas/arguments.dart';
import 'package:alura/apps/app1/tarefas/task_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});
  static const routeName = '/formscreen';

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  //https://w7.pngwing.com/pngs/227/232/png-transparent-super-mario-run-super-mario-bros-new-super-mario-bros-super-mario-super-mario-bros-hand-nintendo.png
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Nova Tarefa',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3)),
            height: 650,
            width: 375,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textFields('Nome', nameController),
                    textFields('Dificuldade', difficultyController,
                        type: true, valid: 'difficulty'),
                    textFields('Imagem', imageController, valid: 'image'),
                    Container(
                      height: 100,
                      width: 72,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(width: 2)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageController.text,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset('assets/images/noImage.png');
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              TaskInherited.of(args.taskContext)!.newTask(
                                  int.parse(difficultyController.text),
                                  nameController.text,
                                  imageController.text);
                              //https://dev.to/joaberamone/como-usar-snackbars-em-flutter-4ce
                              Navigator.pop(context);
                              ScaffoldMessenger.of(args.taskContext)
                                  .showSnackBar(const SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 71, 71, 71),
                                content: Text(
                                  'Tarefa adicionada!',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ));
                            }
                          });
                        },
                        child: const Text('Adicionar')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textFields(
      String textField, TextEditingController inputController,
      {bool type = false, String valid = 'text'}) {
    return TextFormField(
      validator: (value) {
        if (valid == 'text') {
          if (value == null || value.isEmpty) {
            return 'Insira o nome da tarefa';
          }
        }
        if (valid == 'difficulty') {
          if (value == null ||
              value.isEmpty ||
              int.parse(value) < 1 ||
              int.parse(value) > 5) {
            return 'Dificuldade deve ser entre 1 e 5';
          }
        }
        if (valid == 'image') {
          if (value == null || value.isEmpty) {
            return 'Insira uma URL de imagem';
          }
        }
        return null;
      },
      //TODO: Definir a entrada somente de números
      inputFormatters: [
        (valid == 'idade')
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter,
      ],
      keyboardType: (type) ? TextInputType.number : TextInputType.text,
      controller: inputController,
      onChanged: (v) {
        setState(() {});
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: textField,
          filled: true,
          fillColor: Colors.white70),
    );
  }
}
