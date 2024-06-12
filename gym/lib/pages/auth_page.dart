import 'package:flutter/material.dart';
import 'package:gym/_comum/minhas_cores.dart';
import 'package:gym/services/auth_service.dart';
import 'package:gym/components/my_elevated_btn.dart';
import 'package:gym/components/my_input_decoration.dart';
import 'package:gym/components/my_snackbar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool queroEntrar = true;
  //chave para validar formulário
  final _formKey = GlobalKey<FormState>();
  String? _pass = "";

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final AuthService _authService = AuthService();

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
            //key recebe chave de validção do estado do formulário
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
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
                    Visibility(
                      visible: !queroEntrar,
                      child: TextFormField(
                        controller: _nomeController,
                        validator: (String? value) {
                          if (value == '') {
                            return "O nome não pode ser vazio!";
                          }
                          if (value!.length < 4) {
                            return "O nome é muito curto!";
                          }
                          return null;
                        },
                        decoration: myInputDecoration('Nome Completo'),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (String? value) {
                        if (value == '') {
                          return "O e-mail não pode ser vazio!";
                        }
                        if (value!.length < 5) {
                          return "E-mail inválido!";
                        }
                        if (!value.contains('@')) {
                          return "E-mail inválido!";
                        }
                        return null;
                      },
                      decoration: myInputDecoration('E-mail'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _senhaController,
                      obscureText: true,
                      validator: (String? value) {
                        if (value == '') {
                          return "A senha não pode ser vazia!";
                        }
                        _pass = value;
                        return null;
                      },
                      decoration: myInputDecoration('Senha'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Visibility(
                        visible: !queroEntrar,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (String? value) {
                                if (value! == '') {
                                  return 'A confirmação de senha não pode ser vazia';
                                }
                                if (value != _pass) {
                                  return 'As senhas não são iguais';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: myInputDecoration('Confirmar senha'),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    MyElevatedBtn(
                        title: (queroEntrar) ? 'Entrar' : 'Cadastrar',
                        onPressed: () {
                          mainButton();
                        }),
                    const SizedBox(
                      height: 15,
                    ),
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

  mainButton() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String password = _senhaController.text;
    //condicional para verificar o estado da chave de vaidação dos textForm do formulário
    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        _authService
            .loginUser(email: email, password: password)
            .then((String? error) {
          if (error != null) {
            //voltou com erro
            mySnacbar(context: context, texto: error);
          } else {
            //
          }
        });
      } else {
        // print('$nome, $email, $senha');
        _authService
            .cadUser(nome: nome, email: email, senha: password)
            .then((String? error) {
          if (error != null) {
            //voltou com erro
            mySnacbar(context: context, texto: error);
          } else {
            //
          }
        });
      }
    }
  }
}
