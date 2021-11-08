import 'package:flutter/material.dart';

class InfoTitle extends StatelessWidget {
  final String title;

  const InfoTitle({
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

