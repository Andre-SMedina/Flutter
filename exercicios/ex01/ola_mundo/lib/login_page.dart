import 'package:flutter/material.dart';
import 'package:ola_mundo/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  Widget _body() {
    return SingleChildScrollView(
      child: SizedBox(
        //MediaQuery aumenta o tamanho do objeto para o tamanho da tela
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            //centraliza todos os elementos de Column
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Image.asset('assets/images/logo.png'),
              ),
              Container(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 12, left: 12, top: 20, bottom: 12),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (text) {
                          email = text;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Email'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              if (email == 'andre@gmail.com' &&
                                  password == '123') {
                                Navigator.of(context).pushNamed('/home');
                                //O push não encerra a tela anterior, para isso tem que usar o pushReplacement
                                //Rota Manual
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => HomePage()));
                              } else {
                                print('Dados Incorretos!');
                              }
                            },
                            child: const Text('Entrar')),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const CustomSwitch()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold melhora aparência e scroll
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            )),
        Container(
          color: Colors.black.withOpacity(0.3),
        ),
        _body(),
      ],
    ));
  }
}
