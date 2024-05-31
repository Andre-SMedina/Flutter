import 'package:flutter/material.dart';
import 'package:ola_mundo/app_controller.dart';
import 'package:ola_mundo/home_page.dart';
import 'package:ola_mundo/login_page.dart';

// import 'home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.red,
              brightness: AppController.instance.isDarkTheme
                  ? Brightness.dark
                  : Brightness.light),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            '/home': (context) => HomePage(),
          },
          // home: LoginPage(),
        );
      },
    );
  }
}
