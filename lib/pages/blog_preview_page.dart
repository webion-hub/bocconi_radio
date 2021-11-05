import 'package:bocconi_radio/blog/article.dart';
import 'package:bocconi_radio/blocs/blog.dart';
import 'package:bocconi_radio/widgets/blog/article_preview.dart';
import 'package:flutter/material.dart';


class BlogPreviewPage extends StatefulWidget {
  const BlogPreviewPage({Key? key})
    : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlogPreviewState();
}

class _BlogPreviewState extends State<StatefulWidget> {
  final _blog = Blog();
  bool showLeft = false;
  bool showRight = true;
  int currentOffset = 0;


  _BlogPreviewState() {
    _blog.fetchArticles();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Test'),
      ),
      floatingActionButton: Row(
        children: [
          (showLeft 
            ? FloatingActionButton(
                heroTag: "prev",
                child: const Icon(Icons.arrow_back),
                onPressed: () {
                  _fetchArticles(direction: -1);
                },
              )
            : const SizedBox.shrink()
          ),
          (showRight
            ? FloatingActionButton(
                heroTag: "next",
                child: const Icon(Icons.arrow_forward),
                onPressed: () {
                  _fetchArticles(direction: 1);
                },
              )
            : const SizedBox.shrink()
          ),
        ],
      ),
      body: StreamBuilder<Iterable<Article>>(
        stream: _blog.articles,
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


  void _fetchArticles({
    required int direction
  }) async {
    setState(() {
      currentOffset += direction * 12;
    });

    _blog.fetchArticles(
      start: currentOffset,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _blog.dispose();
  }
}