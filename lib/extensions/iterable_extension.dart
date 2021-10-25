extension IterableExtension<T> on Iterable<T> {  
  T accumulate(T Function(T, T) accumulator, T start) {
    return isEmpty
      ? start
      : accumulator(start, reduce(accumulator));
  }
}