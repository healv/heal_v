import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/profile/journal_history/journal_history_page.dart';
import 'package:heal_v/app/main/profile/journal_history/journal_history_page_bloc.dart';
import 'package:heal_v/app/main/profile/profile_page.dart';
import 'package:heal_v/app/main/profile/progress/progress_page.dart';
import 'package:heal_v/app/main/profile/progress/progress_page_bloc.dart';
import 'package:heal_v/app/main/profile/settings/settings_page.dart';
import 'package:heal_v/app/main/profile/settings/settings_page_bloc.dart';

import '../../../app/main/profile/edit_profile/edit_profile_page.dart';
import '../../../app/main/profile/edit_profile/edit_profile_page_bloc.dart';
import '../../app_routes.dart';

part 'profile_graph.g.dart';

@TypedGoRoute<ProfileRoute>(path: MainRoutes.profile, routes: <TypedRoute<RouteData>>[])
@immutable
base class ProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }
}

@immutable
base class ProfileNestedEditProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => EditProfilePageBloc(),
      child: const EditProfilePage(),
    );
  }
}

@TypedGoRoute<ProfileSettingsRoute>(path: ProfileRoutes.settings, routes: <TypedRoute<RouteData>>[])
@immutable
base class ProfileSettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => SettingsPageBloc()..add(SettingsPageEvent.initial()),
      child: const SettingsPage(),
    );
  }
}

@TypedGoRoute<ProfileProgressRoute>(path: ProfileRoutes.progress, routes: <TypedRoute<RouteData>>[])
@immutable
base class ProfileProgressRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => ProgressPageBloc(),
      child: const ProgressPage(),
    );
  }
}

@TypedGoRoute<ProfileJournalHistoryRoute>(path: ProfileRoutes.journalHistory, routes: <TypedRoute<RouteData>>[])
@immutable
base class ProfileJournalHistoryRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => JournalHistoryPageBloc(),
      child: const JournalHistoryPage(),
    );
  }
}

List<RouteBase> get $profileRouteRoutes => $appRoutes;
