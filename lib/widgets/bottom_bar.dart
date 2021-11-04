import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  Function(int) onPressed;
  BottomBar({ 
    required this.onPressed, 
    Key ? key 
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
 
  void _onItemTapped(int index) {
    widget.onPressed(index);

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.radio_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feed_rounded),
          label: 'Blog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videocam_rounded),
          label: 'Webcam',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}