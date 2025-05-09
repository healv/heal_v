// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_graph.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $profileRoute,
      $profileChangePasswordRoute,
      $profileLanguageRoute,
      $profileProgressRoute,
      $profileJournalHistoryRoute,
    ];

RouteBase get $profileRoute => GoRouteData.$route(
      path: '/mainProfile',
      factory: $ProfileRouteExtension._fromState,
    );

extension $ProfileRouteExtension on ProfileRoute {
  static ProfileRoute _fromState(GoRouterState state) => ProfileRoute();

  String get location => GoRouteData.$location(
        '/mainProfile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileChangePasswordRoute => GoRouteData.$route(
      path: '/changePassword',
      factory: $ProfileChangePasswordRouteExtension._fromState,
    );

extension $ProfileChangePasswordRouteExtension on ProfileChangePasswordRoute {
  static ProfileChangePasswordRoute _fromState(GoRouterState state) =>
      ProfileChangePasswordRoute();

  String get location => GoRouteData.$location(
        '/changePassword',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileLanguageRoute => GoRouteData.$route(
      path: '/language',
      factory: $ProfileLanguageRouteExtension._fromState,
    );

extension $ProfileLanguageRouteExtension on ProfileLanguageRoute {
  static ProfileLanguageRoute _fromState(GoRouterState state) =>
      ProfileLanguageRoute();

  String get location => GoRouteData.$location(
        '/language',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileProgressRoute => GoRouteData.$route(
      path: '/profileProgress',
      factory: $ProfileProgressRouteExtension._fromState,
    );

extension $ProfileProgressRouteExtension on ProfileProgressRoute {
  static ProfileProgressRoute _fromState(GoRouterState state) =>
      ProfileProgressRoute();

  String get location => GoRouteData.$location(
        '/profileProgress',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileJournalHistoryRoute => GoRouteData.$route(
      path: '/profileJournalHistory',
      factory: $ProfileJournalHistoryRouteExtension._fromState,
    );

extension $ProfileJournalHistoryRouteExtension on ProfileJournalHistoryRoute {
  static ProfileJournalHistoryRoute _fromState(GoRouterState state) =>
      ProfileJournalHistoryRoute();

  String get location => GoRouteData.$location(
        '/profileJournalHistory',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
