import 'package:bocconi_radio/blocs/app_theme.dart' as app_theme;
import 'package:bocconi_radio/blocs/app_theme.dart';
import 'package:bocconi_radio/dependency_injection.dart';
import 'package:flutter/material.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({ Key? key })
    : super(key: key);

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  final _appTheme = getIt<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
      stream: _appTheme.values,
      builder: (context, snapshot) {
        final value =
          snapshot.data?.isDark ?? false;
        
        return SwitchListTile(
          title: const Text('Tema scuro'),
          secondary: const Icon(Icons.dark_mode_rounded),
          activeColor: Theme.of(context).primaryColor,
          value: value,
          onChanged: (value) {
            _appTheme.hasDarkMode = value;
          }
        );
      }
    );
  }
}


