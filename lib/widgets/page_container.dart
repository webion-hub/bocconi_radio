import 'package:bocconi_radio/widgets/audio_overlay.dart';
import 'package:bocconi_radio/widgets/bottom_bar.dart';
import 'package:bocconi_radio/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  final Widget body;
  final Function(int)? onBottomBarPressed;

  const PageContainer({ 
    required this.body,
    this.onBottomBarPressed,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const CustomAppbar(),
      bottomNavigationBar: BottomBar(onPressed: onBottomBarPressed),
      body: Stack(
        children: [
          body,
          Align(
            alignment: Alignment.bottomCenter,
            child: AudioOverlay(),
          )
        ],
      ),
    );
  }
}