sealed class ApiWrapper<T> {
  const ApiWrapper();

  factory ApiWrapper.success({required T? value}) => Success._(value: value);

  factory ApiWrapper.error({int? code, String? error}) => Error._(code: code, error: error);

  factory ApiWrapper.networkError() => NetworkError();

  factory ApiWrapper.unknownError({Object? error}) => UnknownError._(error: error);
}

class Success<T> extends ApiWrapper<T> {
  final T? value;

  Success._({required this.value});

  @override
  bool operator ==(Object other) => identical(this, other) || other is Success && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class Error extends ApiWrapper<Never> {
  int? code;
  String? error;

  Error._({this.code, this.error});

  @override
  bool operator ==(Object other) => identical(this, other) || other is Error && runtimeType == other.runtimeType && code == other.code && error == other.error;

  @override
  int get hashCode => code.hashCode ^ error.hashCode;
}

class NetworkError extends ApiWrapper<Never> {
  NetworkError._();

  static final NetworkError _instance = NetworkError._();

  factory NetworkError() => _instance;
}

class UnknownError extends ApiWrapper<Never> {
  final Object? error;

  const UnknownError._({this.error});
}
