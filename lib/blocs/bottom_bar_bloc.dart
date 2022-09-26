import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

int lastIndex = 0;

@singleton
class BottomBarBloc {
  final _indexStream = BehaviorSubject.seeded(lastIndex);

  ValueStream<int> get indexes => _indexStream.stream;

  void pushIndex(int index) {
    _indexStream.add(index);
    lastIndex = index;
  }

  int getLastIndex(){
    return lastIndex;
  }
}