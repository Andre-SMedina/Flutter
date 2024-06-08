import 'package:Gym/widgets/myElevatedBtn.dart';
import 'package:Gym/widgets/myText.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyElevatedBtn(
                onPressed: () {
                  print("Testando");
                },
                title: 'Meu botao',
              ),
              const Mytext(texto: 'Meu texto2'),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
