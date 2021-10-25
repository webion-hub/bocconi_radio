import 'package:html/dom.dart';
import 'package:webfeed/webfeed.dart';
import 'package:html/parser.dart' as parser;
import 'package:collection/collection.dart';


class Post {
  late final String? imageUrl;
  late final String description;
  late final DateTime? publishDate;

  Post.from(RssItem item) {
    final doc =
      parser.parse(item.description);

    imageUrl = _maybeGetImageSrc(doc);
    description = _getDescription(doc);
    publishDate = item.pubDate;
  }


  String? _maybeGetImageSrc(Document doc) {
    return doc
      .getElementsByTagName('img')
      .map((e) => e.attributes.remove('src'))
      .firstOrNull;
  }

  String _getDescription(Document doc) {
    return doc
      .getElementsByTagName('p')
      .where((e) => e.text.isNotEmpty)
      .map((e) => e.text)
      .reduce((value, text) => value += text);
  }
}