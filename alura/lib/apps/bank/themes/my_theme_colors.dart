import 'package:flutter/material.dart';

enum EnumColors {
  spent(Color.fromRGBO(255, 175, 29, 1.0)),
  income(Color.fromRGBO(191, 69, 198, 1.0));

  final Color color;
  const EnumColors(this.color);
}

class MyThemeColors {
  static const MaterialColor primaryColor = Colors.purple;
  static const List<Color> headerGradient = [
    Color.fromRGBO(103, 99, 234, 1),
    Color.fromRGBO(155, 105, 254, 1),
    Color.fromRGBO(195, 107, 254, 1)
  ];
  static const division = Color.fromRGBO(166, 166, 166, 1.0);
  static Color recentActivity(EnumColors enumColor) => enumColor.color;
}
