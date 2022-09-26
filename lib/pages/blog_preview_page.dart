import 'dart:async';

import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/blocs/blog.dart';
import 'package:bocconi_radio/blog/blog_page_navigator.dart';
import 'package:bocconi_radio/dependency_injection.dart';
import 'package:bocconi_radio/widgets/blog/article_preview.dart';
import 'package:bocconi_radio/widgets/infinite_list_view.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


class BlogPreviewPage extends StatefulWidget {
  const BlogPreviewPage({Key? key})
    : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlogPreviewState();
}

class _BlogPreviewState extends State<StatefulWidget> {
  final _blogNavigator = BlogPageNavigator(getIt<Blog>());
  final _articles = BehaviorSubject.seeded(
    const Iterable<Article>.empty()
  );

  _BlogPreviewState() {
    _blogNavigator
      .articles
      .listen(_onArticlesReceived);

    _blogNavigator.fetchNextArticles();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<Article>>(
      stream: _articles.stream,
      builder: (context, snapshot) {
        
        if (_shouldDisplayLoadingRing(snapshot.connectionState)) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return const Text('No articles to show');
        }
        
        final articles = snapshot.data;
        if (articles == null) {
          return const Text('Error when fetching articles');
        }

        return InfiniteListView(
          itemCount: articles.length,
          onRefresh: () async {
            _articles.add([]);
            await _blogNavigator.refreshArticles();
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


  void _onArticlesReceived(Iterable<Article> articles) {
    _articles.add(
      _articles.value.concat(articles)
    );
  }

  bool _shouldDisplayLoadingRing(ConnectionState state) {
    switch (state) {
      case ConnectionState.done:
      case ConnectionState.active:
        return false;

      case ConnectionState.waiting:
      default:
        return true;
    }
  }
}