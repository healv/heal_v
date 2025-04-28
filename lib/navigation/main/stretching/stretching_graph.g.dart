// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stretching_graph.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $stretchingRoute,
      $stretchingVideoRoute,
    ];

RouteBase get $stretchingRoute => GoRouteData.$route(
      path: '/mainStretching',
      factory: $StretchingRouteExtension._fromState,
    );

extension $StretchingRouteExtension on StretchingRoute {
  static StretchingRoute _fromState(GoRouterState state) => StretchingRoute();

  String get location => GoRouteData.$location(
        '/mainStretching',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $stretchingVideoRoute => GoRouteData.$route(
      path: '/stretchingVideo',
      factory: $StretchingVideoRouteExtension._fromState,
    );

extension $StretchingVideoRouteExtension on StretchingVideoRoute {
  static StretchingVideoRoute _fromState(GoRouterState state) =>
      StretchingVideoRoute();

  String get location => GoRouteData.$location(
        '/stretchingVideo',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
