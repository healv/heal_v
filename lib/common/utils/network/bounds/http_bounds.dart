import 'package:heal_v/common/exception/exception_error.dart';
import 'package:heal_v/common/exception/exception_network.dart';
import 'package:heal_v/common/exception/exception_unknown.dart';
import 'package:heal_v/common/utils/constants.dart';

import '../../resource.dart';
import '../api_wrapper.dart';
import 'base_network_bounds.dart';

abstract class HttpBounds<ResultType, RequestType> extends BaseNetworkBoundsDefault<ResultType, RequestType> {
  @override
  Future<RequestType?> fetchFromNetwork() async => null;

  @override
  void processErrorResponse(Exception? exception) {}

  @override
  Future<ResultType?> processResponse(RequestType? response, {ResultType? data}) async => null;

  @override
  Exception? isError({RequestType? response, ResultType? result}) {
    return switch (response) {
      UnknownError() => UnknownException(),
      NetworkError() => NetworkException(),
      Error() => ErrorException(message: response.error ?? emptyString, code: response.code),
      _ => null,
    };
  }

  Stream<Resource<ResultType>> call() async* {
    yield (Resource.loading());

    final fetchPolicy = determineFetchPolicy();
    final Resource<ResultType> result;

    switch (fetchPolicy) {
      case FetchPolicy.cacheOnly:
        final storageValue = await fetchFromStorage();
        result = Resource.success(storageValue);
        break;
      case FetchPolicy.networkOnly:
        final apiResponse = await fetchFromNetwork();
        final error = isError(response: apiResponse);
        if (error == null) {
          final processedResponse = await processResponse(apiResponse);
          result = Resource.success(processedResponse);
        } else {
          processErrorResponse(error);
          result = Resource.error(error: error);
        }
        break;
      case FetchPolicy.networkAndCash:
        final storageValue = await fetchFromStorage();
        final apiResponse = await fetchFromNetwork();
        final error = isError(response: apiResponse);
        if (error == null) {
          final processedResponse = await processResponse(apiResponse, data: storageValue);
          await saveNetworkResult(processedResponse);
          result = Resource.success(processedResponse);
        } else if (storageValue != null) {
          result = Resource.success(storageValue);
        } else {
          processErrorResponse(error);
          result = Resource.error(error: error);
        }
        break;
    }

    yield result;
  }
}
