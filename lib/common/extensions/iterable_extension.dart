extension IterableExt<T> on Iterable<T> {
  T? find(bool Function(T) fun, {T Function()? orElse}) {
    try {
      return firstWhere(fun, orElse: orElse);
    } catch (_) {
      return null;
    }
  }
}