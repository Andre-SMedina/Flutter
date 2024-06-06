// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:inicio3/_comum/cores.dart';
import 'package:inicio3/models/user_model.dart';
import 'package:inicio3/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  bool? showPassword = false;

  TextEditingController nameInputController = TextEditingController();
  TextEditingController mailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController confirmPasswordInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
              child: Text(style: TextStyle(color: MyColors.branco), 'Gym')),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(255, 86, 187, 255),
                  MyColors.azul
                ])),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
              child: Column(
                children: [
                  const Text(style: TextStyle(fontSize: 30), 'Cadastre-se'),
                  Form(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                            controller: nameInputController,
                            style: const TextStyle(color: MyColors.branco),
                            decoration: const InputDecoration(
                                labelText: 'Nome completo',
                                labelStyle: TextStyle(color: MyColors.branco),
                                prefixIcon:
                                    Icon(Icons.person, color: MyColors.branco),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.branco)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.branco)))),
                        TextFormField(
                          controller: mailInputController,
                          style: const TextStyle(color: MyColors.branco),
                          decoration: const InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: TextStyle(color: MyColors.branco),
                              prefixIcon: Icon(Icons.mail_outline,
                                  color: MyColors.branco),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.branco)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.branco))),
                        ),
                        TextFormField(
                            controller: passwordInputController,
                            obscureText: (showPassword == false ? true : false),
                            style: const TextStyle(color: MyColors.branco),
                            decoration: const InputDecoration(
                                labelText: 'Senha',
                                labelStyle: TextStyle(color: MyColors.branco),
                                prefixIcon: Icon(
                                  Icons.key_outlined,
                                  color: MyColors.branco,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.branco)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.branco)))),
                        TextFormField(
                            controller: confirmPasswordInputController,
                            obscureText: (showPassword == false ? true : false),
                            style: const TextStyle(color: MyColors.branco),
                            decoration: const InputDecoration(
                                labelText: 'Confirme a Senha',
                                labelStyle: TextStyle(color: MyColors.branco),
                                prefixIcon: Icon(
                                  Icons.key_outlined,
                                  color: MyColors.branco,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.branco)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.branco)))),
                        Row(
                          children: [
                            Checkbox(
                                value: showPassword,
                                onChanged: (newValue) {
                                  setState(() {
                                    showPassword = newValue;
                                  });
                                }),
                            const Text(
                                style: TextStyle(color: MyColors.branco),
                                'Mostrar senha'),
                          ],
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.botao),
                            onPressed: () {
                              _cadastrar();
                            },
                            child: const Text(
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                'Cadastrar')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                'Voltar'))
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ));
  }

  void _cadastrar() {
    User newUser = User(
        name: nameInputController.text,
        mail: mailInputController.text,
        password: passwordInputController.text,
        keepOn: true);

    saveUser(newUser);
  }

  void saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.activeUser, jsonEncode(user.toJson()));
  }
}
