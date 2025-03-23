import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/breathing/breathing_page.dart';
import 'package:heal_v/app/main/feature/breathing/breathing_page_bloc.dart';
import 'package:heal_v/main.dart';

import '../../app_routes.dart';

part 'breathing_graph.g.dart';

@TypedGoRoute<BreathingRoute>(path: MainRoutes.breathing, routes: <TypedRoute<RouteData>>[])
@immutable
base class BreathingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<BreathingPageBloc>(
      create: (context) => BreathingPageBloc(getIt.get())..add(BreathingPageEvent.initial()),
      lazy: false,
      child: const BreathingPage(),
    );
  }
}

List<RouteBase> get $breathingRouteRoutes => $appRoutes;
