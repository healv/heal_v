// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_graph.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $launchRoute,
    ];

RouteBase get $launchRoute => GoRouteData.$route(
      path: '/launch',
      factory: $LaunchRouteExtension._fromState,
    );

extension $LaunchRouteExtension on LaunchRoute {
  static LaunchRoute _fromState(GoRouterState state) => LaunchRoute();

  String get location => GoRouteData.$location(
        '/launch',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
