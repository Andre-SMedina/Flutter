import 'package:alura/apps/bank/pages/home_page_bank.dart';
import 'package:alura/apps/bank/themes/my_theme.dart';
import 'package:flutter/material.dart';

class InitBank extends StatelessWidget {
  const InitBank({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      title: 'Bank',
      home: const HomePageBank(),
      initialRoute: '/',
      routes: {HomePageBank.routeName: (context) => const HomePageBank()},
    );
  }
}
