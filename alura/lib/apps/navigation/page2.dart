import 'package:alura/apps/navigation/arguments.dart';
import 'package:alura/apps/navigation/page3.dart';
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  static String routeName = '/page2';
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    //o conteúdo enviado via argumentos pelo Navigator.pushNamed, serão armazenados na variável args e não podem ser nulos.
    var args = ModalRoute.of(context)!.settings.arguments as Arguments;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Página 2'),
          Text('Title: ${args.title}'),
          Text('Message: ${args.message}'),
          TextField(
            decoration:
                const InputDecoration(hintText: 'Digite aqui sua mensagem'),
            controller: textController,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Page3.routeName,
                    arguments: Arguments(
                        title: 'Menssagem da página 2',
                        message: textController.text));
              },
              child: const Text('Enviar'))
        ],
      )),
    );
  }
}
