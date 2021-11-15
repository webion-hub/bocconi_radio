import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/blocs/blog.dart';
import 'package:bocconi_radio/blog/blog_page_navigator.dart';
import 'package:bocconi_radio/dependency_injection.dart';
import 'package:bocconi_radio/widgets/blog/article_preview.dart';
import 'package:bocconi_radio/widgets/util.dart';
import 'package:flutter/material.dart';


class BlogPreviewPage extends StatefulWidget {
  const BlogPreviewPage({Key? key})
    : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlogPreviewState();
}

class _BlogPreviewState extends State<StatefulWidget> {
  final _blogNavigator = BlogPageNavigator(getIt<Blog>());

  _BlogPreviewState() {
    _blogNavigator.fetchNextArticles();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          MaybeShow(
            show: _blogNavigator.showLeft,
            child: FloatingActionButton(
              heroTag: "prev",
              child: const Icon(Icons.arrow_back),
              onPressed: () {
                _blogNavigator.fetchNextArticles();
              },
            )
          ),
          MaybeShow(
            show: _blogNavigator.showRight,
            child: FloatingActionButton(
              heroTag: "next",
              child: const Icon(Icons.arrow_forward),
              onPressed: () {
                _blogNavigator.fetchNextArticles();
              },
            )
          ),
        ],
      ),
      body: StreamBuilder<Iterable<Article>>(
        stream: _blogNavigator.blog.articles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            case ConnectionState.active:
              break;

            case ConnectionState.waiting:
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }

          if (!snapshot.hasData) {
            return const Text('Nothing');
          }
          
          final articles = snapshot.data;
          if (articles == null) {
            return const Text('Error');
          }

          return ListView.builder(
            itemCount: articles.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return ArticlePreview.from(
                article: articles.elementAt(i),
              );
            }
          );
        }
      ),
    );
  }
}