import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/stretching/stretching_page.dart';

import '../../app_routes.dart';

part 'stretching_graph.g.dart';

@TypedGoRoute<StretchingRoute>(path: MainRoutes.stretching, routes: <TypedRoute<RouteData>>[])
@immutable
base class StretchingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StretchingPage();
  }
}

List<RouteBase> get $stretchingRouteRoutes => $appRoutes;
