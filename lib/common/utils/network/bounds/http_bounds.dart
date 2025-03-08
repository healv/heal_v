import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/network/api_error.dart';

import '../../resource.dart';
import '../api_wrapper.dart';
import 'base_network_bounds.dart';

abstract class HttpBounds<ResultType, RequestType> extends BaseNetworkBoundsDefault<ResultType, RequestType> {
  @override
  Future<RequestType?> fetchFromNetwork() async => null;

  @override
  void processErrorResponse(ApiError? exception) {}

  @override
  Future<ResultType?> processResponse(RequestType? response, {ResultType? data}) async => null;

  @override
  ApiError? isError({RequestType? response, ResultType? result}) {
    return switch (response) {
      UnknownError() => ApiError(code: -1, message: "Unknown error"),
      NetworkError() => ApiError(code: 100, message: "No internet connection"),
      Error() => ApiError(message: response.error ?? emptyString, code: response.code),
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
          result = Resource.error(error: error.message);
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
          result = Resource.error(error: error.message);
        }
        break;
    }

    yield result;
  }
}
