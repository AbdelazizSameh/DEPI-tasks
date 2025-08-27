import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    primaryColorDark: Colors.black12,
    brightness: Brightness.dark,
  );
  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    primaryColorDark: Colors.white,
    brightness: Brightness.light,
  );
  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
