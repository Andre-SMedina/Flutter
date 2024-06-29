import 'package:alura/apps/bank/components/box_card.dart';
import 'package:alura/apps/bank/components/color_dot.dart';
import 'package:alura/apps/bank/components/content_division.dart';
import 'package:alura/apps/bank/components/sections/header.dart';
import 'package:alura/apps/bank/themes/my_theme_colors.dart';
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
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          const Header(),
          BoxCard(
            boxContent:
                ColorDot(color: MyThemeColors.recentActivit(EnumColors.spent)),
          ),
          const ContentDivision()
        ],
      )),
    );
  }
}
