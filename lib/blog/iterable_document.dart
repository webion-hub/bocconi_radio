import 'package:html/dom.dart';
import 'package:collection/collection.dart';

extension IterableDocument on Iterable<Element> {
  Iterable<Element> getArticleParagraphs() {
    return (
       getParagraphsAfterTitle()
      .getParagraphsBeforeEnding()
    );
  }
  
  Iterable<Element> getParagraphsAfterTitle() {
    return ( 
      splitAfter((e) => e.classes.contains('project-desc'))
        .skip(1)
        .first
    );
  }

  Iterable<Element> getParagraphsBeforeEnding() {
    return (
      splitBefore((e) => e.classes.contains('sliderfont3'))
        .first
    );
  }
}