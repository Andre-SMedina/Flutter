import 'package:flutter/material.dart';
import 'package:inicio3/_comum/cores.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(style: TextStyle(color: MyColors.branco), 'My App'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [MyColors.azul, MyColors.branco])),
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
              children: [TextFormField.new()],
            ))
          ],
        ),
      ),
    );
  }
}
