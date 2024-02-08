extension ListX<E> on List<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E value) f) {
    var index = 0;
    return map((e) => f(index++, e));
  }
}
