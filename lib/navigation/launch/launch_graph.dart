import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/launch/launch_page.dart';
import 'package:heal_v/app/launch/launch_page_bloc.dart';
import 'package:heal_v/navigation/app_routes.dart';
import 'package:heal_v/navigation/base/base_go_route_data.dart';

part 'launch_graph.g.dart';

@TypedGoRoute<LaunchRoute>(path: AppRoutes.launch, routes: <TypedRoute<RouteData>>[])
@immutable
base class LaunchRoute extends BaseFadeTransitionGoRouteData {
  @override
  Widget pageChild(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => LaunchPageBloc(),
      child: const LaunchPage(),
    );
  }
}

List<RouteBase> get $launchRoutes => $appRoutes;
