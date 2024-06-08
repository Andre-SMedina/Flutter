import 'package:gym/widgets/my_elevated_btn.dart';
import 'package:flutter/material.dart';

class ExecercicePage extends StatelessWidget {
  const ExecercicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
        backgroundColor: Colors.blue,
        title: const Center(child: Text('Puxada Alta Pronada - Treino A')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Clicou!'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          MyElevatedBtn(
            onPressed: () {},
            title: 'Enviar foto',
          ),
          const Text(
            'Como fazer?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Text('Segura com as duas mãos, mantem a coluna reta e puxa'),
          const Divider()
        ],
      ),
    );
  }
}
