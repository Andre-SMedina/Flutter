import 'package:acesso_mp/pages/home_page.dart';
import 'package:acesso_mp/teste/teste.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(CameraApp(
    cameras: cameras,
  ));
  // runApp(MyTest());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Acesso MP',
      theme: ThemeData(
          // primarySwatch: Colors.red,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 28),
            backgroundColor: Color.fromARGB(255, 14, 0, 167),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2, color: Color.fromARGB(255, 14, 0, 167)),
            ),
            border: OutlineInputBorder(borderSide: BorderSide()),
          ),
          textTheme: const TextTheme(headlineLarge: TextStyle(fontSize: 20))),
      home: const HomePage(),
    );
  }
}
