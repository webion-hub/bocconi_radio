import 'package:bocconi_radio/blog/iterable_document.dart';
import 'package:bocconi_radio/extensions/iterable_extension.dart';
import 'package:collection/collection.dart';
import 'package:html/dom.dart';

extension ArticleDocument on Document {
  String? maybeGetArticleImage() {
    return (
      getElementsByTagName('img')
        .map((e) => e.attributes['src'])
        .firstOrNull
    );
  }

  String getArticleDescription() {
    return ( 
      getElementsByTagName('p')
        .where((e) => e.text.isNotEmpty)
        .map((e) => e.text)
        .accumulate((r, t) => (r + t), start: '')
    );
  }

  String getArticleContent() {
    return (
      getElementsByTagName('p')
        .getArticleParagraphs()
        .map((e) => e.text)
        .accumulate((p, c) => p + c, start: '')
    );
  }
}