import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inicio3/_comum/cores.dart';
import 'package:inicio3/models/user_model.dart';
import 'package:inicio3/pages/cadastro_screen.dart';
import 'package:inicio3/pages/home.dart';
import 'package:inicio3/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? continueConnected = false;

  TextEditingController mailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(style: TextStyle(color: MyColors.branco), 'Gym'),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 10, 14, 250),
              Color.fromARGB(255, 118, 255, 255)
            ])),
        //serve para dar scroll na tela
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
                    controller: mailInputController,
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
                    controller: passwordInputController,
                    obscureText: true,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                          textAlign: TextAlign.right,
                          style: TextStyle(color: MyColors.branco),
                          'Esqueceu a senha?'),
                    ),
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
                onPressed: () {
                  doLogin();
                },
                child: const Text(
                    style: TextStyle(color: MyColors.branco, fontSize: 18),
                    'Login'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                    textAlign: TextAlign.center, 'Ainda não tem uma conta?'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CadastroScreen()));
                  },
                  child: const Text(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    'Cadastre-se',
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void doLogin() async {
    String mailForm = mailInputController.text;
    String passForm = passwordInputController.text;

    User savedUser = await getSavedUser();

    if (mailForm == savedUser.mail && passForm == savedUser.password) {
      // print("Login efetuado com successo");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  Future<User> getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUser = prefs.getString(PreferencesKeys.activeUser)!;

    Map<String, dynamic> mapUser = jsonDecode(jsonUser);
    User user = User.fromJson(mapUser);

    return user;
  }
}
