import 'dart:developer';

import 'package:bocconi_radio/pages/home_page.dart';
import 'package:bocconi_radio/pages/webcam_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  Function(int) indexCallback;

  BottomBar(this.indexCallback, {Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      onTap: (value) {
        setState(() => index = value);
        widget.indexCallback(value);
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_rounded)
        ),
        BottomNavigationBarItem(
          label: 'Webcam',
          icon: Icon(Icons.videocam_rounded)),
        BottomNavigationBarItem(
          label: 'Blog',
          icon: Icon(Icons.article_rounded)
        ),
        BottomNavigationBarItem(
          label: 'Info',
          icon: Icon(Icons.info_rounded)
        )
      ],
    );
  }
}