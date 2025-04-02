import 'package:flutter/material.dart';

abstract class IThemeManager {
  ThemeData get lightTheme;
  ThemeData get darkTheme;
  bool get isDarkMode;
  void toggleTheme();
  void setTheme(bool isDark);
}
