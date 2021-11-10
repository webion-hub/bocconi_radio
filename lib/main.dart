import 'package:bocconi_radio/blocs/app_theme.dart';
import 'package:bocconi_radio/dependency_injection.dart';
import 'package:bocconi_radio/widgets/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final theme = ThemeData();
  final _appTheme = getIt<AppTheme>();

  MyApp({Key? key})
    : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
      stream: _appTheme.stream,
      initialData: AppTheme.$default,
      builder: (context, snapshot) {
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
          themeMode: snapshot.data ?? AppTheme.$default,
          home: const App(),
        );
      }
    );
  }
}
