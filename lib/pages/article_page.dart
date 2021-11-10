import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/widgets/custom_appbar.dart';
import 'package:bocconi_radio/widgets/image_with_loading.dart';
import 'package:bocconi_radio/widgets/util.dart';
import 'package:bocconi_radio/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ArticlePage extends StatelessWidget {
  Article article;

  ArticlePage({ 
    required this.article,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Hero(
              tag: 'article-image-${article.title}',
              child: _getCover(),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                top: 16
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
                    child: FutureBuilder(
                      future: article.loadContent(),
                      builder: (context, AsyncSnapshot<String> snapshot){
                        if(snapshot.hasData){
                          return Text(
                            snapshot.data ?? "",
                            style: Theme.of(context).textTheme.subtitle1,              
                          );
                        }

                        return const LinearProgressIndicator();
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