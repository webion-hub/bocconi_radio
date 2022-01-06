import 'package:darq/darq.dart';

extension IterableExtension<T> on Iterable<T> {
  T accumulate(T Function(T, T) accumulator, {required T start}) {
    return isEmpty
      ? start
      : accumulator(start, reduce(accumulator));
  }

  Iterable<T> takeLastWhile(bool Function(T) predicate) {
    return reverse().takeWhile(predicate);
  }
}