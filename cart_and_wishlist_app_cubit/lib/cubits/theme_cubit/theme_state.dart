import 'package:flutter/material.dart';

abstract class ThemeState {
  bool get isDark;
  ThemeData get themData;
}

class DarkModeState extends ThemeState {
  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    primaryColorDark: Colors.black12,
    brightness: Brightness.dark,
  );

  @override
  bool get isDark => true;

  @override
  ThemeData get themData => darkTheme;
}

class LightModeState extends ThemeState {
  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    primaryColorDark: Colors.white,
    brightness: Brightness.light,
  );

  @override
  bool get isDark => false;

  @override
  ThemeData get themData => lightTheme;
}
