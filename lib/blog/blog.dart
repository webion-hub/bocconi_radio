import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class Blog {
  static Future<List<RssItem>?> getPosts({
    int start = 0,
  }) async {
    final rssFeed = await _fetchRSSFeed(start);
    final channel = RssFeed.parse(rssFeed.body);

    return channel.items;
  }


  static Future<http.Response> _fetchRSSFeed(int start) {
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
}