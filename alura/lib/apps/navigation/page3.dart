import 'package:alura/apps/navigation/arguments.dart';
import 'package:alura/apps/navigation/page2.dart';
import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  static String routeName = '/page3';
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    var args = ModalRoute.of(context)!.settings.arguments as Arguments;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Página 3'),
          Text('Title: ${args.title}'),
          Text('Message: ${args.message}'),
          TextField(
            decoration:
                const InputDecoration(hintText: 'Digite aqui sua mensagem'),
            controller: textController,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Page2.routeName,
                    arguments: Arguments(
                        title: 'Menssagem da página 3',
                        message: textController.text));
              },
              child: const Text('Enviar'))
        ],
      )),
    );
  }
}
