import 'package:bocconi_radio/blocs/bottom_bar_bloc.dart';
import 'package:bocconi_radio/dependency_injection.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final Function(int) onPressed;
  
  const BottomBar({ 
    required this.onPressed, 
    Key ? key 
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final _bottomBar = getIt<BottomBarBloc>();
 
  void _onItemTapped(int index) {
    widget.onPressed(index);
    _bottomBar.pushIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "bottombar",
      child: StreamBuilder(
        stream: _bottomBar.indexes,
        builder: (context, AsyncSnapshot<int> snapshot) {
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
            currentIndex: snapshot.data ?? _bottomBar.getLastIndex(),
            onTap: _onItemTapped,
          );
      },
    )
    );
  }
}