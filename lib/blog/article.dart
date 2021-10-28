import 'package:html/dom.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'article_document.dart';


class Article {
  final String title;
  final String? imageUrl;
  final String description;
  final DateTime publishDate;
  final Uri articleUrl;

  get hasImage {
    return imageUrl != null;
  }


  Article.parse(RssItem item): this._(
    item: item,
    doc: parser.parse(item.description),
  );


  Article._({
    required RssItem item, 
    required Document doc,
  }):
    title = item.title!,
    imageUrl = doc.maybeGetArticleImage(),
    description = doc.getArticleDescription(),
    publishDate = item.pubDate!,
    articleUrl = Uri.parse(item.link!);


  Future<String> loadContent() {
    return http
      .get(articleUrl)
      .then((r) => parser.parse(r.body))
      .then((d) => d.getArticleContent());
  }
}