import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inicio3/_comum/cores.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
              child: Text(style: TextStyle(color: MyColors.branco), 'Gym')),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [MyColors.branco, MyColors.azul])),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(style: TextStyle(fontSize: 20), 'Cadastre-se'),
                Form(
                    child: Column(
                  children: [TextFormField()],
                ))
              ],
            ),
          ),
        ));
  }
}
