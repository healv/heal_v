import 'package:dio/dio.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/store_key.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await Store.get(key: StoreKey.accessToken, defaultValue: emptyString);
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }
}