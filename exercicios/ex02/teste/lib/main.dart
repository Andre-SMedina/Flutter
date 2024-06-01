import 'package:flutter/material.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primeiro Exercício',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: const TextStyle(color: Colors.white, fontSize: 30),
              child: Column(
                children: [
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    'Location Changer',
                  ),
                  Container(
                    height: 15,
                  ),
                  const Text(
                    'Plugin App for Tinder',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    height: 35,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('Login with Facebook'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
