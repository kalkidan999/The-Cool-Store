import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'input_decoration_theme.dart';
import 'theme_constants.dart';

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.all(defaultPadding),
    backgroundColor: Color(0XFF1E1E1E),
    textStyle: const TextStyle(color: Colors.white, fontSize: 14),
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 32),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
);

const BottomNavigationBarThemeData bottomNavigationBarLightTheme =
    BottomNavigationBarThemeData(
        showSelectedLabels: false,
        elevation: 0,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: primaryColor, size: 20),
        unselectedIconTheme: IconThemeData(color: Color(0xFFCBCBD4), size: 17),
        unselectedItemColor: Color(0xFFCBCBD4),
        unselectedLabelStyle: TextStyle(color: Color(0xFFCBCBD4)),
        selectedItemColor: primaryColor);

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
      fontFamily: 'Urbanist',
      brightness: Brightness.light,
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(size: 20, color: primaryColor),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      cardColor: Theme.of(context).colorScheme.secondary,
      elevatedButtonTheme: elevatedButtonThemeData,
      inputDecorationTheme: lightInputDecorationTheme,
      bottomNavigationBarTheme: bottomNavigationBarLightTheme);
}
