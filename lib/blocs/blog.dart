import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:rxdart/rxdart.dart';
import 'package:webfeed/webfeed.dart';
import 'package:bocconi_radio/blog/article.dart';

class Blog {
  final _articlesWatcher = PublishSubject<Iterable<Article>>();


  Stream<Iterable<Article>> get articles {
    return _articlesWatcher.stream;
  }


  Future<Iterable<Article>?> fetchArticles({
    int start = 0,
  }) async {
    final rssFeed = await _fetchRSSFeed(start);
    final channel = RssFeed.parse(rssFeed.body);
    final articles = channel
      .items
      ?.map((e) => Article.parse(e));

    _tryPushArticles(articles);
    return articles;
  }


  static Future<Response> _fetchRSSFeed(int start) {
    return http.get(
      Uri.https(
        'www.radiobocconi.it',
        '/index.php/blog',
        _getQueryParams(start)
      )
    );
  }

  static Map<String, dynamic> _getQueryParams(int start) {
    return {
      'format': 'feed',
      'type': 'rss',
      'start': start.toString(),
    };
  }

  
  void _tryPushArticles(Iterable<Article>? articles) {
    if (articles == null) {
      _articlesWatcher.addError('null');
      return;
    }
    
    _articlesWatcher.add(articles);
  }


  dispose() {
    _articlesWatcher.close();
  }
}