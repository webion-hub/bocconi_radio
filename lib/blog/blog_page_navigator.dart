import 'package:bocconi_radio/blocs/blog.dart';
import 'article.dart';


class BlogPageNavigator {  
  final Blog _blog;
  
  bool _showLeft = false;
  bool _showRight = true;
  int _currentOffset = -12;

  bool get showLeft => _showLeft;
  bool get showRight => _showRight;
  Blog get blog => _blog;
  Stream<Iterable<Article>> get articles => _blog.articles;


  BlogPageNavigator(this._blog);

  Future refreshArticles() {
    _currentOffset = -12;
    return fetchNextArticles();
  }

  Future fetchNextArticles() {
    return _fetchArticles(direction: 1);
  }

  Future fetchPreviousArticles() {
    return _fetchArticles(direction: -1);
  }


  Future _fetchArticles({
    required int direction
  }) {
    _currentOffset += direction * 12;
    return _blog.fetchArticles(
      start: _currentOffset,
    );
  }  
}