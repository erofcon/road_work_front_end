import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white, foregroundColor: Colors.black54),
    tabBarTheme: const TabBarTheme(labelColor: Colors.black),
    // scaffoldBackgroundColor: const Color.fromRGBO(243,243,249, 1),
  );
  final darkTheme = ThemeData.dark().copyWith();
}
