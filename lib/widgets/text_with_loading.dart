import 'package:bocconi_radio/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class TextWithLoading extends StatelessWidget {
  final Widget Function(List<TextSpan>) builder;
  final Future<List<TextSpan>> future;

  const TextWithLoading({
    Key? key,
    required this.future,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TextSpan>>(
      future: future,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return builder(snapshot.data ?? []);
        }

        return Column(
          children: [
            for (int i = 0; i < 10; i++) 
              getSkeletonRow()
          ],
        );
      },
    );
  }

  Widget getSkeletonRow() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      height: 16,
      child: Skeleton(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

