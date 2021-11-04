import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoTitle extends StatelessWidget {
  String title;

  InfoTitle({
    required this.title,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), 
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

