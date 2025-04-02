import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_themes.dart';
import 'i_theme_manager.dart';

class GetXThemeManager implements IThemeManager {
  final _isDarkMode = false.obs;

  @override
  bool get isDarkMode => _isDarkMode.value;

  @override
  ThemeData get lightTheme => AppThemes.light;

  @override
  ThemeData get darkTheme => AppThemes.dark;

  @override
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void setTheme(bool isDark) {
    _isDarkMode.value = isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
