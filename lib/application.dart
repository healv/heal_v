import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/navigation/app_routes.dart';
import 'package:heal_v/navigation/launch/launch_graph.dart';
import 'package:heal_v/navigation/main/breathing/breathing_graph.dart';
import 'package:heal_v/navigation/main/home/home_graph.dart';
import 'package:heal_v/navigation/main/main_graph.dart';
import 'package:heal_v/navigation/main/meditation/meditation_graph.dart';
import 'package:heal_v/navigation/main/profile/profile_graph.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';
import 'package:heal_v/theme/theme_notifier.dart';
import 'package:provider/provider.dart';

import 'shared/feature/auth/auth_bloc.dart';

final navigatorGlobalKey = GlobalKey<NavigatorState>();

class HealVApplication extends StatelessWidget {
  HealVApplication({super.key});

  final GoRouter router = GoRouter(routes: [
    ...$launchRoutes,
    ...$mainRoutes,
    ...$homeRoutes,
    ...$meditationRoutes,
    ...$breathingRouteRoutes,
    ...$stretchingRouteRoutes,
    ...$profileRouteRoutes,
  ], initialLocation: AppRoutes.launch, navigatorKey: navigatorGlobalKey);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ThemeNotifier(),
      child: MultiBlocProvider(
        providers: providers,
        child: Consumer<ThemeNotifier>(
          builder: (context, themeNotifier, child) {
            return MaterialApp.router(
              /// Localization
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,

              /// Navigation
              routerConfig: router,

              /// App settings
              debugShowCheckedModeBanner: false,
              theme: themeNotifier.selectedTheme,
            );
          },
        ),
      ),
    );
  }

  List<BlocProvider<BaseBloc>> get providers => [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ];
}
