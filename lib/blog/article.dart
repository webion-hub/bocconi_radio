import 'package:html/dom.dart';
import 'package:webfeed/webfeed.dart';
import 'package:html/parser.dart' as parser;
import 'package:collection/collection.dart';
import 'package:bocconi_radio/extensions/iterable_extension.dart';


class Article {
  late final String? imageUrl;
  late final String description;
  late final DateTime? publishDate;

  get hasImage => imageUrl != null;
  get hasPublishDate => publishDate != null;


  Article.from(RssItem item) {
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
      .accumulate((r, t) => r + t, '');
  }
}