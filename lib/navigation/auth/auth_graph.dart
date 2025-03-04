import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/auth/sign_in/sign_in_page.dart';
import 'package:heal_v/app/auth/sign_in/sign_in_page_bloc.dart';

import '../app_routes.dart';
import '../base/base_go_route_data.dart';

part 'auth_graph.g.dart';

@TypedGoRoute<SignInRoute>(path: AuthRoutes.signIn, routes: <TypedRoute<RouteData>>[])
@immutable
base class SignInRoute extends BaseFadeTransitionGoRouteData {
  @override
  Widget pageChild(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => SignInPageBloc(),
      child: const SignInPage(),
    );
  }
}

List<RouteBase> get $authRoutes => $appRoutes;
