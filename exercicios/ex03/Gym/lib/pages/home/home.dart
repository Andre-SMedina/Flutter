import 'package:flutter/material.dart';
// import 'package:Gym/_comum/cores.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cont = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Gym'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    'Sair',
                  )),
              Text(
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 50),
                  '$cont'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              cont++;
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
