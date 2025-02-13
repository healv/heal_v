import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/main_page.dart';
import 'package:heal_v/navigation/main/breathing/breathing_graph.dart';
import 'package:heal_v/navigation/main/meditation/meditation_graph.dart';
import 'package:heal_v/navigation/main/profile/profile_graph.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';

import '../app_routes.dart';
import 'home/home_graph.dart';

part 'main_graph.g.dart';

@TypedStatefulShellRoute<MainShellRoute>(branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
  TypedStatefulShellBranch<HomeShellRoute>(routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: MainRoutes.home),
  ]),
  TypedStatefulShellBranch<MeditationShellRoute>(routes: <TypedRoute<RouteData>>[
    TypedGoRoute<MeditationRoute>(path: MainRoutes.meditation),
  ]),
  TypedStatefulShellBranch<StretchingShellRoute>(routes: <TypedRoute<RouteData>>[
    TypedGoRoute<StretchingRoute>(path: MainRoutes.stretching),
  ]),
  TypedStatefulShellBranch<BreathingShellRoute>(routes: <TypedRoute<RouteData>>[
    TypedGoRoute<BreathingRoute>(path: MainRoutes.breathing),
  ]),
  TypedStatefulShellBranch<ProfileShellRoute>(routes: <TypedRoute<RouteData>>[TypedGoRoute<ProfileRoute>(path: MainRoutes.profile)]),
])
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return MainPage(navigationShell);
  }
}

class HomeShellRoute extends StatefulShellBranchData {
  const HomeShellRoute();
}

class MeditationShellRoute extends StatefulShellBranchData {
  const MeditationShellRoute();
}

class StretchingShellRoute extends StatefulShellBranchData {
  const StretchingShellRoute();
}

class BreathingShellRoute extends StatefulShellBranchData {
  const BreathingShellRoute();
}

class ProfileShellRoute extends StatefulShellBranchData {
  const ProfileShellRoute();
}

List<RouteBase> get $mainRoutes => $appRoutes;
