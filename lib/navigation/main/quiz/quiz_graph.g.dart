// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_graph.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $quizRoute,
    ];

RouteBase get $quizRoute => GoRouteData.$route(
      path: '/quiz',
      factory: $QuizRouteExtension._fromState,
    );

extension $QuizRouteExtension on QuizRoute {
  static QuizRoute _fromState(GoRouterState state) => QuizRoute();

  String get location => GoRouteData.$location(
        '/quiz',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
