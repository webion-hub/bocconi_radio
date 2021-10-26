import 'package:bocconi_radio/blog/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticlePreview extends StatelessWidget {
  final Article post;
  
  const ArticlePreview.from({
    Key? key,
    required this.post,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _getCover(),
          _getPublishDate(),
          Text(post.description),
        ],
      ),
    );
  }


  Widget _getCover() {
    return post.hasImage
      ? Image.network(
        post.imageUrl!,
        loadingBuilder: (context, widget, chunk) {
          return const LinearProgressIndicator();
        },
      )
      : const SizedBox.shrink();
  }

  Widget _getPublishDate() {
    return post.hasPublishDate
      ? Text(post.publishDate!.toString())
      : const SizedBox.shrink();
  }
}