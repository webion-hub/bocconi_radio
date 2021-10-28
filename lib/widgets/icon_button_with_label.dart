import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconButtonWithLabel extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active; 
  Function() onPressed;

  IconButtonWithLabel({
    Key? key,
    this.active = false,
    required this.text, 
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = active 
      ? Theme.of(context).primaryColor
      : Theme.of(context).disabledColor;

    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(buttonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          )
        )
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: 48,
        width: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            Flexible(
              child: Text(
                text, 
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10)
              )            
            )
          ],
        ),
      ),
    );
  }
}