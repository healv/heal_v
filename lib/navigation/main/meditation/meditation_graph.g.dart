// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_graph.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $meditationRoute,
      $meditationAudioRoute,
    ];

RouteBase get $meditationRoute => GoRouteData.$route(
      path: '/mainMeditation',
      factory: $MeditationRouteExtension._fromState,
    );

extension $MeditationRouteExtension on MeditationRoute {
  static MeditationRoute _fromState(GoRouterState state) => MeditationRoute();

  String get location => GoRouteData.$location(
        '/mainMeditation',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $meditationAudioRoute => GoRouteData.$route(
      path: '/meditationAudio',
      factory: $MeditationAudioRouteExtension._fromState,
    );

extension $MeditationAudioRouteExtension on MeditationAudioRoute {
  static MeditationAudioRoute _fromState(GoRouterState state) =>
      MeditationAudioRoute(
        breathing: state.uri.queryParameters['breathing']!,
      );

  String get location => GoRouteData.$location(
        '/meditationAudio',
        queryParams: {
          'breathing': breathing,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
