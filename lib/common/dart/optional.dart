class Optional<T> {
  final bool isValid;
  final T? _value;

  T? get value => _value;

  const Optional()
      : isValid = false,
        _value = null;

  const Optional.value(this._value) : isValid = true;
}
