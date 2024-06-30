import 'package:alura/apps/bank/components/content_division.dart';
import 'package:alura/apps/bank/components/sections/account_actions.dart';
import 'package:alura/apps/bank/components/sections/account_points.dart';
import 'package:alura/apps/bank/components/sections/header.dart';
import 'package:alura/apps/bank/components/sections/recent_activity.dart';
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
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: <Widget>[
            Header(),
            RecentActivity(),
            AccountActions(),
            AccountPoints(),
          ],
        )),
      ),
    );
  }
}
