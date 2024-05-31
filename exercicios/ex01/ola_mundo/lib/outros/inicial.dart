import 'package:flutter/material.dart';

void main() {
  runApp(AppWidget(
    title: 'Olá Mundo2',
  ));
}

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        textDirection: TextDirection.ltr,
        style: TextStyle(color: Colors.white, fontSize: 30.0),
      ),
    );
  }
}
