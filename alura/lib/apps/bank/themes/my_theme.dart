import 'package:alura/apps/bank/themes/my_theme_colors.dart';
import 'package:flutter/material.dart';

ThemeData MyTheme = ThemeData(
  primarySwatch: MyThemeColors.primaryColor,
  primaryColor: MyThemeColors.primaryColor,
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16),
    bodyLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  ),
);
