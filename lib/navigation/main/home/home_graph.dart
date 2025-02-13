import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/home/home_page.dart';

import '../../app_routes.dart';

part 'home_graph.g.dart';

@TypedGoRoute<HomeRoute>(path: MainRoutes.home, routes: <TypedRoute<RouteData>>[])
@immutable
base class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

List<RouteBase> get $homeRoutes => $appRoutes;
