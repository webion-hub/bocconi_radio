import 'package:flutter/material.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({ Key? key })
    : super(key: key);

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Theme.of(context).primaryColor,
      value: darkMode, 
      onChanged: (status){
        setState(() {
          darkMode = status;
        });
      }
    );
  }
}


