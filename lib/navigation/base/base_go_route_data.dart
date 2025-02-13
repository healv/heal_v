import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract base class BaseFadeTransitionGoRouteData extends GoRouteData {
  const BaseFadeTransitionGoRouteData();

  Widget pageChild(BuildContext context, GoRouterState state);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildPageWithDefaultTransition(
      context: context,
      state: state,
      child: pageChild(context, state),
    );
  }
}

CustomTransitionPage buildPageWithDefaultTransition<T>({required BuildContext context, required GoRouterState state, required Widget child}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}