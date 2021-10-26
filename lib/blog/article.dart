import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'article_document.dart';


class Article {
  late final String title;
  late final String? imageUrl;
  late final String description;
  late final DateTime publishDate;
  late final Uri articleUrl;

  get hasImage {
    return imageUrl != null;
  }


  Article.parse(RssItem item) {
    final doc =
      parser.parse(item.description);

    title = item.title!;
    imageUrl = doc.maybeGetArticleImage();
    description = doc.getArticleDescription();
    publishDate = item.pubDate!;
    articleUrl = Uri.parse(item.link!);
  }


  Future<String> get content {
    return http
      .get(articleUrl)
      .then((r) => parser.parse(r.body))
      .then((d) => d.getArticleContent());
  }
}