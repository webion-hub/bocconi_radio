import 'package:bocconi_radio/blog/iterable_document.dart';
import 'package:bocconi_radio/extensions/iterable_extension.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

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
      .map((e) => TextSpan(
        children: _mapSubnodes(e),
      ))
      .toList();
  }


  List<TextSpan>? _mapSubnodes(dom.Element e) {
    return e
      .nodes
      .map((c) => TextSpan(
        text: c.text,
        children: c is dom.Element
          ? _mapSubnodes(c)
          : null,
        style: _getStyleFromElement(c),
      ))
      .toList();
  }

  TextStyle _getStyleFromElement(dom.Node e) {
    if (e is! dom.Element) {
      return const TextStyle();
    }

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