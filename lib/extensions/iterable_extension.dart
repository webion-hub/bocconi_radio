extension IterableExtension<T> on Iterable<T> {  
  T accumulate(T Function(T, T) accumulator, {required T start}) {
    return isEmpty
      ? start
      : accumulator(start, reduce(accumulator));
  }
}