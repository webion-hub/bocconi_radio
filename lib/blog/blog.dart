import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:webfeed/webfeed.dart';
import 'package:bocconi_radio/blog/post.dart';

class Blog {
  static Future<Iterable<Post>?> getPosts({
    int start = 0,
  }) async {
    final rssFeed = await _fetchRSSFeed(start);
    final channel = RssFeed.parse(rssFeed.body);

    return channel
      .items
      ?.map((e) => Post.from(e));
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
}