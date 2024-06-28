import 'package:alura/apps/bank/components/sections/header.dart';
import 'package:flutter/material.dart';

class HomePageBank extends StatefulWidget {
  const HomePageBank({super.key});
  static String routeName = '/home';
  @override
  State<HomePageBank> createState() => _HomePageBankState();
}

class _HomePageBankState extends State<HomePageBank> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Header(),
        ],
      )),
    );
  }
}
