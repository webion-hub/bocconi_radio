import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/extensions/date_time_extension.dart';
import 'package:bocconi_radio/pages/article_page.dart';
import 'package:bocconi_radio/widgets/image_with_loading.dart';
import 'package:bocconi_radio/widgets/util/maybe_show.dart';
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
  final borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Hero(
                tag: 'article-image-${widget.article.title}',
                child: _getCover(),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getTitle(context),
                    _getPublishDate(context),
                    _getTextPreview(context),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: borderRadius,
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArticlePage(article: widget.article)),
                  );
                },
              )
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
        borderRadius: borderRadius,

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