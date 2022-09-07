import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: const Color.fromRGBO(90, 143, 187, 1),
    colorScheme: const ColorScheme.light(
      primary: Color.fromRGBO(90, 143, 187, 1),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(90, 143, 187, 1),
        foregroundColor: Colors.white),
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color.fromRGBO(90, 143, 187, 1)))),
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color.fromRGBO(187, 134, 251, 1),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromRGBO(187, 134, 251, 1),
      surface: Color.fromRGBO(29, 38, 51, 1),
      secondary: Color.fromRGBO(187, 134, 251, 1),
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(29, 38, 51, 1),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(33, 45, 59, 1),
        foregroundColor: Colors.white),
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color.fromRGBO(33, 45, 59, 1)))),
    drawerTheme:
        const DrawerThemeData(backgroundColor: Color.fromRGBO(33, 45, 59, 1)),
    dialogBackgroundColor: const Color.fromRGBO(33, 45, 59, 1),
    canvasColor: const Color.fromRGBO(29, 38, 51, 1),
    cardColor: const Color.fromRGBO(33, 45, 59, 1)
  );
}
