import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/profile/profile_page.dart';

import '../../app_routes.dart';

part 'profile_graph.g.dart';

@TypedGoRoute<ProfileRoute>(path: MainRoutes.profile, routes: <TypedRoute<RouteData>>[])
@immutable
base class ProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }
}

List<RouteBase> get $profileRouteRoutes => $appRoutes;
