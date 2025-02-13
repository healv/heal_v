extension CommonListExtension<T> on List<T> {
  T? getOrNull(int index) {
    return (index >= 0 && index < length) ? this[index] : null;
  }

  int? indexWhereOrNull(bool Function(T element) predicate, [int start = 0]) {
    final index = indexWhere(predicate);
    return index == -1 ? null : index;
  }
}
