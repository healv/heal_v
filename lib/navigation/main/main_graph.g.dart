// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_graph.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainShellRoute,
    ];

RouteBase get $mainShellRoute => StatefulShellRouteData.$route(
      factory: $MainShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/mainHome',
              factory: $HomeRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/mainMeditation',
              factory: $MeditationRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/mainStretching',
              factory: $StretchingRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/mainBreathing',
              factory: $BreathingRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/mainProfile',
              factory: $ProfileRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'profileEditProfile',
                  factory: $ProfileNestedEditProfileRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) =>
      const MainShellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/mainHome',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

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

extension $ProfileNestedEditProfileRouteExtension
    on ProfileNestedEditProfileRoute {
  static ProfileNestedEditProfileRoute _fromState(GoRouterState state) =>
      ProfileNestedEditProfileRoute();

  String get location => GoRouteData.$location(
        '/mainProfile/profileEditProfile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
