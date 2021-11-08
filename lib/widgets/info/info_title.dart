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
      padding: const EdgeInsets.symmetric(horizontal: 16), 
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}

