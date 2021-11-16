import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/blocs/blog.dart';
import 'package:bocconi_radio/blog/blog_page_navigator.dart';
import 'package:bocconi_radio/dependency_injection.dart';
import 'package:bocconi_radio/widgets/blog/article_preview.dart';
import 'package:flutter/material.dart';


class BlogPreviewPage extends StatefulWidget {
  const BlogPreviewPage({Key? key})
    : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlogPreviewState();
}

class _BlogPreviewState extends State<StatefulWidget> {
  final _blogNavigator = BlogPageNavigator(getIt<Blog>());
  List<Article> articles = [];

  _BlogPreviewState() {
    _blogNavigator.fetchNextArticles();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<Article>>(
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
        
        final newArticles = snapshot.data;
        if (newArticles == null) {
          return const Text('Error');
        }

        articles.addAll(newArticles);

        return InfiniteListView(     
          itemCount: articles.length,
          onRefresh: () async {
            articles = [];
            _blogNavigator.refreshArticles();
          },
          onScrollEnd: () {
            _blogNavigator.fetchNextArticles();
          },
          itemBuilder: (context, i) {
            return ArticlePreview.from(
              article: articles.elementAt(i),
            );
          }
        );
      }
    );
  }
}

class InfiniteListView extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Function() onScrollEnd;
  final Function(BuildContext, int) itemBuilder;
  final int itemCount;

  const InfiniteListView({ 
    required this.onRefresh,
    required this.onScrollEnd,
    required this.itemBuilder,
    required this.itemCount,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(          
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          if(i >= itemCount - 6) {
            onScrollEnd();
          }

          return itemBuilder(context, i);
        }
      ),
    );
  }
}