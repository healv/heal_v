import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:heal_v/app/main/model/language_enum.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/store_key.dart';

import '../../../tools/store.dart';

class LanguageInterceptor extends Interceptor {
  final Dio dio;

  const LanguageInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final language = await Store.get<String>(key: StoreKey.languageKey, defaultValue: LanguageEnum.english.short);
      options.headers['Accept-Language'] = language;
      log('$healVTag language_interceptor: language: $language');
    } catch (e) {
      log('$healVTag language_interceptor: ${e.toString()}');
    }
    super.onRequest(options, handler);
  }
}
