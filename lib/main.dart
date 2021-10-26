import 'package:bocconi_radio/pages/blog_preview_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog test',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlogPreviewPage(),
    );
  }
}