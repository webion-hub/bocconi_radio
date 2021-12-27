import 'package:bocconi_radio/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class TextWithLoading extends StatelessWidget {
  final Widget Function(List<TextSpan>) builder;
  final Future<List<TextSpan>> future;
  final double skeletonHeight;

  const TextWithLoading({
    Key? key,
    required this.future,
    required this.builder,
    this.skeletonHeight = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TextSpan>>(
      future: future,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return builder(snapshot.data ?? []);
        }

        return SizedBox(
          height: skeletonHeight,
          child: const Skeleton(),
        );
      },
    );
  }
}

