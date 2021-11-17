import 'package:flutter/material.dart';

class MaybeShow extends StatelessWidget {
  final bool show;
  final Widget child;
  final Widget alternativeChild;
  
  const MaybeShow({
    Key? key,
    required this.show,
    required this.child,
    this.alternativeChild = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show
      ? child
      : alternativeChild;
  }
}