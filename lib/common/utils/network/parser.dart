import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import 'api_wrapper.dart';

Future<ApiWrapper<T>> parseHttpResponse<T>(Function function, List<dynamic> arguments) async {
  try {
    final HttpResponse<T?> result = await Function.apply(function, arguments);
    final statusCode = result.response.statusCode;
    final body = result.data;
    final bool isSuccessful = statusCode != null && statusCode >= 200 && statusCode <= 299;
    if (isSuccessful) {
      return ApiWrapper.success(value: body);
    } else {
      return ApiWrapper.error(code: statusCode, error: jsonEncode(result.response.data));
    }
  } on DioException catch (e) {
    final ApiWrapper<T> error;
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout || e.type == DioExceptionType.connectionError) {
      error = NetworkError();
    } else {
      final data = e.response?.data;
      if (data != null) {
        error = ApiWrapper.error(code: e.response?.statusCode, error: jsonEncode(data));
      } else {
        error = ApiWrapper.unknownError(error: e);
      }
    }
    return error;
  } catch (e) {
    return ApiWrapper.unknownError();
  }
}
