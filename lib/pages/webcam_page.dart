import 'package:flutter/material.dart';

class WebcamPage extends StatelessWidget {
  const WebcamPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Webcam',
        ),
      ),
    );
  }
}