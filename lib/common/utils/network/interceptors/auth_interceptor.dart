import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heal_v/common/utils/constants.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  const AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final token = await user.getIdToken();
        log('$healVTag auth_interceptor: accessToken: $token');
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      log('$healVTag auth_interceptor: ${e.toString()}');
    }
    super.onRequest(options, handler);
  }
}
