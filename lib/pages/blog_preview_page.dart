import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/blocs/blog.dart';
import 'package:bocconi_radio/widgets/blog/article_preview.dart';
import 'package:flutter/material.dart';

class BlogPreviewPage extends StatelessWidget {
  late final Stream<Iterable<Article>?> _articles;

  BlogPreviewPage({Key? key}) : super(key: key) {
    _articles = Stream.fromFuture(
      Blog().getArticles()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Test'),
      ),
      body: Center(
        child: StreamBuilder<Iterable<Article>?>(
          stream: _articles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                break;

              case ConnectionState.waiting:
              default:
                return const CircularProgressIndicator();
            }

            if (!snapshot.hasData) {
              return const Text('Nothing');
            }
            
            final posts =
              snapshot.data;

            if (posts == null) {
              return const Text('Null');
            }

            if (posts.isEmpty) {
              return const Text('Empty list');
            }

            return ListView.builder(
              itemCount: posts.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return ArticlePreview.from(
                  post: posts.elementAt(i),
                );
              }
            );
          }
        ),
      ),
    );
  }
}