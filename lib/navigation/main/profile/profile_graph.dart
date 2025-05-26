import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/profile/change_password/change_password_page.dart';
import 'package:heal_v/app/main/feature/profile/change_password/change_password_page_bloc.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/journal_history_page.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/journal_history_page_bloc.dart';
import 'package:heal_v/app/main/feature/profile/language/language_page.dart';
import 'package:heal_v/app/main/feature/profile/profile_page.dart';
import 'package:heal_v/app/main/feature/profile/progress/progress_page.dart';
import 'package:heal_v/app/main/feature/profile/progress/progress_page_bloc.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/main.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';

import '../../../app/main/feature/profile/edit_profile/edit_profile_page.dart';
import '../../../app/main/feature/profile/edit_profile/edit_profile_page_bloc.dart';
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
    final user = context.read<AuthBloc>().state.user;
    return BlocProvider(
      lazy: false,
      create: (_) => EditProfilePageBloc()..add(EditProfilePageEvent.initial(user: user ?? UserDto())),
      child: const EditProfilePage(),
    );
  }
}

@TypedGoRoute<ProfileChangePasswordRoute>(path: ProfileRoutes.changePassword, routes: <TypedRoute<RouteData>>[])
@immutable
base class ProfileChangePasswordRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      lazy: false,
      create: (_) => ChangePasswordPageBloc()..add(ChangePasswordPageEvent.initial()),
      child: const ChangePasswordPage(),
    );
  }
}

@TypedGoRoute<ProfileLanguageRoute>(path: ProfileRoutes.language, routes: <TypedRoute<RouteData>>[])
@immutable
base class ProfileLanguageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LanguagePage();
  }
}

@TypedGoRoute<ProfileProgressRoute>(path: ProfileRoutes.progress, routes: <TypedRoute<RouteData>>[])
@immutable
base class ProfileProgressRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => ProgressPageBloc()..add(ProgressPageEvent.initial()),
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
      create: (_) => JournalHistoryPageBloc(getIt.get())..add(JournalHistoryPageEvent.initial()),
      lazy: false,
      child: const JournalHistoryPage(),
    );
  }
}

List<RouteBase> get $profileRouteRoutes => $appRoutes;
