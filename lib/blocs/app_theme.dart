import 'package:bocconi_radio/dependency_injection.dart';
import 'package:bocconi_radio/extensions/shared_preferences_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AppTheme {
  static const $default = ThemeMode.system;

  final _preferences = getIt.getAsync<SharedPreferences>();
  final _updateSubject = BehaviorSubject.seeded($default);

  Stream<ThemeMode> get stream {
    return _updateSubject.stream;
  }


  @factoryMethod
  static AppTheme create() {
    return AppTheme()..load();
  }


  void useDarkMode(bool v) {
    useLightMode(!v);
  }

  void useLightMode(bool v) {
    update(v
      ? ThemeMode.light
      : ThemeMode.dark
    );
  }

  void update(ThemeMode newTheme) {
    _updateSubject.add(newTheme);
    _save(newTheme);
  }


  Future<void> load() {
    return _preferences
      .then((p) => p.loadTheme())
      .then((t) => update(t));
  }

  void _save(ThemeMode theme) {
    _preferences.then((p) => p.saveTheme(theme));
  }
}