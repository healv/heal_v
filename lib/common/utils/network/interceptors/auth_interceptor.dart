import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  const AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // final accessToken = await Store.get(key: StoreKey.accessToken, defaultValue: emptyString);
    // if (accessToken.isNotEmpty) {
    //   log("AUTH_TOKEN_TAG: ${'Bearer $accessToken'}");
    //   options.headers['Authorization'] = 'Bearer $accessToken';
    // }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final token = await user.getIdToken();
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

// @override
// void onError(DioException err, ErrorInterceptorHandler handler) async {
//   if (err.response?.statusCode == 401) {
//     final refreshToken = await Store.get(key: StoreKey.refreshToken, defaultValue: emptyString);
//     if (refreshToken.isNotEmpty) {
//       final response = await dio.post<Map<String, dynamic>>(
//         '${AuthConstants.baseUrl}auth/refresh',
//         data: {'refreshToken': refreshToken},
//       );
//
//       final refreshTokenDto = RefreshTokenDto.fromJson(response.data ?? {});
//
//       final newAccessToken = refreshTokenDto.accessToken;
//       final newRefreshToken = refreshTokenDto.refreshToken;
//
//       if (newAccessToken != null && newRefreshToken != null) {
//         Store.set(key: StoreKey.accessToken, value: newAccessToken);
//         Store.set(key: StoreKey.refreshToken, value: newRefreshToken);
//
//         final retryRequest = err.requestOptions;
//         retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';
//         final result = await dio.request(
//           '${AuthConstants.baseUrl}${retryRequest.path}',
//           options: Options(
//             method: retryRequest.method,
//             headers: retryRequest.headers,
//           ),
//           data: retryRequest.data,
//           queryParameters: retryRequest.queryParameters,
//         );
//         return handler.resolve(result);
//       }
//     }
//   }
//   super.onError(err, handler);
// }
}
