import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

// String getTime() {
//   String hours = DateTime.now().hour.toString().padLeft(2, '0');
//   String minutes = DateTime.now().minute.toString().padLeft(2, '0');
//   String seconds = DateTime.now().second.toString().padLeft(2, '0');
//   String currentTime = '$hours:$minutes:$seconds';
//   return currentTime;
// }

tchauTime() {
  var hora = DateTime.now().hour;
  String dia = (hora > 18)
      ? (DateTime.now().day + 1).toString()
      : DateTime.now().day.toString();
  String mes = (DateTime.now().month.toString().length == 1)
      ? '0${DateTime.now().month.toString()}'
      : DateTime.now().month.toString();
  String ano = DateTime.now().year.toString();
  var horaSaida = DateTime.parse('$ano-$mes-$dia 18:00:00');
  var tempoFaltante =
      horaSaida.difference(DateTime.now()).toString().split('.')[0];

  // print(DateTime.parse('2024-06-21 18:00:00').difference(DateTime.now()));
  return tempoFaltante;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key? key_});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clock',
      theme: ThemeData.dark().copyWith(
        // Update the dark theme
        primaryColor: Colors.blueGrey, // Update the primary color
      ),
      home: const MyHomePage(title: 'Clock'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, Key? key_, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String timeVar = tchauTime();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _incrementCounter);
  }

  void _incrementCounter(Timer timer) {
    setState(() {
      timeVar = tchauTime();
      tchauTime();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Faltam',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              timeVar,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const Text('Para dizer TCHAU!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ))
            // showTimePicker(context: context, initialTime: initialTime)
          ],
        ),
      ),
    );
  }
}
