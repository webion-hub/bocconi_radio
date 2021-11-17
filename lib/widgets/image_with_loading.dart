import 'package:bocconi_radio/widgets/util/maybe_show.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ImageWithLoading extends StatelessWidget {
  final double height;
  final String src;
  final BorderRadius borderRadius;

  const ImageWithLoading({ 
    required this.height,
    required this.src,
    this.borderRadius = BorderRadius.zero,
    Key? key 
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final image = NetworkImage(src);
    final _streamImageLoader = BehaviorSubject<bool>();

    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          _streamImageLoader.add(true);
        },
      ),
    );

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image
        )
      ),
      child: StreamBuilder(
        stream: _streamImageLoader,
        initialData: false,
        builder: (context, AsyncSnapshot snapshot){
          return MaybeShow(
            show: !snapshot.data, 
            child: const Center(
              child: CircularProgressIndicator()
            ),
            alternativeChild: Container(),
          );
        },
      ),
    );
  }
}