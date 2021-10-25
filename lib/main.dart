import 'package:bocconi_radio/pages/webcam_page.dart';
import 'package:bocconi_radio/widgets/bottom_bar.dart';
import 'package:bocconi_radio/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const PageNavigator(),
    );
  }
}

class PageNavigator extends StatefulWidget {
  const PageNavigator({ Key? key }) : super(key: key);

  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
      Widget child = const HomePage();

      switch (pageIndex) {
        case 0:
          child = const HomePage();
          break;
        case 1:
          child = const WebcamPage();
          break;
      }

    return Scaffold(
      bottomNavigationBar: BottomBar(
        (index){
          setState(() {
            pageIndex = index;
          });
        }
      ),
      appBar: AppBar(),
      body: child
    );
  }
}