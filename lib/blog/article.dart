import 'package:html/dom.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:collection/collection.dart';
import 'package:bocconi_radio/extensions/iterable_extension.dart';

import 'article_doc.dart';


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
    imageUrl = _maybeGetImageSrc(doc);
    description = _getDescription(doc);
    publishDate = item.pubDate!;
    articleUrl = Uri.parse(item.link!);
  }


  static String? _maybeGetImageSrc(Document doc) {
    return doc
      .getElementsByTagName('img')
      .map((e) => e.attributes['src'])
      .firstOrNull;
  }

  static String _getDescription(Document doc) {
    return doc
      .getElementsByTagName('p')
      .where((e) => e.text.isNotEmpty)
      .map((e) => e.text)
      .accumulate((r, t) => (r + t), start: '');
  }


  Future<String> get content {
    return http
      .get(articleUrl)
      .then((r) => parser.parse(r.body))
      .then(_parseArticle);
  }

  static String _parseArticle(Document doc) {
    return doc
      .getElementsByTagName('p')
      .getArticleParagraphs()
      .map((e) => e.text)
      .accumulate((p, c) => p + c, start: '');
  }
}