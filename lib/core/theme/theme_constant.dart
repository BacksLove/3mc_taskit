import 'package:flutter/material.dart';

const colorPrimary = Colors.blueAccent;
const colorAccent = Colors.blue;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: colorPrimary,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 40),
      ),
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(fontSize: 12),
    bodyMedium: TextStyle(fontSize: 17),
    headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  dropdownMenuTheme:
      const DropdownMenuThemeData(textStyle: TextStyle(color: Colors.white)),
  useMaterial3: true,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.amberAccent,
  textTheme: const TextTheme(
    bodySmall: TextStyle(fontSize: 12),
    bodyMedium: TextStyle(fontSize: 17),
    headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Colors.white, fontSize: 90)),
  useMaterial3: true,
);
