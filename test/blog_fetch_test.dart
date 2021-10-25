import 'package:bocconi_radio/blog/post.dart';
import 'package:test/test.dart';
import 'package:bocconi_radio/blog/blog.dart';

void main() {
  group('Download posts', () {
    test('Find recent posts', () async {
      areThereSomePosts(
        await Blog.getPosts()
      );
    });

    test('Find older posts', () async {
      areThereSomePosts(
        await Blog.getPosts(start: 40)
      );
    });

    test('Find no posts (end of pagination)', () async {
      final posts = await Blog.getPosts(
        start: 2000,
      );

      expect(posts?.length, equals(0));
      expect(posts?.isEmpty, isTrue);
    });

    test('Acceptable download and parse time', () async {
      final measures = await download(50);
      final total = measures.reduce((a, b) => a + b);
      final mean = total / measures.length;

      expect(mean, lessThan(600));
    });
  });
}


areThereSomePosts(Iterable<Post>? posts) {
  expect(posts?.length, greaterThan(0));
  expect(posts?.isNotEmpty, isTrue);
  expect(posts?.first.description, isNotNull);
}


Future<List<int>> download(int howMany) {
  return Future.wait(
    List.filled(howMany, measureElapsed())
  );
}

Future<int> measureElapsed() async {
  var stopwatch = Stopwatch()..start();
  await Blog.getPosts();
  return stopwatch.elapsedMilliseconds;
}