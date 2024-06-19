import 'package:alura/apps/navigation/arguments.dart';
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  static String routeName = '/page2';
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
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
            controller: textController,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/',
                    arguments: Arguments(
                        title: 'Menssagem da página 2',
                        message: 'Eu vim da página 2'));
              },
              child: const Text('Voltar'))
        ],
      )),
    );
  }
}
