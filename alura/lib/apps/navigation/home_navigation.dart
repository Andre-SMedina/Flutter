import 'package:alura/apps/navigation/arguments.dart';
import 'package:alura/apps/navigation/page2.dart';
import 'package:flutter/material.dart';

class HomeNavigation extends StatelessWidget {
  // static String routeName = '/';
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Navigation'),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Page2.routeName,
                      arguments: Arguments(
                          title: 'Tela Home', message: 'Testando123'));
                },
                child: const Text('Página 2'))
          ],
        ),
      ),
    );
  }
}
