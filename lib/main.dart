import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:heal_v/application.dart';
import 'package:heal_v/config/easylocalization/easy_localization_config.dart';
import 'package:heal_v/feature/heal_v/api/auth/di/auth_module.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/di/shared_content_module.dart';
import 'package:heal_v/theme/helpers/theme_helper.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.I;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await _setupDio();
  await _setupDI();
  await _setupHydratedBloc();
  await ThemeHelper.init();

  runApp(
    EasyLocalization(
      startLocale: const Locale('en'),
      supportedLocales: EasyLocalizationConfig.supportedLocale,
      path: EasyLocalizationConfig.path,
      child: HealVApplication(),
    ),
  );
}

Future<void> _setupDio() async {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio()
      ..interceptors.addAll([
        LogInterceptor(requestBody: true, responseBody: true),
      ]);
    return dio;
  });
}

Future<void> _setupDI() async {
  getIt.registerSingletonAsync(() => SharedPreferences.getInstance());
  await getIt.authModule();
  await getIt.sharedContentModule();
}

Future<void> _setupHydratedBloc() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
}
