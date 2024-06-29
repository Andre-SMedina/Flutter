import 'package:alura/apps/bank/themes/my_theme_colors.dart';
import 'package:flutter/material.dart';

class ContentDivision extends StatelessWidget {
  const ContentDivision({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration:
          BoxDecoration(border: Border.all(color: MyThemeColors.division)),
    );
  }
}
