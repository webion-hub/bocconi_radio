import 'package:http/http.dart' show Response, Client;
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webfeed/webfeed.dart';
import 'package:bocconi_radio/blog/article.dart';


@singleton
class Blog {
  final _client = Client();
  final _articlesWatcher = 
    PublishSubject<Iterable<Article>>();

  Stream<Iterable<Article>> get articles {
    return _articlesWatcher.stream;
  }


  Future<Iterable<Article>?> fetchArticles({
    int start = 0,
  }) async {
    final rssFeed = await _fetchRSSFeed(start);
    final channel = RssFeed.parse(rssFeed.body);
    final articles = _parseItems(channel);

    _tryPushArticles(articles);
    return articles;
  }


  Future<Response> _fetchRSSFeed(int start) {
    return _client.get(
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


  static Iterable<Article>? _parseItems(RssFeed feed) {
    return feed
      .items
      ?.map((e) => Article.parse(e));
  }

  
  void _tryPushArticles(Iterable<Article>? articles) {
    if (articles == null) {
      _articlesWatcher.addError('null');
      return;
    }
    
    _articlesWatcher.add(articles);
  }


  @disposeMethod
  dispose() {
    _articlesWatcher.close();
  }
}