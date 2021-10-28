import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:webfeed/webfeed.dart';
import 'package:bocconi_radio/blog/article.dart';

class Blog {
  Future<Iterable<Article>?> getArticles({
    int start = 0,
  }) async {
    final rssFeed = await _fetchRSSFeed(start);
    final channel = RssFeed.parse(rssFeed.body);

    return channel
      .items
      ?.map((e) => Article.parse(e));
  }


  Future<Response> _fetchRSSFeed(int start) {
    return http.get(
      Uri.https(
        'www.radiobocconi.it',
        '/index.php/blog',
        _getQueryParams(start)
      )
    );
  }

  Map<String, dynamic> _getQueryParams(int start) {
    return {
      'format': 'feed',
      'type': 'rss',
      'start': start.toString(),
    };
  }
}