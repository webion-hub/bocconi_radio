import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/widgets/bottom_bar.dart';
import 'package:bocconi_radio/widgets/custom_appbar.dart';
import 'package:bocconi_radio/widgets/image_with_loading.dart';
import 'package:bocconi_radio/widgets/text_with_loading.dart';
import 'package:bocconi_radio/widgets/util/maybe_show.dart';
import 'package:bocconi_radio/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  const ArticlePage({ 
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      bottomNavigationBar: BottomBar(
        onPressed: (index){
          Navigator.pop(context, index);
        }
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            Hero(
              tag: 'article-image-${article.title}',
              child: _getCover(),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                top: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    article.publishDate.toShortString(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextWithLoading(
                      skeletonHeight: 200,
                      future: article.loadContent(),
                      builder: (text){
                        return RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.subtitle1,
                            children: text,
                          ),
                        );
                      },
                    ),
                  )  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCover() {
    return MaybeShow(
      show: article.hasImage,
      child: ImageWithLoading(
        height: 250,
        src: article.imageUrl!,
      )
    );
  }
}