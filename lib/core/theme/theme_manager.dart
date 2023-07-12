import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  final ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;
}
