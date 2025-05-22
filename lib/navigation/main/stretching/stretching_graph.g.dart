// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stretching_graph.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $stretchingRoute,
      $stretchingDetailsRoute,
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

RouteBase get $stretchingDetailsRoute => GoRouteData.$route(
      path: '/stretchingDetails',
      factory: $StretchingDetailsRouteExtension._fromState,
    );

extension $StretchingDetailsRouteExtension on StretchingDetailsRoute {
  static StretchingDetailsRoute _fromState(GoRouterState state) =>
      StretchingDetailsRoute(
        weekTitle: state.uri.queryParameters['week-title']!,
        weekId: state.uri.queryParameters['week-id']!,
        lessonId: state.uri.queryParameters['lesson-id']!,
      );

  String get location => GoRouteData.$location(
        '/stretchingDetails',
        queryParams: {
          'week-title': weekTitle,
          'week-id': weekId,
          'lesson-id': lessonId,
        },
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
      StretchingVideoRoute(
        stretchingLesson: state.uri.queryParameters['stretching-lesson']!,
      );

  String get location => GoRouteData.$location(
        '/stretchingVideo',
        queryParams: {
          'stretching-lesson': stretchingLesson,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
