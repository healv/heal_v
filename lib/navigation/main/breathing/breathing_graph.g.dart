// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breathing_graph.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $breathingRoute,
    ];

RouteBase get $breathingRoute => GoRouteData.$route(
      path: '/mainBreathing',
      factory: $BreathingRouteExtension._fromState,
    );

extension $BreathingRouteExtension on BreathingRoute {
  static BreathingRoute _fromState(GoRouterState state) => BreathingRoute();

  String get location => GoRouteData.$location(
        '/mainBreathing',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
