import 'package:dio/dio.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/store_key.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/refresh_token/refresh_token_dto.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  const AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await Store.get(key: StoreKey.accessToken, defaultValue: emptyString);
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await Store.get(key: StoreKey.refreshToken, defaultValue: emptyString);

      final response = await dio.post<Map<String, dynamic>>(
        'https://heal-v-backend.onrender.com/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final refreshTokenDto = RefreshTokenDto.fromJson(response.data ?? {});

      final newAccessToken = refreshTokenDto.accessToken;
      final newRefreshToken = refreshTokenDto.refreshToken;

      if (newAccessToken != null && newRefreshToken != null) {
        Store.set(key: StoreKey.accessToken, value: newAccessToken);
        Store.set(key: StoreKey.refreshToken, value: newRefreshToken);

        final retryRequest = err.requestOptions;
        retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';
        final result = await dio.request(
          'https://heal-v-backend.onrender.com${retryRequest.path}',
          options: Options(
            method: retryRequest.method,
            headers: retryRequest.headers,
          ),
          data: retryRequest.data,
          queryParameters: retryRequest.queryParameters,
        );
        return handler.resolve(result);
      }
    }
    super.onError(err, handler);
  }
}