abstract class BaseNetworkBounds<ResultType, RequestType> {
  Exception? isError({RequestType? response, ResultType result});

  void processErrorResponse(Exception? exception);

  Future<ResultType?> processResponse(RequestType? response, {ResultType? data});

  FetchPolicy determineFetchPolicy() => FetchPolicy.networkOnly;

  Future<ResultType?> fetchFromStorage() async {
    return null;
  }

  Future<void> saveNetworkResult(ResultType? result) async {}
}

abstract class BaseNetworkBoundsStream<ResultType, RequestType> extends BaseNetworkBounds<ResultType, RequestType> {
  Stream<RequestType?> fetchFromNetwork();
}

abstract class BaseNetworkBoundsDefault<ResultType, RequestType> extends BaseNetworkBounds<ResultType, RequestType> {
  Future<RequestType?> fetchFromNetwork();
}

enum FetchPolicy {
  /// Return result from network if available, otherwise return cash result if it's available
  networkAndCash,

  /// Return result from cache if available, fail otherwise.
  cacheOnly,

  /// Return result from network, fail if network call doesn't succeed.
  networkOnly,
}
