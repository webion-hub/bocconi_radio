import 'package:bocconi_radio/blog/article.dart';
import 'package:test/test.dart';
import 'package:bocconi_radio/blog/blog.dart';

void main() {
  group('Download articles', () {
    test('Find recent articles', () async {
      areThereSomeArticles(
        await Blog.getArticles()
      );
    });

    test('Find older articles', () async {
      areThereSomeArticles(
        await Blog.getArticles(start: 40)
      );
    });

    test('Find no articles (end of pagination)', () async {
      final articles = await Blog.getArticles(
        start: 2000,
      );

      expect(articles?.length, equals(0));
      expect(articles?.isEmpty, isTrue);
    });

    test('Acceptable download and parse time', () async {
      final measures = await download(50);
      final total = measures.reduce((a, b) => a + b);
      final mean = total / measures.length;

      expect(mean, lessThan(600));
    });

    test('Content loads', () async {
      final articles = await Blog.getArticles(); 
      final article = articles?.first;

      expect(article, isNotNull);

      final content = await article?.loadContent();
      expect(content, isNotNull);
      expect(content, isNotEmpty);
    });
  });
}


areThereSomeArticles(Iterable<Article>? articles) {
  expect(articles?.length, greaterThan(0));
  expect(articles?.isNotEmpty, isTrue);
  expect(articles?.first.description, isNotNull);
}


Future<List<int>> download(int howMany) {
  return Future.wait(
    List.filled(howMany, measureElapsed())
  );
}

Future<int> measureElapsed() async {
  var stopwatch = Stopwatch()..start();
  await Blog.getArticles();
  return stopwatch.elapsedMilliseconds;
}