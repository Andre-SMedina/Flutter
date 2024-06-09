import 'package:flutter/material.dart';
import 'package:gym/_comum/minhas_cores.dart';
import 'package:gym/widgets/my_elevated_btn.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool queroEntrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                MinhasCores.azulTopoGradiente,
                MinhasCores.azulBaixoGradiente
              ])),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/images/halter.png",
                      height: 128,
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      'GymApp',
                      style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(label: Text('Nome Completo')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                        visible: !queroEntrar,
                        child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text('E-mail')),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(label: Text('Senha')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                        visible: !queroEntrar,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Confirmar senha')),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                    MyElevatedBtn(
                        title: (queroEntrar) ? 'Entrar' : 'Cadastrar',
                        onPressed: () {}),
                    const Divider(),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            queroEntrar = !queroEntrar;
                          });
                        },
                        child: Text((queroEntrar)
                            ? 'Ainda não tem uma conta? Cadastre-se!'
                            : 'Já tem uma conta? Entre!'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
