import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/network/network_state_manager.dart';
import 'package:heal_v/common/widgets/no_internet_sceen.dart';
import 'package:heal_v/main.dart';
import 'package:heal_v/navigation/app_routes.dart';
import 'package:heal_v/navigation/auth/auth_graph.dart';
import 'package:heal_v/navigation/launch/launch_graph.dart';
import 'package:heal_v/navigation/main/breathing/breathing_graph.dart';
import 'package:heal_v/navigation/main/home/home_graph.dart';
import 'package:heal_v/navigation/main/main_graph.dart';
import 'package:heal_v/navigation/main/meditation/meditation_graph.dart';
import 'package:heal_v/navigation/main/profile/profile_graph.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';
import 'package:heal_v/shared/feature/progress/progress_bloc.dart';
import 'package:heal_v/shared/feature/settings/settings_bloc.dart';
import 'package:heal_v/shared/feature/shared_content/shared_content_bloc.dart';
import 'package:heal_v/theme/theme_notifier.dart';
import 'package:provider/provider.dart';

import 'shared/feature/auth/auth_bloc.dart';

final shellNavigatorGlobalKey = GlobalKey<NavigatorState>();

class HealVApplication extends StatefulWidget {
  HealVApplication({super.key});

  final GoRouter router = GoRouter(routes: [
    ...$launchRoutes,
    ...$authRoutes,
    ...$mainRoutes,
    ...$homeRoutes,
    ...$meditationRoutes,
    ...$breathingRouteRoutes,
    ...$stretchingRouteRoutes,
    ...$profileRouteRoutes,
  ], initialLocation: AppRoutes.launch, navigatorKey: shellNavigatorGlobalKey);

  List<BlocProvider<BaseBloc>> get providers => [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(getIt.get())),
        BlocProvider<SettingsBloc>(create: (context) => SettingsBloc()..add(SettingsEvent.initial())),
        BlocProvider<SharedContentBloc>(create: (context) => SharedContentBloc(getIt.get())),
        BlocProvider<ProgressBloc>(create: (context) => ProgressBloc(getIt.get())),
      ];

  @override
  State<StatefulWidget> createState() => _HealVApplicationState();
}

class _HealVApplicationState extends State<HealVApplication> {
  Widget? _overlay;

  void changeCallOverlay({Widget? overlay}) {
    _overlay = overlay;
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    NetworkStateManager().states.listen((state) {
      changeCallOverlay(overlay: state.isOnline == true ? null : const NoInternetScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ThemeNotifier(),
      child: MultiBlocProvider(
        providers: widget.providers,
        child: Consumer<ThemeNotifier>(
          builder: (context, themeNotifier, child) {
            return MaterialApp.router(
              /// Localization
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,

              /// Navigation
              routerConfig: widget.router,

              /// App settings
              debugShowCheckedModeBanner: false,
              theme: themeNotifier.selectedTheme,
              builder: (context, child) {
                return Stack(
                  children: [
                    child!,
                    if (_overlay != null)
                      Positioned(
                        bottom: MediaQuery.of(context).padding.bottom + 70,
                        left: 16,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: _overlay,
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
