import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/store_key.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;

  RetryInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError) {
      await _waitForInternetConnection();
      try {
        final accessToken = await Store.get(key: StoreKey.accessToken, defaultValue: emptyString);
        final options = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );
        if (accessToken.isNotEmpty) {
          options.headers?['Authorization'] = 'Bearer $accessToken';
        }
        final response = await dio.request(
          'https://heal-v-backend.onrender.com${err.requestOptions.path}',
          options: options,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }

    super.onError(err, handler);
  }

  Future<void> _waitForInternetConnection() async {
    final connectivity = Connectivity();
    StreamSubscription? subscription;

    final completer = Completer<void>();
    subscription = connectivity.onConnectivityChanged.listen((status) {
      if (status[0] != ConnectivityResult.none) {
        completer.complete();
      }
    });

    await completer.future;
    subscription.cancel();
  }
}
