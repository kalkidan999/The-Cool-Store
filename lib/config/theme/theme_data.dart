import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'input_decoration_theme.dart';
import 'theme_constants.dart';

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.all(defaultPadding),
    backgroundColor: Color(0XFF1E1E1E),
    textStyle: const TextStyle(color: Colors.white),
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 32),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
    ),
  ),
);

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      iconTheme: const IconThemeData(size: 20, color: primaryColor),
      scaffoldBackgroundColor: Colors.white,
      textTheme:
          const TextTheme(bodyMedium: TextStyle(color: Color(0XFF252425))),
      cardColor: Theme.of(context).colorScheme.secondary,
      elevatedButtonTheme: elevatedButtonThemeData,
      inputDecorationTheme: lightInputDecorationTheme);
}
