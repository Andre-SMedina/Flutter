import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int cont = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Gym App'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          child: Text(style: TextStyle(fontSize: 50), '$cont'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              cont++;
            });
          },
          child: Icon(Icons.add)),
    );
  }
}
