import 'package:flutter/material.dart';

class MaybeShow extends StatelessWidget {
  final bool show;
  final Widget child;
  
  const MaybeShow({
    Key? key,
    required this.show,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show
      ? child
      : const SizedBox.shrink();
  }
}