import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/extensions/date_time_extension.dart';
import 'package:bocconi_radio/widgets/util.dart';
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _getCover(),
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitle(context),
                _getPublishDate(context),
                _getTextPreview(context),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: () {},
              child: const Text('APRI'),
            ),
          )
        ],
      ),
    );
  }


  Widget _getCover() {
    return MaybeShow(
      show: article.hasImage,
      child: Container(
        constraints: const BoxConstraints( 
          maxHeight: 150,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              article.imageUrl!,
            )
          )
        ),
      ) 
    );
  }

  Widget _getPublishDate(context) {
    return Text(
      article.publishDate.toShortString(),
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget _getTitle(context) {
    return Text(
      article.title,
      style: Theme.of(context).textTheme.headline6,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _getTextPreview(context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        article.description,
        style: Theme.of(context).textTheme.subtitle1,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );
  }
}