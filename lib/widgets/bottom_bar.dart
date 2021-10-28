
import 'package:bocconi_radio/widgets/icon_button_with_label.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  String currentRoute;
  GlobalKey<NavigatorState> navigatorKey;

  BottomBar({
    this.currentRoute = "",  
    required this.navigatorKey,
    Key? key
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {

    bool isActive(String url){
      return widget.currentRoute == url;
    }

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButtonWithLabel(
            active: isActive("/blog"),
            onPressed: (){
              if(isActive('/blog')){return;}
              widget.navigatorKey.currentState?.pushNamed("/blog");
            },
            text: "Blog",
            icon: Icons.feed_rounded     
          ),
          IconButtonWithLabel(
            active: isActive("/webcam"),
            onPressed: (){
              if(isActive('/webcam')){return;}
              widget.navigatorKey.currentState?.pushNamed('/webcam');
            },
            text: "Webcam",
            icon: Icons.videocam_rounded   
          ),
        ],
      ),
    );
  }
}