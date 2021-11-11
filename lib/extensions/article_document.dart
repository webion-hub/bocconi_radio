import 'package:bocconi_radio/blog/iterable_document.dart';
import 'package:bocconi_radio/extensions/iterable_extension.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:darq/darq.dart';

extension ArticleDocument on dom.Document {
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

  List<TextSpan> getArticleContent() {
    return getElementsByTagName('p')
      .getArticleParagraphs()
      .selectMany((e, i) => e.children)
      .map((e) => TextSpan(
        text: e.text,
        style: _getStyleFromElement(e),
      ))
      .toList();
  }

  TextStyle _getStyleFromElement(dom.Element e) {
    return const {
      'em': TextStyle(
        fontStyle: FontStyle.italic,
      ),
      'strong': TextStyle(
        fontWeight: FontWeight.bold,
      ),
    }[e.localName] ?? const TextStyle();
  }
}