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
    final elements = getElementsByClassName('inner portfolio')
      .map((e) => e.getElementsByTagName('p'))
      .flatten()
      .getArticleParagraphs()
      .map((e) => TextSpan(
        children: _mapSubnodes(e),
      ));

    return elements
      .skipLast(
        _countEmptyLinesAtArticleEnd(elements)
      )
      .toList();
  }


  List<TextSpan>? _mapSubnodes(dom.Element e) {
    return e
      .nodes
      .map((c) => TextSpan(
        text: c.text,
        style: _getStyleFromElement(c),
      ))
      .concat(const [
        TextSpan(text: '\n\n'),
      ])
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

  int _countEmptyLinesAtArticleEnd(Iterable<TextSpan> elements) {
    return elements
      .takeLastWhile((e) => e
        .children!
        .every((c) => c
          .toPlainText()
          .contains(RegExp(r'^[\n  ]+$'))
        )
      )
      .count();
  }
}