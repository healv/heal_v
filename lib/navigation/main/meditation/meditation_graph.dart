import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page_bloc.dart';
import 'package:heal_v/main.dart';

import '../../app_routes.dart';

part 'meditation_graph.g.dart';

@TypedGoRoute<MeditationRoute>(path: MainRoutes.meditation, routes: <TypedRoute<RouteData>>[])
@immutable
base class MeditationRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MeditationPageBloc>(
      create: (context) => MeditationPageBloc(getIt.get())..add(MeditationPageEvent.initial()),
      lazy: false,
      child: const MeditationPage(),
    );
  }
}

List<RouteBase> get $meditationRoutes => $appRoutes;
