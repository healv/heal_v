import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/meditation/meditation_page.dart';

import '../../app_routes.dart';

part 'meditation_graph.g.dart';

@TypedGoRoute<MeditationRoute>(path: MainRoutes.meditation, routes: <TypedRoute<RouteData>>[])
@immutable
base class MeditationRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MeditationPage();
  }
}

List<RouteBase> get $meditationRoutes => $appRoutes;
