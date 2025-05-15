import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/auth/forgot_password/forgot_password_page_bloc.dart';
import 'package:heal_v/app/auth/sign_in/sign_in_page.dart';
import 'package:heal_v/app/auth/sign_in/sign_in_page_bloc.dart';
import 'package:heal_v/app/auth/sign_up/sign_up_page.dart';
import 'package:heal_v/app/auth/sign_up/sign_up_page_bloc.dart';
import 'package:heal_v/app/main/feature/permission/permission_page.dart';

import '../../app/auth/forgot_password/forgot_password_page.dart';
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

@TypedGoRoute<SignUpRoute>(path: AuthRoutes.signUp, routes: <TypedRoute<RouteData>>[])
@immutable
base class SignUpRoute extends BaseFadeTransitionGoRouteData {
  @override
  Widget pageChild(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => SignUpPageBloc(),
      child: const SignUpPage(),
    );
  }
}

@TypedGoRoute<ForgotPasswordRoute>(path: AuthRoutes.forgotPassword, routes: <TypedRoute<RouteData>>[])
@immutable
base class ForgotPasswordRoute extends BaseFadeTransitionGoRouteData {
  @override
  Widget pageChild(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => ForgotPasswordPageBloc(),
      child: const ForgotPasswordPage(),
    );
  }
}

@TypedGoRoute<PermissionRoute>(path: AuthRoutes.permission, routes: <TypedRoute<RouteData>>[])
@immutable
base class PermissionRoute extends BaseFadeTransitionGoRouteData {
  @override
  Widget pageChild(BuildContext context, GoRouterState state) {
    return const PermissionPage();
  }
}

List<RouteBase> get $authRoutes => $appRoutes;
