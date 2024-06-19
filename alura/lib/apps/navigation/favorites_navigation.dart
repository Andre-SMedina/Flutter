import 'package:flutter/material.dart';

class FavoritesNavigation extends StatelessWidget {
  const FavoritesNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    Object? data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Favorites Navigation'),
            ElevatedButton(
                onPressed: () {
                  print(data);
                },
                child: const Text('Teste')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Voltar'))
          ],
        ),
      ),
    );
  }
}
