import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/extensions/date_time_extension.dart';
import 'package:bocconi_radio/pages/article_page.dart';
import 'package:bocconi_radio/widgets/image_with_loading.dart';
import 'package:bocconi_radio/widgets/util.dart';
import 'package:flutter/material.dart';

class ArticlePreview extends StatefulWidget {
  final Article article;
  
  const ArticlePreview.from({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<ArticlePreview> createState() => _ArticlePreviewState();
}

class _ArticlePreviewState extends State<ArticlePreview> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Hero(
            tag: 'article-image-${widget.article.title}',
            child: _getCover(),
          ),
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
              child: const Text('APRI'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticlePage(article: widget.article)),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _getCover() {
    return MaybeShow(
      show: widget.article.hasImage,
      child: ImageWithLoading(
        height: 200,
        src: widget.article.imageUrl!,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )
      )
    );
  }

  Widget _getPublishDate(context) {
    return Text(
      widget.article.publishDate.toShortString(),
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget _getTitle(context) {
    return Text(
      widget.article.title,
      style: Theme.of(context).textTheme.headline6,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _getTextPreview(context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        widget.article.description,
        style: Theme.of(context).textTheme.subtitle1,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );
  }
}