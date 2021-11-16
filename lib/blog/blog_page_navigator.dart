import 'package:bocconi_radio/blocs/blog.dart';

class BlogPageNavigator {  
  final Blog _blog;
  
  bool _showLeft = false;
  bool _showRight = true;
  int _currentOffset = -12;

  bool get showLeft => _showLeft;
  bool get showRight => _showRight;
  Blog get blog => _blog;


  BlogPageNavigator(this._blog);

  void refreshArticles() async {
    _currentOffset = -12;
    fetchNextArticles();
  }

  void fetchNextArticles() async {
    _fetchArticles(direction: 1);
  }

  void fetchPreviousArticles() async {
    _fetchArticles(direction: -1);
  }


  void _fetchArticles({
    required int direction
  }) async {
    _currentOffset += direction * 12;
    _blog.fetchArticles(
      start: _currentOffset,
    );
  }  
}