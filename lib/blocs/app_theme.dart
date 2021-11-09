
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class AppTheme {
  final _updateStream =
    BehaviorSubject.seeded(ThemeMode.light);

  Stream<ThemeMode> get values {
    return _updateStream.stream;
  }


  set hasDarkMode(bool v) => _setMode(v);
  set hasLightMode(bool v) => _setMode(!v);

  void toggle() {
    update(
      _updateStream.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light
    );
  }

  void update(ThemeMode newTheme) {
    _updateStream.add(newTheme);
  }

  void _setMode(bool darkMode) {
    update(
      darkMode
        ? ThemeMode.dark
        : ThemeMode.light
    );
  }
}

extension ThemeModeExtension on ThemeMode {
  bool get isDark => this == ThemeMode.dark;
  bool get isLight => this == ThemeMode.light;
}