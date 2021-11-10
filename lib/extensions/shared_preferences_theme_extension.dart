import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesThemeExtension on SharedPreferences {
  static const themeKey = 'theme';
  
  ThemeMode loadTheme() {
    final theme = getInt(themeKey);
    final index = theme ?? ThemeMode.system.index;
    return ThemeMode.values[index];
  }

  void saveTheme(ThemeMode theme) {
    setInt(themeKey, theme.index);
  }
}