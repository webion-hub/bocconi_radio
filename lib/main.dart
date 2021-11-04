import 'package:bocconi_radio/widgets/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final theme = ThemeData();

  MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bocconi Radio',
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.red,
          secondary: Colors.red,
        ),
        primaryColor: Colors.red,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF212121),
      ),
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      themeMode: ThemeMode.dark,
      home: const App(),
    );
  }
}
