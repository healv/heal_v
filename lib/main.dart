import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:heal_v/application.dart';
import 'package:heal_v/common/utils/network/interceptors/auth_interceptor.dart';
import 'package:heal_v/common/utils/network/interceptors/language_interceptor.dart';
import 'package:heal_v/common/utils/network/interceptors/retry_interceptor.dart';
import 'package:heal_v/config/easylocalization/easy_localization_config.dart';
import 'package:heal_v/feature/heal_v/api/auth/di/auth_module.dart';
import 'package:heal_v/feature/heal_v/api/breathing/di/breathing_module.dart';
import 'package:heal_v/feature/heal_v/api/meditation/di/meditations_module.dart';
import 'package:heal_v/feature/heal_v/api/progress/di/progress_module.dart';
import 'package:heal_v/feature/heal_v/api/quiz/di/quiz_module.dart';
import 'package:heal_v/feature/heal_v/api/stretching/di/stretching_module.dart';
import 'package:heal_v/theme/helpers/theme_helper.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

final GetIt getIt = GetIt.I;

void main() async {
  BindingBase.debugZoneErrorsAreFatal = true;

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await EasyLocalization.ensureInitialized();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    await _setupDio();
    await _setupDI();
    await _setupHydratedBloc();
    await ThemeHelper.init();
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    runApp(
      EasyLocalization(
        startLocale: const Locale('en'),
        supportedLocales: EasyLocalizationConfig.supportedLocale,
        path: EasyLocalizationConfig.path,
        child: HealVApplication(),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('message received: ${message.messageId}');
}

Future<void> _setupDio() async {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio()
      ..interceptors.addAll([
        LogInterceptor(requestBody: true, responseBody: true),
      ]);
    dio.interceptors.add(AuthInterceptor(dio));
    dio.interceptors.add(LanguageInterceptor(dio));
    dio.interceptors.add(RetryInterceptor(dio));
    return dio;
  });
}

Future<void> _setupDI() async {
  getIt.registerSingletonAsync(() => SharedPreferences.getInstance());
  await getIt.authModule();
  await getIt.progressModule();
  await getIt.meditationsModule();
  await getIt.breathingsModule();
  await getIt.stretchingsModule();
  await getIt.quizModule();
}

Future<void> _setupHydratedBloc() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
}
