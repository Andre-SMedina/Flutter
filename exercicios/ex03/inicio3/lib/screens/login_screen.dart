import 'package:flutter/material.dart';
import 'package:inicio3/_comum/cores.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? continueConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(style: TextStyle(color: MyColors.branco), 'My App'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [MyColors.azul, MyColors.branco])),
        //serve para dar scroll na tela
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Image(
                image: AssetImage('assets/images/halter.png'),
                height: 125,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              const Text(
                'Entrar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.branco,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(color: MyColors.branco),
                    autofocus: true,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.branco)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.branco)),
                        labelText: 'E-mail',
                        labelStyle: TextStyle(color: MyColors.branco),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: MyColors.branco,
                        )),
                  ),
                  TextFormField(
                    style: const TextStyle(color: MyColors.branco),
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.branco)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.branco)),
                        labelText: 'Senha',
                        labelStyle: TextStyle(color: MyColors.branco),
                        prefixIcon: Icon(
                          Icons.key_outlined,
                          color: MyColors.branco,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Funcionou!');
                    },
                    child: const Text(
                        style: TextStyle(color: MyColors.branco),
                        'Esqueceu a senha?'),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: continueConnected,
                          onChanged: (newValue) {
                            setState(() {
                              continueConnected = newValue;
                            });
                          }),
                      const Text(
                          style: TextStyle(color: MyColors.branco),
                          'Continuar conectado?')
                    ],
                  )
                ],
              )),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: MyColors.botao),
                onPressed: () {},
                child: const Text(
                    style: TextStyle(color: MyColors.branco, fontSize: 18),
                    'Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
