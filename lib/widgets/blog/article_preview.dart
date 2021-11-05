import 'package:bocconi_radio/blog/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticlePreview extends StatelessWidget {
  final Article article;
  
  const ArticlePreview.from({
    Key? key,
    required this.article,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _getCover(),
          _getPublishDate(),
          Text(article.description),
        ],
      ),
    );
  }


  Widget _getCover() {
    return article.hasImage
      ? Image.network(
          article.imageUrl!,
          loadingBuilder: (context, widget, chunk) {
            return const LinearProgressIndicator();
          },
        )
      : const SizedBox.shrink();
  }

  Widget _getPublishDate() {
    return Text(article.publishDate.toString());
  }
}