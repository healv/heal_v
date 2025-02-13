extension LetExt<T> on T {
  R let<R>(R Function(T it) block) {
    return block(this);
  }
}

