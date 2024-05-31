import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red), home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Text('Contador: $counter'),
        onTap: () {
          setState(() {
            counter++;
          });
        },
      ),
    );
  }
}
