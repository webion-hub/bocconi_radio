import 'package:bocconi_radio/blog/article.dart';
import 'package:test/test.dart';
import 'package:bocconi_radio/blocs/blog.dart';

void main() {
  group('Download articles', () {
    final blog = Blog();


    test('Find recent articles', () async {
      areThereSomeArticles(
        await blog.fetchArticles()
      );
    });

    test('Find older articles', () async {
      areThereSomeArticles(
        await blog.fetchArticles(start: 40)
      );
    });

    test('Find no articles (end of pagination)', () async {
      final articles = await blog.fetchArticles(
        start: 2000,
      );

      expect(articles?.length, equals(0));
      expect(articles?.isEmpty, isTrue);
    });

    test('Acceptable download and parse time', () async {
      final measures = await download(blog, 50);
      final total = measures.reduce((a, b) => a + b);
      final mean = total / measures.length;

      expect(mean, lessThan(600));
    });

    test('Content loads', () async {
      final articles = await blog.fetchArticles(); 
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


Future<List<int>> download(Blog blog, int howMany) {
  return Future.wait(
    List.filled(howMany, measureElapsed(blog))
  );
}

Future<int> measureElapsed(Blog blog) async {
  var stopwatch = Stopwatch()..start();
  await blog.fetchArticles();
  return stopwatch.elapsedMilliseconds;
}