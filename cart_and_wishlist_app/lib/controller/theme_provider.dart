import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
